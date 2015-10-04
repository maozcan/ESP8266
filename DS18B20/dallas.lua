require('ds18b20')
port = 80

-- ESP-01 GPIO Mapping
gpio0, gpio2 = 3, 4

ds18b20.setup(gpio0)
if (srv ~= nil) then
    srv.close(srv)
    srv = nil
end

srv=net.createServer(net.TCP)
srv:listen(port,connect)
-- svr.close(svr) svr = nil 
--print ("DS18B20 " .. ds18b20.read())
local function connect (conn, data)
    local query_data

    conn:on ("receive",
      function (cn, req_data)
        t = ds18b20.read()
        t = ds18b20.read()
        cn:send("HTTP/1.1 200 OK\nContent-Type: text/html\nRefresh: 5\n\n" ..
              "<!DOCTYPE HTML>" ..
              "<html><body>" ..
              "<b>ESP8266</b></br>" ..
              "Node ChipID : " .. node.chipid() .. "<br>" ..
              "Node MAC : " .. wifi.sta.getmac() .. "<br>" ..
              "Node Heap : " .. node.heap() .. "<br>" ..
              "Timer Ticks : " .. tmr.now() .. "<br>" ..
              "Temperature : " .. t .. "<br>" ..
              "</html></body>")
      -- Close the connection for the request
         cn:close ( )
      end)
     -- srv.close(srr)
     -- srv = nil
end
srv=net.createServer(net.TCP)
srv:listen(port,connect)
