#!/bin/bash


np=8
toRun=scriptSlush_vs_bae.edp

ff-mpirun -np $np $toRun -ns -wg -ffddm_schwarz_method oras -ffddm_verbosity 1
