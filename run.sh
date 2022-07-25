#!/bin/bash

echo "============================================="
echo "  Generating instructions for input DAGs"
echo "  This can take 3-4 hours"
echo "  Log is captured in ./run.log"
echo "============================================="
python main.py --tmode compile &>> ./run.log
echo "============================================="
echo "Done generating instructions"
echo "Launching RTL simulations"
echo "============================================="
cd ./hw/tb
make compile
make run NET=tretail          W_CONFLICT=150  &>> ../../run.log
make run NET=mnist            W_CONFLICT=50   &>> ../../run.log
make run NET=nltcs            W_CONFLICT=225  &>> ../../run.log
make run NET=msweb            W_CONFLICT=250  &>> ../../run.log
make run NET=msnbc            W_CONFLICT=125  &>> ../../run.log
make run NET=bnetflix         W_CONFLICT=275  &>> ../../run.log
make run NET=HB_bp_200        W_CONFLICT=225  &>> ../../run.log
make run NET=HB_west2021      W_CONFLICT=225  &>> ../../run.log
make run NET=MathWorks_Sieber W_CONFLICT=300  &>> ../../run.log
make run NET=HB_jagmesh4      W_CONFLICT=200  &>> ../../run.log
make run NET=Bai_rdb968      W_CONFLICT=175   &>> ../../run.log
make run NET=Bai_dw2048      W_CONFLICT=150   &>> ../../run.log
cd ../..
echo "============================================="
echo "Done RTL simulations"
echo "Plotting charts.."
python main.py --tmode plot_charts &>> ./run.log
echo "Charts available at ./out/plots/"
echo "============================================="
echo "Finished!"

