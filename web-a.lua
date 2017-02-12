function makeHeader()
    buf = "HTTP/1.1 200 OK\nContent-Type: text/html\n\n<!DOCTYPE HTML>";
end

srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
    conn:on("receive", function(client,request)
        local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
        if(method == nil)then
            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");
        end
        makeHeader()
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
        
        client:send(buf);
        client:close();
        collectgarbage();
    end)
end)
