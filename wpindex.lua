if (requestVars ~= nil)then
    for k, v in string.gmatch(requestVars, "(%w+)=(%w+)&*") do


    end
end


buf = buf.."<html><head><title>Muj webicek</title></head><body><h1 style=\"background-color:pink;\">Webik</h1><br>";
buf = buf.."<a href=\"?chci=moc&counter=\">Klikni sem </a>";
buf = buf.."<form method=\"get\"><input type=\"hidden\" name=\"counter\" value=\"\"><input type=\"text\" name=\"textik\"><input type=\"submit\" value=\"odeslat\"></form>"
buf = buf.."</body></html>";