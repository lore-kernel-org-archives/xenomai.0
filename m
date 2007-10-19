Message-ID: <7289437c0710190251p4fd86a75nd9e775aaa5425f19@domain.hid>
Date: Fri, 19 Oct 2007 11:51:15 +0200
From: "Perrine Martignoni" <perrmart@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_2531_19951969.1192787475084"
Subject: [Xenomai-help] Problem to compile a module in the Makefile directory
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

------=_Part_2531_19951969.1192787475084
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

Currently, I write some RTDM modules that I compile with this Makefile :

CSCI = /tmp/c_mhdn/MHDN/CSCIs/BSP_GPP

### List of applications to be build
APPLICATIONS = $(CSCI)/pack_Wrappers/csc_WrapperDSP/src/WDSP_Main

### List of modules to be build
MODULES = ../../../CSCIs/BSP_GPP/pack_Drivers/csc_DriverDSP/src/DDSP_Main

### Note: to override the kernel source path, use "make KSRC=..."
ARCH=ppc
CROSS_COMPILE=ppc_6xx-
KSRC=/usr/src/linux-2.6.18

MY_CFLAGS =  -I$(CSCI)/pack_Drivers/csc_DriverDSP/inc -I$(CSCI)/Common
ADD_CFLAGS = -I$(CSCI)/pack_Drivers/csc_DriverDSP/inc -I$(CSCI)/Common

###### USER SPACE BUILD (no change required normally) ######
ifeq ($(KERNELRELEASE),)
ifneq ($(APPLICATIONS),)

### Default Xenomai installation path
XENO=/usr/src/lib_xenomai

XENOCONFIG=$(shell PATH=$(XENO):$(XENO)/bin:$(PATH) which xeno-config
2>/dev/null)

### Sanity check
ifeq ($(XENOCONFIG),)

all::

    @echo ">>> Invoke make like this: \"make XENO=/path/to/xeno-config\"
<<<"
    @echo

endif

CC=$(shell $(XENOCONFIG) --cc)

CFLAGS=$(shell $(XENOCONFIG) --xeno-cflags) $(MY_CFLAGS)

LDFLAGS=$(shell $(XENOCONFIG) --xeno-ldflags) $(MY_LDFLAGS) -lnative -lrtdm

# This includes the library path of given Xenomai into the binary to make
live
# easier for beginners if Xenomai's libs are not in any default search path.

LDFLAGS+=-Xlinker -rpath -Xlinker $(shell $(XENOCONFIG) --libdir)

all:: $(APPLICATIONS)

clean::

    $(RM) $(APPLICATIONS) *.o

endif
endif

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
$(ADD_CFLAGS)

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
    $(RM) $(CLEANMOD) *.o *.ko *.mod.c Module*.symvers
    $(RM) -R .tmp*

endif

This works fine, but the generated objects are in the source .c directory.
And now, I want to generate objects in another directory : the Makefile
directory.
I don't see how to do. I need some help for this.

Thanks,
Best Regards

