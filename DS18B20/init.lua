-- Configure the ESP as a station (client)
wifi.setmode (wifi.STATION)
wifi.sta.config ("SSID","password")
wifi.sta.autoconnect (1)

-- Hang out until we get a wifi connection before the httpd server is started.
tmr.alarm (1, 800, 1, function ( )
  if wifi.sta.getip ( ) == nil then
     print ("Waiting for Wifi connection")
  else
     tmr.stop (1)
     print ("Config done, IP is " .. wifi.sta.getip ( ))
  end
end)

dofile('dallas.lua')
