-- find add mag --

itemID = -274 -- ID Pot O Gems
delay = 350

targetPOG = 2 --brp x find,contoh 1k berarti 5
stored = 0

magX = math.floor(GetLocal().pos.x / 32)
magY = math.floor(GetLocal().pos.y / 32) + 1

find = true

function console(msg)
    SendVariant({
        v0 = "OnConsoleMessage",
        v1 = msg
    })
end

AddHook("OnVariant","maghook",function(var)

    if var[0] == "OnDialogRequest" and string.find(var[1],"Dropped") then
        return true
    end

    if var[0] == "OnDialogRequest" and string.find(var[1],"MAGPLANT") then
        
        SendPacket(2,
        "action|dialog_return\n"..
        "dialog_name|magplant_edit\n"..
        "x|"..magX.."|\n"..
        "y|"..magY.."|\n"..
        "itemToSelect|"..itemID)

        return true
    end

    if var[0] == "OnConsoleMessage" and string.find(var[1],"doesn't fit into the Magplant") then
        find = false
    end

end)

-- wrench magplant
SendPacketRaw(false,{type=3,value=32,px=magX,py=magY,x=magX*32,y=magY*32})
Sleep(1000)

while true do

    if stored >= targetPOG then
        console("POG stored: "..stored.."/"..targetPOG)
        break
    end

    if find then

        SendPacket(2,"action|dialog_return\ndialog_name|item_search\n"..itemID.."|1")
        Sleep(delay)

        SendPacket(2,
        "action|dialog_return\n"..
        "dialog_name|magplant_edit\n"..
        "x|"..magX.."|\n"..
        "y|"..magY.."|\n"..
        "buttonClicked|additems")

        stored = stored + 1
        console("POG stored: "..stored.."/"..targetPOG)

        Sleep(delay)

    else

        Sleep(500)

        magX = magX + 1

        FindPath(magX,magY - 1)

        Sleep(delay)

        SendPacketRaw(false,{type=3,value=32,px=magX,py=magY,x=magX*32,y=magY*32})

        Sleep(delay)

        find = true

    end

    Sleep(500)

end

console("Script selesai")