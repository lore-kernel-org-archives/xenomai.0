MIME-Version: 1.0
In-Reply-To: <5fb9e066-12c3-7d0b-b36e-01cf506e6082@xenomai.org>
References: <CALD0yU4tbmu_XbmvBoSySn76g8Cq0LW3qO+u=iavp4qj8ouXCQ@mail.gmail.com>
 <5fb9e066-12c3-7d0b-b36e-01cf506e6082@xenomai.org>
From: AG M <agm6274@gmail.com>
Date: Mon, 20 Feb 2017 11:25:03 -0600
Message-ID: <CALD0yU5k59=SCP4d9XkKfeYyMHWM3MqJk40-fAB2bkJVEZ9GxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Understanding Domain Switching
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Thanks Philippe.

I commented out all the pthread stuff and just ran a while loop
without any Linux system calls. I still see that MSW immediately
become 1 as soon as I start the program. It looks like the program is
immediately going to the secondary domain as soon as I run it (also I
wonder why I dont get the SIGXCPU signal now that I know its doing a
domain switch). My program at this point is a simple while loop.
Here's my Makefile

###### CONFIGURATION ######

### List of applications to be build
APPLICATIONS = main_posix

### Note: to override the search path for the xeno-config script, use
"make XENO=..."


### List of modules to be build
MODULES = main_posix

### Note: to override the kernel source path, use "make KSRC=..."

all::

satch: main_posix.c


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

CFLAGS=-DCONSUMER $(shell $(XENOCONFIG) --skin=posix --cflags) $(APP_CFLAGS)

LDFLAGS=$(shell $(XENOCONFIG) --skin=posix --ldflags) $(APP_LDFLAGS)

# This includes the library path of given Xenomai into the binary to make live
# easier for beginners if Xenomai's libs are not in any default search path.
LDFLAGS+=-Xlinker -rpath -Xlinker $(shell $(XENOCONFIG) --libdir)

all:: $(APPLICATIONS)

clean::
$(RM) $(APPLICATIONS) *.o

endif
endif


clean::
$(RM) $(CLEANMOD) *.o *.ko *.mod.c Module*.symvers Module.markers modules.order
$(RM) -R .tmp*
$(RM) .runinfo


My ultimate goal is to port my Linux based app to Xenomai. The
application has a lot of communication modules (WiFi, Ethernet, USB
etc. ) and some computing. I went through some of the old mailing
lists and found the following
1. Using RTDM based model does not necessarily guarantee hard
deadlines for communication/disk related activities. Keeping that in
mind, if I do all the communication and disk related activities with
Linux and do the computing/prcoessing (or something which does not
require Linux system call) with Xenomai, what would be the best way
for these to exchange information? For ex: I want to linux to fetch
data from TCP socket and Xenomai thread to process that data.
2.When it executing a non-rt service, it switches to the secondary
domain and then comes back to primary if it is rt-related. How can I
detect this secondary--> primary switch?

Thanks for your help!



On Wed, Feb 15, 2017 at 8:29 AM, Philippe Gerum <rpm@xenomai.org> wrote:
> On 02/15/2017 12:49 AM, AG M wrote:
>> Hi,
>>
>
> [snip]
>
>> I have simple program (using POSIX skin) and I'm trying to figure out
>> when my program switches from primary (Xenomai) to secondary domain
>> (Linux)
>> *****
>>  - How do I know if my program is running in primary or secondary
>> mode? I never get the SIGXCPU signal. Other signals like SIGINT work.
>
> Your demo loop won't switch to secondary mode since clock_nanosleep() is
> implemented by Xenomai as a real-time compatible service. Besides, using
> an explicit constant instead of PTHREAD_WARNSW is a bad idea; such value
> may change with the ABI across major Xenomai releases.
>
>> If I run the same example using the native skin, it works (using this:
>> http://svn.gna.org/svn/xenomai/trunk/examples/native/sigxcpu.c)
>>
>
> Caution, this is very, very outdated code from an abandoned server (10+
> years). You may want to refer to git.xenomai.org instead.
>
>> - I get the return value of ret pthread_setschedparam(pth,SCHED_FIFO,
>> &sparam); as 16 which is EBUSY. Any idea why? My goal is to run the
>> program in the highest priority if it transfers over to the secondary
>> domain.
>>
>
> pth is uninit memory in your example, so this code can't work. If you
> have symbol wrapping enabled, Xenomai's version of
> pthread_setschedparam() will be picked, affecting the scheduling policy
> of the Xenomai co-kernel. If you need the regular Linux policy to be
> changed, then call the glibc service via __real_pthread_setschedparam()
> instead.
>
>> - I'm also trying to figure out using /proc/xenomai/stat. This program
>> shows up as two processes and I see CSW and MSW have non zero values
>> and sometimes change. I know that it means a context switch but does
>> the mean its in the Linux domain?
>>
>
> MSW counts primary -> secondary transitions, i.e. from rt to Linux.
>
>> - If the program can be seen in Linux (meaning it gets a PID through
>> the Linux kernel), does it mean its running in secondary mode?
>>
>
> No, this is unrelated. A Xenomai thread running in primary mode appears
> as sleeping for the Linux kernel.
>
>> I'm running Xenomai 2.6.3 and ipipe 3.
>> Any help is appreciated. Thanks!
>>
>
> Xenomai 2.6.x reached EOL a year ago. Xenomai 3 is maintained.
>
> --
> Philippe.

