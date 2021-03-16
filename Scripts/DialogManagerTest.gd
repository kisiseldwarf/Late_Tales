extends Control

var dialogTemplate: Control

func inflate(dialogTemplate: Control):
	self.dialogTemplate = dialogTemplate
	
	dialogTemplate.add_button("Avez-vous des informations particulieres sur la Rin-Ra ?",["rin_ra"])
	dialogTemplate.add_button("Bonjour",dialogTemplate.loadDialogUnsafe("res://Assets/Dialogs/albin.txt"))
	dialogTemplate.next_line()
