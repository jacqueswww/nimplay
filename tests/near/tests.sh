#!/bin/bash
set -x
TESTS=(hello helloo)
# Adapted from https://github.com/nearprotocol/near-runtime-ts/tree/master/tests
[[ -e /tmp/main.wasm ]] && rm /tmp/main.wasm
cp $(dirname "$0")/../../examples/near/hello_v0.wasm /tmp/main.wasm
cp $(dirname "$0")/*.json /tmp/
errormsg="Error"
errors=0
passed=0

testcase () {
    res=`nearcore/target/debug/near-vm-runner-standalone --context-file=/tmp/context.json --config-file=/tmp/config.json --method-name=$1 --wasm-file=/tmp/main.wasm --input="{}"`
    if [[ "$res" =~ "$errormsg" ]]; then
        echo -e "\033[91m[FAIL] \033[0m$res"
        errors=`expr $errors + 1`
    else
        echo -e "\033[92m[PASS] \033[0m$res"
        passed=`expr $passed + 1`
    fi
}

for i in "${TESTS[@]}"
do
    # access each element  
    # as $i
    echo
    echo "Running $i" 
    testcase $i
done

echo
echo -e "$(expr ${passed} + ${errors} + ${#DISABLED_TESTS[@]}) Total, \033[92m${passed} Passed\033[0m, \033[91m${errors} Failed\033[0m, ${#DISABLED_TESTS[@]} Ignored."

if [[ "$errors" -gt 0 ]]; then
    exit 1
fi
