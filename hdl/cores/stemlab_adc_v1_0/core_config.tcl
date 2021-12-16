set display_name {STEMlab SDR ADC}

set core [ipx::current_core]

set_property DISPLAY_NAME $display_name $core
set_property DESCRIPTION $display_name $core

set bus [ipx::get_bus_interfaces -of_objects $core m_axis_a]
set_property NAME M_AXIS_A $bus
set_property INTERFACE_MODE master $bus

set bus [ipx::get_bus_interfaces -of_objects $core m_axis_b]
set_property NAME M_AXIS_B $bus
set_property INTERFACE_MODE master $bus

set bus [ipx::get_bus_interfaces aclk]
set parameter [ipx::add_bus_parameter ASSOCIATED_BUSIF $bus]
set_property VALUE M_AXIS_A:M_AXIS_B $parameter
