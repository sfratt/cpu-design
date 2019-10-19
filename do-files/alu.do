restart -f -nowave

add wave x
add wave y
add wave add_sub
add wave logic_func
add wave func
add wave output
add wave zero
add wave overflow

force x "00000000000000000000000000000111"
force y "00000000000000000000000000001000"
force add_sub '0'
force logic_func "00"
force func "00"
run 2

force x "00000000000000000000000000000010"
force y "00000000000000000000000000000001"
force add_sub '1'
force logic_func "00"
force func "01"
run 2

force x "11111111111111111111111111110110"
force y "00000000000000000000000000000001"
force add_sub '1'
force logic_func "00"
force func "01"
run 2

force x "10101010101010101010101010101010"
force y "01010101010101010101010101010101"
force add_sub '0'
force logic_func "00"
force func "10"
run 2

force x "01010000010000010000100101111101"
force y "01111111111111111111111111111111"
force add_sub '0'
force logic_func "00"
force func "10"
run 2

force x "00000000000000001111111111111111"
force y "00000000000000001111111111111111"
force add_sub '1'
force logic_func "00"
force func "10"
run 2

force x "11110010111100101111001011110010"
force y "00101111001011110010111100101111"
force add_sub '0'
force logic_func "00"
force func "11"
run 2

force x "11110000111100001111000011110000"
force y "00001111000011110000111100001111"
force add_sub '0'
force logic_func "01"
force func "11"
run 2

force x "11000111101001111111000011110000"
force y "01001111001011110000111111110000"
force add_sub '0'
force logic_func "10"
force func "11"
run 2

force x "11001100110011001100110011001100"
force y "10101010101010101010101010101010"
force add_sub '0'
force logic_func "11"
force func "11"
run 2

write wave ~/Modelsim/PostScript/alu.ps

# vim: ft=sh
