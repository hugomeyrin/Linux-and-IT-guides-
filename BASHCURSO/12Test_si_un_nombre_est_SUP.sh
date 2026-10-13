#!/bin/bash
nb=30
if [[ "$nb" -gt 100 ]]; then
	echo "Ce numero est plus grand que 100"
else
	echo "ce numero $nb est plus petit, donc ok"
fi
