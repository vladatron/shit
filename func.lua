buf = ""
bufReadIndex = 0
maxSendPacket = 1450

local i_maxCharsInString = 4000

b_timeSynchronized = false;     -- flag if time is synchronized with NTP server

function my_sync_time()
    local tmp_val = false
    sntp.sync("0.cz.pool.ntp.org",
    function(sec,usec,server)
        print('setting time to:', sec, usec, "from: " .. server)
        rtctime.set(sec+3600, usec)     -- plus UTC+1
        sec, usec = rtctime.get()
        print('time set to: ', sec, usec)
        b_timeSynchronized = true;
        tmp_val = true
    end,
    function()
        b_timeSynchronized = false;
        print('failed!')
        tmp_val = false
    end
    )
    return tmp_val
end

function add2buf(text)
    if ((string.len(text) + string.len(buf)) <= i_maxCharsInString) then 
        buf = buf .. text;
    else 
        print("error: attempt to exceed max buffer length ")
    end
end