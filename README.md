```
docker build . --no-cache -t dcrd-fuzzers
```

then:

```
./run-fuzzer.sh <fuzzer name>
```

eg.

```
./run-fuzzer.sh txscript
```