------=_Part_2531_19951969.1192787475084
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello, <br><br>Currently, I write some RTDM modules that I compile with this Makefile :<br><font size="2"><br></font><font size="1"><font size="2"><span style="font-family: courier new,monospace;">CSCI = /tmp/c_mhdn/MHDN/CSCIs/BSP_GPP
<br><br style="font-family: courier new,monospace;"></span><span style="font-family: courier new,monospace;">### List of applications to be build</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">
APPLICATIONS = $(CSCI)/pack_Wrappers/csc_WrapperDSP/src/WDSP_Main</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">### List of modules to be build
</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">MODULES = ../../../CSCIs/BSP_GPP/pack_Drivers/csc_DriverDSP/src/DDSP_Main</span><br style="font-family: courier new,monospace;">
<br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">### Note: to override the kernel source path, use &quot;make KSRC=...&quot;</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">ARCH=ppc</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">CROSS_COMPILE=ppc_6xx-</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">KSRC=/usr/src/linux-2.6.18</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">
MY_CFLAGS =&nbsp; -I$(CSCI)/pack_Drivers/csc_DriverDSP/inc -I$(CSCI)/Common </span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">ADD_CFLAGS = -I$(CSCI)/pack_Drivers/csc_DriverDSP/inc -I$(CSCI)/Common 
</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">###### USER SPACE BUILD (no change required normally) ######</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">ifeq ($(KERNELRELEASE),)</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">ifneq ($(APPLICATIONS),)</span><br style="font-family: courier new,monospace;">
<br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">### Default Xenomai installation path</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">
XENO=/usr/src/lib_xenomai</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">XENOCONFIG=$(shell PATH=$(XENO):$(XENO)/bin:$(PATH) which xeno-config 2&gt;/dev/null)
</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">### Sanity check</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">ifeq ($(XENOCONFIG),)</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">
all::</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; @echo &quot;&gt;&gt;&gt; Invoke make like this: \&quot;make XENO=/path/to/xeno-config\&quot; &lt;&lt;&lt;&quot;
</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; @echo</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">
endif</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">CC=$(shell $(XENOCONFIG) --cc)</span><br style="font-family: courier new,monospace;">
<br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">CFLAGS=$(shell $(XENOCONFIG) --xeno-cflags) $(MY_CFLAGS)</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">LDFLAGS=$(shell $(XENOCONFIG) --xeno-ldflags) $(MY_LDFLAGS) -lnative -lrtdm </span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">
&nbsp;</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;"># This includes the library path of given Xenomai into the binary to make live</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;"># easier for beginners if Xenomai&#39;s libs are not in any default search path.</span><br><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">
LDFLAGS+=-Xlinker -rpath -Xlinker $(shell $(XENOCONFIG) --libdir)</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">all:: $(APPLICATIONS)
</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">clean::</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; $(RM) $(APPLICATIONS) *.o</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">
endif</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">endif</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">
###### KERNEL MODULE BUILD (no change required normally) ######</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">ifneq ($(MODULES),)</span><br style="font-family: courier new,monospace;">
<br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">### Default to sources of currently running kernel</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">KSRC ?= /lib/modules/$(shell uname -r)/build</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">
OBJS&nbsp;&nbsp;&nbsp;&nbsp; := ${patsubst %, %.o, $(MODULES)}</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">CLEANMOD := ${patsubst %, .%*, $(MODULES)}</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">PWD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; := $(shell if [ &quot;$$PWD&quot; != &quot;&quot; ]; then echo $$PWD; else pwd; fi)</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">### Kernel 2.6</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">ifeq ($(findstring 
2.6,$(KSRC)),2.6)</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">obj-m&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; := $(OBJS)</span><br style="font-family: courier new,monospace;">
<br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">EXTRA_CFLAGS := -I$(KSRC)/include/xenomai -I$(KSRC)/include/xenomai/posix $(ADD_CFLAGS)</span><br style="font-family: courier new,monospace;">
<br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">all::</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">
&nbsp;&nbsp;&nbsp; $(MAKE) -C $(KSRC) SUBDIRS=$(PWD) modules</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">### Kernel 2.4</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">else</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">ARCH&nbsp;&nbsp;&nbsp; ?= $(shell uname -i)</span><br style="font-family: courier new,monospace;">
<br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">INCLUDE := -I$(KSRC)/include/xenomai -I$(KSRC)/include/xenomai/compat -I$(KSRC)/include/xenomai/posix</span><br style="font-family: courier new,monospace;">
<br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">CFLAGS&nbsp; += $(shell $(MAKE) -s -C $(KSRC) CC=$(CC) ARCH=$(ARCH) SUBDIRS=$(PWD) modules) $(INCLUDE)</span><br style="font-family: courier new,monospace;">
<br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">all:: $(OBJS)</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">
endif</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">## Target for capturing 2.4 module CFLAGS</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">modules:</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; @echo &quot;$(CFLAGS)&quot;</span><br style="font-family: courier new,monospace;">
<br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">clean::</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; $(RM) $(CLEANMOD) *.o *.ko *.mod.c Module*.symvers
</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; $(RM) -R .tmp*</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">endif</span></font><br style="font-family: courier new,monospace;"></font><br>This works fine, but the generated objects are in the source .c directory.<br>And now, I want to generate objects in another directory : the Makefile directory.
<br>I don&#39;t see how to do. I need some help for this.<br><br>Thanks, <br>Best Regards<br><br><br>

------=_Part_2531_19951969.1192787475084--

