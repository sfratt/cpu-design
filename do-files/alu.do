restart -f -nowave

add wave x
add wave y
add wave add_sub
add wave logic_func
add wave func
add wave output
add wave zero
add wave overflow

force x "00000000000000000000000000000001"
force y "00000000000000000000000000000001"
force add_sub '0'
force logic_func "00"
force func "00"
run 2

force x "11111111111111111111111111111111"
force y "11111111111111111111111111111111"
force add_sub '1'
force logic_func "01"
force func "01"
run 2

force x "10101010101010101010101010101010"
force y "01010101010101010101010101010101"
force add_sub '0'
force logic_func "10"
force func "10"
run 2

force x "11111111111111111111111111111111"
force y "00000000000000000000000000000000"
force add_sub '1'
force logic_func "11"
force func "11"
run 2

write wave ~/Modelsim/PostScript/alu.ps

# vim: ft=sh
