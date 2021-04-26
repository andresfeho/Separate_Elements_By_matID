clearlistener()
max modify mode
maxOps.CloneNodes selection cloneType: #copy newNodes:&nnl
baseName = $.name
original_geo = $

hide $ --Hide original

select nnl -- Selects copy

nnl.name = "detachMaster"
if $.modifiers[#Arnold_Properties] != undefined then
(
	global ArnoldModifierCopy = copy $.modifiers[#Arnold_Properties]
	print ("Ok!")
)
modPanel.addModToSelection (Edit_Poly ())
subobjectlevel = 4
i = 0
collected = #()
	
	
do
(
format "Conteo de i = %\n" (i)
numFaces = #()
$detachMaster.modifiers[#Edit_Poly].selectByMaterialClear = on
$detachMaster.modifiers[#Edit_Poly].selectByMaterialID = i
$detachMaster.modifiers[#Edit_Poly].ButtonOp #SelectByMaterial
join numFaces (EditPolyMod.GetSelection $detachMaster.Edit_Poly #Face)
format "Numero de caras = %\n" (numFaces.count)

$detachMaster.modifiers[#Edit_Poly].DetachToObject (baseName + "_Object_MatID_" + (i+1) as string) 
$detachMaster.modifiers[#Edit_Poly].ButtonOp #DetachFace
append collected (getNodeByName(baseName + "_Object_MatID_" + (i+1) as string))

i = i + 1
)
while numFaces.count != 0


for c = 1 to collected.count-1  do (
	addModifier collected [c] ArnoldModifierCopy
)

delete $detachMaster


