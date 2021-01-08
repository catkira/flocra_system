
set project_name [lindex $argv 0]

set proc_name [lindex $argv 1]

set repo_path [lindex $argv 2]

set boot_args {console=ttyPS0,115200 root=/dev/mmcblk0p2 ro rootfstype=ext4 earlyprintk rootwait}

set hard_path tmp/$project_name.hard
set tree_path tmp/$project_name.tree

file mkdir $hard_path
file copy -force tmp/$project_name.hdf $hard_path/$project_name.hdf
hsi set_repo_path $repo_path

hsi open_hw_design $hard_path/$project_name.hdf
hsi create_sw_design -proc $proc_name -os device_tree devicetree

set get_os [hsi get_os]

hsi set_property CONFIG.kernel_version {2019.2} [hsi get_os]
hsi set_property CONFIG.bootargs $boot_args [hsi get_os]
hsi set_property CONFIG.dt_overlay true [hsi get_os]
hsi set_property CONFIG.firmware_name $project_name.bit [hsi get_os]

hsi generate_bsp -dir $tree_path

hsi close_sw_design [hsi current_sw_design]
hsi close_hw_design [hsi current_hw_design]
