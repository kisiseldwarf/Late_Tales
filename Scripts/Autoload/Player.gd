extends Node

class Logical:
	var id: int
	var name: String
	var linksIds: Array
	
	func _init(var name: String, var id: int, var linkedIds: PoolIntArray):
		self.name = name
		self.id = id
		self.linksIds = linkedIds

func toLogical(logicalJson: Dictionary, logicalLinksJson: Array) -> Logical:
	var logicalLinkIds: PoolIntArray
	for logicalLink in logicalLinksJson:
		if(logicalLink["idFirst"] == logicalJson["id"]):
			logicalLinkIds.push_back(logicalLink["idSecond"])
		else:
			logicalLinkIds.push_back(logicalLink["idFirst"])
	
	return Logical.new(
		logicalJson["name"],
		logicalJson["id"],
		logicalLinkIds
	)

var logicalElements: Array
