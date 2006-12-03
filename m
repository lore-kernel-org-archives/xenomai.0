Message-ID: <45733E1D.8090605@domain.hid>
Date: Sun, 03 Dec 2006 22:14:05 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [ANNOUNCE] Xenomai Example Repository
References: <457002EB.8080106@domain.hid> <45705C11.2010502@domain.hid>
	<457064F3.5050300@domain.hid> <4570AE1C.8050008@domain.hid>
	<4572E4FD.1040208@domain.hid>
In-Reply-To: <4572E4FD.1040208@domain.hid>
Content-Type: multipart/mixed; boundary="------------050107070808020604030300"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>, xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------050107070808020604030300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jan,

Jan Kiszka wrote:
> Wolfgang Grandegger wrote:
> 
>> Jan Kiszka wrote:
>>   
>>> Wolfgang Grandegger wrote:
>>>     
>>>> Jan Kiszka wrote:
>>>>       
>>>>> Hi,
>>>>>         
>>>>> the new Xenomai example repository has been created. I don't want to
>>>>>         
>>>>> repeat here what is explained already on the related wiki page, please
>>>>>         
>>>>> have a look at
>>>>>         
>>>>>     http://www.xenomai.org/index.php/Examples
>>>>>         
>>>>> Instead, let me sketch what could be done next:
>>>>>         
>>>>>  o Port existing examples, snippets, demos from ksrc/skins/* over, make
>>>>>         
>>>>>    them compilable and runnable if required.
>>>>>         
>>>>>  o Identify what kind of examples are lacking. You, the user, is needed
>>>>>         
>>>>>    here. What do *you* think is missing, what would be helpful to show?
>>>>>         
>>>>>  o Check what is needed to compile kernel-based examples over PPC 2.4.
>>>>>         
>>>>>    Philippe indicated that some switches are likely missing (x86 is fine
>>>>>         
>>>>>    already, other archs are 2.6-only).
>>>>>         
>>>> Some time ago I sent a patch for RTnet using the "kernel CFLAGS
>>>>       
>>>> capturing" trick to get proper switches for 2.4:
>>>>       
>>>> http://sourceforge.net/mailarchive/forum.php?thread_id=9493711&forum_id=24610
>>>>       
>>>>       
>>>> We could do the same trick here.
>>>>       
>>> Yeah, I had a look at this before. The point is that I would prefer to
>>>     
>>> keep things _simple_ and self-contained. This capturing requires some
>>>     
>>> helper Makefile and complex call nestings that likely only people with
>>>     
>>> advanced make and shell skills can understand and adopt to their projects.
>>>     
>>> But maybe things are that complicated already, and this is just
>>>     
>>> different complexity. How do you compile simple out-of-tree modules
>>>     
>>> against 2.4 PPC kernels? Are there any standard flags? Or is it
>>>     
>>> different for each board or each compiler version or whatever?
>>>     
>> I just cut and paste the flags from a kernel module make. For PPC, there 
>> are plenty of flags, not board but some are processor depended, but I'm 
>> unable to tell which one are really required. For this reason I like the 
>> module capturing trick.
>>   
> What about this patch? I /seems/ to work (yeah, only tested on x86...), merging the
> whole capturing stuff into the same Makefile. Please give it hell on PPC.

The attached Makefile works. I had to fix two problems. First, cross 
compilation was not supported. I now take the CC from "xeno-config --cc" 
for user space applications. I think "xeno-config" is intended only for 
making user space applications and therefore CC should be specified on 
the command line for kernel modules:

$ make KSRC=/devel/linuxppc_2_4_devel ARCH=ppc CC=ppc-linux-gcc
ppc-linux-gcc -D__KERNEL__ -I/devel/linuxppc_2_4_devel/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -I/devel/linuxppc_2_4_devel/arch/ppc -fsigned-char 
-msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g 
-ggdb -DMODULE 
-I/devel/linuxppc_2_4_devel-2006_11_21_1134/include/xenomai 
-I/devel/linuxppc_2_4_devel-2006_11_21_1134/include/xenomai/compat 
-I/devel/linuxppc_2_4_devel-2006_11_21_1134/include/xenomai/posix    -c 
-o heartbeat-x86.o heartbeat-x86.c

Furthermore I removed "-I$(KSRC)/include", it is already included in the 
captured CFLAGS.

Wolfgang.

> 
> Index: rtdm/driver-api/Makefile
> ===================================================================
> --- rtdm/driver-api/Makefile	(Revision 1916)
> +++ rtdm/driver-api/Makefile	(Arbeitskopie)
> @@ -47,23 +47,23 @@ ifneq ($(MODULES),)
>  
>  OBJS     := ${patsubst %, %.o, $(MODULES)}
>  CLEANMOD := ${patsubst %, .%*, $(MODULES)}
> +PWD      := $(shell if [ "$$PWD" != "" ]; then echo $$PWD; else pwd; fi)
>  
> -# Kernel 2.6
> +### Kernel 2.6
>  ifeq ($(findstring 2.6,$(KSRC)),2.6)
>  
>  obj-m        := $(OBJS)
>  EXTRA_CFLAGS := -I$(KSRC)/include/xenomai -I$(KSRC)/include/xenomai/posix $(ADD_CFLAGS)
> -PWD          := $(shell pwd)
>  
>  all::
>  	$(MAKE) -C $(KSRC) SUBDIRS=$(PWD) modules
>  
> -# Kernel 2.4
> +### Kernel 2.4
>  else
>  
> +ARCH    ?= $(shell uname -i)
>  INCLUDE := -I$(KSRC)/include -I$(KSRC)/include/xenomai -I$(KSRC)/include/xenomai/compat -I$(KSRC)/include/xenomai/posix
> -CFLAGS  += -O2 -Wall -Wstrict-prototypes -Wno-trigraphs -DMODULE -D__KERNEL__ -DLINUX \
> -           -fno-strict-aliasing -fno-common $(INCLUDE) $(ADD_CFLAGS)
> +CFLAGS  += $(shell $(MAKE) -s -C $(KSRC) CC=$(CC) ARCH=$(ARCH) SUBDIRS=$(PWD) modules) $(INCLUDE) $(ADD_CFLAGS)
>  
>  all:: $(OBJS)
>  
> @@ -74,3 +74,7 @@ clean::
>  	$(RM) -R .tmp*
>  
>  endif
> +
> +## Target for capturing 2.4 module CFLAGS
> +modules:
> +	@echo "$(CFLAGS)"
> 
> 
> Jan
> 
> 


--------------050107070808020604030300
Content-Type: text/plain;
 name="Makefile"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Makefile"

###### CONFIGURATION ######

### List of applications to be build
APPLICATIONS =

### Note: to override the search path for the xeno-config script, use "make XENO=..."


### List of modules to be build
MODULES = heartbeat-x86

### Default to sources of currently running kernel
KSRC ?= /lib/modules/$(shell uname -r)/build

### Note: to override the kernel source path, use "make KSRC=..."

###### USER SPACE BUILD (no change required normally) ######
ifneq ($(APPLICATIONS),)

XENOCONFIG=$(shell PATH=$(XENO):$(XENO)/bin:$(PATH) which xeno-config 2>/dev/null)

### Sanity check
ifeq ($(XENOCONFIG),)
all::
	@echo ">>> Invoke make like this: \"make XENO=/path/to/xeno-config\" <<<"
	@echo
endif

CC=$(shell $(XENOCONFIG) --cc)

CFLAGS=$(shell $(XENOCONFIG) --xeno-cflags) $(MY_CFLAGS)

LDFLAGS=$(shell $(XENOCONFIG) --xeno-ldflags) $(MY_LDFLAGS) -lnative -lrtdm

all:: $(APPLICATIONS)

clean::
	$(RM) $(APPLICATIONS) *.o

endif



###### KERNEL MODULE BUILD (no change required normally) ######
ifneq ($(MODULES),)

OBJS     := ${patsubst %, %.o, $(MODULES)}
CLEANMOD := ${patsubst %, .%*, $(MODULES)}
PWD      := $(shell if [ "$$PWD" != "" ]; then echo $$PWD; else pwd; fi)

### Kernel 2.6
ifeq ($(findstring 2.6,$(KSRC)),2.6)

obj-m        := $(OBJS)
EXTRA_CFLAGS := -I$(KSRC)/include/xenomai -I$(KSRC)/include/xenomai/posix $(ADD_CFLAGS)

all::
	$(MAKE) -C $(KSRC) SUBDIRS=$(PWD) modules

### Kernel 2.4
else

ARCH    ?= $(shell uname -i)
INCLUDE := -I$(KSRC)/include/xenomai -I$(KSRC)/include/xenomai/compat -I$(KSRC)/include/xenomai/posix
CFLAGS  += $(shell $(MAKE) -s -C $(KSRC) CC=$(CC) ARCH=$(ARCH) SUBDIRS=$(PWD) modules) $(INCLUDE) $(ADD_CFLAGS)

all:: $(OBJS)

endif

clean::
	$(RM) $(CLEANMOD) *.cmd *.o *.ko *.mod.c Module*.symvers
	$(RM) -R .tmp*

endif

## Target for capturing 2.4 module CFLAGS
modules:
	@echo "$(CFLAGS)"

--------------050107070808020604030300--

