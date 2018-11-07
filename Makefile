
CFLAGS=-Wall -g -O0 -std=gnu90 -pedantic

SRCS=$(wildcard *.c)

all: sheerdns sheerdnshash

docs: sheerdns.ps

OBJECTS=$(SRCS:.c=.o)

sheerdns: $(OBJECTS)
	gcc -o sheerdns $(OBJECTS)

sheerdnshash: hash.c
	gcc $(CFLAGS) -o sheerdnshash hash.c -DSTANDALONE -Wall

.c.o: $(SRCS)
	gcc $(CFLAGS) -c $<

clean:
	rm -f sheerdns sheerdnshash *.o

distclean: clean
	rm -f core *~ sheerdns.ps *.diss

sheerdns.ps:
	groff -Tps -mandoc sheerdns.8 > sheerdns.ps

install: all
	install sheerdnshash sheerdns /usr/sbin/

install-docs: docs
	install sheerdns.8 /usr/man/man8/

