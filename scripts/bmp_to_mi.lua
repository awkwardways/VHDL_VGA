local colored_img = io.open("..\\BMPs\\toro_is_happy.bmp", "rb")
local rom_img = io.open("..\\images\\toro_is_happy.mi", "w")

if not colored_img or not rom_img then print("Could not open files") return end

local contents = colored_img:read(138)
local bytes = {}
local value = 0
local px = 0
local ln = 0
local str = ""

rom_img:write("#File_format=AddrHex\n#Address_depth=32768\n#Data_width=16\n")

while true do
  if px == 160 then
    px = 0
    ln = ln + 1
  end

  contents = colored_img:read(2)
  if contents == nil then break end
  rom_img:write(string.format("%04x:", (2^8) * ln + px))
  bytes = {string.byte(contents, 1, 2)}
  for _, byte in ipairs(bytes) do
    str = string.format("%02x", byte) .. str
  end
  rom_img:write(str .. "\n")

  px = px + 1
  str = ""
end

colored_img:close()
rom_img:close()
