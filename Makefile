TGT       = echo_server
TST       = $(TGT).t
OBJS      = $(patsubst %.cc,.obj/%.o,$(filter-out $(TST).cc, $(wildcard *.cc)))
TSTOBJS   = $(patsubst %.cc,.obj/%.o,$(filter-out main.cc, $(wildcard *.cc)))
CXX       = g++
CC        = g++
DEBUG     = -g
CXXFLAGS  = -Wall -std=gnu++0x -I. $(DEBUG) -pthread -lpthread -Wl,--no-as-needed
CXXFLAGS += -I/usr/include/fltk -L/usr/lib64/fltk -lfltk
TESTLIBS  = -lgtest

$(TGT): $(OBJS)
	$(LINK.cc) $^ $(LOADLIBS) $(LDLIBS) -o $@

$(TST): $(TSTOBJS)
	$(LINK.cc) $^ $(LOADLIBS) $(TESTLIBS) -o $@

.obj:
	mkdir .obj

.obj/%.o: %.cc .obj
	$(COMPILE.cc) $(OUTPUT_OPTION) $<

$(TST).o: $(TST).cc $(TGT).cxx $(TGT).h

clean:
	rm -f .obj/*.o *~ $(TGT) $(TST)

test: $(TST)
	./$(TST)
