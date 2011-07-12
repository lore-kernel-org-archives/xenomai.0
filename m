MIME-Version: 1.0
In-Reply-To: <4E1ADEA7.30003@domain.hid>
References: <CAG1VJdr9-_WbBTg+L7tAT8+aGOM7oH844F3NfcRmQrHLcCvpAw@domain.hid>
	<4E1ADEA7.30003@domain.hid>
From: Ashish Budhiraja <ashishmach@domain.hid>
Date: Tue, 12 Jul 2011 10:04:37 +0200
Message-ID: <CAG1VJdoogk8gUPxct1LQ32mtK4ezBDnDpah45fhrUcm6W_JNyw@domain.hid>
Content-Type: multipart/mixed; boundary=000e0cd2583ca99ef804a7dac213
Subject: Re: [Xenomai-help] Compiling Library files over Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

--000e0cd2583ca99ef804a7dac213
Content-Type: multipart/alternative; boundary=000e0cd2583ca99ee204a7dac211

--000e0cd2583ca99ee204a7dac211
Content-Type: text/plain; charset=ISO-8859-1

Hello Everyone and Gilles,

I am really sorry for not explaining clearly. I am attaching my Makefile and
also my output and my main file.
I have tried posix & native and also few more!!! output is same.

About the Errors
1)  The functions for which it is giving this error are in different files
like this not being used called anywhere and also in the file
     preacautions have been taken for the file not to get included more then
once.

2) The same files used to work without Xenomai.

The functions are of this kind

i2cdx.h:    RBAPI(unsigned char) i2c0_ReadStatREG(void);
i2cdx.h:    RB_INLINE RBAPI(unsigned char) i2c0_ReadStatREG(void) {


I have also appended inline my Makefile and output....

################################MAKEFILE#############################################
###### CONFIGURATION ######

### List of applications to be build
APPLICATIONS = testingxenomai

### Note: to override the search path for the xeno-config script, use "make
XENO=..."

### List of modules to be build
MODULES =

### Note: to override the kernel source path, use "make KSRC=..."

ROBOARD_LIB=./roboard_lib/

###### USER SPACE BUILD (no change required normally) ######
ifeq ($(KERNELRELEASE),)
ifneq ($(APPLICATIONS),)

### Default Xenomai installation path
XENO ?= /usr/xenomai

XENOCONFIG=$(shell PATH=$(XENO):$(XENO)/bin:$(PATH) which xeno-config
2>/dev/null)

### Sanity check
ifeq ($(XENOCONFIG),)
all::
    @echo ">>> Invoke make like this: \"make XENO=/path/to/xeno-config\"
<<<"
    @echo
endif

OBJECTS =      \
        spidx.o \
        spi.o \
        rcservo.o \
        pwmdx.o \
        pwm.o \
        io.o \
        i2cdx.o \
        i2c.o \
        common.o \
        ad79x8.o \

INCLUDE_DIR=./roboard_lib

CC=$(shell $(XENOCONFIG) --cc)

#CPP=$(shell $(XENOCONFIG) --g++)

#CFLAGS=$(shell $(XENOCONFIG) --xeno-cflags) $(MY_CFLAGS) -Wall
#-DROBOIO_DLL
CFLAGS=$(shell $(XENOCONFIG) --skin native --cflags) #$(MY_CFLAGS)

#LDFLAGS=$(shell $(XENOCONFIG) --xeno-ldflags) $(MY_LDFLAGS) -lnative
LDFLAGS=$(shell $(XENOCONFIG) --skin native --ldflags)# $(MY_LDFLAGS)
#-lnative

# This includes the library path of given Xenomai into the binary to make
live
# easier for beginners if Xenomai's libs are not in any default search path.
# LDFLAGS+=-Xlinker -rpath -Xlinker $(shell $(XENOCONFIG) --libdir)

all:: $(APPLICATIONS)

clean::
    $(RM) $(APPLICATIONS) *.o

endif
endif

###### SPECIAL TARGET RULES ######
#rtprint: rtprint.c
#    $(CC) $(CFLAGS) $? $(LDFLAGS) -lrtdk -o $@


spidx.o : $(ROBOARD_LIB)spidx.c
    $(CC) $(CFLAGS) -I$(INCLUDE_DIR) -c $(ROBOARD_LIB)spidx.c

spi.o : $(ROBOARD_LIB)spi.c
    $(CC) $(CFLAGS) -I$(INCLUDE_DIR) -c $(ROBOARD_LIB)spi.c

rcservo.o : $(ROBOARD_LIB)rcservo.c
    $(CC) $(CFLAGS) -I$(INCLUDE_DIR) -c $(ROBOARD_LIB)rcservo.c

pwmdx.o : $(ROBOARD_LIB)pwmdx.c
    $(CC) $(CFLAGS) -I$(INCLUDE_DIR) -c $(ROBOARD_LIB)pwmdx.c

pwm.o : $(ROBOARD_LIB)pwm.c
    $(CC) $(CFLAGS) -I$(INCLUDE_DIR) -c $(ROBOARD_LIB)pwm.c

io.o : $(ROBOARD_LIB)io.c
    $(CC) $(CFLAGS) -I$(INCLUDE_DIR) -c $(ROBOARD_LIB)io.c

i2cdx.o : $(ROBOARD_LIB)i2cdx.c
    $(CC) $(CFLAGS) -I$(INCLUDE_DIR) -c $(ROBOARD_LIB)i2cdx.c

i2c.o : $(ROBOARD_LIB)i2c.c
    $(CC) $(CFLAGS) -I$(INCLUDE_DIR) -c $(ROBOARD_LIB)i2c.c

common.o : $(ROBOARD_LIB)common.c
    $(CC) $(CFLAGS) -I$(INCLUDE_DIR) -c $(ROBOARD_LIB)common.c

ad79x8.o : $(ROBOARD_LIB)ad79x8.c
    $(CC) $(CFLAGS) -I./roboard_lib -c $(ROBOARD_LIB)ad79x8.c


testingxenomai:  $(OBJECTS)
#    $(CC) $(CFLAGS) $(OBJECTS) $(LDFLAGS) -lrtdk -o $@
    $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(OBJECTS) -lrtdk


###### KERNEL MODULE BUILD (no change required normally) ######
ifneq ($(MODULES),)

### Default to sources of currently running kernel
KSRC ?= /lib/modules/$(shell uname -r)/build

OBJS     := ${patsubst %, %.o, $(MODULES)}
CLEANMOD := ${patsubst %, .%*, $(MODULES)}
PWD      := $(shell if [ "$$PWD" != "" ]; then echo $$PWD; else pwd; fi)

### Kernel 2.6
ifeq ($(findstring 2.6,$(KSRC)),2.6)

obj-m        := $(OBJS)
EXTRA_CFLAGS := -I$(KSRC)/include/xenomai -I$(KSRC)/include/xenomai/posix
-I$(ADD_CFLAGS) -I$(PWD) -I$./

all::
    $(MAKE) -C $(KSRC) SUBDIRS=$(PWD) modules

### Kernel 2.4
else

ARCH    ?= $(shell uname -i)
INCLUDE := -I$(KSRC)/include/xenomai -I$(KSRC)/include/xenomai/compat
-I$(KSRC)/include/xenomai/posix
CFLAGS  += $(shell $(MAKE) -s -C $(KSRC) CC=$(CC) ARCH=$(ARCH)
SUBDIRS=$(PWD) modules) $(INCLUDE)

all:: $(OBJS)

endif

## Target for capturing 2.4 module CFLAGS
modules:
    @echo "$(CFLAGS)"

clean::
    $(RM) $(CLEANMOD) *.o *.ko *.mod.c Module*.symvers Module.markers
modules.order
    $(RM) -R .tmp*

endif
#######################################MAKE
END##############################


##############OUTPUT############################################

ugvuavrt4@domain.hid codes$ sudo make
gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall -pipe
-D__XENO__  -I./roboard_lib -c ./roboard_lib/spidx.c
gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall -pipe
-D__XENO__  -I./roboard_lib -c ./roboard_lib/spi.c
gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall -pipe
-D__XENO__  -I./roboard_lib -c ./roboard_lib/rcservo.c
gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall -pipe
-D__XENO__  -I./roboard_lib -c ./roboard_lib/pwmdx.c
gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall -pipe
-D__XENO__  -I./roboard_lib -c ./roboard_lib/pwm.c
gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall -pipe
-D__XENO__  -I./roboard_lib -c ./roboard_lib/io.c
gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall -pipe
-D__XENO__  -I./roboard_lib -c ./roboard_lib/i2cdx.c
gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall -pipe
-D__XENO__  -I./roboard_lib -c ./roboard_lib/i2c.c
gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall -pipe
-D__XENO__  -I./roboard_lib -c ./roboard_lib/common.c
gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall -pipe
-D__XENO__  -I./roboard_lib -c ./roboard_lib/ad79x8.c
gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall -pipe
-D__XENO__  -lnative -L/usr/xenomai/lib -lxenomai -lpthread -o
testingxenomai spidx.o spi.o rcservo.o pwmdx.o pwm.o io.o i2cdx.o i2c.o
common.o ad79x8.o  -lrtdk
spi.o: In function `read_sb_regb':
spi.c:(.text+0x0): multiple definition of `read_sb_regb'
spidx.o:spidx.c:(.text+0x0): first defined here
spi.o: In function `read_sb_regw':
spi.c:(.text+0x44): multiple definition of `read_sb_regw'
spidx.o:spidx.c:(.text+0x44): first defined here
spi.o: In function `read_sb_reg':
spi.c:(.text+0x8d): multiple definition of `read_sb_reg'
spidx.o:spidx.c:(.text+0x8d): first defined here
spi.o: In function `write_sb_regb':
spi.c:(.text+0xc3): multiple definition of `write_sb_regb'
spidx.o:spidx.c:(.text+0xc3): first defined here
spi.o: In function `write_sb_regw':
spi.c:(.text+0x14a): multiple definition of `write_sb_regw'
spidx.o:spidx.c:(.text+0x14a): first defined here
spi.o: In function `write_sb_reg':
spi.c:(.text+0x1ca): multiple definition of `write_sb_reg'
spidx.o:spidx.c:(.text+0x1ca): first defined here
spi.o: In function `read_nb_regb':
spi.c:(.text+0x207): multiple definition of `read_nb_regb'
spidx.o:spidx.c:(.text+0x207): first defined here
spi.o: In function `read_nb_regw':
spi.c:(.text+0x24b): multiple definition of `read_nb_regw'
spidx.o:spidx.c:(.text+0x24b): first defined here
spi.o: In function `read_nb_reg':
spi.c:(.text+0x294): multiple definition of `read_nb_reg'
spidx.o:spidx.c:(.text+0x294): first defined here
spi.o: In function `write_nb_regb':
spi.c:(.text+0x2ca): multiple definition of `write_nb_regb'
spidx.o:spidx.c:(.text+0x2ca): first defined here
spi.o: In function `write_nb_regw':
spi.c:(.text+0x351): multiple definition of `write_nb_regw'
spidx.o:spidx.c:(.text+0x351): first defined here
spi.o: In function `write_nb_reg':
spi.c:(.text+0x3d1): multiple definition of `write_nb_reg'
spidx.o:spidx.c:(.text+0x3d1): first defined here
rcservo.o: In function `read_sb_regb':
rcservo.c:(.text+0x0): multiple definition of `read_sb_regb'
spidx.o:spidx.c:(.text+0x0): first defined here
rcservo.o: In function `read_sb_regw':
rcservo.c:(.text+0x44): multiple definition of `read_sb_regw'
spidx.o:spidx.c:(.text+0x44): first defined here
rcservo.o: In function `read_sb_reg':
rcservo.c:(.text+0x8d): multiple definition of `read_sb_reg'
spidx.o:spidx.c:(.text+0x8d): first defined here
rcservo.o: In function `write_sb_regb':
rcservo.c:(.text+0xc3): multiple definition of `write_sb_regb'
spidx.o:spidx.c:(.text+0xc3): first defined here
rcservo.o: In function `write_sb_regw':
rcservo.c:(.text+0x14a): multiple definition of `write_sb_regw'
spidx.o:spidx.c:(.text+0x14a): first defined here
rcservo.o: In function `write_sb_reg':
rcservo.c:(.text+0x1ca): multiple definition of `write_sb_reg'
spidx.o:spidx.c:(.text+0x1ca): first defined here
rcservo.o: In function `read_nb_regb':
rcservo.c:(.text+0x207): multiple definition of `read_nb_regb'
spidx.o:spidx.c:(.text+0x207): first defined here
rcservo.o: In function `read_nb_regw':
rcservo.c:(.text+0x24b): multiple definition of `read_nb_regw'
spidx.o:spidx.c:(.text+0x24b): first defined here
rcservo.o: In function `read_nb_reg':
rcservo.c:(.text+0x294): multiple definition of `read_nb_reg'
spidx.o:spidx.c:(.text+0x294): first defined here
rcservo.o: In function `write_nb_regb':
rcservo.c:(.text+0x2ca): multiple definition of `write_nb_regb'
spidx.o:spidx.c:(.text+0x2ca): first defined here
rcservo.o: In function `write_nb_regw':
rcservo.c:(.text+0x351): multiple definition of `write_nb_regw'
spidx.o:spidx.c:(.text+0x351): first defined here
rcservo.o: In function `write_nb_reg':
rcservo.c:(.text+0x3d1): multiple definition of `write_nb_reg'
spidx.o:spidx.c:(.text+0x3d1): first defined here
pwmdx.o: In function `read_sb_regb':
pwmdx.c:(.text+0x0): multiple definition of `read_sb_regb'
spidx.o:spidx.c:(.text+0x0): first defined here
pwmdx.o: In function `read_sb_regw':
pwmdx.c:(.text+0x44): multiple definition of `read_sb_regw'
spidx.o:spidx.c:(.text+0x44): first defined here
pwmdx.o: In function `read_sb_reg':
pwmdx.c:(.text+0x8d): multiple definition of `read_sb_reg'
spidx.o:spidx.c:(.text+0x8d): first defined here
pwmdx.o: In function `write_sb_regb':
pwmdx.c:(.text+0xc3): multiple definition of `write_sb_regb'
spidx.o:spidx.c:(.text+0xc3): first defined here
pwmdx.o: In function `write_sb_regw':
pwmdx.c:(.text+0x14a): multiple definition of `write_sb_regw'
spidx.o:spidx.c:(.text+0x14a): first defined here
pwmdx.o: In function `write_sb_reg':
pwmdx.c:(.text+0x1ca): multiple definition of `write_sb_reg'
spidx.o:spidx.c:(.text+0x1ca): first defined here
pwmdx.o: In function `read_nb_regb':
pwmdx.c:(.text+0x207): multiple definition of `read_nb_regb'
spidx.o:spidx.c:(.text+0x207): first defined here
pwmdx.o: In function `read_nb_regw':
pwmdx.c:(.text+0x24b): multiple definition of `read_nb_regw'
spidx.o:spidx.c:(.text+0x24b): first defined here
pwmdx.o: In function `read_nb_reg':
pwmdx.c:(.text+0x294): multiple definition of `read_nb_reg'
spidx.o:spidx.c:(.text+0x294): first defined here
pwmdx.o: In function `write_nb_regb':
pwmdx.c:(.text+0x2ca): multiple definition of `write_nb_regb'
spidx.o:spidx.c:(.text+0x2ca): first defined here
pwmdx.o: In function `write_nb_regw':
pwmdx.c:(.text+0x351): multiple definition of `write_nb_regw'
spidx.o:spidx.c:(.text+0x351): first defined here
pwmdx.o: In function `write_nb_reg':
pwmdx.c:(.text+0x3d1): multiple definition of `write_nb_reg'
spidx.o:spidx.c:(.text+0x3d1): first defined here
pwm.o: In function `read_sb_regb':
pwm.c:(.text+0x0): multiple definition of `read_sb_regb'
spidx.o:spidx.c:(.text+0x0): first defined here
pwm.o: In function `read_sb_regw':
pwm.c:(.text+0x44): multiple definition of `read_sb_regw'
spidx.o:spidx.c:(.text+0x44): first defined here
pwm.o: In function `read_sb_reg':
pwm.c:(.text+0x8d): multiple definition of `read_sb_reg'
spidx.o:spidx.c:(.text+0x8d): first defined here
pwm.o: In function `write_sb_regb':
pwm.c:(.text+0xc3): multiple definition of `write_sb_regb'
spidx.o:spidx.c:(.text+0xc3): first defined here
pwm.o: In function `write_sb_regw':
pwm.c:(.text+0x14a): multiple definition of `write_sb_regw'
spidx.o:spidx.c:(.text+0x14a): first defined here
pwm.o: In function `write_sb_reg':
pwm.c:(.text+0x1ca): multiple definition of `write_sb_reg'
spidx.o:spidx.c:(.text+0x1ca): first defined here
pwm.o: In function `read_nb_regb':
pwm.c:(.text+0x207): multiple definition of `read_nb_regb'
spidx.o:spidx.c:(.text+0x207): first defined here
pwm.o: In function `read_nb_regw':
pwm.c:(.text+0x24b): multiple definition of `read_nb_regw'
spidx.o:spidx.c:(.text+0x24b): first defined here
pwm.o: In function `read_nb_reg':
pwm.c:(.text+0x294): multiple definition of `read_nb_reg'
spidx.o:spidx.c:(.text+0x294): first defined here
pwm.o: In function `write_nb_regb':
pwm.c:(.text+0x2ca): multiple definition of `write_nb_regb'
spidx.o:spidx.c:(.text+0x2ca): first defined here
pwm.o: In function `write_nb_regw':
pwm.c:(.text+0x351): multiple definition of `write_nb_regw'
spidx.o:spidx.c:(.text+0x351): first defined here
pwm.o: In function `write_nb_reg':
pwm.c:(.text+0x3d1): multiple definition of `write_nb_reg'
spidx.o:spidx.c:(.text+0x3d1): first defined here
io.o: In function `read_sb_regb':
io.c:(.text+0x0): multiple definition of `read_sb_regb'
spidx.o:spidx.c:(.text+0x0): first defined here
io.o: In function `read_sb_regw':
io.c:(.text+0x44): multiple definition of `read_sb_regw'
spidx.o:spidx.c:(.text+0x44): first defined here
io.o: In function `read_sb_reg':
io.c:(.text+0x8d): multiple definition of `read_sb_reg'
spidx.o:spidx.c:(.text+0x8d): first defined here
io.o: In function `write_sb_regb':
io.c:(.text+0xc3): multiple definition of `write_sb_regb'
spidx.o:spidx.c:(.text+0xc3): first defined here
io.o: In function `write_sb_regw':
io.c:(.text+0x14a): multiple definition of `write_sb_regw'
spidx.o:spidx.c:(.text+0x14a): first defined here
io.o: In function `write_sb_reg':
io.c:(.text+0x1ca): multiple definition of `write_sb_reg'
spidx.o:spidx.c:(.text+0x1ca): first defined here
io.o: In function `read_nb_regb':
io.c:(.text+0x207): multiple definition of `read_nb_regb'
spidx.o:spidx.c:(.text+0x207): first defined here
io.o: In function `read_nb_regw':
io.c:(.text+0x24b): multiple definition of `read_nb_regw'
spidx.o:spidx.c:(.text+0x24b): first defined here
io.o: In function `read_nb_reg':
io.c:(.text+0x294): multiple definition of `read_nb_reg'
spidx.o:spidx.c:(.text+0x294): first defined here
io.o: In function `write_nb_regb':
io.c:(.text+0x2ca): multiple definition of `write_nb_regb'
spidx.o:spidx.c:(.text+0x2ca): first defined here
io.o: In function `write_nb_regw':
io.c:(.text+0x351): multiple definition of `write_nb_regw'
spidx.o:spidx.c:(.text+0x351): first defined here
io.o: In function `write_nb_reg':
io.c:(.text+0x3d1): multiple definition of `write_nb_reg'
spidx.o:spidx.c:(.text+0x3d1): first defined here
i2cdx.o: In function `read_sb_regb':
i2cdx.c:(.text+0x0): multiple definition of `read_sb_regb'
spidx.o:spidx.c:(.text+0x0): first defined here
i2cdx.o: In function `read_sb_regw':
i2cdx.c:(.text+0x44): multiple definition of `read_sb_regw'
spidx.o:spidx.c:(.text+0x44): first defined here
i2cdx.o: In function `read_sb_reg':
i2cdx.c:(.text+0x8d): multiple definition of `read_sb_reg'
spidx.o:spidx.c:(.text+0x8d): first defined here
i2cdx.o: In function `write_sb_regb':
i2cdx.c:(.text+0xc3): multiple definition of `write_sb_regb'
spidx.o:spidx.c:(.text+0xc3): first defined here
i2cdx.o: In function `write_sb_regw':
i2cdx.c:(.text+0x14a): multiple definition of `write_sb_regw'
spidx.o:spidx.c:(.text+0x14a): first defined here
i2cdx.o: In function `write_sb_reg':
i2cdx.c:(.text+0x1ca): multiple definition of `write_sb_reg'
spidx.o:spidx.c:(.text+0x1ca): first defined here
i2cdx.o: In function `read_nb_regb':
i2cdx.c:(.text+0x207): multiple definition of `read_nb_regb'
spidx.o:spidx.c:(.text+0x207): first defined here
i2cdx.o: In function `read_nb_regw':
i2cdx.c:(.text+0x24b): multiple definition of `read_nb_regw'
spidx.o:spidx.c:(.text+0x24b): first defined here
i2cdx.o: In function `read_nb_reg':
i2cdx.c:(.text+0x294): multiple definition of `read_nb_reg'
spidx.o:spidx.c:(.text+0x294): first defined here
i2cdx.o: In function `write_nb_regb':
i2cdx.c:(.text+0x2ca): multiple definition of `write_nb_regb'
spidx.o:spidx.c:(.text+0x2ca): first defined here
i2cdx.o: In function `write_nb_regw':
i2cdx.c:(.text+0x351): multiple definition of `write_nb_regw'
spidx.o:spidx.c:(.text+0x351): first defined here
i2cdx.o: In function `write_nb_reg':
i2cdx.c:(.text+0x3d1): multiple definition of `write_nb_reg'
spidx.o:spidx.c:(.text+0x3d1): first defined here
i2c.o: In function `read_sb_regb':
i2c.c:(.text+0x0): multiple definition of `read_sb_regb'
spidx.o:spidx.c:(.text+0x0): first defined here
i2c.o: In function `read_sb_regw':
i2c.c:(.text+0x44): multiple definition of `read_sb_regw'
spidx.o:spidx.c:(.text+0x44): first defined here
i2c.o: In function `read_sb_reg':
i2c.c:(.text+0x8d): multiple definition of `read_sb_reg'
spidx.o:spidx.c:(.text+0x8d): first defined here
i2c.o: In function `write_sb_regb':
i2c.c:(.text+0xc3): multiple definition of `write_sb_regb'
spidx.o:spidx.c:(.text+0xc3): first defined here
i2c.o: In function `write_sb_regw':
i2c.c:(.text+0x14a): multiple definition of `write_sb_regw'
spidx.o:spidx.c:(.text+0x14a): first defined here
i2c.o: In function `write_sb_reg':
i2c.c:(.text+0x1ca): multiple definition of `write_sb_reg'
spidx.o:spidx.c:(.text+0x1ca): first defined here
i2c.o: In function `read_nb_regb':
i2c.c:(.text+0x207): multiple definition of `read_nb_regb'
spidx.o:spidx.c:(.text+0x207): first defined here
i2c.o: In function `read_nb_regw':
i2c.c:(.text+0x24b): multiple definition of `read_nb_regw'
spidx.o:spidx.c:(.text+0x24b): first defined here
i2c.o: In function `read_nb_reg':
i2c.c:(.text+0x294): multiple definition of `read_nb_reg'
spidx.o:spidx.c:(.text+0x294): first defined here
i2c.o: In function `write_nb_regb':
i2c.c:(.text+0x2ca): multiple definition of `write_nb_regb'
spidx.o:spidx.c:(.text+0x2ca): first defined here
i2c.o: In function `write_nb_regw':
i2c.c:(.text+0x351): multiple definition of `write_nb_regw'
spidx.o:spidx.c:(.text+0x351): first defined here
i2c.o: In function `write_nb_reg':
i2c.c:(.text+0x3d1): multiple definition of `write_nb_reg'
spidx.o:spidx.c:(.text+0x3d1): first defined here
i2c.o: In function `i2c0_Reset':
i2c.c:(.text+0x40e): multiple definition of `i2c0_Reset'
i2cdx.o:i2cdx.c:(.text+0x40e): first defined here
i2c.o: In function `i2c1_Reset':
i2c.c:(.text+0x422): multiple definition of `i2c1_Reset'
i2cdx.o:i2cdx.c:(.text+0x422): first defined here
i2c.o: In function `i2c0_EnableNoiseFilter':
i2c.c:(.text+0x436): multiple definition of `i2c0_EnableNoiseFilter'
i2cdx.o:i2cdx.c:(.text+0x436): first defined here
i2c.o: In function `i2c1_EnableNoiseFilter':
i2c.c:(.text+0x44a): multiple definition of `i2c1_EnableNoiseFilter'
i2cdx.o:i2cdx.c:(.text+0x44a): first defined here
i2c.o: In function `i2c0_DisableNoiseFilter':
i2c.c:(.text+0x45e): multiple definition of `i2c0_DisableNoiseFilter'
i2cdx.o:i2cdx.c:(.text+0x45e): first defined here
i2c.o: In function `i2c1_DisableNoiseFilter':
i2c.c:(.text+0x472): multiple definition of `i2c1_DisableNoiseFilter'
i2cdx.o:i2cdx.c:(.text+0x472): first defined here
i2c.o: In function `i2c0_EnableStandardHSM':
i2c.c:(.text+0x486): multiple definition of `i2c0_EnableStandardHSM'
i2cdx.o:i2cdx.c:(.text+0x486): first defined here
i2c.o: In function `i2c1_EnableStandardHSM':
i2c.c:(.text+0x49a): multiple definition of `i2c1_EnableStandardHSM'
i2cdx.o:i2cdx.c:(.text+0x49a): first defined here
i2c.o: In function `i2c0_DisableStandardHSM':
i2c.c:(.text+0x4ae): multiple definition of `i2c0_DisableStandardHSM'
i2cdx.o:i2cdx.c:(.text+0x4ae): first defined here
i2c.o: In function `i2c1_DisableStandardHSM':
i2c.c:(.text+0x4c2): multiple definition of `i2c1_DisableStandardHSM'
i2cdx.o:i2cdx.c:(.text+0x4c2): first defined here
i2c.o: In function `i2c0_EnableINT':
i2c.c:(.text+0x4d6): multiple definition of `i2c0_EnableINT'
i2cdx.o:i2cdx.c:(.text+0x4d6): first defined here
i2c.o: In function `i2c1_EnableINT':
i2c.c:(.text+0x4f8): multiple definition of `i2c1_EnableINT'
i2cdx.o:i2cdx.c:(.text+0x4f8): first defined here
i2c.o: In function `i2c0_DisableINT':
i2c.c:(.text+0x51a): multiple definition of `i2c0_DisableINT'
i2cdx.o:i2cdx.c:(.text+0x51a): first defined here
i2c.o: In function `i2c1_DisableINT':
i2c.c:(.text+0x53c): multiple definition of `i2c1_DisableINT'
i2cdx.o:i2cdx.c:(.text+0x53c): first defined here
i2c.o: In function `i2c0_SetCLKREG':
i2c.c:(.text+0x55e): multiple definition of `i2c0_SetCLKREG'
i2cdx.o:i2cdx.c:(.text+0x55e): first defined here
i2c.o: In function `i2c1_SetCLKREG':
i2c.c:(.text+0x595): multiple definition of `i2c1_SetCLKREG'
i2cdx.o:i2cdx.c:(.text+0x595): first defined here
i2c.o: In function `i2c0_ClearSTAT':
i2c.c:(.text+0x5cc): multiple definition of `i2c0_ClearSTAT'
i2cdx.o:i2cdx.c:(.text+0x5cc): first defined here
i2c.o: In function `i2c1_ClearSTAT':
i2c.c:(.text+0x5ee): multiple definition of `i2c1_ClearSTAT'
i2cdx.o:i2cdx.c:(.text+0x5ee): first defined here
i2c.o: In function `i2c0_ReadStatREG':
i2c.c:(.text+0x610): multiple definition of `i2c0_ReadStatREG'
i2cdx.o:i2cdx.c:(.text+0x610): first defined here
i2c.o: In function `i2c1_ReadStatREG':
i2c.c:(.text+0x624): multiple definition of `i2c1_ReadStatREG'
i2cdx.o:i2cdx.c:(.text+0x624): first defined here
i2c.o: In function `i2c0_IsMaster':
i2c.c:(.text+0x638): multiple definition of `i2c0_IsMaster'
i2cdx.o:i2cdx.c:(.text+0x638): first defined here
i2c.o: In function `i2c1_IsMaster':
i2c.c:(.text+0x64c): multiple definition of `i2c1_IsMaster'
i2cdx.o:i2cdx.c:(.text+0x64c): first defined here
i2c.o: In function `i2c0_CheckBusBusy':
i2c.c:(.text+0x660): multiple definition of `i2c0_CheckBusBusy'
i2cdx.o:i2cdx.c:(.text+0x660): first defined here
i2c.o: In function `i2c1_CheckBusBusy':
i2c.c:(.text+0x674): multiple definition of `i2c1_CheckBusBusy'
i2cdx.o:i2cdx.c:(.text+0x674): first defined here
i2c.o: In function `i2c0_CheckTXDone':
i2c.c:(.text+0x688): multiple definition of `i2c0_CheckTXDone'
i2cdx.o:i2cdx.c:(.text+0x688): first defined here
i2c.o: In function `i2c1_CheckTXDone':
i2c.c:(.text+0x69c): multiple definition of `i2c1_CheckTXDone'
i2cdx.o:i2cdx.c:(.text+0x69c): first defined here
i2c.o: In function `i2c0_ClearTXDone':
i2c.c:(.text+0x6b0): multiple definition of `i2c0_ClearTXDone'
i2cdx.o:i2cdx.c:(.text+0x6b0): first defined here
i2c.o: In function `i2c1_ClearTXDone':
i2c.c:(.text+0x6c4): multiple definition of `i2c1_ClearTXDone'
i2cdx.o:i2cdx.c:(.text+0x6c4): first defined here
i2c.o: In function `i2c0_CheckRXRdy':
i2c.c:(.text+0x6d8): multiple definition of `i2c0_CheckRXRdy'
i2cdx.o:i2cdx.c:(.text+0x6d8): first defined here
i2c.o: In function `i2c1_CheckRXRdy':
i2c.c:(.text+0x6ec): multiple definition of `i2c1_CheckRXRdy'
i2cdx.o:i2cdx.c:(.text+0x6ec): first defined here
i2c.o: In function `i2c0_ClearRXRdy':
i2c.c:(.text+0x700): multiple definition of `i2c0_ClearRXRdy'
i2cdx.o:i2cdx.c:(.text+0x700): first defined here
i2c.o: In function `i2c1_ClearRXRdy':
i2c.c:(.text+0x714): multiple definition of `i2c1_ClearRXRdy'
i2cdx.o:i2cdx.c:(.text+0x714): first defined here
i2c.o: In function `i2c0_WriteDataREG':
i2c.c:(.text+0x728): multiple definition of `i2c0_WriteDataREG'
i2cdx.o:i2cdx.c:(.text+0x728): first defined here
i2c.o: In function `i2c1_WriteDataREG':
i2c.c:(.text+0x74a): multiple definition of `i2c1_WriteDataREG'
i2cdx.o:i2cdx.c:(.text+0x74a): first defined here
i2c.o: In function `i2c0_ReadDataREG':
i2c.c:(.text+0x76c): multiple definition of `i2c0_ReadDataREG'
i2cdx.o:i2cdx.c:(.text+0x76c): first defined here
i2c.o: In function `i2c1_ReadDataREG':
i2c.c:(.text+0x780): multiple definition of `i2c1_ReadDataREG'
i2cdx.o:i2cdx.c:(.text+0x780): first defined here
i2c.o: In function `i2c0master_SetStopBit':
i2c.c:(.text+0x794): multiple definition of `i2c0master_SetStopBit'
i2cdx.o:i2cdx.c:(.text+0x794): first defined here
i2c.o: In function `i2c1master_SetStopBit':
i2c.c:(.text+0x7a8): multiple definition of `i2c1master_SetStopBit'
i2cdx.o:i2cdx.c:(.text+0x7a8): first defined here
i2c.o: In function `i2c0master_CheckStopBit':
i2c.c:(.text+0x7bc): multiple definition of `i2c0master_CheckStopBit'
i2cdx.o:i2cdx.c:(.text+0x7bc): first defined here
i2c.o: In function `i2c1master_CheckStopBit':
i2c.c:(.text+0x7d0): multiple definition of `i2c1master_CheckStopBit'
i2cdx.o:i2cdx.c:(.text+0x7d0): first defined here
i2c.o: In function `i2c0master_CheckARLoss':
i2c.c:(.text+0x7e4): multiple definition of `i2c0master_CheckARLoss'
i2cdx.o:i2cdx.c:(.text+0x7e4): first defined here
i2c.o: In function `i2c1master_CheckARLoss':
i2c.c:(.text+0x7f8): multiple definition of `i2c1master_CheckARLoss'
i2cdx.o:i2cdx.c:(.text+0x7f8): first defined here
i2c.o: In function `i2c0master_ClearARLoss':
i2c.c:(.text+0x80c): multiple definition of `i2c0master_ClearARLoss'
i2cdx.o:i2cdx.c:(.text+0x80c): first defined here
i2c.o: In function `i2c1master_ClearARLoss':
i2c.c:(.text+0x820): multiple definition of `i2c1master_ClearARLoss'
i2cdx.o:i2cdx.c:(.text+0x820): first defined here
i2c.o: In function `i2c0master_CheckAckErr':
i2c.c:(.text+0x834): multiple definition of `i2c0master_CheckAckErr'
i2cdx.o:i2cdx.c:(.text+0x834): first defined here
i2c.o: In function `i2c1master_CheckAckErr':
i2c.c:(.text+0x848): multiple definition of `i2c1master_CheckAckErr'
i2cdx.o:i2cdx.c:(.text+0x848): first defined here
i2c.o: In function `i2c0master_ClearAckErr':
i2c.c:(.text+0x85c): multiple definition of `i2c0master_ClearAckErr'
i2cdx.o:i2cdx.c:(.text+0x85c): first defined here
i2c.o: In function `i2c1master_ClearAckErr':
i2c.c:(.text+0x870): multiple definition of `i2c1master_ClearAckErr'
i2cdx.o:i2cdx.c:(.text+0x870): first defined here
i2c.o: In function `i2c0master_WriteAddrREG':
i2c.c:(.text+0x884): multiple definition of `i2c0master_WriteAddrREG'
i2cdx.o:i2cdx.c:(.text+0x884): first defined here
i2c.o: In function `i2c1master_WriteAddrREG':
i2c.c:(.text+0x8b4): multiple definition of `i2c1master_WriteAddrREG'
i2cdx.o:i2cdx.c:(.text+0x8b4): first defined here
i2c.o: In function `i2c0slave_EnableACK':
i2c.c:(.text+0x8e4): multiple definition of `i2c0slave_EnableACK'
i2cdx.o:i2cdx.c:(.text+0x8e4): first defined here
i2c.o: In function `i2c1slave_EnableACK':
i2c.c:(.text+0x8f8): multiple definition of `i2c1slave_EnableACK'
i2cdx.o:i2cdx.c:(.text+0x8f8): first defined here
i2c.o: In function `i2c0slave_EnableNAK':
i2c.c:(.text+0x90c): multiple definition of `i2c0slave_EnableNAK'
i2cdx.o:i2cdx.c:(.text+0x90c): first defined here
i2c.o: In function `i2c1slave_EnableNAK':
i2c.c:(.text+0x920): multiple definition of `i2c1slave_EnableNAK'
i2cdx.o:i2cdx.c:(.text+0x920): first defined here
i2c.o: In function `i2c0slave_SetAddr':
i2c.c:(.text+0x934): multiple definition of `i2c0slave_SetAddr'
i2cdx.o:i2cdx.c:(.text+0x934): first defined here
i2c.o: In function `i2c1slave_SetAddr':
i2c.c:(.text+0x956): multiple definition of `i2c1slave_SetAddr'
i2cdx.o:i2cdx.c:(.text+0x956): first defined here
i2c.o: In function `i2c0slave_CheckSlaveWREQ':
i2c.c:(.text+0x978): multiple definition of `i2c0slave_CheckSlaveWREQ'
i2cdx.o:i2cdx.c:(.text+0x978): first defined here
i2c.o: In function `i2c1slave_CheckSlaveWREQ':
i2c.c:(.text+0x98c): multiple definition of `i2c1slave_CheckSlaveWREQ'
i2cdx.o:i2cdx.c:(.text+0x98c): first defined here
i2c.o: In function `i2c0slave_ClearSlaveWREQ':
i2c.c:(.text+0x9a0): multiple definition of `i2c0slave_ClearSlaveWREQ'
i2cdx.o:i2cdx.c:(.text+0x9a0): first defined here
i2c.o: In function `i2c1slave_ClearSlaveWREQ':
i2c.c:(.text+0x9b4): multiple definition of `i2c1slave_ClearSlaveWREQ'
i2cdx.o:i2cdx.c:(.text+0x9b4): first defined here
ad79x8.o: In function `read_sb_regb':
ad79x8.c:(.text+0x0): multiple definition of `read_sb_regb'
spidx.o:spidx.c:(.text+0x0): first defined here
ad79x8.o: In function `read_sb_regw':
ad79x8.c:(.text+0x44): multiple definition of `read_sb_regw'
spidx.o:spidx.c:(.text+0x44): first defined here
ad79x8.o: In function `read_sb_reg':
ad79x8.c:(.text+0x8d): multiple definition of `read_sb_reg'
spidx.o:spidx.c:(.text+0x8d): first defined here
ad79x8.o: In function `write_sb_regb':
ad79x8.c:(.text+0xc3): multiple definition of `write_sb_regb'
spidx.o:spidx.c:(.text+0xc3): first defined here
ad79x8.o: In function `write_sb_regw':
ad79x8.c:(.text+0x14a): multiple definition of `write_sb_regw'
spidx.o:spidx.c:(.text+0x14a): first defined here
ad79x8.o: In function `write_sb_reg':
ad79x8.c:(.text+0x1ca): multiple definition of `write_sb_reg'
spidx.o:spidx.c:(.text+0x1ca): first defined here
ad79x8.o: In function `read_nb_regb':
ad79x8.c:(.text+0x207): multiple definition of `read_nb_regb'
spidx.o:spidx.c:(.text+0x207): first defined here
ad79x8.o: In function `read_nb_regw':
ad79x8.c:(.text+0x24b): multiple definition of `read_nb_regw'
spidx.o:spidx.c:(.text+0x24b): first defined here
ad79x8.o: In function `read_nb_reg':
ad79x8.c:(.text+0x294): multiple definition of `read_nb_reg'
spidx.o:spidx.c:(.text+0x294): first defined here
ad79x8.o: In function `write_nb_regb':
ad79x8.c:(.text+0x2ca): multiple definition of `write_nb_regb'
spidx.o:spidx.c:(.text+0x2ca): first defined here
ad79x8.o: In function `write_nb_regw':
ad79x8.c:(.text+0x351): multiple definition of `write_nb_regw'
spidx.o:spidx.c:(.text+0x351): first defined here
ad79x8.o: In function `write_nb_reg':
ad79x8.c:(.text+0x3d1): multiple definition of `write_nb_reg'
spidx.o:spidx.c:(.text+0x3d1): first defined here
/usr/lib/gcc/i486-linux-gnu/4.4.1/../../../../lib/crt1.o: In function
`_start':
/build/buildd/eglibc-2.10.1/csu/../sysdeps/i386/elf/start.S:115: undefined
reference to `main'
collect2: ld returned 1 exit status
make: *** [testingxenomai] Error 1
##########################################END############################

--000e0cd2583ca99ee204a7dac211
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello Everyone and Gilles,<br><br>I am really sorry for not explaining clea=
rly. I am attaching my Makefile and also my output and my main file.<br>I h=
ave tried posix &amp; native and also few more!!! output is same. <br><br>



About the Errors<br>1)=A0 The functions for which it is giving this error a=
re in different files like this not being used called anywhere and also in =
the file <br>=A0=A0=A0=A0 preacautions have been taken for the file not to =
get included more then once.<br>


