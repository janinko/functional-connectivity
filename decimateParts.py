#!/bin/python

import os
import bpy

bpy.data.objects['Cube'].select = True
bpy.data.objects['Camera'].select = True
bpy.data.objects['Lamp'].select = True
bpy.ops.object.delete()

path = 'data/parts'
# get list of all files in directory
file_list = os.listdir(path)

# reduce the list to files ending in 'obj'
# using 'list comprehensions'
obj_list = [item for item in file_list if item[-3:] == 'obj']

# reduce the list to files starting with 'part_'
part_list = [item for item in obj_list if item[:5] == 'part_']

# loop through the strings in obj_list.
for item in part_list:
    number = item[5:-4]
    print("item: " + item + ", number: "+ item)
    full_path_to_file = os.path.join(path, item)
    bpy.ops.import_scene.obj(filepath=full_path_to_file)
    obj = bpy.data.objects['Brain part ' + number]
    mod = obj.modifiers.new(name='decimate', type='DECIMATE')
    mod.decimate_type='DISSOLVE'
    bpy.context.scene.objects.active = obj
    bpy.ops.object.modifier_apply(modifier='decimate')
    mod = obj.modifiers.new(name='triangulate', type='TRIANGULATE')
    bpy.ops.object.modifier_apply(modifier='triangulate')
    outpath = os.path.join(path,'part_' + number + 'd.obj')
    bpy.ops.export_scene.obj(filepath=outpath, use_selection=True)


#exit()
