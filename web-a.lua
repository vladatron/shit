buf = {}
lastBufIndex = 5
bufIndex = 0;

function makeHeader()
    buf[0] = "HTTP/1.1 200 OK\nContent-Type: text/html\n\n<!DOCTYPE HTML>";
    for i=1,lastBufIndex-1,1 do buf[i] = " "; end
end

srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
    conn:on("receive", function(client,request)
        local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
        if(method == nil)then
            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");
        end
        makeHeader()
        bufIndex = lastBufIndex; -- stop sending previous page
        requestVars = vars
        --local _GET = {}
        local k=nil
        local l=nil
        k, l = string.find(path, "%w+", 1)
        if ((k ~= nil)and(l ~= nil)and(l >= k)and(l >= 1)) then
           local webPage = string.sub(path, k, l);
           local webFile = "wp"..webPage..".lua"
           if (file.open(webFile)) then 
               file.close()
               dofile(webFile)
           else
               dofile("wperr.lua")
           end
        else dofile("wpindex.lua")
        end
        bufIndex = 1;
        client:send(buf[0]);
    end)
    conn:on("sent", function(client)
        if (bufIndex < lastBufIndex) then 
            client:send(buf[bufIndex]);
            bufIndex = bufIndex + 1;
        else 
            client:close();
            collectgarbage();
        end
    end)
end)