<br>2) The same files used to work without Xenomai.<br><br>The functions ar=
e of this kind<br><br>i2cdx.h:=A0=A0=A0 RBAPI(unsigned char) i2c0_ReadStatR=
EG(void);<br>i2cdx.h:=A0=A0=A0 RB_INLINE RBAPI(unsigned char) i2c0_ReadStat=
REG(void) {<br>


<br><br>I have also appended inline my Makefile and output....<br><br>#####=
###########################MAKEFILE########################################=
#####<br>###### CONFIGURATION ######<br><br>### List of applications to be =
build<br>

APPLICATIONS =3D testingxenomai <br><br>### Note: to override the search pa=
th for the xeno-config script, use &quot;make XENO=3D...&quot;<br><br>### L=
ist of modules to be build<br>MODULES =3D<br><br>### Note: to override the =
kernel source path, use &quot;make KSRC=3D...&quot;<br>

<br>ROBOARD_LIB=3D./roboard_lib/<br><br>###### USER SPACE BUILD (no change =
required normally) ######<br>ifeq ($(KERNELRELEASE),)<br>ifneq ($(APPLICATI=
ONS),)<br><br>### Default Xenomai installation path<br>XENO ?=3D /usr/xenom=
ai<br>

<br>XENOCONFIG=3D$(shell PATH=3D$(XENO):$(XENO)/bin:$(PATH) which xeno-conf=
ig 2&gt;/dev/null)<br><br>### Sanity check<br>ifeq ($(XENOCONFIG),)<br>all:=
:<br>=A0=A0=A0 @echo &quot;&gt;&gt;&gt; Invoke make like this: \&quot;make =
XENO=3D/path/to/xeno-config\&quot; &lt;&lt;&lt;&quot;<br>

=A0=A0=A0 @echo<br>endif<br><br>OBJECTS =3D=A0=A0=A0=A0=A0 \<br>=A0=A0=A0 =
=A0=A0=A0 spidx.o \<br>=A0=A0=A0 =A0=A0=A0 spi.o \<br>=A0=A0=A0 =A0=A0=A0 r=
cservo.o \<br>=A0=A0=A0 =A0=A0=A0 pwmdx.o \<br>=A0=A0=A0 =A0=A0=A0 pwm.o \<=
br>=A0=A0=A0 =A0=A0=A0 io.o \<br>=A0=A0=A0 =A0=A0=A0 i2cdx.o \<br>=A0=A0=A0=
 =A0=A0=A0 i2c.o \<br>=A0=A0=A0 =A0=A0=A0 common.o \<br>

=A0=A0=A0 =A0=A0=A0 ad79x8.o \<br><br>INCLUDE_DIR=3D./roboard_lib<br><br>CC=
=3D$(shell $(XENOCONFIG) --cc)<br><br>#CPP=3D$(shell $(XENOCONFIG) --g++)<b=
r><br>#CFLAGS=3D$(shell $(XENOCONFIG) --xeno-cflags) $(MY_CFLAGS) -Wall #-D=
ROBOIO_DLL<br>CFLAGS=3D$(shell $(XENOCONFIG) --skin native --cflags) #$(MY_=
CFLAGS) <br>

<br>#LDFLAGS=3D$(shell $(XENOCONFIG) --xeno-ldflags) $(MY_LDFLAGS) -lnative=
<br>LDFLAGS=3D$(shell $(XENOCONFIG) --skin native --ldflags)# $(MY_LDFLAGS)=
 #-lnative<br><br># This includes the library path of given Xenomai into th=
e binary to make live<br>

# easier for beginners if Xenomai&#39;s libs are not in any default search =
path.<br># LDFLAGS+=3D-Xlinker -rpath -Xlinker $(shell $(XENOCONFIG) --libd=
ir)<br><br>all:: $(APPLICATIONS)<br><br>clean::<br>=A0=A0=A0 $(RM) $(APPLIC=
ATIONS) *.o<br>

<br>endif<br>endif<br><br>###### SPECIAL TARGET RULES ######<br>#rtprint: r=
tprint.c<br>#=A0=A0=A0 $(CC) $(CFLAGS) $? $(LDFLAGS) -lrtdk -o $@<br><br><b=
r>spidx.o : $(ROBOARD_LIB)spidx.c<br>=A0=A0=A0 $(CC) $(CFLAGS) -I$(INCLUDE_=
DIR) -c $(ROBOARD_LIB)spidx.c<br>

<br>spi.o : $(ROBOARD_LIB)spi.c<br>=A0=A0=A0 $(CC) $(CFLAGS) -I$(INCLUDE_DI=
R) -c $(ROBOARD_LIB)spi.c<br><br>rcservo.o : $(ROBOARD_LIB)rcservo.c<br>=A0=
=A0=A0 $(CC) $(CFLAGS) -I$(INCLUDE_DIR) -c $(ROBOARD_LIB)rcservo.c<br><br>p=
wmdx.o : $(ROBOARD_LIB)pwmdx.c<br>

=A0=A0=A0 $(CC) $(CFLAGS) -I$(INCLUDE_DIR) -c $(ROBOARD_LIB)pwmdx.c<br><br>=
pwm.o : $(ROBOARD_LIB)pwm.c<br>=A0=A0=A0 $(CC) $(CFLAGS) -I$(INCLUDE_DIR) -=
c $(ROBOARD_LIB)pwm.c<br><br>io.o : $(ROBOARD_LIB)io.c<br>=A0=A0=A0 $(CC) $=
(CFLAGS) -I$(INCLUDE_DIR) -c $(ROBOARD_LIB)io.c<br>

<br>i2cdx.o : $(ROBOARD_LIB)i2cdx.c<br>=A0=A0=A0 $(CC) $(CFLAGS) -I$(INCLUD=
E_DIR) -c $(ROBOARD_LIB)i2cdx.c<br><br>i2c.o : $(ROBOARD_LIB)i2c.c<br>=A0=
=A0=A0 $(CC) $(CFLAGS) -I$(INCLUDE_DIR) -c $(ROBOARD_LIB)i2c.c<br><br>commo=
n.o : $(ROBOARD_LIB)common.c<br>

