#!/bin/bash

name="global"

func_a() {
	local local_name="local"
	echo "Inside func_a : $local_name"
}

func_b() {
	regular_name="regular"
	echo "Inside func_b : $regular_name"
}

func_a
func_b

echo ""

echo "Outside func_a (local variable) : $local_name"
echo "Outside func_b (regular variable) : $regular_name"
echo "Global variable : $name"
