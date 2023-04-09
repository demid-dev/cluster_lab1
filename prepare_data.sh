#!/bin/bash
echo -8504 4990 30 | awk '{xmin=$1; xmax=$2; steps=$3; dx=(xmaxxmin)/steps;x=xmin; for (i=0; i<steps; i++){print x" "x+dx;x+=dx}}'
