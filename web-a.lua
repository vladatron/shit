
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
        bufIndex = lastBufIndex; -- stop sending previous page
        requestVars = vars
        --local _GET = {}
        if (false == b_timeSynchronized) then    -- check if time is synchronized
            add2buf("<html><body><b>Time synchronizing in progress. Try again in few seconds... </b></br><a href=\"index\">back</a>");    -- error page
        else
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
                    add2buf("<html><body><b>Page not found</b></br><a href=\"index\">back</a>");    -- error page
                end
            else 
                dofile("wpindex.lua")
            end           
            add2buf("</body></html>"); 
            client:send(string.sub(buf,0,maxSendPacket));
            bufReadIndex = maxSendPacket+1;
        end
    end)
    conn:on("sent", function(client)
        local tmpBuf = string.sub(buf,bufReadIndex,bufReadIndex+maxSendPacket)
        if (string.len(tmpBuf) ~= 0) then 
            client:send(tmpBuf);
            bufReadIndex = bufReadIndex + maxSendPacket+1;
        else 
            client:close();
            collectgarbage();
        end
    end)
end)