=A0=A0=A0 $(CC) $(CFLAGS) -I$(INCLUDE_DIR) -c $(ROBOARD_LIB)common.c<br><br=
>ad79x8.o : $(ROBOARD_LIB)ad79x8.c<br>=A0=A0=A0 $(CC) $(CFLAGS) -I./roboard=
_lib -c $(ROBOARD_LIB)ad79x8.c<br><br><br>testingxenomai:=A0 $(OBJECTS)<br>=
#=A0=A0=A0 $(CC) $(CFLAGS) $(OBJECTS) $(LDFLAGS) -lrtdk -o $@<br>

=A0=A0=A0 $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(OBJECTS) -lrtdk <br><br><br>##=
#### KERNEL MODULE BUILD (no change required normally) ######<br>ifneq ($(M=
ODULES),)<br><br>### Default to sources of currently running kernel<br>KSRC=
 ?=3D /lib/modules/$(shell uname -r)/build<br>

<br>OBJS=A0=A0=A0=A0 :=3D ${patsubst %, %.o, $(MODULES)}<br>CLEANMOD :=3D $=
{patsubst %, .%*, $(MODULES)}<br>PWD=A0=A0=A0=A0=A0 :=3D $(shell if [ &quot=
;$$PWD&quot; !=3D &quot;&quot; ]; then echo $$PWD; else pwd; fi)<br><br>###=
 Kernel 2.6<br>ifeq ($(findstring 2.6,$(KSRC)),2.6)<br>

<br>obj-m=A0=A0=A0=A0=A0=A0=A0 :=3D $(OBJS)<br>EXTRA_CFLAGS :=3D -I$(KSRC)/=
include/xenomai -I$(KSRC)/include/xenomai/posix -I$(ADD_CFLAGS) -I$(PWD) -I=
$./<br><br>all::<br>=A0=A0=A0 $(MAKE) -C $(KSRC) SUBDIRS=3D$(PWD) modules<b=
r><br>### Kernel 2.4<br>

else<br><br>ARCH=A0=A0=A0 ?=3D $(shell uname -i)<br>INCLUDE :=3D -I$(KSRC)/=
include/xenomai -I$(KSRC)/include/xenomai/compat -I$(KSRC)/include/xenomai/=
posix<br>CFLAGS=A0 +=3D $(shell $(MAKE) -s -C $(KSRC) CC=3D$(CC) ARCH=3D$(A=
RCH) SUBDIRS=3D$(PWD) modules) $(INCLUDE)<br>

<br>all:: $(OBJS)<br><br>endif<br><br>## Target for capturing 2.4 module CF=
LAGS<br>modules:<br>=A0=A0=A0 @echo &quot;$(CFLAGS)&quot;<br><br>clean::<br=
>=A0=A0=A0 $(RM) $(CLEANMOD) *.o *.ko *.mod.c Module*.symvers Module.marker=
s modules.order<br>

=A0=A0=A0 $(RM) -R .tmp*<br><br>endif<br>##################################=
#####MAKE END##############################<br><br><br>##############OUTPUT=
############################################<br><br>ugvuavrt4@domain.hid=
ktop:~/testing codes$ sudo make<br>

gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -D__XENO_=
_=A0 -I./roboard_lib -c ./roboard_lib/spidx.c<br>gcc -I/usr/xenomai/include=
 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -D__XENO__=A0 -I./roboard_lib -c ./=
roboard_lib/spi.c<br>

gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -D__XENO_=
_=A0 -I./roboard_lib -c ./roboard_lib/rcservo.c<br>gcc -I/usr/xenomai/inclu=
de -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -D__XENO__=A0 -I./roboard_lib -c =
./roboard_lib/pwmdx.c<br>

gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -D__XENO_=
_=A0 -I./roboard_lib -c ./roboard_lib/pwm.c<br>gcc -I/usr/xenomai/include -=
D_GNU_SOURCE -D_REENTRANT -Wall -pipe -D__XENO__=A0 -I./roboard_lib -c ./ro=
board_lib/io.c<br>

gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -D__XENO_=
_=A0 -I./roboard_lib -c ./roboard_lib/i2cdx.c<br>gcc -I/usr/xenomai/include=
 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -D__XENO__=A0 -I./roboard_lib -c ./=
roboard_lib/i2c.c<br>

gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -D__XENO_=
_=A0 -I./roboard_lib -c ./roboard_lib/common.c<br>gcc -I/usr/xenomai/includ=
e -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -D__XENO__=A0 -I./roboard_lib -c .=
/roboard_lib/ad79x8.c<br>

gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -D__XENO_=
_=A0 -lnative -L/usr/xenomai/lib -lxenomai -lpthread -o testingxenomai spid=
x.o spi.o rcservo.o pwmdx.o pwm.o io.o i2cdx.o i2c.o common.o ad79x8.o=A0 -=
lrtdk <br>

spi.o: In function `read_sb_regb&#39;:<br>spi.c:(.text+0x0): multiple defin=
ition of `read_sb_regb&#39;<br>spidx.o:spidx.c:(.text+0x0): first defined h=
ere<br>spi.o: In function `read_sb_regw&#39;:<br>spi.c:(.text+0x44): multip=
le definition of `read_sb_regw&#39;<br>

spidx.o:spidx.c:(.text+0x44): first defined here<br>spi.o: In function `rea=
d_sb_reg&#39;:<br>spi.c:(.text+0x8d): multiple definition of `read_sb_reg&#=
39;<br>spidx.o:spidx.c:(.text+0x8d): first defined here<br>spi.o: In functi=
on `write_sb_regb&#39;:<br>

spi.c:(.text+0xc3): multiple definition of `write_sb_regb&#39;<br>spidx.o:s=
pidx.c:(.text+0xc3): first defined here<br>spi.o: In function `write_sb_reg=
w&#39;:<br>spi.c:(.text+0x14a): multiple definition of `write_sb_regw&#39;<=
br>

spidx.o:spidx.c:(.text+0x14a): first defined here<br>spi.o: In function `wr=
ite_sb_reg&#39;:<br>spi.c:(.text+0x1ca): multiple definition of `write_sb_r=
eg&#39;<br>spidx.o:spidx.c:(.text+0x1ca): first defined here<br>spi.o: In f=
unction `read_nb_regb&#39;:<br>

spi.c:(.text+0x207): multiple definition of `read_nb_regb&#39;<br>spidx.o:s=
pidx.c:(.text+0x207): first defined here<br>spi.o: In function `read_nb_reg=
w&#39;:<br>spi.c:(.text+0x24b): multiple definition of `read_nb_regw&#39;<b=
r>

spidx.o:spidx.c:(.text+0x24b): first defined here<br>spi.o: In function `re=
ad_nb_reg&#39;:<br>spi.c:(.text+0x294): multiple definition of `read_nb_reg=
&#39;<br>spidx.o:spidx.c:(.text+0x294): first defined here<br>spi.o: In fun=
ction `write_nb_regb&#39;:<br>

spi.c:(.text+0x2ca): multiple definition of `write_nb_regb&#39;<br>spidx.o:=
spidx.c:(.text+0x2ca): first defined here<br>spi.o: In function `write_nb_r=
egw&#39;:<br>spi.c:(.text+0x351): multiple definition of `write_nb_regw&#39=
;<br>

spidx.o:spidx.c:(.text+0x351): first defined here<br>spi.o: In function `wr=
ite_nb_reg&#39;:<br>spi.c:(.text+0x3d1): multiple definition of `write_nb_r=
eg&#39;<br>spidx.o:spidx.c:(.text+0x3d1): first defined here<br>rcservo.o: =
In function `read_sb_regb&#39;:<br>

rcservo.c:(.text+0x0): multiple definition of `read_sb_regb&#39;<br>spidx.o=
:spidx.c:(.text+0x0): first defined here<br>rcservo.o: In function `read_sb=
_regw&#39;:<br>rcservo.c:(.text+0x44): multiple definition of `read_sb_regw=
&#39;<br>

spidx.o:spidx.c:(.text+0x44): first defined here<br>rcservo.o: In function =
`read_sb_reg&#39;:<br>rcservo.c:(.text+0x8d): multiple definition of `read_=
sb_reg&#39;<br>spidx.o:spidx.c:(.text+0x8d): first defined here<br>rcservo.=
o: In function `write_sb_regb&#39;:<br>

rcservo.c:(.text+0xc3): multiple definition of `write_sb_regb&#39;<br>spidx=
.o:spidx.c:(.text+0xc3): first defined here<br>rcservo.o: In function `writ=
e_sb_regw&#39;:<br>rcservo.c:(.text+0x14a): multiple definition of `write_s=
b_regw&#39;<br>

spidx.o:spidx.c:(.text+0x14a): first defined here<br>rcservo.o: In function=
 `write_sb_reg&#39;:<br>rcservo.c:(.text+0x1ca): multiple definition of `wr=
ite_sb_reg&#39;<br>spidx.o:spidx.c:(.text+0x1ca): first defined here<br>

rcservo.o: In function `read_nb_regb&#39;:<br>rcservo.c:(.text+0x207): mult=
iple definition of `read_nb_regb&#39;<br>spidx.o:spidx.c:(.text+0x207): fir=
st defined here<br>rcservo.o: In function `read_nb_regw&#39;:<br>rcservo.c:=
(.text+0x24b): multiple definition of `read_nb_regw&#39;<br>

spidx.o:spidx.c:(.text+0x24b): first defined here<br>rcservo.o: In function=
 `read_nb_reg&#39;:<br>rcservo.c:(.text+0x294): multiple definition of `rea=
d_nb_reg&#39;<br>spidx.o:spidx.c:(.text+0x294): first defined here<br>
rcservo.o: In function `write_nb_regb&#39;:<br>
rcservo.c:(.text+0x2ca): multiple definition of `write_nb_regb&#39;<br>spid=
x.o:spidx.c:(.text+0x2ca): first defined here<br>rcservo.o: In function `wr=
ite_nb_regw&#39;:<br>rcservo.c:(.text+0x351): multiple definition of `write=
_nb_regw&#39;<br>

spidx.o:spidx.c:(.text+0x351): first defined here<br>rcservo.o: In function=
 `write_nb_reg&#39;:<br>rcservo.c:(.text+0x3d1): multiple definition of `wr=
ite_nb_reg&#39;<br>spidx.o:spidx.c:(.text+0x3d1): first defined here<br>

pwmdx.o: In function `read_sb_regb&#39;:<br>pwmdx.c:(.text+0x0): multiple d=
efinition of `read_sb_regb&#39;<br>spidx.o:spidx.c:(.text+0x0): first defin=
ed here<br>pwmdx.o: In function `read_sb_regw&#39;:<br>pwmdx.c:(.text+0x44)=
: multiple definition of `read_sb_regw&#39;<br>

spidx.o:spidx.c:(.text+0x44): first defined here<br>pwmdx.o: In function `r=
ead_sb_reg&#39;:<br>pwmdx.c:(.text+0x8d): multiple definition of `read_sb_r=
eg&#39;<br>spidx.o:spidx.c:(.text+0x8d): first defined here<br>pwmdx.o: In =
function `write_sb_regb&#39;:<br>

pwmdx.c:(.text+0xc3): multiple definition of `write_sb_regb&#39;<br>spidx.o=
:spidx.c:(.text+0xc3): first defined here<br>pwmdx.o: In function `write_sb=
_regw&#39;:<br>pwmdx.c:(.text+0x14a): multiple definition of `write_sb_regw=
&#39;<br>

spidx.o:spidx.c:(.text+0x14a): first defined here<br>pwmdx.o: In function `=
write_sb_reg&#39;:<br>pwmdx.c:(.text+0x1ca): multiple definition of `write_=
sb_reg&#39;<br>spidx.o:spidx.c:(.text+0x1ca): first defined here<br>pwmdx.o=
: In function `read_nb_regb&#39;:<br>

pwmdx.c:(.text+0x207): multiple definition of `read_nb_regb&#39;<br>spidx.o=
:spidx.c:(.text+0x207): first defined here<br>pwmdx.o: In function `read_nb=
_regw&#39;:<br>pwmdx.c:(.text+0x24b): multiple definition of `read_nb_regw&=
#39;<br>

spidx.o:spidx.c:(.text+0x24b): first defined here<br>pwmdx.o: In function `=
read_nb_reg&#39;:<br>pwmdx.c:(.text+0x294): multiple definition of `read_nb=
_reg&#39;<br>spidx.o:spidx.c:(.text+0x294): first defined here<br>pwmdx.o: =
In function `write_nb_regb&#39;:<br>

pwmdx.c:(.text+0x2ca): multiple definition of `write_nb_regb&#39;<br>spidx.=
o:spidx.c:(.text+0x2ca): first defined here<br>pwmdx.o: In function `write_=
nb_regw&#39;:<br>pwmdx.c:(.text+0x351): multiple definition of `write_nb_re=
gw&#39;<br>

spidx.o:spidx.c:(.text+0x351): first defined here<br>pwmdx.o: In function `=
write_nb_reg&#39;:<br>pwmdx.c:(.text+0x3d1): multiple definition of `write_=
nb_reg&#39;<br>spidx.o:spidx.c:(.text+0x3d1): first defined here<br>pwm.o: =
In function `read_sb_regb&#39;:<br>

pwm.c:(.text+0x0): multiple definition of `read_sb_regb&#39;<br>spidx.o:spi=
dx.c:(.text+0x0): first defined here<br>pwm.o: In function `read_sb_regw&#3=
9;:<br>pwm.c:(.text+0x44): multiple definition of `read_sb_regw&#39;<br>

spidx.o:spidx.c:(.text+0x44): first defined here<br>pwm.o: In function `rea=
d_sb_reg&#39;:<br>pwm.c:(.text+0x8d): multiple definition of `read_sb_reg&#=
39;<br>spidx.o:spidx.c:(.text+0x8d): first defined here<br>pwm.o: In functi=
on `write_sb_regb&#39;:<br>

pwm.c:(.text+0xc3): multiple definition of `write_sb_regb&#39;<br>spidx.o:s=
pidx.c:(.text+0xc3): first defined here<br>pwm.o: In function `write_sb_reg=
w&#39;:<br>pwm.c:(.text+0x14a): multiple definition of `write_sb_regw&#39;<=
br>

spidx.o:spidx.c:(.text+0x14a): first defined here<br>pwm.o: In function `wr=
ite_sb_reg&#39;:<br>pwm.c:(.text+0x1ca): multiple definition of `write_sb_r=
eg&#39;<br>spidx.o:spidx.c:(.text+0x1ca): first defined here<br>pwm.o: In f=
unction `read_nb_regb&#39;:<br>

pwm.c:(.text+0x207): multiple definition of `read_nb_regb&#39;<br>spidx.o:s=
pidx.c:(.text+0x207): first defined here<br>pwm.o: In function `read_nb_reg=
w&#39;:<br>pwm.c:(.text+0x24b): multiple definition of `read_nb_regw&#39;<b=
r>

spidx.o:spidx.c:(.text+0x24b): first defined here<br>pwm.o: In function `re=
ad_nb_reg&#39;:<br>pwm.c:(.text+0x294): multiple definition of `read_nb_reg=
&#39;<br>spidx.o:spidx.c:(.text+0x294): first defined here<br>pwm.o: In fun=
ction `write_nb_regb&#39;:<br>

pwm.c:(.text+0x2ca): multiple definition of `write_nb_regb&#39;<br>spidx.o:=
spidx.c:(.text+0x2ca): first defined here<br>pwm.o: In function `write_nb_r=
egw&#39;:<br>pwm.c:(.text+0x351): multiple definition of `write_nb_regw&#39=
;<br>

spidx.o:spidx.c:(.text+0x351): first defined here<br>pwm.o: In function `wr=
ite_nb_reg&#39;:<br>pwm.c:(.text+0x3d1): multiple definition of `write_nb_r=
eg&#39;<br>spidx.o:spidx.c:(.text+0x3d1): first defined here<br>io.o: In fu=
nction `read_sb_regb&#39;:<br>

io.c:(.text+0x0): multiple definition of `read_sb_regb&#39;<br>spidx.o:spid=
x.c:(.text+0x0): first defined here<br>io.o: In function `read_sb_regw&#39;=
:<br>io.c:(.text+0x44): multiple definition of `read_sb_regw&#39;<br>spidx.=
o:spidx.c:(.text+0x44): first defined here<br>

io.o: In function `read_sb_reg&#39;:<br>io.c:(.text+0x8d): multiple definit=
ion of `read_sb_reg&#39;<br>spidx.o:spidx.c:(.text+0x8d): first defined her=
e<br>io.o: In function `write_sb_regb&#39;:<br>io.c:(.text+0xc3): multiple =
definition of `write_sb_regb&#39;<br>

spidx.o:spidx.c:(.text+0xc3): first defined here<br>io.o: In function `writ=
e_sb_regw&#39;:<br>io.c:(.text+0x14a): multiple definition of `write_sb_reg=
w&#39;<br>spidx.o:spidx.c:(.text+0x14a): first defined here<br>io.o: In fun=
ction `write_sb_reg&#39;:<br>

io.c:(.text+0x1ca): multiple definition of `write_sb_reg&#39;<br>spidx.o:sp=
idx.c:(.text+0x1ca): first defined here<br>io.o: In function `read_nb_regb&=
#39;:<br>io.c:(.text+0x207): multiple definition of `read_nb_regb&#39;<br>

spidx.o:spidx.c:(.text+0x207): first defined here<br>io.o: In function `rea=
d_nb_regw&#39;:<br>io.c:(.text+0x24b): multiple definition of `read_nb_regw=
&#39;<br>spidx.o:spidx.c:(.text+0x24b): first defined here<br>io.o: In func=
tion `read_nb_reg&#39;:<br>

io.c:(.text+0x294): multiple definition of `read_nb_reg&#39;<br>spidx.o:spi=
dx.c:(.text+0x294): first defined here<br>io.o: In function `write_nb_regb&=
#39;:<br>io.c:(.text+0x2ca): multiple definition of `write_nb_regb&#39;<br>

spidx.o:spidx.c:(.text+0x2ca): first defined here<br>io.o: In function `wri=
te_nb_regw&#39;:<br>io.c:(.text+0x351): multiple definition of `write_nb_re=
gw&#39;<br>spidx.o:spidx.c:(.text+0x351): first defined here<br>io.o: In fu=
nction `write_nb_reg&#39;:<br>

io.c:(.text+0x3d1): multiple definition of `write_nb_reg&#39;<br>spidx.o:sp=
idx.c:(.text+0x3d1): first defined here<br>i2cdx.o: In function `read_sb_re=
gb&#39;:<br>i2cdx.c:(.text+0x0): multiple definition of `read_sb_regb&#39;<=
br>

spidx.o:spidx.c:(.text+0x0): first defined here<br>i2cdx.o: In function `re=
ad_sb_regw&#39;:<br>i2cdx.c:(.text+0x44): multiple definition of `read_sb_r=
egw&#39;<br>spidx.o:spidx.c:(.text+0x44): first defined here<br>i2cdx.o: In=
 function `read_sb_reg&#39;:<br>

i2cdx.c:(.text+0x8d): multiple definition of `read_sb_reg&#39;<br>spidx.o:s=
pidx.c:(.text+0x8d): first defined here<br>i2cdx.o: In function `write_sb_r=
egb&#39;:<br>i2cdx.c:(.text+0xc3): multiple definition of `write_sb_regb&#3=
9;<br>

spidx.o:spidx.c:(.text+0xc3): first defined here<br>i2cdx.o: In function `w=
rite_sb_regw&#39;:<br>i2cdx.c:(.text+0x14a): multiple definition of `write_=
sb_regw&#39;<br>spidx.o:spidx.c:(.text+0x14a): first defined here<br>i2cdx.=
o: In function `write_sb_reg&#39;:<br>

i2cdx.c:(.text+0x1ca): multiple definition of `write_sb_reg&#39;<br>spidx.o=
:spidx.c:(.text+0x1ca): first defined here<br>i2cdx.o: In function `read_nb=
_regb&#39;:<br>i2cdx.c:(.text+0x207): multiple definition of `read_nb_regb&=
#39;<br>

spidx.o:spidx.c:(.text+0x207): first defined here<br>i2cdx.o: In function `=
read_nb_regw&#39;:<br>i2cdx.c:(.text+0x24b): multiple definition of `read_n=
b_regw&#39;<br>spidx.o:spidx.c:(.text+0x24b): first defined here<br>i2cdx.o=
: In function `read_nb_reg&#39;:<br>

i2cdx.c:(.text+0x294): multiple definition of `read_nb_reg&#39;<br>spidx.o:=
spidx.c:(.text+0x294): first defined here<br>i2cdx.o: In function `write_nb=
_regb&#39;:<br>i2cdx.c:(.text+0x2ca): multiple definition of `write_nb_regb=
&#39;<br>

spidx.o:spidx.c:(.text+0x2ca): first defined here<br>i2cdx.o: In function `=
write_nb_regw&#39;:<br>i2cdx.c:(.text+0x351): multiple definition of `write=
_nb_regw&#39;<br>spidx.o:spidx.c:(.text+0x351): first defined here<br>
i2cdx.o: In function `write_nb_reg&#39;:<br>
i2cdx.c:(.text+0x3d1): multiple definition of `write_nb_reg&#39;<br>spidx.o=
:spidx.c:(.text+0x3d1): first defined here<br>i2c.o: In function `read_sb_r=
egb&#39;:<br>i2c.c:(.text+0x0): multiple definition of `read_sb_regb&#39;<b=
r>

spidx.o:spidx.c:(.text+0x0): first defined here<br>i2c.o: In function `read=
_sb_regw&#39;:<br>i2c.c:(.text+0x44): multiple definition of `read_sb_regw&=
#39;<br>spidx.o:spidx.c:(.text+0x44): first defined here<br>i2c.o: In funct=
ion `read_sb_reg&#39;:<br>

i2c.c:(.text+0x8d): multiple definition of `read_sb_reg&#39;<br>spidx.o:spi=
dx.c:(.text+0x8d): first defined here<br>i2c.o: In function `write_sb_regb&=
#39;:<br>i2c.c:(.text+0xc3): multiple definition of `write_sb_regb&#39;<br>

spidx.o:spidx.c:(.text+0xc3): first defined here<br>i2c.o: In function `wri=
te_sb_regw&#39;:<br>i2c.c:(.text+0x14a): multiple definition of `write_sb_r=
egw&#39;<br>spidx.o:spidx.c:(.text+0x14a): first defined here<br>i2c.o: In =
function `write_sb_reg&#39;:<br>

i2c.c:(.text+0x1ca): multiple definition of `write_sb_reg&#39;<br>spidx.o:s=
pidx.c:(.text+0x1ca): first defined here<br>i2c.o: In function `read_nb_reg=
b&#39;:<br>i2c.c:(.text+0x207): multiple definition of `read_nb_regb&#39;<b=
r>

spidx.o:spidx.c:(.text+0x207): first defined here<br>i2c.o: In function `re=
ad_nb_regw&#39;:<br>i2c.c:(.text+0x24b): multiple definition of `read_nb_re=
gw&#39;<br>spidx.o:spidx.c:(.text+0x24b): first defined here<br>i2c.o: In f=
unction `read_nb_reg&#39;:<br>

i2c.c:(.text+0x294): multiple definition of `read_nb_reg&#39;<br>spidx.o:sp=
idx.c:(.text+0x294): first defined here<br>i2c.o: In function `write_nb_reg=
b&#39;:<br>i2c.c:(.text+0x2ca): multiple definition of `write_nb_regb&#39;<=
br>

