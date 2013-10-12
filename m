MIME-Version: 1.0
In-Reply-To: <3b559e148cf71d636e41b420b7476428.squirrel@127.0.0.1>
References: <CAKKWdtfW+p1twc63Z1t3AXQscNtCGMO0j0NUc9uqq4gXaCgfoA@mail.gmail.com>
	<3b559e148cf71d636e41b420b7476428.squirrel@127.0.0.1>
Date: Sat, 12 Oct 2013 19:00:14 +0330
Message-ID: <CAKKWdtctE64WA0v74-s6DgtBjVW14TJxjeTZtb66Sj5UKkw=Qw@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Watchdog timer does not function correctly
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is the C code and it is run for an Intel core to  quad , 2.4 MHZ CPU:

#include <sys/mman.h>
#include <native/timer.h>
#include <stdio.h>
#include <native/alarm.h>
#include <native/task.h>

void main(){
RT_TIMER_INFO var1;
RTIME var2;
SRTIME nanosec;
char c1, *name1;
RT_ALARM alarm1;
RT_ALARM_INFO info1;
int i,j;
RT_TASK task1;

mlockall(MCL_CURRENT|MCL_FUTURE);
j = rt_task_shadow(&task1, "xentask1", 50, T_FPU);
if(j == 0)
    printf("successfully task was moved to the primary domain\n");

printf("RTIME,  size=%d\n", sizeof(RTIME));
printf("unsigned long long, size=%d\n", sizeof(unsigned long long));
printf("unsigned long, size=%d\n", sizeof(unsigned long));
printf("unsigned, size=%d\n", sizeof(unsigned));

printf("\nAperiodic mode\n");
rt_timer_set_mode(0);
rt_timer_inquire(&var1);
printf("period=%.1llu, date=%.1llu tsc=%.1llu\n", var1.period, var1.date,
var1.tsc);
nanosec = 1;
printf("%.1llu ns = %.1llu internal clock ticks\n", nanosec,
rt_timer_ns2ticks(nanosec));
printf("%.1llu ns = %.1llu CPU clock tick\n", nanosec,
rt_timer_ns2tsc(nanosec));
printf("%.1llu = current system time\n", rt_timer_read());

printf("\nPeriodic mode\n");
rt_timer_set_mode(100000000);
nanosec = 1000000;
printf("%.1llu ns = %.1llu internal clock ticks\n", nanosec,
rt_timer_ns2ticks(nanosec));
rt_timer_inquire(&var1);
printf("period=%.1llu, date=%.1llu tsc=%.1llu\n", var1.period, var1.date,
var1.tsc);
printf("%.1llu = current system time\n", rt_timer_read());

printf("\nrt-timer_spin-test-in-periodic-mode\n");
rt_timer_spin(50);
printf("\nnow pops up after...seconds\n");
printf("\nrt-timer_spin-test-in-aperiodic-mode\n");
rt_timer_set_mode(0);
rt_timer_spin(1000000000ull);
printf("\nnow pops up after...seconds\n");
printf("\n");

rt_timer_set_mode(0);
printf("\n1 tick in aperiodic mode is %.1llu nano seconds \n",
rt_timer_ticks2ns(1));
rt_timer_set_mode(100000000);
printf("\n1 tick in periodic mode is %.1llu nano seconds \n",
rt_timer_ticks2ns(1));

printf("\nPress any key to continue...\nn: next tsc; q:quit\n");
do{
    c1 = getchar();
    if(c1 == 'n')
        printf("\ntsc = %.1llu\n", rt_timer_tsc());
}while (c1 != 'q');

printf("\n 10 CPU ticks = %.1llu nano seconds \n", rt_timer_tsc2ns(10));

rt_timer_set_mode(0);
printf("\ntesting alarm services\n");
printf("\nreading alarm information\n");
rt_alarm_create(&alarm1, "alarm1");
rt_alarm_inquire(&alarm1, &info1);
printf("expiration = %.1llu, expiries = %.1lu, name = %s\n",
info1.expiration, info1.expiries, info1.name );
printf("now starting the periodic timer...\n");
rt_alarm_start(&alarm1, 2000000000ull, 1000000000ull);
for(i = 0; i < 1; i++){
    j = rt_alarm_wait(&alarm1);
    if(j == -EPERM)
        printf("sucess");
}
printf("\n");
rt_alarm_inquire(&alarm1, &info1);
printf("expiration = %.1llu, expiries = %.1lu, name = %s\n",
info1.expiration, info1.expiries, info1.name );
printf("now starting the one shot timer...\n");
for(i = 0; i < 3; i++){
    rt_alarm_start(&alarm1, 1000000000ull, TM_INFINITE);
    rt_alarm_wait(&alarm1);
    rt_alarm_inquire(&alarm1, &info1);
    printf("expiration = %.1llu, expiries = %.1lu, name = %s\n",
info1.expiration, info1.expiries, info1.name );
}

while(1);

}

and it is compiled by the following makefile:

###### CONFIGURATION ######

### List of applications to be build
APPLICATIONS = examp2
### Note: to override the search path for the xeno-config script, use "make
XENO=..."


### List of modules to be build
MODULES =

### Note: to override the kernel source path, use "make KSRC=..."



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


CC=$(shell $(XENOCONFIG) --cc)

CPPFLAGS=$(shell $(XENOCONFIG) --skin=native --cflags) $(MY_CFLAGS)

LDFLAGS=$(MY_LDFLAGS)
LDLIBS=$(shell $(XENOCONFIG) --skin=native --ldflags)

# This includes the library path of given Xenomai into the binary to make
live
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
    $(RM) $(CLEANMOD) *.o *.ko *.mod.c Module*.symvers Module.markers
modules.order
    $(RM) -R .tmp*

endif



On Wed, Oct 9, 2013 at 2:21 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

>
> ali hagigat wrote:
> > I have installed xenomai-2.6.2.1 for linux-3.5.7 under Fedora 13
> correctly
> > and the Xenomai tests like,  "latency",  seem to work properly. I have
> > written a application and have made it execute in the primary xenomai
> mode
> > by rt_task_shadow and the timer mode is set in one shot=aperiodic.
> > I have put the following instruction at the end of my C code:
> >
> > while(1);
> >
> > and I have only one real time application in user space. Watchdog timer
> > facility has been enabled inside the kernel. but it does not kill the
> > runaway process after 4 seconds!! that task continues to run. For the
> > first
> > 3 minutes when i use "PS axu" , it shows that CPU has been use over 70%.
> > But the number will rise gradually so that it becomes 88%, even 100% and
> > then suddenly, the system freezes and the screen is not updated and
> > keyboard and other things seem not functioning.
> >
> > That was the first problem.
>
> Please post the full code of the test application. The only reason I could
> see for such a behaviour would be if the signal SIGXCPU is ignored, masked,
> or its handler does not stop the program.
>
> >
> > Another problem is that before executing that real-time application, when
> > i
> > execute the regular Linux tasks like i run "make -j 16" for compiling the
> > Linux kernel, system becomes not responsive much, for some minutes the
> > keystrokes of the keyboard are not taken  till "make" finishes.
> > What is the reason for that?
> >
> > That was the second problem.
>
> I do not understand how this problem is related to Xenomai.
>
> --
>                                               Gilles
>
>
