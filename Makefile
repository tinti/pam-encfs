PAM_ENCFS_VERSION = 0.1.5

# Toolchain
CC = /usr/bin/gcc
LD = /usr/bin/ld
INSTALL = /usr/bin/install

# Flags
CFLAGS = -fPIC -O2 -c -g -Wall -Wformat-security -fno-strict-aliasing
LDFLAGS = --shared
PAMLIBS = -lpam

# Install path
PAM_LIB_DIR = $(DESTDIR)/lib/security

all: pam_encfs.so

pam_encfs.o: pam_encfs.c
	$(CC) $(CFLAGS) -DPAM_ENCFS_VERSION=\"$(PAM_ENCFS_VERSION)\" pam_encfs.c

pam_encfs.so: pam_encfs.o
	$(LD) $(LDFLAGS) -o pam_encfs.so pam_encfs.o $(PAMLIBS)

install: pam_encfs.so
	$(INSTALL) -m 0755 -d $(PAM_LIB_DIR)
	$(INSTALL) -m 0644 pam_encfs.so $(PAM_LIB_DIR)

clean:
	rm -f pam_encfs.o pam_encfs.so
