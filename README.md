# Late_Tales
Repository of the Late Hotel Stories game

# Conventions
**PascalCase** : Classes virtuelle ou script qui ne doit pas être instancié directement en jeu, mais utilisé via un script

**lowcase** : Scripts instanciés dans un objet Godot et utilisé directement dans le jeu

# FAQ

## Interface Utilisateur
### Notes
Tous les élément de l'interface utilisateur devront être instanciés sous le node HUD, permettant ainsi d'être à la bonne taille vis-a-vis de la camera2D.
### Controls
Dans Godot, tous les éléments UI héritent de Control. Ils sont labellisés en vert, pour plus de simplicité.

Tous les éléments UI doivent être compris dans un Conteneneur UI. Il en existe de plusieurs sortes, pour pouvoir réaliser la majorité des layouts possible.
