

function my_sync_time()
    local tmp_val = false
    sntp.sync("0.cz.pool.ntp.org",
    function(sec,usec,server)
        print('setting time to:', sec, usec, "from: " .. server)
        rtctime.set(sec+3600, usec)     -- plus UTC+1
        sec, usec = rtctime.get()
        print('time set to: ', sec, usec)
        tmp_val = true
    end,
    function()
        print('failed!')
        tmp_val = false
    end
    )
    return tmp_val
end