spidx.o:spidx.c:(.text+0x2ca): first defined here<br>i2c.o: In function `wr=
ite_nb_regw&#39;:<br>i2c.c:(.text+0x351): multiple definition of `write_nb_=
regw&#39;<br>spidx.o:spidx.c:(.text+0x351): first defined here<br>i2c.o: In=
 function `write_nb_reg&#39;:<br>

i2c.c:(.text+0x3d1): multiple definition of `write_nb_reg&#39;<br>spidx.o:s=
pidx.c:(.text+0x3d1): first defined here<br>i2c.o: In function `i2c0_Reset&=
#39;:<br>i2c.c:(.text+0x40e): multiple definition of `i2c0_Reset&#39;<br>

i2cdx.o:i2cdx.c:(.text+0x40e): first defined here<br>i2c.o: In function `i2=
c1_Reset&#39;:<br>i2c.c:(.text+0x422): multiple definition of `i2c1_Reset&#=
39;<br>i2cdx.o:i2cdx.c:(.text+0x422): first defined here<br>i2c.o: In funct=
ion `i2c0_EnableNoiseFilter&#39;:<br>

i2c.c:(.text+0x436): multiple definition of `i2c0_EnableNoiseFilter&#39;<br=
>i2cdx.o:i2cdx.c:(.text+0x436): first defined here<br>i2c.o: In function `i=
2c1_EnableNoiseFilter&#39;:<br>i2c.c:(.text+0x44a): multiple definition of =
`i2c1_EnableNoiseFilter&#39;<br>

i2cdx.o:i2cdx.c:(.text+0x44a): first defined here<br>i2c.o: In function `i2=
c0_DisableNoiseFilter&#39;:<br>i2c.c:(.text+0x45e): multiple definition of =
`i2c0_DisableNoiseFilter&#39;<br>i2cdx.o:i2cdx.c:(.text+0x45e): first defin=
ed here<br>

i2c.o: In function `i2c1_DisableNoiseFilter&#39;:<br>i2c.c:(.text+0x472): m=
ultiple definition of `i2c1_DisableNoiseFilter&#39;<br>i2cdx.o:i2cdx.c:(.te=
xt+0x472): first defined here<br>i2c.o: In function `i2c0_EnableStandardHSM=
&#39;:<br>

i2c.c:(.text+0x486): multiple definition of `i2c0_EnableStandardHSM&#39;<br=
>i2cdx.o:i2cdx.c:(.text+0x486): first defined here<br>i2c.o: In function `i=
2c1_EnableStandardHSM&#39;:<br>i2c.c:(.text+0x49a): multiple definition of =
`i2c1_EnableStandardHSM&#39;<br>

i2cdx.o:i2cdx.c:(.text+0x49a): first defined here<br>i2c.o: In function `i2=
c0_DisableStandardHSM&#39;:<br>i2c.c:(.text+0x4ae): multiple definition of =
`i2c0_DisableStandardHSM&#39;<br>i2cdx.o:i2cdx.c:(.text+0x4ae): first defin=
ed here<br>

i2c.o: In function `i2c1_DisableStandardHSM&#39;:<br>i2c.c:(.text+0x4c2): m=
ultiple definition of `i2c1_DisableStandardHSM&#39;<br>i2cdx.o:i2cdx.c:(.te=
xt+0x4c2): first defined here<br>i2c.o: In function `i2c0_EnableINT&#39;:<b=
r>

i2c.c:(.text+0x4d6): multiple definition of `i2c0_EnableINT&#39;<br>i2cdx.o=
:i2cdx.c:(.text+0x4d6): first defined here<br>i2c.o: In function `i2c1_Enab=
leINT&#39;:<br>i2c.c:(.text+0x4f8): multiple definition of `i2c1_EnableINT&=
#39;<br>

i2cdx.o:i2cdx.c:(.text+0x4f8): first defined here<br>i2c.o: In function `i2=
c0_DisableINT&#39;:<br>i2c.c:(.text+0x51a): multiple definition of `i2c0_Di=
sableINT&#39;<br>i2cdx.o:i2cdx.c:(.text+0x51a): first defined here<br>
i2c.o: In function `i2c1_DisableINT&#39;:<br>
i2c.c:(.text+0x53c): multiple definition of `i2c1_DisableINT&#39;<br>i2cdx.=
o:i2cdx.c:(.text+0x53c): first defined here<br>i2c.o: In function `i2c0_Set=
CLKREG&#39;:<br>i2c.c:(.text+0x55e): multiple definition of `i2c0_SetCLKREG=
&#39;<br>

i2cdx.o:i2cdx.c:(.text+0x55e): first defined here<br>i2c.o: In function `i2=
c1_SetCLKREG&#39;:<br>i2c.c:(.text+0x595): multiple definition of `i2c1_Set=
CLKREG&#39;<br>i2cdx.o:i2cdx.c:(.text+0x595): first defined here<br>i2c.o: =
In function `i2c0_ClearSTAT&#39;:<br>

i2c.c:(.text+0x5cc): multiple definition of `i2c0_ClearSTAT&#39;<br>i2cdx.o=
:i2cdx.c:(.text+0x5cc): first defined here<br>i2c.o: In function `i2c1_Clea=
rSTAT&#39;:<br>i2c.c:(.text+0x5ee): multiple definition of `i2c1_ClearSTAT&=
#39;<br>

i2cdx.o:i2cdx.c:(.text+0x5ee): first defined here<br>i2c.o: In function `i2=
c0_ReadStatREG&#39;:<br>i2c.c:(.text+0x610): multiple definition of `i2c0_R=
eadStatREG&#39;<br>i2cdx.o:i2cdx.c:(.text+0x610): first defined here<br>

i2c.o: In function `i2c1_ReadStatREG&#39;:<br>i2c.c:(.text+0x624): multiple=
 definition of `i2c1_ReadStatREG&#39;<br>i2cdx.o:i2cdx.c:(.text+0x624): fir=
st defined here<br>i2c.o: In function `i2c0_IsMaster&#39;:<br>i2c.c:(.text+=
0x638): multiple definition of `i2c0_IsMaster&#39;<br>

i2cdx.o:i2cdx.c:(.text+0x638): first defined here<br>i2c.o: In function `i2=
c1_IsMaster&#39;:<br>i2c.c:(.text+0x64c): multiple definition of `i2c1_IsMa=
ster&#39;<br>i2cdx.o:i2cdx.c:(.text+0x64c): first defined here<br>i2c.o: In=
 function `i2c0_CheckBusBusy&#39;:<br>

i2c.c:(.text+0x660): multiple definition of `i2c0_CheckBusBusy&#39;<br>i2cd=
x.o:i2cdx.c:(.text+0x660): first defined here<br>i2c.o: In function `i2c1_C=
heckBusBusy&#39;:<br>i2c.c:(.text+0x674): multiple definition of `i2c1_Chec=
kBusBusy&#39;<br>

i2cdx.o:i2cdx.c:(.text+0x674): first defined here<br>i2c.o: In function `i2=
c0_CheckTXDone&#39;:<br>i2c.c:(.text+0x688): multiple definition of `i2c0_C=
heckTXDone&#39;<br>i2cdx.o:i2cdx.c:(.text+0x688): first defined here<br>

i2c.o: In function `i2c1_CheckTXDone&#39;:<br>i2c.c:(.text+0x69c): multiple=
 definition of `i2c1_CheckTXDone&#39;<br>i2cdx.o:i2cdx.c:(.text+0x69c): fir=
st defined here<br>i2c.o: In function `i2c0_ClearTXDone&#39;:<br>i2c.c:(.te=
xt+0x6b0): multiple definition of `i2c0_ClearTXDone&#39;<br>

i2cdx.o:i2cdx.c:(.text+0x6b0): first defined here<br>i2c.o: In function `i2=
c1_ClearTXDone&#39;:<br>i2c.c:(.text+0x6c4): multiple definition of `i2c1_C=
learTXDone&#39;<br>i2cdx.o:i2cdx.c:(.text+0x6c4): first defined here<br>

i2c.o: In function `i2c0_CheckRXRdy&#39;:<br>i2c.c:(.text+0x6d8): multiple =
definition of `i2c0_CheckRXRdy&#39;<br>i2cdx.o:i2cdx.c:(.text+0x6d8): first=
 defined here<br>i2c.o: In function `i2c1_CheckRXRdy&#39;:<br>i2c.c:(.text+=
0x6ec): multiple definition of `i2c1_CheckRXRdy&#39;<br>

i2cdx.o:i2cdx.c:(.text+0x6ec): first defined here<br>i2c.o: In function `i2=
c0_ClearRXRdy&#39;:<br>i2c.c:(.text+0x700): multiple definition of `i2c0_Cl=
earRXRdy&#39;<br>i2cdx.o:i2cdx.c:(.text+0x700): first defined here<br>
i2c.o: In function `i2c1_ClearRXRdy&#39;:<br>
i2c.c:(.text+0x714): multiple definition of `i2c1_ClearRXRdy&#39;<br>i2cdx.=
o:i2cdx.c:(.text+0x714): first defined here<br>i2c.o: In function `i2c0_Wri=
teDataREG&#39;:<br>i2c.c:(.text+0x728): multiple definition of `i2c0_WriteD=
ataREG&#39;<br>

i2cdx.o:i2cdx.c:(.text+0x728): first defined here<br>i2c.o: In function `i2=
c1_WriteDataREG&#39;:<br>i2c.c:(.text+0x74a): multiple definition of `i2c1_=
WriteDataREG&#39;<br>i2cdx.o:i2cdx.c:(.text+0x74a): first defined here<br>

i2c.o: In function `i2c0_ReadDataREG&#39;:<br>i2c.c:(.text+0x76c): multiple=
 definition of `i2c0_ReadDataREG&#39;<br>i2cdx.o:i2cdx.c:(.text+0x76c): fir=
st defined here<br>i2c.o: In function `i2c1_ReadDataREG&#39;:<br>i2c.c:(.te=
xt+0x780): multiple definition of `i2c1_ReadDataREG&#39;<br>

i2cdx.o:i2cdx.c:(.text+0x780): first defined here<br>i2c.o: In function `i2=
c0master_SetStopBit&#39;:<br>i2c.c:(.text+0x794): multiple definition of `i=
2c0master_SetStopBit&#39;<br>i2cdx.o:i2cdx.c:(.text+0x794): first defined h=
ere<br>

i2c.o: In function `i2c1master_SetStopBit&#39;:<br>i2c.c:(.text+0x7a8): mul=
tiple definition of `i2c1master_SetStopBit&#39;<br>i2cdx.o:i2cdx.c:(.text+0=
x7a8): first defined here<br>i2c.o: In function `i2c0master_CheckStopBit&#3=
9;:<br>

i2c.c:(.text+0x7bc): multiple definition of `i2c0master_CheckStopBit&#39;<b=
r>i2cdx.o:i2cdx.c:(.text+0x7bc): first defined here<br>i2c.o: In function `=
i2c1master_CheckStopBit&#39;:<br>i2c.c:(.text+0x7d0): multiple definition o=
f `i2c1master_CheckStopBit&#39;<br>

i2cdx.o:i2cdx.c:(.text+0x7d0): first defined here<br>i2c.o: In function `i2=
c0master_CheckARLoss&#39;:<br>i2c.c:(.text+0x7e4): multiple definition of `=
i2c0master_CheckARLoss&#39;<br>i2cdx.o:i2cdx.c:(.text+0x7e4): first defined=
 here<br>

i2c.o: In function `i2c1master_CheckARLoss&#39;:<br>i2c.c:(.text+0x7f8): mu=
ltiple definition of `i2c1master_CheckARLoss&#39;<br>i2cdx.o:i2cdx.c:(.text=
+0x7f8): first defined here<br>i2c.o: In function `i2c0master_ClearARLoss&#=
39;:<br>

i2c.c:(.text+0x80c): multiple definition of `i2c0master_ClearARLoss&#39;<br=
>i2cdx.o:i2cdx.c:(.text+0x80c): first defined here<br>i2c.o: In function `i=
2c1master_ClearARLoss&#39;:<br>i2c.c:(.text+0x820): multiple definition of =
`i2c1master_ClearARLoss&#39;<br>

i2cdx.o:i2cdx.c:(.text+0x820): first defined here<br>i2c.o: In function `i2=
c0master_CheckAckErr&#39;:<br>i2c.c:(.text+0x834): multiple definition of `=
i2c0master_CheckAckErr&#39;<br>i2cdx.o:i2cdx.c:(.text+0x834): first defined=
 here<br>

i2c.o: In function `i2c1master_CheckAckErr&#39;:<br>i2c.c:(.text+0x848): mu=
ltiple definition of `i2c1master_CheckAckErr&#39;<br>i2cdx.o:i2cdx.c:(.text=
+0x848): first defined here<br>i2c.o: In function `i2c0master_ClearAckErr&#=
39;:<br>

i2c.c:(.text+0x85c): multiple definition of `i2c0master_ClearAckErr&#39;<br=
>i2cdx.o:i2cdx.c:(.text+0x85c): first defined here<br>i2c.o: In function `i=
2c1master_ClearAckErr&#39;:<br>i2c.c:(.text+0x870): multiple definition of =
`i2c1master_ClearAckErr&#39;<br>

i2cdx.o:i2cdx.c:(.text+0x870): first defined here<br>i2c.o: In function `i2=
c0master_WriteAddrREG&#39;:<br>i2c.c:(.text+0x884): multiple definition of =
`i2c0master_WriteAddrREG&#39;<br>i2cdx.o:i2cdx.c:(.text+0x884): first defin=
ed here<br>

i2c.o: In function `i2c1master_WriteAddrREG&#39;:<br>i2c.c:(.text+0x8b4): m=
ultiple definition of `i2c1master_WriteAddrREG&#39;<br>i2cdx.o:i2cdx.c:(.te=
xt+0x8b4): first defined here<br>i2c.o: In function `i2c0slave_EnableACK&#3=
9;:<br>

i2c.c:(.text+0x8e4): multiple definition of `i2c0slave_EnableACK&#39;<br>i2=
cdx.o:i2cdx.c:(.text+0x8e4): first defined here<br>i2c.o: In function `i2c1=
slave_EnableACK&#39;:<br>i2c.c:(.text+0x8f8): multiple definition of `i2c1s=
lave_EnableACK&#39;<br>

i2cdx.o:i2cdx.c:(.text+0x8f8): first defined here<br>i2c.o: In function `i2=
c0slave_EnableNAK&#39;:<br>i2c.c:(.text+0x90c): multiple definition of `i2c=
0slave_EnableNAK&#39;<br>i2cdx.o:i2cdx.c:(.text+0x90c): first defined here<=
br>

i2c.o: In function `i2c1slave_EnableNAK&#39;:<br>i2c.c:(.text+0x920): multi=
ple definition of `i2c1slave_EnableNAK&#39;<br>i2cdx.o:i2cdx.c:(.text+0x920=
): first defined here<br>i2c.o: In function `i2c0slave_SetAddr&#39;:<br>

i2c.c:(.text+0x934): multiple definition of `i2c0slave_SetAddr&#39;<br>i2cd=
x.o:i2cdx.c:(.text+0x934): first defined here<br>i2c.o: In function `i2c1sl=
ave_SetAddr&#39;:<br>i2c.c:(.text+0x956): multiple definition of `i2c1slave=
_SetAddr&#39;<br>

i2cdx.o:i2cdx.c:(.text+0x956): first defined here<br>i2c.o: In function `i2=
c0slave_CheckSlaveWREQ&#39;:<br>i2c.c:(.text+0x978): multiple definition of=
 `i2c0slave_CheckSlaveWREQ&#39;<br>i2cdx.o:i2cdx.c:(.text+0x978): first def=
ined here<br>

i2c.o: In function `i2c1slave_CheckSlaveWREQ&#39;:<br>i2c.c:(.text+0x98c): =
multiple definition of `i2c1slave_CheckSlaveWREQ&#39;<br>i2cdx.o:i2cdx.c:(.=
text+0x98c): first defined here<br>i2c.o: In function `i2c0slave_ClearSlave=
WREQ&#39;:<br>

i2c.c:(.text+0x9a0): multiple definition of `i2c0slave_ClearSlaveWREQ&#39;<=
br>i2cdx.o:i2cdx.c:(.text+0x9a0): first defined here<br>i2c.o: In function =
`i2c1slave_ClearSlaveWREQ&#39;:<br>i2c.c:(.text+0x9b4): multiple definition=
 of `i2c1slave_ClearSlaveWREQ&#39;<br>

i2cdx.o:i2cdx.c:(.text+0x9b4): first defined here<br>ad79x8.o: In function =
`read_sb_regb&#39;:<br>ad79x8.c:(.text+0x0): multiple definition of `read_s=
b_regb&#39;<br>spidx.o:spidx.c:(.text+0x0): first defined here<br>ad79x8.o:=
 In function `read_sb_regw&#39;:<br>

ad79x8.c:(.text+0x44): multiple definition of `read_sb_regw&#39;<br>spidx.o=
:spidx.c:(.text+0x44): first defined here<br>ad79x8.o: In function `read_sb=
_reg&#39;:<br>ad79x8.c:(.text+0x8d): multiple definition of `read_sb_reg&#3=
9;<br>

spidx.o:spidx.c:(.text+0x8d): first defined here<br>ad79x8.o: In function `=
write_sb_regb&#39;:<br>ad79x8.c:(.text+0xc3): multiple definition of `write=
_sb_regb&#39;<br>spidx.o:spidx.c:(.text+0xc3): first defined here<br>ad79x8=
.o: In function `write_sb_regw&#39;:<br>

ad79x8.c:(.text+0x14a): multiple definition of `write_sb_regw&#39;<br>spidx=
.o:spidx.c:(.text+0x14a): first defined here<br>ad79x8.o: In function `writ=
e_sb_reg&#39;:<br>ad79x8.c:(.text+0x1ca): multiple definition of `write_sb_=
reg&#39;<br>

spidx.o:spidx.c:(.text+0x1ca): first defined here<br>ad79x8.o: In function =
`read_nb_regb&#39;:<br>ad79x8.c:(.text+0x207): multiple definition of `read=
_nb_regb&#39;<br>spidx.o:spidx.c:(.text+0x207): first defined here<br>
ad79x8.o: In function `read_nb_regw&#39;:<br>
ad79x8.c:(.text+0x24b): multiple definition of `read_nb_regw&#39;<br>spidx.=
o:spidx.c:(.text+0x24b): first defined here<br>ad79x8.o: In function `read_=
nb_reg&#39;:<br>ad79x8.c:(.text+0x294): multiple definition of `read_nb_reg=
&#39;<br>

spidx.o:spidx.c:(.text+0x294): first defined here<br>ad79x8.o: In function =
`write_nb_regb&#39;:<br>ad79x8.c:(.text+0x2ca): multiple definition of `wri=
te_nb_regb&#39;<br>spidx.o:spidx.c:(.text+0x2ca): first defined here<br>

ad79x8.o: In function `write_nb_regw&#39;:<br>ad79x8.c:(.text+0x351): multi=
ple definition of `write_nb_regw&#39;<br>spidx.o:spidx.c:(.text+0x351): fir=
st defined here<br>ad79x8.o: In function `write_nb_reg&#39;:<br>ad79x8.c:(.=
text+0x3d1): multiple definition of `write_nb_reg&#39;<br>

spidx.o:spidx.c:(.text+0x3d1): first defined here<br>/usr/lib/gcc/i486-linu=
x-gnu/4.4.1/../../../../lib/crt1.o: In function `_start&#39;:<br>/build/bui=
ldd/eglibc-2.10.1/csu/../sysdeps/i386/elf/start.S:115: undefined reference =
to `main&#39;<br>

collect2: ld returned 1 exit status<br>make: *** [testingxenomai] Error 1<b=
r>##########################################END############################=
<br><br><br><br><br>
<br>

--000e0cd2583ca99ee204a7dac211--

--000e0cd2583ca99ef804a7dac213
Content-Type: application/octet-stream; name=Makefile
Content-Disposition: attachment; filename=Makefile
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gq0kiugg1

