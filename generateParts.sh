#!/bin/bash



if ! hash java; then
	echo "Java not found, exiting."
	exit 1
fi

rm data/parts/part_*.obj

java -jar parser/parser.jar

if hash blender; then
	blender -P decimateParts.py
else
	echo "Blender not found, I will skip optimizing .obj files"
	for a in data/parts/part_*.obj; do
		mv $a ${a/.obj/d.obj}
	done
fi
