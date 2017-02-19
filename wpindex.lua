
if (requestVars ~= nil)then
    for k, v in string.gmatch(requestVars, "(%w+)=(%w+)&*") do
        if ((k == "cmd") and (v == "synctime")) then
            my_sync_time()
        end

    end
end

local curr_tm = rtctime.epoch2cal(rtctime.get())
local curr_date = string.format("%04d/%02d/%02d %02d:%02d:%02d", curr_tm["year"], curr_tm["mon"], curr_tm["day"], curr_tm["hour"], curr_tm["min"], curr_tm["sec"])

add2buf("<html><head><title>Muj webicek</title></head><body><h1 style=\"background-color:pink;\">Webik</h1><br>");
add2buf("datum: ".. curr_date.."<br>");
add2buf("<a href=\"index?cmd=synctime\">Synchronizace casu</a><br><br>");
add2buf("<a href=\"calendar\">Calendar</a><br><br>");
add2buf("<form method=\"get\"><input type=\"hidden\" name=\"counter\" value=\"\"><input type=\"text\" name=\"textik\"><input type=\"submit\" value=\"odeslat\"></form>");

add2buf("The rtctime module provides advanced timekeeping support for NodeMCU, including keeping time across deep sleep cycles (provided rtctime.dsleep() is used instead of node.dsleep()). This can be used to significantly extend battery life on battery powered sensor nodes, as it is no longer necessary to fire up the RF module each wake-up in order to obtain an accurate timestamp.");
add2buf("This module is intended for use together with NTP (Network Time Protocol) for keeping highly accurate real time at all times. Timestamps are available with microsecond precision, based on the Unix Epoch (1970/01/01 00:00:00).");
add2buf("Time keeping on the ESP8266 is technically quite challenging. Despite being named RTC, the RTC is not really a Real Time Clock in the normal sense of the word. While it does keep a counter ticking while the module is sleeping, the accuracy with which it does so is highly dependent on the temperature of the chip. Said temperature changes significantly between when the chip is running and when it is sleeping, meaning that any calibration performed while the chip is active becomes useless mere moments after the chip has gone to sleep. As such, calibration values need to be deduced across sleep cycles in order to enable accurate time keeping. This is one of the things this module does.");
add2buf("Further complicating the matter of time keeping is that the ESP8266 operates on three different clock frequencies - 52MHz right at boot, 80MHz during regular operation, and 160MHz if boosted. This module goes to considerable length to take all of this into account to properly keep the time.");
add2buf("To enable this module, it needs to be given a reference time at least once (via rtctime.set()). For best accuracy it is recommended to provide a reference time twice, with the second time being after a deep sleep.");
add2buf("Note that while the rtctime module can keep time across deep sleeps, it will lose the time if the module is unexpectedly reset.");

add2buf("The rtctime module provides advanced timekeeping support for NodeMCU, including keeping time across deep sleep cycles (provided rtctime.dsleep() is used instead of node.dsleep()). This can be used to significantly extend battery life on battery powered sensor nodes, as it is no longer necessary to fire up the RF module each wake-up in order to obtain an accurate timestamp.");
add2buf("This module is intended for use together with NTP (Network Time Protocol) for keeping highly accurate real time at all times. Timestamps are available with microsecond precision, based on the Unix Epoch (1970/01/01 00:00:00).");
add2buf("Time keeping on the ESP8266 is technically quite challenging. Despite being named RTC, the RTC is not really a Real Time Clock in the normal sense of the word. While it does keep a counter ticking while the module is sleeping, the accuracy with which it does so is highly dependent on the temperature of the chip. Said temperature changes significantly between when the chip is running and when it is sleeping, meaning that any calibration performed while the chip is active becomes useless mere moments after the chip has gone to sleep. As such, calibration values need to be deduced across sleep cycles in order to enable accurate time keeping. This is one of the things this module does.");
add2buf("Further complicating the matter of time keeping is that the ESP8266 operates on three different clock frequencies - 52MHz right at boot, 80MHz during regular operation, and 160MHz if boosted. This module goes to considerable length to take all of this into account to properly keep the time.");

