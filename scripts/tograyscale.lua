local colored_image = io.open("..\\BMPs\\awawita.bmp", "rb")
local rom_img = io.open("..\\images\\rom.mi", "w")

if not colored_image or not rom_img then print("Could not open files") return end

local contents = colored_image:read(140)
local bytes = {}
local value = 0
local px = 0
local ln = 0

rom_img:write("#File_format=AddrHex\n#Address_depth=524288\n#Data_width=1\n")

-- get image info
while true do
  if px == 640 then
    px = 0
    ln = ln + 1
  end

  contents = colored_image:read(2)
  if contents == nil then break end
  bytes = {string.byte(contents, 1, 2)}
  for _, byte in ipairs(bytes) do
    value = value + byte
  end

  if value >= 256 then
    rom_img:write(string.format("%05x", (2^10) * ln + px)..":1\n")
  else
    rom_img:write(string.format("%05x", (2^10) * ln + px)..":0\n")
  end
  value = 0
  px = px + 1
end

colored_image:close()
rom_img:close()