IyMjIyMjIENPTkZJR1VSQVRJT04gIyMjIyMjCgojIyMgTGlzdCBvZiBhcHBsaWNhdGlvbnMgdG8g
YmUgYnVpbGQKQVBQTElDQVRJT05TID0gdGVzdGluZ3hlbm9tYWkgCgojIyMgTm90ZTogdG8gb3Zl
cnJpZGUgdGhlIHNlYXJjaCBwYXRoIGZvciB0aGUgeGVuby1jb25maWcgc2NyaXB0LCB1c2UgIm1h
a2UgWEVOTz0uLi4iCgojIyMgTGlzdCBvZiBtb2R1bGVzIHRvIGJlIGJ1aWxkCk1PRFVMRVMgPQoK
IyMjIE5vdGU6IHRvIG92ZXJyaWRlIHRoZSBrZXJuZWwgc291cmNlIHBhdGgsIHVzZSAibWFrZSBL
U1JDPS4uLiIKClJPQk9BUkRfTElCPS4vcm9ib2FyZF9saWIvCgojIyMjIyMgVVNFUiBTUEFDRSBC
VUlMRCAobm8gY2hhbmdlIHJlcXVpcmVkIG5vcm1hbGx5KSAjIyMjIyMKaWZlcSAoJChLRVJORUxS
RUxFQVNFKSwpCmlmbmVxICgkKEFQUExJQ0FUSU9OUyksKQoKIyMjIERlZmF1bHQgWGVub21haSBp
bnN0YWxsYXRpb24gcGF0aApYRU5PID89IC91c3IveGVub21haQoKWEVOT0NPTkZJRz0kKHNoZWxs
IFBBVEg9JChYRU5PKTokKFhFTk8pL2JpbjokKFBBVEgpIHdoaWNoIHhlbm8tY29uZmlnIDI+L2Rl
di9udWxsKQoKIyMjIFNhbml0eSBjaGVjawppZmVxICgkKFhFTk9DT05GSUcpLCkKYWxsOjoKCUBl
Y2hvICI+Pj4gSW52b2tlIG1ha2UgbGlrZSB0aGlzOiBcIm1ha2UgWEVOTz0vcGF0aC90by94ZW5v
LWNvbmZpZ1wiIDw8PCIKCUBlY2hvCmVuZGlmCgpPQkpFQ1RTID0gICAgICBcCgkJc3BpZHgubyBc
CgkJc3BpLm8gXAoJCXJjc2Vydm8ubyBcCgkJcHdtZHgubyBcCgkJcHdtLm8gXAoJCWlvLm8gXAoJ
CWkyY2R4Lm8gXAoJCWkyYy5vIFwKCQljb21tb24ubyBcCgkJYWQ3OXg4Lm8gXAoKSU5DTFVERV9E
SVI9Li9yb2JvYXJkX2xpYgoKQ0M9JChzaGVsbCAkKFhFTk9DT05GSUcpIC0tY2MpCgojQ1BQPSQo
c2hlbGwgJChYRU5PQ09ORklHKSAtLWcrKykKCiNDRkxBR1M9JChzaGVsbCAkKFhFTk9DT05GSUcp
IC0teGVuby1jZmxhZ3MpICQoTVlfQ0ZMQUdTKSAtV2FsbCAjLURST0JPSU9fRExMCkNGTEFHUz0k
KHNoZWxsICQoWEVOT0NPTkZJRykgLS1za2luIG5hdGl2ZSAtLWNmbGFncykgIyQoTVlfQ0ZMQUdT
KSAKCiNMREZMQUdTPSQoc2hlbGwgJChYRU5PQ09ORklHKSAtLXhlbm8tbGRmbGFncykgJChNWV9M
REZMQUdTKSAtbG5hdGl2ZQpMREZMQUdTPSQoc2hlbGwgJChYRU5PQ09ORklHKSAtLXNraW4gbmF0
aXZlIC0tbGRmbGFncykjICQoTVlfTERGTEFHUykgIy1sbmF0aXZlCgojIFRoaXMgaW5jbHVkZXMg
dGhlIGxpYnJhcnkgcGF0aCBvZiBnaXZlbiBYZW5vbWFpIGludG8gdGhlIGJpbmFyeSB0byBtYWtl
IGxpdmUKIyBlYXNpZXIgZm9yIGJlZ2lubmVycyBpZiBYZW5vbWFpJ3MgbGlicyBhcmUgbm90IGlu
IGFueSBkZWZhdWx0IHNlYXJjaCBwYXRoLgojIExERkxBR1MrPS1YbGlua2VyIC1ycGF0aCAtWGxp
bmtlciAkKHNoZWxsICQoWEVOT0NPTkZJRykgLS1saWJkaXIpCgphbGw6OiAkKEFQUExJQ0FUSU9O
UykKCmNsZWFuOjoKCSQoUk0pICQoQVBQTElDQVRJT05TKSAqLm8KCmVuZGlmCmVuZGlmCgojIyMj
IyMgU1BFQ0lBTCBUQVJHRVQgUlVMRVMgIyMjIyMjCiNydHByaW50OiBydHByaW50LmMKIwkkKEND
KSAkKENGTEFHUykgJD8gJChMREZMQUdTKSAtbHJ0ZGsgLW8gJEAKCgpzcGlkeC5vIDogJChST0JP
QVJEX0xJQilzcGlkeC5jCgkkKENDKSAkKENGTEFHUykgLUkkKElOQ0xVREVfRElSKSAtYyAkKFJP
Qk9BUkRfTElCKXNwaWR4LmMKCnNwaS5vIDogJChST0JPQVJEX0xJQilzcGkuYwoJJChDQykgJChD
RkxBR1MpIC1JJChJTkNMVURFX0RJUikgLWMgJChST0JPQVJEX0xJQilzcGkuYwoKcmNzZXJ2by5v
IDogJChST0JPQVJEX0xJQilyY3NlcnZvLmMKCSQoQ0MpICQoQ0ZMQUdTKSAtSSQoSU5DTFVERV9E
SVIpIC1jICQoUk9CT0FSRF9MSUIpcmNzZXJ2by5jCgpwd21keC5vIDogJChST0JPQVJEX0xJQilw
d21keC5jCgkkKENDKSAkKENGTEFHUykgLUkkKElOQ0xVREVfRElSKSAtYyAkKFJPQk9BUkRfTElC
KXB3bWR4LmMKCnB3bS5vIDogJChST0JPQVJEX0xJQilwd20uYwoJJChDQykgJChDRkxBR1MpIC1J
JChJTkNMVURFX0RJUikgLWMgJChST0JPQVJEX0xJQilwd20uYwoKaW8ubyA6ICQoUk9CT0FSRF9M
SUIpaW8uYwoJJChDQykgJChDRkxBR1MpIC1JJChJTkNMVURFX0RJUikgLWMgJChST0JPQVJEX0xJ
Qilpby5jCgppMmNkeC5vIDogJChST0JPQVJEX0xJQilpMmNkeC5jCgkkKENDKSAkKENGTEFHUykg
LUkkKElOQ0xVREVfRElSKSAtYyAkKFJPQk9BUkRfTElCKWkyY2R4LmMKCmkyYy5vIDogJChST0JP
QVJEX0xJQilpMmMuYwoJJChDQykgJChDRkxBR1MpIC1JJChJTkNMVURFX0RJUikgLWMgJChST0JP
QVJEX0xJQilpMmMuYwoKY29tbW9uLm8gOiAkKFJPQk9BUkRfTElCKWNvbW1vbi5jCgkkKENDKSAk
KENGTEFHUykgLUkkKElOQ0xVREVfRElSKSAtYyAkKFJPQk9BUkRfTElCKWNvbW1vbi5jCgphZDc5
eDgubyA6ICQoUk9CT0FSRF9MSUIpYWQ3OXg4LmMKCSQoQ0MpICQoQ0ZMQUdTKSAtSS4vcm9ib2Fy
ZF9saWIgLWMgJChST0JPQVJEX0xJQilhZDc5eDguYwoKCnRlc3Rpbmd4ZW5vbWFpOiAgJChPQkpF
Q1RTKQojCSQoQ0MpICQoQ0ZMQUdTKSAkKE9CSkVDVFMpICQoTERGTEFHUykgLWxydGRrIC1vICRA
CgkkKENDKSAkKENGTEFHUykgJChMREZMQUdTKSAtbyAkQCAkKE9CSkVDVFMpIC1scnRkayAKCgoj
IyMjIyMgS0VSTkVMIE1PRFVMRSBCVUlMRCAobm8gY2hhbmdlIHJlcXVpcmVkIG5vcm1hbGx5KSAj
IyMjIyMKaWZuZXEgKCQoTU9EVUxFUyksKQoKIyMjIERlZmF1bHQgdG8gc291cmNlcyBvZiBjdXJy
ZW50bHkgcnVubmluZyBrZXJuZWwKS1NSQyA/PSAvbGliL21vZHVsZXMvJChzaGVsbCB1bmFtZSAt
cikvYnVpbGQKCk9CSlMgICAgIDo9ICR7cGF0c3Vic3QgJSwgJS5vLCAkKE1PRFVMRVMpfQpDTEVB
Tk1PRCA6PSAke3BhdHN1YnN0ICUsIC4lKiwgJChNT0RVTEVTKX0KUFdEICAgICAgOj0gJChzaGVs
bCBpZiBbICIkJFBXRCIgIT0gIiIgXTsgdGhlbiBlY2hvICQkUFdEOyBlbHNlIHB3ZDsgZmkpCgoj
IyMgS2VybmVsIDIuNgppZmVxICgkKGZpbmRzdHJpbmcgMi42LCQoS1NSQykpLDIuNikKCm9iai1t
ICAgICAgICA6PSAkKE9CSlMpCkVYVFJBX0NGTEFHUyA6PSAtSSQoS1NSQykvaW5jbHVkZS94ZW5v
bWFpIC1JJChLU1JDKS9pbmNsdWRlL3hlbm9tYWkvcG9zaXggLUkkKEFERF9DRkxBR1MpIC1JJChQ
V0QpIC1JJC4vCgphbGw6OgoJJChNQUtFKSAtQyAkKEtTUkMpIFNVQkRJUlM9JChQV0QpIG1vZHVs
ZXMKCiMjIyBLZXJuZWwgMi40CmVsc2UKCkFSQ0ggICAgPz0gJChzaGVsbCB1bmFtZSAtaSkKSU5D
TFVERSA6PSAtSSQoS1NSQykvaW5jbHVkZS94ZW5vbWFpIC1JJChLU1JDKS9pbmNsdWRlL3hlbm9t
YWkvY29tcGF0IC1JJChLU1JDKS9pbmNsdWRlL3hlbm9tYWkvcG9zaXgKQ0ZMQUdTICArPSAkKHNo
ZWxsICQoTUFLRSkgLXMgLUMgJChLU1JDKSBDQz0kKENDKSBBUkNIPSQoQVJDSCkgU1VCRElSUz0k
KFBXRCkgbW9kdWxlcykgJChJTkNMVURFKQoKYWxsOjogJChPQkpTKQoKZW5kaWYKCiMjIFRhcmdl
dCBmb3IgY2FwdHVyaW5nIDIuNCBtb2R1bGUgQ0ZMQUdTCm1vZHVsZXM6CglAZWNobyAiJChDRkxB
R1MpIgoKY2xlYW46OgoJJChSTSkgJChDTEVBTk1PRCkgKi5vICoua28gKi5tb2QuYyBNb2R1bGUq
LnN5bXZlcnMgTW9kdWxlLm1hcmtlcnMgbW9kdWxlcy5vcmRlcgoJJChSTSkgLVIgLnRtcCoKCmVu
ZGlmCg==
--000e0cd2583ca99ef804a7dac213
Content-Type: text/x-csrc; charset=US-ASCII; name="testingxenomai.c"
Content-Disposition: attachment; filename="testingxenomai.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gq0kjmel2

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRib29sLmg+CiNpbmNsdWRlIDxzaWduYWwu
aD4KI2luY2x1ZGUgPHVuaXN0ZC5oPgojaW5jbHVkZSA8c3lzL21tYW4uaD4KCiNpbmNsdWRlIDxu
YXRpdmUvdGFzay5oPgojaW5jbHVkZSA8bmF0aXZlL3RpbWVyLmg+CgovLyNpbmNsdWRlICIuL3Jv
Ym9hcmRfbGliL2RlZmluZXMuaCIKI2luY2x1ZGUgIi4vcm9ib2FyZF9saWIvcHdtLmgiCgojaW5j
bHVkZSAiLi9yb2JvYXJkX2xpYi9yb2JvYXJkLmgiCgoKUlRfVEFTSyBkZW1vX3Rhc2s7CgovKiBO
T1RFOiBlcnJvciBoYW5kbGluZyBvbWl0dGVkLiAqLwoKdm9pZCBkZW1vKHZvaWQgKmFyZykKewoJ
UlRJTUUgbm93LCBwcmV2aW91czsKCgkvKgoJICogQXJndW1lbnRzOiAmdGFzayAoTlVMTD1zZWxm
KSwKCSAqICAgICAgICAgICAgc3RhcnQgdGltZSwKCSAqICAgICAgICAgICAgcGVyaW9kIChoZXJl
OiAxIHMpCgkgKi8KCXJ0X3Rhc2tfc2V0X3BlcmlvZGljKE5VTEwsIFRNX05PVywgMTAwMDAwMCk7
ICAgIC8vMSBraHo9MXgxMF42CgkvL3ByZXZpb3VzID0gcnRfdGltZXJfcmVhZCgpOwoKCXdoaWxl
ICgxKSB7CgkJcnRfdGFza193YWl0X3BlcmlvZChOVUxMKTsKCQkvL25vdyA9IHJ0X3RpbWVyX3Jl
YWQoKTsKICAgICAgICAgICAgICAgIGludCB2YWw7CgogICAgICAgICAgICAgICAgIHByaW50Zigi
b3V0IGxvZ2ljIDEgb24gUFdNIGNoYW5uZWwgMCAocGluOiBTMSlcbiIpOwoJICAgICAgICAgcmNz
ZXJ2b19PdXRwKDAsIDEpOwoKCQkgcHJpbnRmKCJvdXQgbG9naWMgMCBvbiBQV00gY2hhbm5lbCAw
IChwaW46IFMxKVxuIik7CgkgCSByY3NlcnZvX091dHAoMCwgMCk7CgoJCS8qCgkJICogTk9URTog
cHJpbnRmIG1heSBoYXZlIHVuZXhwZWN0ZWQgaW1wYWN0IG9uIHRoZSB0aW1pbmcgb2YKCQkgKiAg
ICAgICB5b3VyIHByb2dyYW0uIEl0IGlzIHVzZWQgaGVyZSBpbiB0aGUgY3JpdGljYWwgbG9vcAoJ
CSAqICAgICAgIG9ubHkgZm9yIGRlbW9uc3RyYXRpb24gcHVycG9zZXMuCgkJICovCgkJLypwcmlu
dGYoIlRpbWUgc2luY2UgbGFzdCB0dXJuOiAlbGQuJTA2bGQgbXNcbiIsCgkJICAgICAgIChsb25n
KShub3cgLSBwcmV2aW91cykgLyAxMDAwMDAwLAoJCSAgICAgICAobG9uZykobm93IC0gcHJldmlv
dXMpICUgMTAwMDAwMCk7CgkJICAgICAgIHByZXZpb3VzID0gbm93OyovCgl9Cn0KCnZvaWQgY2F0
Y2hfc2lnbmFsKGludCBzaWcpCnsKfQoKaW50IG1haW4oaW50IGFyZ2MsIGNoYXIqIGFyZ3ZbXSkK
ewoKCXJvYm9pb19TZXRSQlZlcihSQl8xMDApOyAgLy8gc2V0IHRoZSBSb0JvYXJkIHZlcnNpb24K
CSAgICBpZiAocmNzZXJ2b19Jbml0aWFsaXplKFJDU0VSVk9fVVNFTk9DSEFOTkVMKSA9PSBmYWxz
ZSkKICAgIHsKICAgICAgICBwcmludGYoIkVSUjogcmNzZXJ2b19Jbml0aWFsaXplKCkgZmFpbHMg
KCVzKSFcbiIsIHJvYm9pb19HZXRFcnJNc2coKSk7Ci8vICAgICAgICByZXR1cm4gLTE7CiAgICB9
CgoKCXNpZ25hbChTSUdURVJNLCBjYXRjaF9zaWduYWwpOwoJc2lnbmFsKFNJR0lOVCwgY2F0Y2hf
c2lnbmFsKTsKCgkvKiBBdm9pZHMgbWVtb3J5IHN3YXBwaW5nIGZvciB0aGlzIHByb2dyYW0gKi8K
CW1sb2NrYWxsKE1DTF9DVVJSRU5UfE1DTF9GVVRVUkUpOwoKCS8qCgkgKiBBcmd1bWVudHM6ICZ0
YXNrLAoJICogICAgICAgICAgICBuYW1lLAoJICogICAgICAgICAgICBzdGFjayBzaXplICgwPWRl
ZmF1bHQpLAoJICogICAgICAgICAgICBwcmlvcml0eSwKCSAqICAgICAgICAgICAgbW9kZSAoRlBV
LCBzdGFydCBzdXNwZW5kZWQsIC4uLikKCSAqLwoJcnRfdGFza19jcmVhdGUoJmRlbW9fdGFzaywg
InRyaXZpYWwiLCAwLCA5OSwgMCk7CgoJLyoKCSAqIEFyZ3VtZW50czogJnRhc2ssCgkgKiAgICAg
ICAgICAgIHRhc2sgZnVuY3Rpb24sCgkgKiAgICAgICAgICAgIGZ1bmN0aW9uIGFyZ3VtZW50Cgkg
Ki8KCXJ0X3Rhc2tfc3RhcnQoJmRlbW9fdGFzaywgJmRlbW8sIE5VTEwpOwoKCXBhdXNlKCk7CgoJ
cnRfdGFza19kZWxldGUoJmRlbW9fdGFzayk7Cn0K
--000e0cd2583ca99ef804a7dac213
Content-Type: application/octet-stream; name=errrorr
Content-Disposition: attachment; filename=errrorr
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gq0kr7n62

