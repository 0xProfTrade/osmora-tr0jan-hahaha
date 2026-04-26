Settings = {
ProviderID = 928
}

SendVariantList({[0] = "OnDialogRequest", [1] = [[
set_default_color|`w
add_label_with_icon|big|`8Osmora Engine v2.0|left|2918|
add_spacer|small|
add_label_with_icon|small|`5VIP `b- `5Ultimate Script Engine|left|3898|
add_label_with_icon|small|`eGL `b- `2BotHax `b- `8GPai|left|3898|
add_label_with_icon|small|`6Report Bug Script|left|3898|
add_label_with_icon|small|`3Request Script|left|3898|
add_label_with_icon|small|`8Learn Script|left|3898|
add_spacer|small|
add_url_button||`qContact Whatsapp``|NOFLAGS|https://wa.me/+84563199752|`$Osmora LLM.|0|0|
add_smalltext|`9Need more scripts?! Request at Chat|
add_quick_exit|]]})

if type(GetTile(199,99)) == "table" then
  x, y = 199, 199
else
  x, y = 99, 53
end

state = { 4196896, 16779296 }

function PathFind(x, y)
  local PX = math.floor(GetLocal().pos.x / 32)
  local PY = math.floor(GetLocal().pos.y / 32)

  while math.abs(y - PY) > 6 do
    PY = PY + (y - PY > 0 and 6 or -6)
    FindPath(PX, PY)
    Sleep(340)
  end

  while math.abs(x - PX) > 6 do
    PX = PX + (x - PX > 0 and 6 or -6)
    FindPath(PX, PY)
    Sleep(340)
  end

  FindPath(x, y)
  Sleep(200)
end

function Punch(x, y) 
  pkt = {} 
  pkt.px = math.floor(GetLocal().pos.x / 32 + x)
  pkt.py = math.floor(GetLocal().pos.y / 32 + y)
  pkt.type = 3 
  pkt.value = 18 
  pkt.x = GetLocal().pos.x 
  pkt.y = GetLocal().pos.y
  SendPacketRaw(false, pkt)
  state = {4196896,16779296}
  for _, st in ipairs(state) do
      hld = {}
      hld.px = x
      hld.py = y 
      hld.type = 0 
      hld.value = 0 
      hld.x = GetLocal().pos.x
      hld.y = GetLocal().pos.y 
      hld.state = st
      SendPacketRaw(false,hld)
      Sleep(74)
  end
  Sleep(100)
end

do
  for tileY = y, 0, -1 do
    for tileX = 0, x do
      if GetTile(tileX, tileY).fg == Settings.ProviderID and (GetTile(tileX, tileY).extra and GetTile(tileX, tileY).extra.progress == 1.00) then
        PathFind(tileX, tileY)
        Sleep(200)
        Punch(0, 0)
        Sleep(auto)
      end
    end
  end
end
