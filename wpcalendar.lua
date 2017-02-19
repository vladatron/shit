local curr_tm = rtctime.epoch2cal(rtctime.get());
local act_cal_year = curr_tm["year"];
local act_cal_mon = curr_tm["mon"];
local act_cal_day = curr_tm["day"];
local cal_year = curr_tm["year"];
local cal_mon = curr_tm["mon"];
local cal_day = curr_tm["day"];

if (requestVars ~= nil)then
    for k, v in string.gmatch(requestVars, "(%w+)=(%w+)&*") do
        if (k == "y") then 
            cal_year = v;
        elseif (k == "m") then 
            cal_mon = v;
        elseif (k == "d") then 
            cal_day = v;
        end

    end
end

--day per month/jumlah hari perbulan?
local dpm = {
    0,
    (31),
    (31+28),
    (31+28+31),
    (31+28+31+30),
    (31+28+31+30+31),
    (31+28+31+30+31+30),
    (31+28+31+30+31+30+31),
    (31+28+31+30+31+30+31+31),
    (31+28+31+30+31+30+31+31+30),
    (31+28+31+30+31+30+31+31+30+31),
    (31+28+31+30+31+30+31+31+30+31+30),
    (31+28+31+30+31+30+31+31+30+31+30+31)
}

local dayspm = {0,(31),(28),(31),(30),(31),(30),(31),(31),(30),(31),(30),(31)}

function mod(a, b)
    return a - (math.floor(a/b))*b
end

function isleap (year)
    -- every fourth year is a leap year except for century years that are
    -- not divisible by 400.
  return (mod(year,4)==0 and (mod(year,100)~=0 or mod(year,400)==0))
end

function cal2epoch(yyyy, mo, dd, hh, mm, ss)
    days = 0
    for year = 1970, yyyy-1 do
        if isleap(year) then
            days = days + 366
        else
            days = days + 365
        end
    end
    days = days + dpm[mo]
    if isleap(yyyy) and mo > 2 then days = days + 1 end
    days = days + dd - 1

    seconds = days*24*60*60 + hh*60*60+  mm*60 + ss

    return seconds
end

function daysInMonth(yyyy, mon)
    local days = 0
    if ((2 == mon)and(isleap(yyyy))) then 
        days = 1
    end
    days = days + dayspm[mon+1];
    return days
end

-----------------------------------------------------------------

local tmp_stamp = cal2epoch(cal_year, cal_mon, 1, 0, 0, 0)
curr_tm = rtctime.epoch2cal(tmp_stamp);

local curr_date = string.format("%04d/%02d/%02d %02d:%02d:%02d", curr_tm["year"], curr_tm["mon"], curr_tm["day"], curr_tm["hour"], curr_tm["min"], curr_tm["sec"])

add2buf("<html><head><title>Muj webicek - calendar</title>");
add2buf("<style type=\"text/css\">");
add2buf("tr {height: 50px;}");
add2buf("td {text-align: center;}");
add2buf("h1 {text-align: center; background-color:pink;}");
add2buf("</style>");
add2buf("</head><body>");

add2buf("<h1>Calendar</h1><br>");
add2buf("datum: ".. curr_date.."<br>");
add2buf("<a href=\"index\">Index</a><br><br>");

add2buf("<table style=\"margin-left: auto; margin-right: auto; background-color: #ebebe0; border-color: #000066;\" border=\"1\" cellspacing=\"1\" cellpadding=\"1\">");
add2buf("<tr style=\"height: 35px; background-color: #80bfff;\">");
add2buf("<td style=\"width: 35px;\">Mo</td>");
add2buf("<td style=\"width: 35px;\">Tu</td>");
add2buf("<td style=\"width: 35px;\">We</td>");
add2buf("<td style=\"width: 35px;\">Th</td>");
add2buf("<td style=\"width: 35px;\">Fr</td>");
add2buf("<td style=\"width: 35px;\">Sa</td>");
add2buf("<td style=\"width: 35px;\">Su</td>");
add2buf("</tr>");


function addTd(color)
    add2buf("<td style=\"background-color: "..color.."\">");
end

add2buf("<tr>");
local tmp_stamp = cal2epoch(cal_year, cal_mon, 1, 0, 0, 0)
curr_tm = rtctime.epoch2cal(tmp_stamp)
local firstDay = curr_tm["wday"]-1;
if (0 == firstDay) then firstDay = 7; end
for i=1,firstDay-1,1 do 
    addTd(" ")
    add2buf("&nbsp;</td>")
end    
local dayIndex = 1;     -- for print callendar days
local wDayIndex = firstDay;  -- 1 - Mo, 2 - Th, ...
local currDaysInMonth = daysInMonth(cal_year, cal_mon)

print(currDaysInMonth)

for i=1,36-firstDay,1 do 
    if (1 == wDayIndex) then add2buf("<tr>"); end
    if ((cal_year == act_cal_year)and(cal_mon == act_cal_mon)and(cal_day == dayIndex)) then 
        addTd("#66a3ff")
    else addTd(" ")
    end
    if (i <= currDaysInMonth) then add2buf("<a href=\"sev?date="..string.format("%04d%02d%02d", curr_tm["year"], curr_tm["mon"], dayIndex).."\">"..string.format("%01d",dayIndex).."</a></td>")
    else add2buf("&nbsp;</td>")
    end
    dayIndex = dayIndex + 1;    
    wDayIndex = wDayIndex + 1;
    if (wDayIndex > 7) then 
        wDayIndex = 1;
        add2buf("</tr>");
    end
end
add2buf("</tr>");


