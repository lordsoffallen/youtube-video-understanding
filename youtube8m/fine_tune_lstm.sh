#!/usr/bin/env bash

export TF_CPP_MIN_LOG_LEVEL=3

for feature in rgb audio all ; do
    echo
    echo "FINE TUNING LSTM ON $feature FEATURES...."
    echo
    for i in 512 1024 2048; do
        for loss in binary huber ; do
            echo
            echo "TRAINING MODEL: UNITS ($i) FEATURE ($feature) LOSS ($loss)..."
            echo
            python train_inference.py -m lstm -u "$i" -f ${feature} -l ${loss} --gpu

            echo
            echo "TRAINING MODEL: UNITS ($i, $i) FEATURE ($feature) LOSS ($loss)....."
            echo
            python train_inference.py -m lstm -u "$i, $i" -f ${feature} -l ${loss} --gpu

            echo
            echo "TRAINING MODEL: UNITS ($i, $i, $i) FEATURE ($feature) LOSS ($loss)....."
            echo
            python train_inference.py -m lstm -u "$i, $i, $i" -f ${feature} -l ${loss} --gpu

            echo
            echo "TRAINING MODEL: UNITS ($i) FEATURE ($feature) LOSS ($loss) and dropout ....."
            echo
            python train_inference.py -m lstm -u "$i" -f ${feature} -l ${loss} --dropout --gpu

            echo
            echo "TRAINING MODEL: UNITS ($i, $i) FEATURE ($feature) LOSS ($loss) and dropout ....."
            echo
            python train_inference.py -m lstm -u "$i, $i" -f ${feature} -l ${loss} --dropout --gpu

            echo
            echo "TRAINING MODEL: UNITS ($i, $i, $i) FEATURE ($feature) LOSS ($loss) and dropout ....."
            echo
            python train_inference.py -m lstm -u "$i, $i, $i" -f ${feature} -l ${loss} --dropout --gpu

        done
    done
done
