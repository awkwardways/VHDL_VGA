print("Populating ram with rising count")
local rom_img = io.open("rom.img", "w")
local rom_width = 16
local rom_depth = 2^15

if not rom_img then print("Could not open file") return end

for i = 0, rom_depth - 1, 1 do
  rom_img:write(string.format("%04x", i) .. "\n")
end

rom_img:close()