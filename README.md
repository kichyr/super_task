## Converting numbers into binary format

This tool provides function for converting numbers into binary representation.
## Building project
```
$ cmake -H. -B_builds -DBUILD_TESTS=ON
$ cmake --build _builds
```
or
```
$ tools/polly/bin/polly.py --test --install --reconfig
```
## creating archives packages
```
cmake --build _build --target package
```
## Running tests
```
$ cmake -H. -B_builds -DBUILD_TESTS=ON
$ cmake --build _builds
$ cmake --build _builds --target test
```

## Run DEMO
```
./_install/bin/demo 
4 # enter number
100 # getting string representation
```

