#!/bin/bash
set -eux

cmake -DOPENSSL_ROOT_DIR=${PREFIX} -DOPENSSL_LIBRARIES=${PREFIX}/lib
make

cp ./bin/gost.so ${PREFIX}/lib/engines-1.1

export LD_LIBRARY_PATH=${PREFIX}/lib
export PATH=${PREFIX}/bin:${PATH}
export OPENSSL_ENGINES=${PREFIX}/lib/engines-1.1

# ${PREFIX}/bin/openssl ciphers |grep GOST

prove -r test || (cat tests.err && exit 1)
