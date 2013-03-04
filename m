MIME-Version: 1.0
In-Reply-To: <1362372963.15714.YahooMailNeo@web192402.mail.sg3.yahoo.com>
References: <mailman.24.1362279196.1444.xenomai@xenomai.org>
	<1362305720.60639.YahooMailNeo@web192403.mail.sg3.yahoo.com>
	<CAJjOJyY3GZ2UO2xiJc4VXYnf7dJmh4aj_3jR=HHiN7CdCKnw8Q@mail.gmail.com>
	<1362372963.15714.YahooMailNeo@web192402.mail.sg3.yahoo.com>
Date: Sun, 3 Mar 2013 22:10:45 -0800
Message-ID: <CAJjOJyYBKjK9GdijsWR93V2rMiq-RUpnkiS1STforeA-HdaxXw@mail.gmail.com>
From: Jonathan Wallace <jonmon6691@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Problem Handling GPIO interrupts - compiling example
	codes
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Amlekar Gopal <gopal_amlekar@yahoo.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Sun, Mar 3, 2013 at 8:56 PM, Amlekar Gopal <gopal_amlekar@yahoo.com> wrote:
>
>
> ________________________________
> From: Jonathan Wallace <jonmon6691@gmail.com>
> To: Amlekar Gopal <gopal_amlekar@yahoo.com>
> Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>
> Sent: Sunday, 3 March 2013 4:59 PM
> Subject: Re: [Xenomai] Problem Handling GPIO interrupts - compiling example
> codes
>
>
>
> On Sunday, March 3, 2013, Amlekar Gopal wrote:
>
>
>
>
> Date: Sat, 2 Mar 2013 18:53:09 -0800
> From: Jonathan Wallace <jonmon6691@gmail.com>
> To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> Cc: Xenomai <xenomai@xenomai.org>
> Subject: Re: [Xenomai] Problem Handling GPIO interrupts
> Message-ID:
>     <CAJjOJyYkOmXyyrXCvQ+EHrW9qs98TdFw4SPV+1d9_ozMVM2xBg@mail.gmail.com>
> Content-Type: text/plain; charset=ISO-8859-1
>
> On Fri, Mar 1, 2013 at 10:44 PM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>> On 03/02/2013 07:38 AM, Jonathan Wallace wrote:
>>
>>> On Fri, Mar 1, 2013 at 9:41 PM, Gilles Chanteperdrix
>>> <gilles.chanteperdrix@xenomai.org
>>> <mailto:gilles.chanteperdrix@xenomai.org>> wrote:
>>>> On 03/02/2013 05:47 AM, Jonathan Wallace wrote:
>>>>
>>>>> Hi all,
>>>>>
>>>>> I'm trying to get a small variation of the usr_irq.c example working,
>>>>> but rt_intr_wait keeps returning -38 without blocking and perror
>>>>> prints success. If I don't let it print anything (so it will run
>>>>
>>>>
>>>> Sorry for the empty reply. The native skin does not use errno, so,
>>>> perror will not print anything, rt_intr_wait return value has to be
>>>> considered the error itself.
>>>>
>>>> -38 is -ENOSYS, meaning that the kernel does not implement the function.
>>>>
>>>> Indeed, handling interrupts in user-space is deprecated, for this
>>>> reason, support is disabled by default in Xenomai kernel.
>>>>
>>>> In order to add support for the rt_intr_* services, you have to enable
>>>> CONFIG_XENO_OPT_NATIVE_INTR
>>>> in the kernel configuration.
>>>>
>>>>
>>>>> faster) it seg faults after about 4 or 5 seconds, calling rt_intr_wait
>>>>> in an infinite loop during that time.
>>>>>
>>>>> I'm also having an issue where if I run the program from an SSH
>>>>> session, rt_task_create returns EPERM, but will return a success if I
>>>>> run the program from the serial console. I can only assume there's
>>>>> some difference in the shell processes at the kernel level, but if
>>>>> there's a way to get around this, I would love to know too.
>>>>
>>>>
>>>> I do not know if this is related, but Xenomai services are by default
>>>> only available to the "root" user, so, if you are not loging with ssh as
>>>> root user, what you observe is normal. If not, then what you observe is
>>>> a new bug. Maybe ssh restrict some capabilities even when logging at
>>>> root?
>>>>
>>>>
>>>>
>>>>>
>>>>> A little background about the IRQ, because I could have this all wrong
>>>>> too... I exported a gpio pin and echoed "falling" into the edge file
>>>>> in sysfs. This added an entry in /procs/interrupts "205: 42
>>>>> GPIO gpiolib" The number 42, increments every time I press my
>>>>> button to cause an physical interrupt on the pin so I know its at
>>>>> least working up to that point. I used this number 205 as the argument
>>>>> to rt_intr_create, but I'm not sure that was the right thing to do.
>>>>
>>>>
>>>> This should probably work. You may have to run rt_intr_enable after
>>>> rt_intr_create though.
>>>>
>>>> --
>>>>
>>>> Gilles.
>>>
>>> Oh, the API documentation doesn't list ENOSYS as a possible return value
>>> for rt_intr_wait, is there a Xenomai version of errno that I should use
>>> for the definitions of the error codes or are they just part of the
>>> standard headers?
>>
>>
>> ENOSYS is defined of errno.h, the error are not returned through the
>> "errno" variable by native skin services, but directly as negative
>> values. ENOSYS is a "generic" return value, meaning that a service is
>> not implemented by the kernel, and generally means that you have to
>> enable some option in the kernel configuration to enable the service.
>> Maybe we can document this in TROUBLESHOOTING.
>>
>>>
>>> Either way I'd rather run this in kernel space I thought I'd just
>>> implement it the easy way if possible to make sure things were working
>>> on the Xenomai side of things.
>>
>>
>> You can try to implement this in user-space. Chances are, however, that
>> handling interrupts in user-space is in fact harder than handling them
>> in kernel-space.
>>
>>>
>>> For the SSH part, I was root in both terminals, I'll check the ssh group
>>> permissions though. This is on a beaglebone btw.
>>
>>
>> Maybe your rootfs has /etc/security/capabilities.conf or
>> /etc/security/limits.conf ?
>>
>> (re-adding the list to cc).
>>
>> --
>>                                                                 Gilles.
>
> I've moved my test app over to a bare-bones module where I can printk
> to see if its working, but I can't get it to compile using a simple
> Makefile that works for cross-compiling modules that don't #include
> Xenomai headers. It quits when it can't find native/task.h. So I ran
> make with V=1 and it looks like -Iinclude/xenomai isn't added to the
> (enormous) gcc command, which should put native/* in the search path.
> I don't know what the "proper" way of adding this to the CFLAGS is so
> I thought I'd look at some of the examples in the xenomai source...
>
> I ended up modifying the makefile in
> .../xenomai-2.6.2.1/examples/rtdm/driver-api to try and make it
> compile just the rtdm examples for my board but the preprocesser isn't
> finding the Xenomai headers either and has a few other errors. I ran
> this one with V=1 also and it looks like some of the "-I" paths,
> including .../include/xenomai, are missing the XENO_DESTDIR prefix so
> its looking in my native machine's /lib/modules path instead of the
> target's, I don't know how to fix this one either. I can send one or
> both of these makefiles if it would help, but if there was an example
> with a makefile built for cross-compiling modules, that would make my
> life a lot easier.
>
> As far as the SSH permissions issue, I checked the files under
> /etc/security and there aren't any policies configured, ssh has a very
> minimal config (dropbear server). Let me know if there's anything else
> you want me to check, I don't know if there is a bugreporting site,
> but I'd be happy to write up a small report on it if you think its
> something worth looking into.
>
> -Jon
>
>
>
> ------------------------------
> I had similar issues when compiling the examples in source folder. After
> some trials, the following sequence worked for me. I just followed the steps
> on xenomai website here
> (http://www.xenomai.org/documentation/xenomai-2.6/html/README.INSTALL/#arm)
> and here (http://www.xenomai.org/index.php/Examples).
>
> 1. Patch the kernel sources with prepare-kernel.sh in scripts/
> 2. Build kernel in the same folder as the source. (Not to use the make O=
> option).
> 3. Configure xenomai source for user space for building (Using configure
> script in src/). This step I did from a new folder created somewhere other
> than the xenomai source code. ($build_root as mentioned in the links above).
> 4. Build Xenomai user space.i
>
>
> I've already gotten the kernel booting with the patch using the steps on the
> website as well as with a little help from the how to at this link:
> http://yapatel.org/wiki/index.php/Installing_Xenomai_on_a_beaglebone
> I even got the user space tools installed. The purpose of my question was to
> better understand how to build my own modules outside of the Xenomai source
> tree, you and Guilles answered that question very well.
>
>
> 5. Now, to compile the examples, DESTDIR is the staging directory where your
> xenomai user space is built. This is where the folder usr/xenomai appears
> after build. XENO= is DESTDIR/usr/xenomai so that it includes the neccessary
> files for the EXTRA_CFLAGS and KSRC is the linux source tree (not xenomai
> source tree as I had misunderstood earlier).
> 6. In addition, I had specified the ARCH= and CROSS_COMPILE= flags as well.
>
>
> I keep forgetting I need to do this every time I run make on a kernel build,
> the link you provided to the wiki article on compiling the examples is very
> helpful, and made me realize I was forgetting these options also.
>
> ---- I made a shell script for that long command but running that script
> gave some error again, so I am just continuing with the long command
> directly. I think I should put those flags like XENO= and so inside the
> Makefile itself. Will try it sometime later. ---
>
>
> Inspite of this, I have got shared library not found while running some of
> the examples on beagleboard C4. For now, I copied the library files
> appearing in usr/xenomai to /usr/lib and it worked. Don't know if that is
> the correct method. I will put up a separate message for that.
>
>
> Could you post the error you were getting? Sounds like the same problem I
> was having a few days ago. Turns out I needed to add /usr/Xenomai/lib to the
> library reach path. I did that by putting that path in /etc/ld.so.conf, it
> may be a folder called ld.so.conf.d on other systems, in that case add the
> path to any file in that directory.
>
> --- I'm not right now in front of that PC and the error has gone away now.
> But I remember it was something like "Shared library libnative.so.1 not
> found". I will try modifying the library search path and removing those
> files from /usr/lib. But for now, its working so it's tempting for me to
> skip past it. ----
>
>
> Another thing in step 4 was that the --host option needed to be put without
> the last "-" usually appearing in the cross_compile options. ( I use
> arm-angstrom-linux-gnueabi- toolchain, so I had to give that option as
> arm-angstrom-linux-gnueabi for the --host option).
>
> I am much noob to xenomai but just thought to share..
> Hope it helps.
>
> Thanks,
> Gopal
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>
>
> Thanks for the input, I'm a Linux kernel noob on top of being a Xenomai
> noob, it's all making my head spin just a little bit, but a good challenge
> is always rewarding.
> -Jon
>
> ----   +1 for this :-)  and good to be of help. ---
> I will put my long make command in next message when resume work tonight
> from home...
>
> oh and yes, did you make sure that the Makefile in your folder has the name
> of your program in that. For e.g. if you are compiling a user space module
> of your own (foo.c) then the line should be APPLICATIONS = foo and it could
> be followed by other modules as well in the same folder. If you are
> compiling a kernel module (bar.c) the module name should appear in the
> MODULES = bar.

I ended up putting all of those cross-compile related flags near the
top of the Makefile so all I need to do to compile for my board is
"make", I'll send you my file so you can see what I did. You have to
modify the $(MAKE) line that is propagated to the kernel build system
with the ARCH= and CROSS_COMPILE= commands, the other variables only
need to be set at the top of the file. Then just list your files in
the appropriate fields at the top, APPLICATIONS= and MODULES=.

-Jon

###### CONFIGURATION ######
APPLICATIONS =
MODULES = heartbeat

#>>>>># Lines that I added #<<<<<<<#
DESTDIR=/home/jon/bone
KSRC=/home/jon/xeno/beaglebone-xenomai/linux-3.2.21
XENO=$(DESTDIR)/usr/xenomai
ARCH=arm
CROSS_COMPILE=arm-linux-gnueabihf-

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
	@echo ">>> Invoke make like this: \"make XENO=/path/to/xeno-config\" <<<"
	@echo
endif
CC=$(shell $(XENOCONFIG) --cc)
CPPFLAGS=$(shell $(XENOCONFIG) --skin=native --cflags) $(MY_CFLAGS)
LDFLAGS=$(MY_LDFLAGS)
LDLIBS=$(shell $(XENOCONFIG) --skin=native --ldflags)

# This includes the library path of given Xenomai into the binary to make live
# easier for beginners if Xenomai's libs are not in any default search path.
LOADLIBES+=-Xlinker -rpath -Xlinker $(shell $(XENOCONFIG) --libdir)

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

### Kernel 2.6 or 3.0
PATCHLEVEL:=$(shell sed 's/PATCHLEVEL = \(.*\)/\1/;t;d' $(KSRC)/Makefile)
VERSION:=$(shell sed 's/VERSION = \(.*\)/\1/;t;d' $(KSRC)/Makefile)
ifneq ($(VERSION).$(PATCHLEVEL),2.4)

obj-m        := $(OBJS)
EXTRA_CFLAGS := -I$(KSRC)/include/xenomai
-I$(KSRC)/include/xenomai/posix $(ADD_CFLAGS)

#>>>>>>>>>>>>>>> Changed this recipe line <<<<<<<<<<<<<<<<<<<<<<<<<<<#
all::
	$(MAKE) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -C $(KSRC)
SUBDIRS=$(PWD) modules

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
	$(RM) $(CLEANMOD) *.o *.ko *.mod.c Module*.symvers Module.markers modules.order
	$(RM) -R .tmp*

endif
install: all
	cp *.ko /home/jon/bone/home/root/mod_testing/

