set(buildscript
"# Create temporary directory
wdir=$(pwd)
tmp_dir=$(mktemp -d)
cd $tmp_dir
# Execute cmake
retv=0
cmake \${2}
if [ $? -ne 0 ]\; then
  echo \"Error while running cmake on folder \" \${2}
  retv=1
else
  cmake --build .
  cmake_ret=$?
  if [ \${cmake_ret} -eq 0 ]\; then
    success=0
  else
    success=1
  fi
  if [ \${success} -ne \${1} ]\; then
    echo \"CMake returned \${cmake_ret}, but we were expecting \${1}\"
    retv=1
  fi
fi
# Back to original folder and cleanup
cd $wdir
rm -fr tmp_dir
exit \${retv}")

file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/build.sh ${buildscript})
file(COPY ${CMAKE_CURRENT_BINARY_DIR}/build.sh
    DESTINATION ${CMAKE_CURRENT_BINARY_DIR}
    FILE_PERMISSIONS OWNER_EXECUTE)

function(add_build_test)
    set(opt EXPECT_FAIL)
    set(one_value_args NAME FOLDER)
    cmake_parse_arguments(BT "${opt}" "${one_value_args}" "" ${ARGN})
    if (BT_EXPECT_FAIL)
        set(BT_EXPECTED 1)
    else()
        set(BT_EXPECTED 0)
    endif()
    add_test(
        NAME ${BT_NAME}
        COMMAND sh ./build.sh ${BT_EXPECTED} ${BT_FOLDER})
endfunction()

