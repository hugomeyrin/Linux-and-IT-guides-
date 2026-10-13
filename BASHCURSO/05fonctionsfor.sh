#!/bin/bash
greet() {
   local name=$1 #"verifies if a local variable called name exists"
   echo "hello $name (from func)"

}
for name in "$@"; do 
	greet "$name"
done
