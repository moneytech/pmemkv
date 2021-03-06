# SPDX-License-Identifier: BSD-3-Clause
# Copyright 2020, Intel Corporation

include(${SRC_DIR}/../helpers.cmake)

setup()

if ((${TRACER} STREQUAL "drd") OR (${TRACER} STREQUAL "helgrind"))
    check_is_pmem(${DIR}/testfile)
endif()

pmempool_execute(create -l "pmemkv" -s ${DB_SIZE} obj ${DIR}/testfile)

make_config({"path":"${DIR}/testfile"})
execute(${TEST_EXECUTABLE} ${ENGINE} ${CONFIG} insert ${PARAMS})
execute(${TEST_EXECUTABLE} ${ENGINE} ${CONFIG} check ${PARAMS})

finish()
