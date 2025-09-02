function HexToBin(hex_string)
  local num = tonumber(hex_string, 16)
  local bin = ""
  for i = 0, 7 do
    if (num & (0x1 << i)) ~= 0 then
      bin = bin .. "1"
    else
      bin = bin .. "0"
    end
  end
  print(string.format("%02x", num) .. " turned to " .. bin .. "\n")
  return bin
end

ByteFile = io.open("bitmap.font", "r")
if not ByteFile then print("Could not open file") return end
BitFile = io.open("bit.mi", "w")

local address = 0x0801
while true do
  local line = ByteFile:read()
  if line == nil then break end
  local binary = HexToBin(line)
  for i = 1, #binary do
    BitFile:write(string.format("%04x", address) .. ":" .. binary:sub(i,i) .. "\n")
    address = address + 1
  end
end

-- #File_format=AddrHex
-- #Address_depth=8192
-- #Data_width=1