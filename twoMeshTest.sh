#!/bin/bash

np=8
toRun=scriptTwoMeshTest.edp

ff-mpirun -np $np $toRun -ns -wg -ffddm_schwarz_method oras -ffddm_verbosity 1
