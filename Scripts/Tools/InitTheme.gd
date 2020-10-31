extends Node2D

func init_theme(theme,font):
	# -- Fonts
	font.font_data = load("res://Assets/Brighton Spring Personal Use Only.ttf")
	font.size = 35
	theme.set_default_font(font)
	# -- Buttons
	theme.set_stylebox("hover","Button",StyleBoxEmpty.new())
	theme.set_stylebox("normal","Button",StyleBoxEmpty.new())
	theme.set_stylebox("pressed","Button",StyleBoxEmpty.new())
	theme.set_stylebox("focus","Button",StyleBoxEmpty.new())
	theme.set_color("font_color","Button",Color(0.7,0.7,0.7,1))
	theme.set_color("font_color_hover","Button",Color(1,1,1,1))
	theme.set_color("font_color_pressed","Button",Color(0.7,0.7,0.7,1))
	theme.set_constant("separation","VBoxContainer",20)
