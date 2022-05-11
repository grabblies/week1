#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
CIRCUIT_DIR=$SCRIPT_DIR/../contracts/circuits
BUILD_DIR=$CIRCUIT_DIR/build_Multiplier3_plonk

if [ -d "$BUILD_DIR" ]
then
	echo "Build directory exists"
else
	echo "Build directory does not exist, creating"
	mkdir $BUILD_DIR
fi

PPoT_PATH=$SCRIPT_DIR/../../powersOfTau28_hez_final_11.ptau

if [ -f $PPoT_PATH ]; then
    echo "powersOfTau28_hez_final_11.ptau already exists. Skipping."
else
    echo "Where is powersOfTau28_hez_final_11.ptau? It's not in this directory!" 
fi

echo "Compiling Multipler3, plonk style"

echo "This is circut dir: $CIRCUIT_DIR"
echo "This is build dir: $BUILD_DIR"

ls $BUILD_DIR
circom $CIRCUIT_DIR/Multiplier3.circom --r1cs --wasm --sym -o $BUILD_DIR
ls $BUILD_DIR
snarkjs r1cs info $BUILD_DIR/Multiplier3.r1cs

# Start a new zkey and make a contribution

snarkjs plonk setup $BUILD_DIR/Multiplier3.r1cs $PPoT_PATH $BUILD_DIR/circuit_final.zkey
# snarkjs zkey contribute $BUILD_DIR/circuit_00.zkey $BUILD_DIR/circuit_final.zkey --name="bgd"
snarkjs zkey export verificationkey $BUILD_DIR/circuit_final.zkey $BUILD_DIR/verification_key.json
snarkjs zkey export solidityverifier $BUILD_DIR/circuit_final.zkey $CIRCUIT_DIR/Multiplier3Verifier.sol