dWd2dWF2cnQ0QHVndnVhdnJ0NC1kZXNrdG9wOn4vdGVzdGluZyBjb2RlcyQgc3VkbyBtYWtlCmdj
YyAtSS91c3IveGVub21haS9pbmNsdWRlIC1EX0dOVV9TT1VSQ0UgLURfUkVFTlRSQU5UIC1XYWxs
IC1waXBlIC1EX19YRU5PX18gIC1JLi9yb2JvYXJkX2xpYiAtYyAuL3JvYm9hcmRfbGliL3NwaWR4
LmMKZ2NjIC1JL3Vzci94ZW5vbWFpL2luY2x1ZGUgLURfR05VX1NPVVJDRSAtRF9SRUVOVFJBTlQg
LVdhbGwgLXBpcGUgLURfX1hFTk9fXyAgLUkuL3JvYm9hcmRfbGliIC1jIC4vcm9ib2FyZF9saWIv
c3BpLmMKZ2NjIC1JL3Vzci94ZW5vbWFpL2luY2x1ZGUgLURfR05VX1NPVVJDRSAtRF9SRUVOVFJB
TlQgLVdhbGwgLXBpcGUgLURfX1hFTk9fXyAgLUkuL3JvYm9hcmRfbGliIC1jIC4vcm9ib2FyZF9s
aWIvcmNzZXJ2by5jCmdjYyAtSS91c3IveGVub21haS9pbmNsdWRlIC1EX0dOVV9TT1VSQ0UgLURf
UkVFTlRSQU5UIC1XYWxsIC1waXBlIC1EX19YRU5PX18gIC1JLi9yb2JvYXJkX2xpYiAtYyAuL3Jv
Ym9hcmRfbGliL3B3bWR4LmMKZ2NjIC1JL3Vzci94ZW5vbWFpL2luY2x1ZGUgLURfR05VX1NPVVJD
RSAtRF9SRUVOVFJBTlQgLVdhbGwgLXBpcGUgLURfX1hFTk9fXyAgLUkuL3JvYm9hcmRfbGliIC1j
IC4vcm9ib2FyZF9saWIvcHdtLmMKZ2NjIC1JL3Vzci94ZW5vbWFpL2luY2x1ZGUgLURfR05VX1NP
VVJDRSAtRF9SRUVOVFJBTlQgLVdhbGwgLXBpcGUgLURfX1hFTk9fXyAgLUkuL3JvYm9hcmRfbGli
IC1jIC4vcm9ib2FyZF9saWIvaW8uYwpnY2MgLUkvdXNyL3hlbm9tYWkvaW5jbHVkZSAtRF9HTlVf
U09VUkNFIC1EX1JFRU5UUkFOVCAtV2FsbCAtcGlwZSAtRF9fWEVOT19fICAtSS4vcm9ib2FyZF9s
aWIgLWMgLi9yb2JvYXJkX2xpYi9pMmNkeC5jCmdjYyAtSS91c3IveGVub21haS9pbmNsdWRlIC1E
X0dOVV9TT1VSQ0UgLURfUkVFTlRSQU5UIC1XYWxsIC1waXBlIC1EX19YRU5PX18gIC1JLi9yb2Jv
YXJkX2xpYiAtYyAuL3JvYm9hcmRfbGliL2kyYy5jCmdjYyAtSS91c3IveGVub21haS9pbmNsdWRl
IC1EX0dOVV9TT1VSQ0UgLURfUkVFTlRSQU5UIC1XYWxsIC1waXBlIC1EX19YRU5PX18gIC1JLi9y
b2JvYXJkX2xpYiAtYyAuL3JvYm9hcmRfbGliL2NvbW1vbi5jCmdjYyAtSS91c3IveGVub21haS9p
bmNsdWRlIC1EX0dOVV9TT1VSQ0UgLURfUkVFTlRSQU5UIC1XYWxsIC1waXBlIC1EX19YRU5PX18g
IC1JLi9yb2JvYXJkX2xpYiAtYyAuL3JvYm9hcmRfbGliL2FkNzl4OC5jCmdjYyAtSS91c3IveGVu
b21haS9pbmNsdWRlIC1EX0dOVV9TT1VSQ0UgLURfUkVFTlRSQU5UIC1XYWxsIC1waXBlIC1EX19Y
RU5PX18gIC1sbmF0aXZlIC1ML3Vzci94ZW5vbWFpL2xpYiAtbHhlbm9tYWkgLWxwdGhyZWFkIC1v
IHRlc3Rpbmd4ZW5vbWFpIHNwaWR4Lm8gc3BpLm8gcmNzZXJ2by5vIHB3bWR4Lm8gcHdtLm8gaW8u
byBpMmNkeC5vIGkyYy5vIGNvbW1vbi5vIGFkNzl4OC5vICAtbHJ0ZGsgCnNwaS5vOiBJbiBmdW5j
dGlvbiBgcmVhZF9zYl9yZWdiJzoKc3BpLmM6KC50ZXh0KzB4MCk6IG11bHRpcGxlIGRlZmluaXRp
b24gb2YgYHJlYWRfc2JfcmVnYicKc3BpZHgubzpzcGlkeC5jOigudGV4dCsweDApOiBmaXJzdCBk
ZWZpbmVkIGhlcmUKc3BpLm86IEluIGZ1bmN0aW9uIGByZWFkX3NiX3JlZ3cnOgpzcGkuYzooLnRl
eHQrMHg0NCk6IG11bHRpcGxlIGRlZmluaXRpb24gb2YgYHJlYWRfc2JfcmVndycKc3BpZHgubzpz
cGlkeC5jOigudGV4dCsweDQ0KTogZmlyc3QgZGVmaW5lZCBoZXJlCnNwaS5vOiBJbiBmdW5jdGlv
biBgcmVhZF9zYl9yZWcnOgpzcGkuYzooLnRleHQrMHg4ZCk6IG11bHRpcGxlIGRlZmluaXRpb24g
b2YgYHJlYWRfc2JfcmVnJwpzcGlkeC5vOnNwaWR4LmM6KC50ZXh0KzB4OGQpOiBmaXJzdCBkZWZp
bmVkIGhlcmUKc3BpLm86IEluIGZ1bmN0aW9uIGB3cml0ZV9zYl9yZWdiJzoKc3BpLmM6KC50ZXh0
KzB4YzMpOiBtdWx0aXBsZSBkZWZpbml0aW9uIG9mIGB3cml0ZV9zYl9yZWdiJwpzcGlkeC5vOnNw
aWR4LmM6KC50ZXh0KzB4YzMpOiBmaXJzdCBkZWZpbmVkIGhlcmUKc3BpLm86IEluIGZ1bmN0aW9u
IGB3cml0ZV9zYl9yZWd3JzoKc3BpLmM6KC50ZXh0KzB4MTRhKTogbXVsdGlwbGUgZGVmaW5pdGlv
biBvZiBgd3JpdGVfc2JfcmVndycKc3BpZHgubzpzcGlkeC5jOigudGV4dCsweDE0YSk6IGZpcnN0
IGRlZmluZWQgaGVyZQpzcGkubzogSW4gZnVuY3Rpb24gYHdyaXRlX3NiX3JlZyc6CnNwaS5jOigu
dGV4dCsweDFjYSk6IG11bHRpcGxlIGRlZmluaXRpb24gb2YgYHdyaXRlX3NiX3JlZycKc3BpZHgu
bzpzcGlkeC5jOigudGV4dCsweDFjYSk6IGZpcnN0IGRlZmluZWQgaGVyZQpzcGkubzogSW4gZnVu
Y3Rpb24gYHJlYWRfbmJfcmVnYic6CnNwaS5jOigudGV4dCsweDIwNyk6IG11bHRpcGxlIGRlZmlu
aXRpb24gb2YgYHJlYWRfbmJfcmVnYicKc3BpZHgubzpzcGlkeC5jOigudGV4dCsweDIwNyk6IGZp
cnN0IGRlZmluZWQgaGVyZQpzcGkubzogSW4gZnVuY3Rpb24gYHJlYWRfbmJfcmVndyc6CnNwaS5j
OigudGV4dCsweDI0Yik6IG11bHRpcGxlIGRlZmluaXRpb24gb2YgYHJlYWRfbmJfcmVndycKc3Bp
ZHgubzpzcGlkeC5jOigudGV4dCsweDI0Yik6IGZpcnN0IGRlZmluZWQgaGVyZQpzcGkubzogSW4g
ZnVuY3Rpb24gYHJlYWRfbmJfcmVnJzoKc3BpLmM6KC50ZXh0KzB4Mjk0KTogbXVsdGlwbGUgZGVm
aW5pdGlvbiBvZiBgcmVhZF9uYl9yZWcnCnNwaWR4Lm86c3BpZHguYzooLnRleHQrMHgyOTQpOiBm
aXJzdCBkZWZpbmVkIGhlcmUKc3BpLm86IEluIGZ1bmN0aW9uIGB3cml0ZV9uYl9yZWdiJzoKc3Bp
LmM6KC50ZXh0KzB4MmNhKTogbXVsdGlwbGUgZGVmaW5pdGlvbiBvZiBgd3JpdGVfbmJfcmVnYicK
c3BpZHgubzpzcGlkeC5jOigudGV4dCsweDJjYSk6IGZpcnN0IGRlZmluZWQgaGVyZQpzcGkubzog
SW4gZnVuY3Rpb24gYHdyaXRlX25iX3JlZ3cnOgpzcGkuYzooLnRleHQrMHgzNTEpOiBtdWx0aXBs
ZSBkZWZpbml0aW9uIG9mIGB3cml0ZV9uYl9yZWd3JwpzcGlkeC5vOnNwaWR4LmM6KC50ZXh0KzB4
MzUxKTogZmlyc3QgZGVmaW5lZCBoZXJlCnNwaS5vOiBJbiBmdW5jdGlvbiBgd3JpdGVfbmJfcmVn
JzoKc3BpLmM6KC50ZXh0KzB4M2QxKTogbXVsdGlwbGUgZGVmaW5pdGlvbiBvZiBgd3JpdGVfbmJf
cmVnJwpzcGlkeC5vOnNwaWR4LmM6KC50ZXh0KzB4M2QxKTogZmlyc3QgZGVmaW5lZCBoZXJlCnJj
c2Vydm8ubzogSW4gZnVuY3Rpb24gYHJlYWRfc2JfcmVnYic6CnJjc2Vydm8uYzooLnRleHQrMHgw
KTogbXVsdGlwbGUgZGVmaW5pdGlvbiBvZiBgcmVhZF9zYl9yZWdiJwpzcGlkeC5vOnNwaWR4LmM6
KC50ZXh0KzB4MCk6IGZpcnN0IGRlZmluZWQgaGVyZQpyY3NlcnZvLm86IEluIGZ1bmN0aW9uIGBy
ZWFkX3NiX3JlZ3cnOgpyY3NlcnZvLmM6KC50ZXh0KzB4NDQpOiBtdWx0aXBsZSBkZWZpbml0aW9u
IG9mIGByZWFkX3NiX3JlZ3cnCnNwaWR4Lm86c3BpZHguYzooLnRleHQrMHg0NCk6IGZpcnN0IGRl
ZmluZWQgaGVyZQpyY3NlcnZvLm86IEluIGZ1bmN0aW9uIGByZWFkX3NiX3JlZyc6CnJjc2Vydm8u
YzooLnRleHQrMHg4ZCk6IG11bHRpcGxlIGRlZmluaXRpb24gb2YgYHJlYWRfc2JfcmVnJwpzcGlk
eC5vOnNwaWR4LmM6KC50ZXh0KzB4OGQpOiBmaXJzdCBkZWZpbmVkIGhlcmUKcmNzZXJ2by5vOiBJ
biBmdW5jdGlvbiBgd3JpdGVfc2JfcmVnYic6CnJjc2Vydm8uYzooLnRleHQrMHhjMyk6IG11bHRp
cGxlIGRlZmluaXRpb24gb2YgYHdyaXRlX3NiX3JlZ2InCnNwaWR4Lm86c3BpZHguYzooLnRleHQr
MHhjMyk6IGZpcnN0IGRlZmluZWQgaGVyZQpyY3NlcnZvLm86IEluIGZ1bmN0aW9uIGB3cml0ZV9z
Yl9yZWd3JzoKcmNzZXJ2by5jOigudGV4dCsweDE0YSk6IG11bHRpcGxlIGRlZmluaXRpb24gb2Yg
YHdyaXRlX3NiX3JlZ3cnCnNwaWR4Lm86c3BpZHguYzooLnRleHQrMHgxNGEpOiBmaXJzdCBkZWZp
bmVkIGhlcmUKcmNzZXJ2by5vOiBJbiBmdW5jdGlvbiBgd3JpdGVfc2JfcmVnJzoKcmNzZXJ2by5j
OigudGV4dCsweDFjYSk6IG11bHRpcGxlIGRlZmluaXRpb24gb2YgYHdyaXRlX3NiX3JlZycKc3Bp
ZHgubzpzcGlkeC5jOigudGV4dCsweDFjYSk6IGZpcnN0IGRlZmluZWQgaGVyZQpyY3NlcnZvLm86
IEluIGZ1bmN0aW9uIGByZWFkX25iX3JlZ2InOgpyY3NlcnZvLmM6KC50ZXh0KzB4MjA3KTogbXVs
dGlwbGUgZGVmaW5pdGlvbiBvZiBgcmVhZF9uYl9yZWdiJwpzcGlkeC5vOnNwaWR4LmM6KC50ZXh0
KzB4MjA3KTogZmlyc3QgZGVmaW5lZCBoZXJlCnJjc2Vydm8ubzogSW4gZnVuY3Rpb24gYHJlYWRf
bmJfcmVndyc6CnJjc2Vydm8uYzooLnRleHQrMHgyNGIpOiBtdWx0aXBsZSBkZWZpbml0aW9uIG9m
IGByZWFkX25iX3JlZ3cnCnNwaWR4Lm86c3BpZHguYzooLnRleHQrMHgyNGIpOiBmaXJzdCBkZWZp
bmVkIGhlcmUKcmNzZXJ2by5vOiBJbiBmdW5jdGlvbiBgcmVhZF9uYl9yZWcnOgpyY3NlcnZvLmM6
KC50ZXh0KzB4Mjk0KTogbXVsdGlwbGUgZGVmaW5pdGlvbiBvZiBgcmVhZF9uYl9yZWcnCnNwaWR4
Lm86c3BpZHguYzooLnRleHQrMHgyOTQpOiBmaXJzdCBkZWZpbmVkIGhlcmUKcmNzZXJ2by5vOiBJ
biBmdW5jdGlvbiBgd3JpdGVfbmJfcmVnYic6CnJjc2Vydm8uYzooLnRleHQrMHgyY2EpOiBtdWx0
aXBsZSBkZWZpbml0aW9uIG9mIGB3cml0ZV9uYl9yZWdiJwpzcGlkeC5vOnNwaWR4LmM6KC50ZXh0
KzB4MmNhKTogZmlyc3QgZGVmaW5lZCBoZXJlCnJjc2Vydm8ubzogSW4gZnVuY3Rpb24gYHdyaXRl
X25iX3JlZ3cnOgpyY3NlcnZvLmM6KC50ZXh0KzB4MzUxKTogbXVsdGlwbGUgZGVmaW5pdGlvbiBv
ZiBgd3JpdGVfbmJfcmVndycKc3BpZHgubzpzcGlkeC5jOigudGV4dCsweDM1MSk6IGZpcnN0IGRl
ZmluZWQgaGVyZQpyY3NlcnZvLm86IEluIGZ1bmN0aW9uIGB3cml0ZV9uYl9yZWcnOgpyY3NlcnZv
LmM6KC50ZXh0KzB4M2QxKTogbXVsdGlwbGUgZGVmaW5pdGlvbiBvZiBgd3JpdGVfbmJfcmVnJwpz
cGlkeC5vOnNwaWR4LmM6KC50ZXh0KzB4M2QxKTogZmlyc3QgZGVmaW5lZCBoZXJlCnB3bWR4Lm86
IEluIGZ1bmN0aW9uIGByZWFkX3NiX3JlZ2InOgpwd21keC5jOigudGV4dCsweDApOiBtdWx0aXBs
ZSBkZWZpbml0aW9uIG9mIGByZWFkX3NiX3JlZ2InCnNwaWR4Lm86c3BpZHguYzooLnRleHQrMHgw
KTogZmlyc3QgZGVmaW5lZCBoZXJlCnB3bWR4Lm86IEluIGZ1bmN0aW9uIGByZWFkX3NiX3JlZ3cn
Ogpwd21keC5jOigudGV4dCsweDQ0KTogbXVsdGlwbGUgZGVmaW5pdGlvbiBvZiBgcmVhZF9zYl9y
ZWd3JwpzcGlkeC5vOnNwaWR4LmM6KC50ZXh0KzB4NDQpOiBmaXJzdCBkZWZpbmVkIGhlcmUKcHdt
ZHgubzogSW4gZnVuY3Rpb24gYHJlYWRfc2JfcmVnJzoKcHdtZHguYzooLnRleHQrMHg4ZCk6IG11
bHRpcGxlIGRlZmluaXRpb24gb2YgYHJlYWRfc2JfcmVnJwpzcGlkeC5vOnNwaWR4LmM6KC50ZXh0
KzB4OGQpOiBmaXJzdCBkZWZpbmVkIGhlcmUKcHdtZHgubzogSW4gZnVuY3Rpb24gYHdyaXRlX3Ni
X3JlZ2InOgpwd21keC5jOigudGV4dCsweGMzKTogbXVsdGlwbGUgZGVmaW5pdGlvbiBvZiBgd3Jp
dGVfc2JfcmVnYicKc3BpZHgubzpzcGlkeC5jOigudGV4dCsweGMzKTogZmlyc3QgZGVmaW5lZCBo
ZXJlCnB3bWR4Lm86IEluIGZ1bmN0aW9uIGB3cml0ZV9zYl9yZWd3JzoKcHdtZHguYzooLnRleHQr
MHgxNGEpOiBtdWx0aXBsZSBkZWZpbml0aW9uIG9mIGB3cml0ZV9zYl9yZWd3JwpzcGlkeC5vOnNw
aWR4LmM6KC50ZXh0KzB4MTRhKTogZmlyc3QgZGVmaW5lZCBoZXJlCnB3bWR4Lm86IEluIGZ1bmN0
aW9uIGB3cml0ZV9zYl9yZWcnOgpwd21keC5jOigudGV4dCsweDFjYSk6IG11bHRpcGxlIGRlZmlu
aXRpb24gb2YgYHdyaXRlX3NiX3JlZycKc3BpZHgubzpzcGlkeC5jOigudGV4dCsweDFjYSk6IGZp
cnN0IGRlZmluZWQgaGVyZQpwd21keC5vOiBJbiBmdW5jdGlvbiBgcmVhZF9uYl9yZWdiJzoKcHdt
ZHguYzooLnRleHQrMHgyMDcpOiBtdWx0aXBsZSBkZWZpbml0aW9uIG9mIGByZWFkX25iX3JlZ2In
CnNwaWR4Lm86c3BpZHguYzooLnRleHQrMHgyMDcpOiBmaXJzdCBkZWZpbmVkIGhlcmUKcHdtZHgu
bzogSW4gZnVuY3Rpb24gYHJlYWRfbmJfcmVndyc6CnB3bWR4LmM6KC50ZXh0KzB4MjRiKTogbXVs
dGlwbGUgZGVmaW5pdGlvbiBvZiBgcmVhZF9uYl9yZWd3JwpzcGlkeC5vOnNwaWR4LmM6KC50ZXh0
KzB4MjRiKTogZmlyc3QgZGVmaW5lZCBoZXJlCnB3bWR4Lm86IEluIGZ1bmN0aW9uIGByZWFkX25i
X3JlZyc6CnB3bWR4LmM6KC50ZXh0KzB4Mjk0KTogbXVsdGlwbGUgZGVmaW5pdGlvbiBvZiBgcmVh
ZF9uYl9yZWcnCnNwaWR4Lm86c3BpZHguYzooLnRleHQrMHgyOTQpOiBmaXJzdCBkZWZpbmVkIGhl
cmUKcHdtZHgubzogSW4gZnVuY3Rpb24gYHdyaXRlX25iX3JlZ2InOgpwd21keC5jOigudGV4dCsw
eDJjYSk6IG11bHRpcGxlIGRlZmluaXRpb24gb2YgYHdyaXRlX25iX3JlZ2InCnNwaWR4Lm86c3Bp
ZHguYzooLnRleHQrMHgyY2EpOiBmaXJzdCBkZWZpbmVkIGhlcmUKcHdtZHgubzogSW4gZnVuY3Rp
b24gYHdyaXRlX25iX3JlZ3cnOgpwd21keC5jOigudGV4dCsweDM1MSk6IG11bHRpcGxlIGRlZmlu
aXRpb24gb2YgYHdyaXRlX25iX3JlZ3cnCnNwaWR4Lm86c3BpZHguYzooLnRleHQrMHgzNTEpOiBm
aXJzdCBkZWZpbmVkIGhlcmUKcHdtZHgubzogSW4gZnVuY3Rpb24gYHdyaXRlX25iX3JlZyc6CnB3
bWR4LmM6KC50ZXh0KzB4M2QxKTogbXVsdGlwbGUgZGVmaW5pdGlvbiBvZiBgd3JpdGVfbmJfcmVn
JwpzcGlkeC5vOnNwaWR4LmM6KC50ZXh0KzB4M2QxKTogZmlyc3QgZGVmaW5lZCBoZXJlCnB3bS5v
OiBJbiBmdW5jdGlvbiBgcmVhZF9zYl9yZWdiJzoKcHdtLmM6KC50ZXh0KzB4MCk6IG11bHRpcGxl
IGRlZmluaXRpb24gb2YgYHJlYWRfc2JfcmVnYicKc3BpZHgubzpzcGlkeC5jOigudGV4dCsweDAp
OiBmaXJzdCBkZWZpbmVkIGhlcmUKcHdtLm86IEluIGZ1bmN0aW9uIGByZWFkX3NiX3JlZ3cnOgpw
d20uYzooLnRleHQrMHg0NCk6IG11bHRpcGxlIGRlZmluaXRpb24gb2YgYHJlYWRfc2JfcmVndycK
c3BpZHgubzpzcGlkeC5jOigudGV4dCsweDQ0KTogZmlyc3QgZGVmaW5lZCBoZXJlCnB3bS5vOiBJ
biBmdW5jdGlvbiBgcmVhZF9zYl9yZWcnOgpwd20uYzooLnRleHQrMHg4ZCk6IG11bHRpcGxlIGRl
ZmluaXRpb24gb2YgYHJlYWRfc2JfcmVnJwpzcGlkeC5vOnNwaWR4LmM6KC50ZXh0KzB4OGQpOiBm
aXJzdCBkZWZpbmVkIGhlcmUKcHdtLm86IEluIGZ1bmN0aW9uIGB3cml0ZV9zYl9yZWdiJzoKcHdt
LmM6KC50ZXh0KzB4YzMpOiBtdWx0aXBsZSBkZWZpbml0aW9uIG9mIGB3cml0ZV9zYl9yZWdiJwpz
cGlkeC5vOnNwaWR4LmM6KC50ZXh0KzB4YzMpOiBmaXJzdCBkZWZpbmVkIGhlcmUKcHdtLm86IElu
IGZ1bmN0aW9uIGB3cml0ZV9zYl9yZWd3JzoKcHdtLmM6KC50ZXh0KzB4MTRhKTogbXVsdGlwbGUg
ZGVmaW5pdGlvbiBvZiBgd3JpdGVfc2JfcmVndycKc3BpZHgubzpzcGlkeC5jOigudGV4dCsweDE0
YSk6IGZpcnN0IGRlZmluZWQgaGVyZQpwd20ubzogSW4gZnVuY3Rpb24gYHdyaXRlX3NiX3JlZyc6
CnB3bS5jOigudGV4dCsweDFjYSk6IG11bHRpcGxlIGRlZmluaXRpb24gb2YgYHdyaXRlX3NiX3Jl
ZycKc3BpZHgubzpzcGlkeC5jOigudGV4dCsweDFjYSk6IGZpcnN0IGRlZmluZWQgaGVyZQpwd20u
bzogSW4gZnVuY3Rpb24gYHJlYWRfbmJfcmVnYic6CnB3bS5jOigudGV4dCsweDIwNyk6IG11bHRp
cGxlIGRlZmluaXRpb24gb2YgYHJlYWRfbmJfcmVnYicKc3BpZHgubzpzcGlkeC5jOigudGV4dCsw
eDIwNyk6IGZpcnN0IGRlZmluZWQgaGVyZQpwd20ubzogSW4gZnVuY3Rpb24gYHJlYWRfbmJfcmVn
dyc6CnB3bS5jOigudGV4dCsweDI0Yik6IG11bHRpcGxlIGRlZmluaXRpb24gb2YgYHJlYWRfbmJf
cmVndycKc3BpZHgubzpzcGlkeC5jOigudGV4dCsweDI0Yik6IGZpcnN0IGRlZmluZWQgaGVyZQpw
d20ubzogSW4gZnVuY3Rpb24gYHJlYWRfbmJfcmVnJzoKcHdtLmM6KC50ZXh0KzB4Mjk0KTogbXVs
dGlwbGUgZGVmaW5pdGlvbiBvZiBgcmVhZF9uYl9yZWcnCnNwaWR4Lm86c3BpZHguYzooLnRleHQr
MHgyOTQpOiBmaXJzdCBkZWZpbmVkIGhlcmUKcHdtLm86IEluIGZ1bmN0aW9uIGB3cml0ZV9uYl9y
ZWdiJzoKcHdtLmM6KC50ZXh0KzB4MmNhKTogbXVsdGlwbGUgZGVmaW5pdGlvbiBvZiBgd3JpdGVf
bmJfcmVnYicKc3BpZHgubzpzcGlkeC5jOigudGV4dCsweDJjYSk6IGZpcnN0IGRlZmluZWQgaGVy
ZQpwd20ubzogSW4gZnVuY3Rpb24gYHdyaXRlX25iX3JlZ3cnOgpwd20uYzooLnRleHQrMHgzNTEp
OiBtdWx0aXBsZSBkZWZpbml0aW9uIG9mIGB3cml0ZV9uYl9yZWd3JwpzcGlkeC5vOnNwaWR4LmM6
KC50ZXh0KzB4MzUxKTogZmlyc3QgZGVmaW5lZCBoZXJlCnB3bS5vOiBJbiBmdW5jdGlvbiBgd3Jp
dGVfbmJfcmVnJzoKcHdtLmM6KC50ZXh0KzB4M2QxKTogbXVsdGlwbGUgZGVmaW5pdGlvbiBvZiBg
d3JpdGVfbmJfcmVnJwpzcGlkeC5vOnNwaWR4LmM6KC50ZXh0KzB4M2QxKTogZmlyc3QgZGVmaW5l
ZCBoZXJlCmlvLm86IEluIGZ1bmN0aW9uIGByZWFkX3NiX3JlZ2InOgppby5jOigudGV4dCsweDAp
OiBtdWx0aXBsZSBkZWZpbml0aW9uIG9mIGByZWFkX3NiX3JlZ2InCnNwaWR4Lm86c3BpZHguYzoo
LnRleHQrMHgwKTogZmlyc3QgZGVmaW5lZCBoZXJlCmlvLm86IEluIGZ1bmN0aW9uIGByZWFkX3Ni
X3JlZ3cnOgppby5jOigudGV4dCsweDQ0KTogbXVsdGlwbGUgZGVmaW5pdGlvbiBvZiBgcmVhZF9z
Yl9yZWd3JwpzcGlkeC5vOnNwaWR4LmM6KC50ZXh0KzB4NDQpOiBmaXJzdCBkZWZpbmVkIGhlcmUK
aW8ubzogSW4gZnVuY3Rpb24gYHJlYWRfc2JfcmVnJzoKaW8uYzooLnRleHQrMHg4ZCk6IG11bHRp
cGxlIGRlZmluaXRpb24gb2YgYHJlYWRfc2JfcmVnJwpzcGlkeC5vOnNwaWR4LmM6KC50ZXh0KzB4
OGQpOiBmaXJzdCBkZWZpbmVkIGhlcmUKaW8ubzogSW4gZnVuY3Rpb24gYHdyaXRlX3NiX3JlZ2In
Ogppby5jOigudGV4dCsweGMzKTogbXVsdGlwbGUgZGVmaW5pdGlvbiBvZiBgd3JpdGVfc2JfcmVn
YicKc3BpZHgubzpzcGlkeC5jOigudGV4dCsweGMzKTogZmlyc3QgZGVmaW5lZCBoZXJlCmlvLm86
IEluIGZ1bmN0aW9uIGB3cml0ZV9zYl9yZWd3JzoKaW8uYzooLnRleHQrMHgxNGEpOiBtdWx0aXBs
ZSBkZWZpbml0aW9uIG9mIGB3cml0ZV9zYl9yZWd3JwpzcGlkeC5vOnNwaWR4LmM6KC50ZXh0KzB4
MTRhKTogZmlyc3QgZGVmaW5lZCBoZXJlCmlvLm86IEluIGZ1bmN0aW9uIGB3cml0ZV9zYl9yZWcn
Ogppby5jOigudGV4dCsweDFjYSk6IG11bHRpcGxlIGRlZmluaXRpb24gb2YgYHdyaXRlX3NiX3Jl
ZycKc3BpZHgubzpzcGlkeC5jOigudGV4dCsweDFjYSk6IGZpcnN0IGRlZmluZWQgaGVyZQppby5v
OiBJbiBmdW5jdGlvbiBgcmVhZF9uYl9yZWdiJzoKaW8uYzooLnRleHQrMHgyMDcpOiBtdWx0aXBs
ZSBkZWZpbml0aW9uIG9mIGByZWFkX25iX3JlZ2InCnNwaWR4Lm86c3BpZHguYzooLnRleHQrMHgy
MDcpOiBmaXJzdCBkZWZpbmVkIGhlcmUKaW8ubzogSW4gZnVuY3Rpb24gYHJlYWRfbmJfcmVndyc6
CmlvLmM6KC50ZXh0KzB4MjRiKTogbXVsdGlwbGUgZGVmaW5pdGlvbiBvZiBgcmVhZF9uYl9yZWd3
JwpzcGlkeC5vOnNwaWR4LmM6KC50ZXh0KzB4MjRiKTogZmlyc3QgZGVmaW5lZCBoZXJlCmlvLm86
IEluIGZ1bmN0aW9uIGByZWFkX25iX3JlZyc6CmlvLmM6KC50ZXh0KzB4Mjk0KTogbXVsdGlwbGUg
ZGVmaW5pdGlvbiBvZiBgcmVhZF9uYl9yZWcnCnNwaWR4Lm86c3BpZHguYzooLnRleHQrMHgyOTQp
OiBmaXJzdCBkZWZpbmVkIGhlcmUKaW8ubzogSW4gZnVuY3Rpb24gYHdyaXRlX25iX3JlZ2InOgpp
by5jOigudGV4dCsweDJjYSk6IG11bHRpcGxlIGRlZmluaXRpb24gb2YgYHdyaXRlX25iX3JlZ2In
CnNwaWR4Lm86c3BpZHguYzooLnRleHQrMHgyY2EpOiBmaXJzdCBkZWZpbmVkIGhlcmUKaW8ubzog
SW4gZnVuY3Rpb24gYHdyaXRlX25iX3JlZ3cnOgppby5jOigudGV4dCsweDM1MSk6IG11bHRpcGxl
IGRlZmluaXRpb24gb2YgYHdyaXRlX25iX3JlZ3cnCnNwaWR4Lm86c3BpZHguYzooLnRleHQrMHgz
NTEpOiBmaXJzdCBkZWZpbmVkIGhlcmUKaW8ubzogSW4gZnVuY3Rpb24gYHdyaXRlX25iX3JlZyc6
CmlvLmM6KC50ZXh0KzB4M2QxKTogbXVsdGlwbGUgZGVmaW5pdGlvbiBvZiBgd3JpdGVfbmJfcmVn
JwpzcGlkeC5vOnNwaWR4LmM6KC50ZXh0KzB4M2QxKTogZmlyc3QgZGVmaW5lZCBoZXJlCmkyY2R4
Lm86IEluIGZ1bmN0aW9uIGByZWFkX3NiX3JlZ2InOgppMmNkeC5jOigudGV4dCsweDApOiBtdWx0
aXBsZSBkZWZpbml0aW9uIG9mIGByZWFkX3NiX3JlZ2InCnNwaWR4Lm86c3BpZHguYzooLnRleHQr
MHgwKTogZmlyc3QgZGVmaW5lZCBoZXJlCmkyY2R4Lm86IEluIGZ1bmN0aW9uIGByZWFkX3NiX3Jl
Z3cnOgppMmNkeC5jOigudGV4dCsweDQ0KTogbXVsdGlwbGUgZGVmaW5pdGlvbiBvZiBgcmVhZF9z
Yl9yZWd3JwpzcGlkeC5vOnNwaWR4LmM6KC50ZXh0KzB4NDQpOiBmaXJzdCBkZWZpbmVkIGhlcmUK
aTJjZHgubzogSW4gZnVuY3Rpb24gYHJlYWRfc2JfcmVnJzoKaTJjZHguYzooLnRleHQrMHg4ZCk6
IG11bHRpcGxlIGRlZmluaXRpb24gb2YgYHJlYWRfc2JfcmVnJwpzcGlkeC5vOnNwaWR4LmM6KC50
ZXh0KzB4OGQpOiBmaXJzdCBkZWZpbmVkIGhlcmUKaTJjZHgubzogSW4gZnVuY3Rpb24gYHdyaXRl
X3NiX3JlZ2InOgppMmNkeC5jOigudGV4dCsweGMzKTogbXVsdGlwbGUgZGVmaW5pdGlvbiBvZiBg
d3JpdGVfc2JfcmVnYicKc3BpZHgubzpzcGlkeC5jOigudGV4dCsweGMzKTogZmlyc3QgZGVmaW5l
ZCBoZXJlCmkyY2R4Lm86IEluIGZ1bmN0aW9uIGB3cml0ZV9zYl9yZWd3JzoKaTJjZHguYzooLnRl
eHQrMHgxNGEpOiBtdWx0aXBsZSBkZWZpbml0aW9uIG9mIGB3cml0ZV9zYl9yZWd3JwpzcGlkeC5v
OnNwaWR4LmM6KC50ZXh0KzB4MTRhKTogZmlyc3QgZGVmaW5lZCBoZXJlCmkyY2R4Lm86IEluIGZ1
bmN0aW9uIGB3cml0ZV9zYl9yZWcnOgppMmNkeC5jOigudGV4dCsweDFjYSk6IG11bHRpcGxlIGRl
ZmluaXRpb24gb2YgYHdyaXRlX3NiX3JlZycKc3BpZHgubzpzcGlkeC5jOigudGV4dCsweDFjYSk6
IGZpcnN0IGRlZmluZWQgaGVyZQppMmNkeC5vOiBJbiBmdW5jdGlvbiBgcmVhZF9uYl9yZWdiJzoK
aTJjZHguYzooLnRleHQrMHgyMDcpOiBtdWx0aXBsZSBkZWZpbml0aW9uIG9mIGByZWFkX25iX3Jl
Z2InCnNwaWR4Lm86c3BpZHguYzooLnRleHQrMHgyMDcpOiBmaXJzdCBkZWZpbmVkIGhlcmUKaTJj
ZHgubzogSW4gZnVuY3Rpb24gYHJlYWRfbmJfcmVndyc6CmkyY2R4LmM6KC50ZXh0KzB4MjRiKTog
bXVsdGlwbGUgZGVmaW5pdGlvbiBvZiBgcmVhZF9uYl9yZWd3JwpzcGlkeC5vOnNwaWR4LmM6KC50
ZXh0KzB4MjRiKTogZmlyc3QgZGVmaW5lZCBoZXJlCmkyY2R4Lm86IEluIGZ1bmN0aW9uIGByZWFk
X25iX3JlZyc6CmkyY2R4LmM6KC50ZXh0KzB4Mjk0KTogbXVsdGlwbGUgZGVmaW5pdGlvbiBvZiBg
cmVhZF9uYl9yZWcnCnNwaWR4Lm86c3BpZHguYzooLnRleHQrMHgyOTQpOiBmaXJzdCBkZWZpbmVk
IGhlcmUKaTJjZHgubzogSW4gZnVuY3Rpb24gYHdyaXRlX25iX3JlZ2InOgppMmNkeC5jOigudGV4
dCsweDJjYSk6IG11bHRpcGxlIGRlZmluaXRpb24gb2YgYHdyaXRlX25iX3JlZ2InCnNwaWR4Lm86
c3BpZHguYzooLnRleHQrMHgyY2EpOiBmaXJzdCBkZWZpbmVkIGhlcmUKaTJjZHgubzogSW4gZnVu
Y3Rpb24gYHdyaXRlX25iX3JlZ3cnOgppMmNkeC5jOigudGV4dCsweDM1MSk6IG11bHRpcGxlIGRl
ZmluaXRpb24gb2YgYHdyaXRlX25iX3JlZ3cnCnNwaWR4Lm86c3BpZHguYzooLnRleHQrMHgzNTEp
OiBmaXJzdCBkZWZpbmVkIGhlcmUKaTJjZHgubzogSW4gZnVuY3Rpb24gYHdyaXRlX25iX3JlZyc6
CmkyY2R4LmM6KC50ZXh0KzB4M2QxKTogbXVsdGlwbGUgZGVmaW5pdGlvbiBvZiBgd3JpdGVfbmJf
cmVnJwpzcGlkeC5vOnNwaWR4LmM6KC50ZXh0KzB4M2QxKTogZmlyc3QgZGVmaW5lZCBoZXJlCmky
Yy5vOiBJbiBmdW5jdGlvbiBgcmVhZF9zYl9yZWdiJzoKaTJjLmM6KC50ZXh0KzB4MCk6IG11bHRp
cGxlIGRlZmluaXRpb24gb2YgYHJlYWRfc2JfcmVnYicKc3BpZHgubzpzcGlkeC5jOigudGV4dCsw
eDApOiBmaXJzdCBkZWZpbmVkIGhlcmUKaTJjLm86IEluIGZ1bmN0aW9uIGByZWFkX3NiX3JlZ3cn
OgppMmMuYzooLnRleHQrMHg0NCk6IG11bHRpcGxlIGRlZmluaXRpb24gb2YgYHJlYWRfc2JfcmVn
dycKc3BpZHgubzpzcGlkeC5jOigudGV4dCsweDQ0KTogZmlyc3QgZGVmaW5lZCBoZXJlCmkyYy5v
OiBJbiBmdW5jdGlvbiBgcmVhZF9zYl9yZWcnOgppMmMuYzooLnRleHQrMHg4ZCk6IG11bHRpcGxl
IGRlZmluaXRpb24gb2YgYHJlYWRfc2JfcmVnJwpzcGlkeC5vOnNwaWR4LmM6KC50ZXh0KzB4OGQp
OiBmaXJzdCBkZWZpbmVkIGhlcmUKaTJjLm86IEluIGZ1bmN0aW9uIGB3cml0ZV9zYl9yZWdiJzoK
aTJjLmM6KC50ZXh0KzB4YzMpOiBtdWx0aXBsZSBkZWZpbml0aW9uIG9mIGB3cml0ZV9zYl9yZWdi
JwpzcGlkeC5vOnNwaWR4LmM6KC50ZXh0KzB4YzMpOiBmaXJzdCBkZWZpbmVkIGhlcmUKaTJjLm86
IEluIGZ1bmN0aW9uIGB3cml0ZV9zYl9yZWd3JzoKaTJjLmM6KC50ZXh0KzB4MTRhKTogbXVsdGlw
bGUgZGVmaW5pdGlvbiBvZiBgd3JpdGVfc2JfcmVndycKc3BpZHgubzpzcGlkeC5jOigudGV4dCsw
eDE0YSk6IGZpcnN0IGRlZmluZWQgaGVyZQppMmMubzogSW4gZnVuY3Rpb24gYHdyaXRlX3NiX3Jl
Zyc6CmkyYy5jOigudGV4dCsweDFjYSk6IG11bHRpcGxlIGRlZmluaXRpb24gb2YgYHdyaXRlX3Ni
X3JlZycKc3BpZHgubzpzcGlkeC5jOigudGV4dCsweDFjYSk6IGZpcnN0IGRlZmluZWQgaGVyZQpp
MmMubzogSW4gZnVuY3Rpb24gYHJlYWRfbmJfcmVnYic6CmkyYy5jOigudGV4dCsweDIwNyk6IG11
bHRpcGxlIGRlZmluaXRpb24gb2YgYHJlYWRfbmJfcmVnYicKc3BpZHgubzpzcGlkeC5jOigudGV4
dCsweDIwNyk6IGZpcnN0IGRlZmluZWQgaGVyZQppMmMubzogSW4gZnVuY3Rpb24gYHJlYWRfbmJf
cmVndyc6CmkyYy5jOigudGV4dCsweDI0Yik6IG11bHRpcGxlIGRlZmluaXRpb24gb2YgYHJlYWRf
bmJfcmVndycKc3BpZHgubzpzcGlkeC5jOigudGV4dCsweDI0Yik6IGZpcnN0IGRlZmluZWQgaGVy
ZQppMmMubzogSW4gZnVuY3Rpb24gYHJlYWRfbmJfcmVnJzoKaTJjLmM6KC50ZXh0KzB4Mjk0KTog
bXVsdGlwbGUgZGVmaW5pdGlvbiBvZiBgcmVhZF9uYl9yZWcnCnNwaWR4Lm86c3BpZHguYzooLnRl
eHQrMHgyOTQpOiBmaXJzdCBkZWZpbmVkIGhlcmUKaTJjLm86IEluIGZ1bmN0aW9uIGB3cml0ZV9u
Yl9yZWdiJzoKaTJjLmM6KC50ZXh0KzB4MmNhKTogbXVsdGlwbGUgZGVmaW5pdGlvbiBvZiBgd3Jp
dGVfbmJfcmVnYicKc3BpZHgubzpzcGlkeC5jOigudGV4dCsweDJjYSk6IGZpcnN0IGRlZmluZWQg
aGVyZQppMmMubzogSW4gZnVuY3Rpb24gYHdyaXRlX25iX3JlZ3cnOgppMmMuYzooLnRleHQrMHgz
NTEpOiBtdWx0aXBsZSBkZWZpbml0aW9uIG9mIGB3cml0ZV9uYl9yZWd3JwpzcGlkeC5vOnNwaWR4
LmM6KC50ZXh0KzB4MzUxKTogZmlyc3QgZGVmaW5lZCBoZXJlCmkyYy5vOiBJbiBmdW5jdGlvbiBg
d3JpdGVfbmJfcmVnJzoKaTJjLmM6KC50ZXh0KzB4M2QxKTogbXVsdGlwbGUgZGVmaW5pdGlvbiBv
ZiBgd3JpdGVfbmJfcmVnJwpzcGlkeC5vOnNwaWR4LmM6KC50ZXh0KzB4M2QxKTogZmlyc3QgZGVm
aW5lZCBoZXJlCmkyYy5vOiBJbiBmdW5jdGlvbiBgaTJjMF9SZXNldCc6CmkyYy5jOigudGV4dCsw
eDQwZSk6IG11bHRpcGxlIGRlZmluaXRpb24gb2YgYGkyYzBfUmVzZXQnCmkyY2R4Lm86aTJjZHgu
YzooLnRleHQrMHg0MGUpOiBmaXJzdCBkZWZpbmVkIGhlcmUKaTJjLm86IEluIGZ1bmN0aW9uIGBp
MmMxX1Jlc2V0JzoKaTJjLmM6KC50ZXh0KzB4NDIyKTogbXVsdGlwbGUgZGVmaW5pdGlvbiBvZiBg
aTJjMV9SZXNldCcKaTJjZHgubzppMmNkeC5jOigudGV4dCsweDQyMik6IGZpcnN0IGRlZmluZWQg
aGVyZQppMmMubzogSW4gZnVuY3Rpb24gYGkyYzBfRW5hYmxlTm9pc2VGaWx0ZXInOgppMmMuYzoo
LnRleHQrMHg0MzYpOiBtdWx0aXBsZSBkZWZpbml0aW9uIG9mIGBpMmMwX0VuYWJsZU5vaXNlRmls
dGVyJwppMmNkeC5vOmkyY2R4LmM6KC50ZXh0KzB4NDM2KTogZmlyc3QgZGVmaW5lZCBoZXJlCmky
Yy5vOiBJbiBmdW5jdGlvbiBgaTJjMV9FbmFibGVOb2lzZUZpbHRlcic6CmkyYy5jOigudGV4dCsw
eDQ0YSk6IG11bHRpcGxlIGRlZmluaXRpb24gb2YgYGkyYzFfRW5hYmxlTm9pc2VGaWx0ZXInCmky
Y2R4Lm86aTJjZHguYzooLnRleHQrMHg0NGEpOiBmaXJzdCBkZWZpbmVkIGhlcmUKaTJjLm86IElu
IGZ1bmN0aW9uIGBpMmMwX0Rpc2FibGVOb2lzZUZpbHRlcic6CmkyYy5jOigudGV4dCsweDQ1ZSk6
IG11bHRpcGxlIGRlZmluaXRpb24gb2YgYGkyYzBfRGlzYWJsZU5vaXNlRmlsdGVyJwppMmNkeC5v
OmkyY2R4LmM6KC50ZXh0KzB4NDVlKTogZmlyc3QgZGVmaW5lZCBoZXJlCmkyYy5vOiBJbiBmdW5j
dGlvbiBgaTJjMV9EaXNhYmxlTm9pc2VGaWx0ZXInOgppMmMuYzooLnRleHQrMHg0NzIpOiBtdWx0
aXBsZSBkZWZpbml0aW9uIG9mIGBpMmMxX0Rpc2FibGVOb2lzZUZpbHRlcicKaTJjZHgubzppMmNk
eC5jOigudGV4dCsweDQ3Mik6IGZpcnN0IGRlZmluZWQgaGVyZQppMmMubzogSW4gZnVuY3Rpb24g
YGkyYzBfRW5hYmxlU3RhbmRhcmRIU00nOgppMmMuYzooLnRleHQrMHg0ODYpOiBtdWx0aXBsZSBk
ZWZpbml0aW9uIG9mIGBpMmMwX0VuYWJsZVN0YW5kYXJkSFNNJwppMmNkeC5vOmkyY2R4LmM6KC50
ZXh0KzB4NDg2KTogZmlyc3QgZGVmaW5lZCBoZXJlCmkyYy5vOiBJbiBmdW5jdGlvbiBgaTJjMV9F
bmFibGVTdGFuZGFyZEhTTSc6CmkyYy5jOigudGV4dCsweDQ5YSk6IG11bHRpcGxlIGRlZmluaXRp
b24gb2YgYGkyYzFfRW5hYmxlU3RhbmRhcmRIU00nCmkyY2R4Lm86aTJjZHguYzooLnRleHQrMHg0
OWEpOiBmaXJzdCBkZWZpbmVkIGhlcmUKaTJjLm86IEluIGZ1bmN0aW9uIGBpMmMwX0Rpc2FibGVT
dGFuZGFyZEhTTSc6CmkyYy5jOigudGV4dCsweDRhZSk6IG11bHRpcGxlIGRlZmluaXRpb24gb2Yg
YGkyYzBfRGlzYWJsZVN0YW5kYXJkSFNNJwppMmNkeC5vOmkyY2R4LmM6KC50ZXh0KzB4NGFlKTog
Zmlyc3QgZGVmaW5lZCBoZXJlCmkyYy5vOiBJbiBmdW5jdGlvbiBgaTJjMV9EaXNhYmxlU3RhbmRh
cmRIU00nOgppMmMuYzooLnRleHQrMHg0YzIpOiBtdWx0aXBsZSBkZWZpbml0aW9uIG9mIGBpMmMx
X0Rpc2FibGVTdGFuZGFyZEhTTScKaTJjZHgubzppMmNkeC5jOigudGV4dCsweDRjMik6IGZpcnN0
IGRlZmluZWQgaGVyZQppMmMubzogSW4gZnVuY3Rpb24gYGkyYzBfRW5hYmxlSU5UJzoKaTJjLmM6
KC50ZXh0KzB4NGQ2KTogbXVsdGlwbGUgZGVmaW5pdGlvbiBvZiBgaTJjMF9FbmFibGVJTlQnCmky
Y2R4Lm86aTJjZHguYzooLnRleHQrMHg0ZDYpOiBmaXJzdCBkZWZpbmVkIGhlcmUKaTJjLm86IElu
IGZ1bmN0aW9uIGBpMmMxX0VuYWJsZUlOVCc6CmkyYy5jOigudGV4dCsweDRmOCk6IG11bHRpcGxl
IGRlZmluaXRpb24gb2YgYGkyYzFfRW5hYmxlSU5UJwppMmNkeC5vOmkyY2R4LmM6KC50ZXh0KzB4
NGY4KTogZmlyc3QgZGVmaW5lZCBoZXJlCmkyYy5vOiBJbiBmdW5jdGlvbiBgaTJjMF9EaXNhYmxl
SU5UJzoKaTJjLmM6KC50ZXh0KzB4NTFhKTogbXVsdGlwbGUgZGVmaW5pdGlvbiBvZiBgaTJjMF9E
aXNhYmxlSU5UJwppMmNkeC5vOmkyY2R4LmM6KC50ZXh0KzB4NTFhKTogZmlyc3QgZGVmaW5lZCBo
ZXJlCmkyYy5vOiBJbiBmdW5jdGlvbiBgaTJjMV9EaXNhYmxlSU5UJzoKaTJjLmM6KC50ZXh0KzB4
NTNjKTogbXVsdGlwbGUgZGVmaW5pdGlvbiBvZiBgaTJjMV9EaXNhYmxlSU5UJwppMmNkeC5vOmky
Y2R4LmM6KC50ZXh0KzB4NTNjKTogZmlyc3QgZGVmaW5lZCBoZXJlCmkyYy5vOiBJbiBmdW5jdGlv
biBgaTJjMF9TZXRDTEtSRUcnOgppMmMuYzooLnRleHQrMHg1NWUpOiBtdWx0aXBsZSBkZWZpbml0
aW9uIG9mIGBpMmMwX1NldENMS1JFRycKaTJjZHgubzppMmNkeC5jOigudGV4dCsweDU1ZSk6IGZp
cnN0IGRlZmluZWQgaGVyZQppMmMubzogSW4gZnVuY3Rpb24gYGkyYzFfU2V0Q0xLUkVHJzoKaTJj
LmM6KC50ZXh0KzB4NTk1KTogbXVsdGlwbGUgZGVmaW5pdGlvbiBvZiBgaTJjMV9TZXRDTEtSRUcn
CmkyY2R4Lm86aTJjZHguYzooLnRleHQrMHg1OTUpOiBmaXJzdCBkZWZpbmVkIGhlcmUKaTJjLm86
IEluIGZ1bmN0aW9uIGBpMmMwX0NsZWFyU1RBVCc6CmkyYy5jOigudGV4dCsweDVjYyk6IG11bHRp
cGxlIGRlZmluaXRpb24gb2YgYGkyYzBfQ2xlYXJTVEFUJwppMmNkeC5vOmkyY2R4LmM6KC50ZXh0
KzB4NWNjKTogZmlyc3QgZGVmaW5lZCBoZXJlCmkyYy5vOiBJbiBmdW5jdGlvbiBgaTJjMV9DbGVh
clNUQVQnOgppMmMuYzooLnRleHQrMHg1ZWUpOiBtdWx0aXBsZSBkZWZpbml0aW9uIG9mIGBpMmMx
X0NsZWFyU1RBVCcKaTJjZHgubzppMmNkeC5jOigudGV4dCsweDVlZSk6IGZpcnN0IGRlZmluZWQg
aGVyZQppMmMubzogSW4gZnVuY3Rpb24gYGkyYzBfUmVhZFN0YXRSRUcnOgppMmMuYzooLnRleHQr
MHg2MTApOiBtdWx0aXBsZSBkZWZpbml0aW9uIG9mIGBpMmMwX1JlYWRTdGF0UkVHJwppMmNkeC5v
OmkyY2R4LmM6KC50ZXh0KzB4NjEwKTogZmlyc3QgZGVmaW5lZCBoZXJlCmkyYy5vOiBJbiBmdW5j
dGlvbiBgaTJjMV9SZWFkU3RhdFJFRyc6CmkyYy5jOigudGV4dCsweDYyNCk6IG11bHRpcGxlIGRl
ZmluaXRpb24gb2YgYGkyYzFfUmVhZFN0YXRSRUcnCmkyY2R4Lm86aTJjZHguYzooLnRleHQrMHg2
MjQpOiBmaXJzdCBkZWZpbmVkIGhlcmUKaTJjLm86IEluIGZ1bmN0aW9uIGBpMmMwX0lzTWFzdGVy
JzoKaTJjLmM6KC50ZXh0KzB4NjM4KTogbXVsdGlwbGUgZGVmaW5pdGlvbiBvZiBgaTJjMF9Jc01h
c3RlcicKaTJjZHgubzppMmNkeC5jOigudGV4dCsweDYzOCk6IGZpcnN0IGRlZmluZWQgaGVyZQpp
MmMubzogSW4gZnVuY3Rpb24gYGkyYzFfSXNNYXN0ZXInOgppMmMuYzooLnRleHQrMHg2NGMpOiBt
dWx0aXBsZSBkZWZpbml0aW9uIG9mIGBpMmMxX0lzTWFzdGVyJwppMmNkeC5vOmkyY2R4LmM6KC50
ZXh0KzB4NjRjKTogZmlyc3QgZGVmaW5lZCBoZXJlCmkyYy5vOiBJbiBmdW5jdGlvbiBgaTJjMF9D
aGVja0J1c0J1c3knOgppMmMuYzooLnRleHQrMHg2NjApOiBtdWx0aXBsZSBkZWZpbml0aW9uIG9m
IGBpMmMwX0NoZWNrQnVzQnVzeScKaTJjZHgubzppMmNkeC5jOigudGV4dCsweDY2MCk6IGZpcnN0
IGRlZmluZWQgaGVyZQppMmMubzogSW4gZnVuY3Rpb24gYGkyYzFfQ2hlY2tCdXNCdXN5JzoKaTJj
LmM6KC50ZXh0KzB4Njc0KTogbXVsdGlwbGUgZGVmaW5pdGlvbiBvZiBgaTJjMV9DaGVja0J1c0J1
c3knCmkyY2R4Lm86aTJjZHguYzooLnRleHQrMHg2NzQpOiBmaXJzdCBkZWZpbmVkIGhlcmUKaTJj
Lm86IEluIGZ1bmN0aW9uIGBpMmMwX0NoZWNrVFhEb25lJzoKaTJjLmM6KC50ZXh0KzB4Njg4KTog
bXVsdGlwbGUgZGVmaW5pdGlvbiBvZiBgaTJjMF9DaGVja1RYRG9uZScKaTJjZHgubzppMmNkeC5j
OigudGV4dCsweDY4OCk6IGZpcnN0IGRlZmluZWQgaGVyZQppMmMubzogSW4gZnVuY3Rpb24gYGky
YzFfQ2hlY2tUWERvbmUnOgppMmMuYzooLnRleHQrMHg2OWMpOiBtdWx0aXBsZSBkZWZpbml0aW9u
IG9mIGBpMmMxX0NoZWNrVFhEb25lJwppMmNkeC5vOmkyY2R4LmM6KC50ZXh0KzB4NjljKTogZmly
c3QgZGVmaW5lZCBoZXJlCmkyYy5vOiBJbiBmdW5jdGlvbiBgaTJjMF9DbGVhclRYRG9uZSc6Cmky
Yy5jOigudGV4dCsweDZiMCk6IG11bHRpcGxlIGRlZmluaXRpb24gb2YgYGkyYzBfQ2xlYXJUWERv
bmUnCmkyY2R4Lm86aTJjZHguYzooLnRleHQrMHg2YjApOiBmaXJzdCBkZWZpbmVkIGhlcmUKaTJj
Lm86IEluIGZ1bmN0aW9uIGBpMmMxX0NsZWFyVFhEb25lJzoKaTJjLmM6KC50ZXh0KzB4NmM0KTog
bXVsdGlwbGUgZGVmaW5pdGlvbiBvZiBgaTJjMV9DbGVhclRYRG9uZScKaTJjZHgubzppMmNkeC5j
OigudGV4dCsweDZjNCk6IGZpcnN0IGRlZmluZWQgaGVyZQppMmMubzogSW4gZnVuY3Rpb24gYGky
YzBfQ2hlY2tSWFJkeSc6CmkyYy5jOigudGV4dCsweDZkOCk6IG11bHRpcGxlIGRlZmluaXRpb24g
b2YgYGkyYzBfQ2hlY2tSWFJkeScKaTJjZHgubzppMmNkeC5jOigudGV4dCsweDZkOCk6IGZpcnN0
IGRlZmluZWQgaGVyZQppMmMubzogSW4gZnVuY3Rpb24gYGkyYzFfQ2hlY2tSWFJkeSc6CmkyYy5j
OigudGV4dCsweDZlYyk6IG11bHRpcGxlIGRlZmluaXRpb24gb2YgYGkyYzFfQ2hlY2tSWFJkeScK
aTJjZHgubzppMmNkeC5jOigudGV4dCsweDZlYyk6IGZpcnN0IGRlZmluZWQgaGVyZQppMmMubzog
SW4gZnVuY3Rpb24gYGkyYzBfQ2xlYXJSWFJkeSc6CmkyYy5jOigudGV4dCsweDcwMCk6IG11bHRp
cGxlIGRlZmluaXRpb24gb2YgYGkyYzBfQ2xlYXJSWFJkeScKaTJjZHgubzppMmNkeC5jOigudGV4
dCsweDcwMCk6IGZpcnN0IGRlZmluZWQgaGVyZQppMmMubzogSW4gZnVuY3Rpb24gYGkyYzFfQ2xl
YXJSWFJkeSc6CmkyYy5jOigudGV4dCsweDcxNCk6IG11bHRpcGxlIGRlZmluaXRpb24gb2YgYGky
YzFfQ2xlYXJSWFJkeScKaTJjZHgubzppMmNkeC5jOigudGV4dCsweDcxNCk6IGZpcnN0IGRlZmlu
ZWQgaGVyZQppMmMubzogSW4gZnVuY3Rpb24gYGkyYzBfV3JpdGVEYXRhUkVHJzoKaTJjLmM6KC50
ZXh0KzB4NzI4KTogbXVsdGlwbGUgZGVmaW5pdGlvbiBvZiBgaTJjMF9Xcml0ZURhdGFSRUcnCmky
Y2R4Lm86aTJjZHguYzooLnRleHQrMHg3MjgpOiBmaXJzdCBkZWZpbmVkIGhlcmUKaTJjLm86IElu
IGZ1bmN0aW9uIGBpMmMxX1dyaXRlRGF0YVJFRyc6CmkyYy5jOigudGV4dCsweDc0YSk6IG11bHRp
cGxlIGRlZmluaXRpb24gb2YgYGkyYzFfV3JpdGVEYXRhUkVHJwppMmNkeC5vOmkyY2R4LmM6KC50
ZXh0KzB4NzRhKTogZmlyc3QgZGVmaW5lZCBoZXJlCmkyYy5vOiBJbiBmdW5jdGlvbiBgaTJjMF9S
ZWFkRGF0YVJFRyc6CmkyYy5jOigudGV4dCsweDc2Yyk6IG11bHRpcGxlIGRlZmluaXRpb24gb2Yg
YGkyYzBfUmVhZERhdGFSRUcnCmkyY2R4Lm86aTJjZHguYzooLnRleHQrMHg3NmMpOiBmaXJzdCBk
ZWZpbmVkIGhlcmUKaTJjLm86IEluIGZ1bmN0aW9uIGBpMmMxX1JlYWREYXRhUkVHJzoKaTJjLmM6
KC50ZXh0KzB4NzgwKTogbXVsdGlwbGUgZGVmaW5pdGlvbiBvZiBgaTJjMV9SZWFkRGF0YVJFRycK
aTJjZHgubzppMmNkeC5jOigudGV4dCsweDc4MCk6IGZpcnN0IGRlZmluZWQgaGVyZQppMmMubzog
SW4gZnVuY3Rpb24gYGkyYzBtYXN0ZXJfU2V0U3RvcEJpdCc6CmkyYy5jOigudGV4dCsweDc5NCk6
IG11bHRpcGxlIGRlZmluaXRpb24gb2YgYGkyYzBtYXN0ZXJfU2V0U3RvcEJpdCcKaTJjZHgubzpp
MmNkeC5jOigudGV4dCsweDc5NCk6IGZpcnN0IGRlZmluZWQgaGVyZQppMmMubzogSW4gZnVuY3Rp
b24gYGkyYzFtYXN0ZXJfU2V0U3RvcEJpdCc6CmkyYy5jOigudGV4dCsweDdhOCk6IG11bHRpcGxl
IGRlZmluaXRpb24gb2YgYGkyYzFtYXN0ZXJfU2V0U3RvcEJpdCcKaTJjZHgubzppMmNkeC5jOigu
dGV4dCsweDdhOCk6IGZpcnN0IGRlZmluZWQgaGVyZQppMmMubzogSW4gZnVuY3Rpb24gYGkyYzBt
YXN0ZXJfQ2hlY2tTdG9wQml0JzoKaTJjLmM6KC50ZXh0KzB4N2JjKTogbXVsdGlwbGUgZGVmaW5p
dGlvbiBvZiBgaTJjMG1hc3Rlcl9DaGVja1N0b3BCaXQnCmkyY2R4Lm86aTJjZHguYzooLnRleHQr
MHg3YmMpOiBmaXJzdCBkZWZpbmVkIGhlcmUKaTJjLm86IEluIGZ1bmN0aW9uIGBpMmMxbWFzdGVy
X0NoZWNrU3RvcEJpdCc6CmkyYy5jOigudGV4dCsweDdkMCk6IG11bHRpcGxlIGRlZmluaXRpb24g
b2YgYGkyYzFtYXN0ZXJfQ2hlY2tTdG9wQml0JwppMmNkeC5vOmkyY2R4LmM6KC50ZXh0KzB4N2Qw
KTogZmlyc3QgZGVmaW5lZCBoZXJlCmkyYy5vOiBJbiBmdW5jdGlvbiBgaTJjMG1hc3Rlcl9DaGVj
a0FSTG9zcyc6CmkyYy5jOigudGV4dCsweDdlNCk6IG11bHRpcGxlIGRlZmluaXRpb24gb2YgYGky
YzBtYXN0ZXJfQ2hlY2tBUkxvc3MnCmkyY2R4Lm86aTJjZHguYzooLnRleHQrMHg3ZTQpOiBmaXJz
dCBkZWZpbmVkIGhlcmUKaTJjLm86IEluIGZ1bmN0aW9uIGBpMmMxbWFzdGVyX0NoZWNrQVJMb3Nz
JzoKaTJjLmM6KC50ZXh0KzB4N2Y4KTogbXVsdGlwbGUgZGVmaW5pdGlvbiBvZiBgaTJjMW1hc3Rl
cl9DaGVja0FSTG9zcycKaTJjZHgubzppMmNkeC5jOigudGV4dCsweDdmOCk6IGZpcnN0IGRlZmlu
ZWQgaGVyZQppMmMubzogSW4gZnVuY3Rpb24gYGkyYzBtYXN0ZXJfQ2xlYXJBUkxvc3MnOgppMmMu
YzooLnRleHQrMHg4MGMpOiBtdWx0aXBsZSBkZWZpbml0aW9uIG9mIGBpMmMwbWFzdGVyX0NsZWFy
QVJMb3NzJwppMmNkeC5vOmkyY2R4LmM6KC50ZXh0KzB4ODBjKTogZmlyc3QgZGVmaW5lZCBoZXJl
CmkyYy5vOiBJbiBmdW5jdGlvbiBgaTJjMW1hc3Rlcl9DbGVhckFSTG9zcyc6CmkyYy5jOigudGV4
dCsweDgyMCk6IG11bHRpcGxlIGRlZmluaXRpb24gb2YgYGkyYzFtYXN0ZXJfQ2xlYXJBUkxvc3Mn
CmkyY2R4Lm86aTJjZHguYzooLnRleHQrMHg4MjApOiBmaXJzdCBkZWZpbmVkIGhlcmUKaTJjLm86
IEluIGZ1bmN0aW9uIGBpMmMwbWFzdGVyX0NoZWNrQWNrRXJyJzoKaTJjLmM6KC50ZXh0KzB4ODM0
KTogbXVsdGlwbGUgZGVmaW5pdGlvbiBvZiBgaTJjMG1hc3Rlcl9DaGVja0Fja0VycicKaTJjZHgu
bzppMmNkeC5jOigudGV4dCsweDgzNCk6IGZpcnN0IGRlZmluZWQgaGVyZQppMmMubzogSW4gZnVu
Y3Rpb24gYGkyYzFtYXN0ZXJfQ2hlY2tBY2tFcnInOgppMmMuYzooLnRleHQrMHg4NDgpOiBtdWx0
aXBsZSBkZWZpbml0aW9uIG9mIGBpMmMxbWFzdGVyX0NoZWNrQWNrRXJyJwppMmNkeC5vOmkyY2R4
LmM6KC50ZXh0KzB4ODQ4KTogZmlyc3QgZGVmaW5lZCBoZXJlCmkyYy5vOiBJbiBmdW5jdGlvbiBg
aTJjMG1hc3Rlcl9DbGVhckFja0Vycic6CmkyYy5jOigudGV4dCsweDg1Yyk6IG11bHRpcGxlIGRl
ZmluaXRpb24gb2YgYGkyYzBtYXN0ZXJfQ2xlYXJBY2tFcnInCmkyY2R4Lm86aTJjZHguYzooLnRl
eHQrMHg4NWMpOiBmaXJzdCBkZWZpbmVkIGhlcmUKaTJjLm86IEluIGZ1bmN0aW9uIGBpMmMxbWFz
dGVyX0NsZWFyQWNrRXJyJzoKaTJjLmM6KC50ZXh0KzB4ODcwKTogbXVsdGlwbGUgZGVmaW5pdGlv
biBvZiBgaTJjMW1hc3Rlcl9DbGVhckFja0VycicKaTJjZHgubzppMmNkeC5jOigudGV4dCsweDg3
MCk6IGZpcnN0IGRlZmluZWQgaGVyZQppMmMubzogSW4gZnVuY3Rpb24gYGkyYzBtYXN0ZXJfV3Jp
dGVBZGRyUkVHJzoKaTJjLmM6KC50ZXh0KzB4ODg0KTogbXVsdGlwbGUgZGVmaW5pdGlvbiBvZiBg
aTJjMG1hc3Rlcl9Xcml0ZUFkZHJSRUcnCmkyY2R4Lm86aTJjZHguYzooLnRleHQrMHg4ODQpOiBm
aXJzdCBkZWZpbmVkIGhlcmUKaTJjLm86IEluIGZ1bmN0aW9uIGBpMmMxbWFzdGVyX1dyaXRlQWRk
clJFRyc6CmkyYy5jOigudGV4dCsweDhiNCk6IG11bHRpcGxlIGRlZmluaXRpb24gb2YgYGkyYzFt
YXN0ZXJfV3JpdGVBZGRyUkVHJwppMmNkeC5vOmkyY2R4LmM6KC50ZXh0KzB4OGI0KTogZmlyc3Qg
ZGVmaW5lZCBoZXJlCmkyYy5vOiBJbiBmdW5jdGlvbiBgaTJjMHNsYXZlX0VuYWJsZUFDSyc6Cmky
Yy5jOigudGV4dCsweDhlNCk6IG11bHRpcGxlIGRlZmluaXRpb24gb2YgYGkyYzBzbGF2ZV9FbmFi
bGVBQ0snCmkyY2R4Lm86aTJjZHguYzooLnRleHQrMHg4ZTQpOiBmaXJzdCBkZWZpbmVkIGhlcmUK
aTJjLm86IEluIGZ1bmN0aW9uIGBpMmMxc2xhdmVfRW5hYmxlQUNLJzoKaTJjLmM6KC50ZXh0KzB4
OGY4KTogbXVsdGlwbGUgZGVmaW5pdGlvbiBvZiBgaTJjMXNsYXZlX0VuYWJsZUFDSycKaTJjZHgu
bzppMmNkeC5jOigudGV4dCsweDhmOCk6IGZpcnN0IGRlZmluZWQgaGVyZQppMmMubzogSW4gZnVu
Y3Rpb24gYGkyYzBzbGF2ZV9FbmFibGVOQUsnOgppMmMuYzooLnRleHQrMHg5MGMpOiBtdWx0aXBs
ZSBkZWZpbml0aW9uIG9mIGBpMmMwc2xhdmVfRW5hYmxlTkFLJwppMmNkeC5vOmkyY2R4LmM6KC50
ZXh0KzB4OTBjKTogZmlyc3QgZGVmaW5lZCBoZXJlCmkyYy5vOiBJbiBmdW5jdGlvbiBgaTJjMXNs
YXZlX0VuYWJsZU5BSyc6CmkyYy5jOigudGV4dCsweDkyMCk6IG11bHRpcGxlIGRlZmluaXRpb24g
b2YgYGkyYzFzbGF2ZV9FbmFibGVOQUsnCmkyY2R4Lm86aTJjZHguYzooLnRleHQrMHg5MjApOiBm
aXJzdCBkZWZpbmVkIGhlcmUKaTJjLm86IEluIGZ1bmN0aW9uIGBpMmMwc2xhdmVfU2V0QWRkcic6
CmkyYy5jOigudGV4dCsweDkzNCk6IG11bHRpcGxlIGRlZmluaXRpb24gb2YgYGkyYzBzbGF2ZV9T
ZXRBZGRyJwppMmNkeC5vOmkyY2R4LmM6KC50ZXh0KzB4OTM0KTogZmlyc3QgZGVmaW5lZCBoZXJl
CmkyYy5vOiBJbiBmdW5jdGlvbiBgaTJjMXNsYXZlX1NldEFkZHInOgppMmMuYzooLnRleHQrMHg5
NTYpOiBtdWx0aXBsZSBkZWZpbml0aW9uIG9mIGBpMmMxc2xhdmVfU2V0QWRkcicKaTJjZHgubzpp
MmNkeC5jOigudGV4dCsweDk1Nik6IGZpcnN0IGRlZmluZWQgaGVyZQppMmMubzogSW4gZnVuY3Rp
b24gYGkyYzBzbGF2ZV9DaGVja1NsYXZlV1JFUSc6CmkyYy5jOigudGV4dCsweDk3OCk6IG11bHRp
cGxlIGRlZmluaXRpb24gb2YgYGkyYzBzbGF2ZV9DaGVja1NsYXZlV1JFUScKaTJjZHgubzppMmNk
eC5jOigudGV4dCsweDk3OCk6IGZpcnN0IGRlZmluZWQgaGVyZQppMmMubzogSW4gZnVuY3Rpb24g
YGkyYzFzbGF2ZV9DaGVja1NsYXZlV1JFUSc6CmkyYy5jOigudGV4dCsweDk4Yyk6IG11bHRpcGxl
IGRlZmluaXRpb24gb2YgYGkyYzFzbGF2ZV9DaGVja1NsYXZlV1JFUScKaTJjZHgubzppMmNkeC5j
OigudGV4dCsweDk4Yyk6IGZpcnN0IGRlZmluZWQgaGVyZQppMmMubzogSW4gZnVuY3Rpb24gYGky
YzBzbGF2ZV9DbGVhclNsYXZlV1JFUSc6CmkyYy5jOigudGV4dCsweDlhMCk6IG11bHRpcGxlIGRl
ZmluaXRpb24gb2YgYGkyYzBzbGF2ZV9DbGVhclNsYXZlV1JFUScKaTJjZHgubzppMmNkeC5jOigu
dGV4dCsweDlhMCk6IGZpcnN0IGRlZmluZWQgaGVyZQppMmMubzogSW4gZnVuY3Rpb24gYGkyYzFz
bGF2ZV9DbGVhclNsYXZlV1JFUSc6CmkyYy5jOigudGV4dCsweDliNCk6IG11bHRpcGxlIGRlZmlu
aXRpb24gb2YgYGkyYzFzbGF2ZV9DbGVhclNsYXZlV1JFUScKaTJjZHgubzppMmNkeC5jOigudGV4
dCsweDliNCk6IGZpcnN0IGRlZmluZWQgaGVyZQphZDc5eDgubzogSW4gZnVuY3Rpb24gYHJlYWRf
c2JfcmVnYic6CmFkNzl4OC5jOigudGV4dCsweDApOiBtdWx0aXBsZSBkZWZpbml0aW9uIG9mIGBy
ZWFkX3NiX3JlZ2InCnNwaWR4Lm86c3BpZHguYzooLnRleHQrMHgwKTogZmlyc3QgZGVmaW5lZCBo
ZXJlCmFkNzl4OC5vOiBJbiBmdW5jdGlvbiBgcmVhZF9zYl9yZWd3JzoKYWQ3OXg4LmM6KC50ZXh0
KzB4NDQpOiBtdWx0aXBsZSBkZWZpbml0aW9uIG9mIGByZWFkX3NiX3JlZ3cnCnNwaWR4Lm86c3Bp
ZHguYzooLnRleHQrMHg0NCk6IGZpcnN0IGRlZmluZWQgaGVyZQphZDc5eDgubzogSW4gZnVuY3Rp
b24gYHJlYWRfc2JfcmVnJzoKYWQ3OXg4LmM6KC50ZXh0KzB4OGQpOiBtdWx0aXBsZSBkZWZpbml0
aW9uIG9mIGByZWFkX3NiX3JlZycKc3BpZHgubzpzcGlkeC5jOigudGV4dCsweDhkKTogZmlyc3Qg
ZGVmaW5lZCBoZXJlCmFkNzl4OC5vOiBJbiBmdW5jdGlvbiBgd3JpdGVfc2JfcmVnYic6CmFkNzl4
OC5jOigudGV4dCsweGMzKTogbXVsdGlwbGUgZGVmaW5pdGlvbiBvZiBgd3JpdGVfc2JfcmVnYicK
c3BpZHgubzpzcGlkeC5jOigudGV4dCsweGMzKTogZmlyc3QgZGVmaW5lZCBoZXJlCmFkNzl4OC5v
OiBJbiBmdW5jdGlvbiBgd3JpdGVfc2JfcmVndyc6CmFkNzl4OC5jOigudGV4dCsweDE0YSk6IG11
bHRpcGxlIGRlZmluaXRpb24gb2YgYHdyaXRlX3NiX3JlZ3cnCnNwaWR4Lm86c3BpZHguYzooLnRl
eHQrMHgxNGEpOiBmaXJzdCBkZWZpbmVkIGhlcmUKYWQ3OXg4Lm86IEluIGZ1bmN0aW9uIGB3cml0
ZV9zYl9yZWcnOgphZDc5eDguYzooLnRleHQrMHgxY2EpOiBtdWx0aXBsZSBkZWZpbml0aW9uIG9m
IGB3cml0ZV9zYl9yZWcnCnNwaWR4Lm86c3BpZHguYzooLnRleHQrMHgxY2EpOiBmaXJzdCBkZWZp
bmVkIGhlcmUKYWQ3OXg4Lm86IEluIGZ1bmN0aW9uIGByZWFkX25iX3JlZ2InOgphZDc5eDguYzoo
LnRleHQrMHgyMDcpOiBtdWx0aXBsZSBkZWZpbml0aW9uIG9mIGByZWFkX25iX3JlZ2InCnNwaWR4
Lm86c3BpZHguYzooLnRleHQrMHgyMDcpOiBmaXJzdCBkZWZpbmVkIGhlcmUKYWQ3OXg4Lm86IElu
IGZ1bmN0aW9uIGByZWFkX25iX3JlZ3cnOgphZDc5eDguYzooLnRleHQrMHgyNGIpOiBtdWx0aXBs
ZSBkZWZpbml0aW9uIG9mIGByZWFkX25iX3JlZ3cnCnNwaWR4Lm86c3BpZHguYzooLnRleHQrMHgy
NGIpOiBmaXJzdCBkZWZpbmVkIGhlcmUKYWQ3OXg4Lm86IEluIGZ1bmN0aW9uIGByZWFkX25iX3Jl
Zyc6CmFkNzl4OC5jOigudGV4dCsweDI5NCk6IG11bHRpcGxlIGRlZmluaXRpb24gb2YgYHJlYWRf
bmJfcmVnJwpzcGlkeC5vOnNwaWR4LmM6KC50ZXh0KzB4Mjk0KTogZmlyc3QgZGVmaW5lZCBoZXJl
CmFkNzl4OC5vOiBJbiBmdW5jdGlvbiBgd3JpdGVfbmJfcmVnYic6CmFkNzl4OC5jOigudGV4dCsw
eDJjYSk6IG11bHRpcGxlIGRlZmluaXRpb24gb2YgYHdyaXRlX25iX3JlZ2InCnNwaWR4Lm86c3Bp
ZHguYzooLnRleHQrMHgyY2EpOiBmaXJzdCBkZWZpbmVkIGhlcmUKYWQ3OXg4Lm86IEluIGZ1bmN0
aW9uIGB3cml0ZV9uYl9yZWd3JzoKYWQ3OXg4LmM6KC50ZXh0KzB4MzUxKTogbXVsdGlwbGUgZGVm
aW5pdGlvbiBvZiBgd3JpdGVfbmJfcmVndycKc3BpZHgubzpzcGlkeC5jOigudGV4dCsweDM1MSk6
IGZpcnN0IGRlZmluZWQgaGVyZQphZDc5eDgubzogSW4gZnVuY3Rpb24gYHdyaXRlX25iX3JlZyc6
CmFkNzl4OC5jOigudGV4dCsweDNkMSk6IG11bHRpcGxlIGRlZmluaXRpb24gb2YgYHdyaXRlX25i
X3JlZycKc3BpZHgubzpzcGlkeC5jOigudGV4dCsweDNkMSk6IGZpcnN0IGRlZmluZWQgaGVyZQov
dXNyL2xpYi9nY2MvaTQ4Ni1saW51eC1nbnUvNC40LjEvLi4vLi4vLi4vLi4vbGliL2NydDEubzog
SW4gZnVuY3Rpb24gYF9zdGFydCc6Ci9idWlsZC9idWlsZGQvZWdsaWJjLTIuMTAuMS9jc3UvLi4v
c3lzZGVwcy9pMzg2L2VsZi9zdGFydC5TOjExNTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgbWFp
bicKY29sbGVjdDI6IGxkIHJldHVybmVkIDEgZXhpdCBzdGF0dXMKbWFrZTogKioqIFt0ZXN0aW5n
eGVub21haV0gRXJyb3IgMQoK
--000e0cd2583ca99ef804a7dac213--

