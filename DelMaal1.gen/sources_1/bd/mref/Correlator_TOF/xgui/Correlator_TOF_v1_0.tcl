# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "input_size" -parent ${Page_0}
  ipgui::add_param $IPINST -name "word_size" -parent ${Page_0}


}

proc update_PARAM_VALUE.input_size { PARAM_VALUE.input_size } {
	# Procedure called to update input_size when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.input_size { PARAM_VALUE.input_size } {
	# Procedure called to validate input_size
	return true
}

proc update_PARAM_VALUE.word_size { PARAM_VALUE.word_size } {
	# Procedure called to update word_size when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.word_size { PARAM_VALUE.word_size } {
	# Procedure called to validate word_size
	return true
}


proc update_MODELPARAM_VALUE.input_size { MODELPARAM_VALUE.input_size PARAM_VALUE.input_size } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.input_size}] ${MODELPARAM_VALUE.input_size}
}

proc update_MODELPARAM_VALUE.word_size { MODELPARAM_VALUE.word_size PARAM_VALUE.word_size } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.word_size}] ${MODELPARAM_VALUE.word_size}
}

