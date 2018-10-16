dcrd_fuzzers_pkg := github.com/guidovranken/dcrd-fuzzers
go_pkg_path := $(GOPATH)/src
dcrd_fuzzers_path := $(go_pkg_path)/$(dcrd_fuzzers_pkg)
fuzzers := $(subst /,,$(subst $(dcrd_fuzzers_path)/,,$(sort $(dir $(wildcard $(dcrd_fuzzers_path)/*/)))))
targets := $(addprefix fuzzer-, $(fuzzers))

.PHONY: $(fuzzers)

all: main.o $(targets)

main.o : main.c
	$(CC) $(CFLAGS) -Wall -Wextra main.c -g -O3 -c -o main.o

fuzzer-%: %
	./go-fuzz-build -o $?.a github.com/guidovranken/dcrd-fuzzers/$?
	$(CXX) $(CXXFLAGS) main.o $?.a $(LIBFUZZER_A_PATH) -lpthread -o $@
