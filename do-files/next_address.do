restart -f -nowave

add wave rs
add wave rt
add wave pc
add wave target_address
add wave branch_type
add wave pc_sel
add wave control
add wave offset
add wave next_pc

force rs X"00000003"
force rt X"00000004"
force pc X"00001000"
force target_address "00000000000000000000000001"
force branch_type "00"
force pc_sel "00"
run 2

force rs X"00000003"
force rt X"00000004"
force pc X"00001000"
force target_address "00000000000000000000000001"
force branch_type "01"
force pc_sel "00"
run 2

force rs X"00000003"
force rt X"00000004"
force pc X"00001000"
force target_address "00000000000000000000000001"
force branch_type "10"
force pc_sel "00"
run 2

force rs X"00000003"
force rt X"00000004"
force pc X"00001000"
force target_address "00000000000000000000000001"
force branch_type "11"
force pc_sel "00"
run 2

force rs X"00000003"
force rt X"00000004"
force pc X"00001000"
force target_address "00000000000000000000000001"
force branch_type "00"
force pc_sel "01"
run 2

force rs X"00000003"
force rt X"00000004"
force pc X"00001000"
force target_address "00000000000000000000000001"
force branch_type "00"
force pc_sel "10"
run 2

force rs X"00000003"
force rt X"00000004"
force pc X"00001000"
force target_address "00000000000000000000000001"
force branch_type "00"
force pc_sel "11"
run 2

write wave ~/Modelsim/PostScript/next_address.ps

# vim: ft=sh
