References: <55DF2471.6030006@cern.ch> <55DF2868.2070804@xenomai.org>
 <55DF32E3.1010706@cern.ch> <55E015FE.7000302@xenomai.org>
From: Konstantinos Chalas <konchalas@gmail.com>
Message-ID: <55E0560B.4040601@gmail.com>
Date: Fri, 28 Aug 2015 14:37:31 +0200
MIME-Version: 1.0
In-Reply-To: <55E015FE.7000302@xenomai.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Cyclictest in Xenomai-3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

Great! Now, it is much better! Thanks for the interest.

I have noticed something else, when using clock_nanosleep, there is 
something wrong going on. Example output with clock_nanosleep:

root@beaglebone:~# cyclictest    -p 99  -i 250 -n
# /dev/cpu_dma_latency set to 0us
policy: fifo: loadavg: 1.13 1.18 1.15 1/243 2385

T: 0 ( 2384) P:99 I:250 C: 122168 Min:      0 Act:    9 *Avg:2147483647* 
Max:      -1

The Avg value jumps to this insane number.
I didn't find any differences between the vanilla cyclictest and the 
xenomai-2.6 upstream cyclictest regarding the use of clock_nanosleep. 
Any ideas of where this behaviour would come from?

Thanks,
Konstantinos

On 08/28/2015 10:04 AM, Philippe Gerum wrote:
> On 08/27/2015 05:55 PM, Konstantinos Chalas wrote:
>> The build command for cyclictest was
>>
>> gcc -Wall -Wno-nonnull -I/usr/xenomai/include/cobalt
>> -I/usr/xenomai/include -march=armv7-a -mfpu=vfp3 -D_GNU_SOURCE
>> -D_REENTRANT -D__COBALT__ -O2 -Wl,@/usr/xenomai/lib/cobalt.wrappers
>> /usr/xenomai/lib/xenomai/bootstrap.o -Wl,--wrap=main
>> -Wl,--dynamic-list=/usr/xenomai/lib/dynlist.ld -L/usr/xenomai/lib
>> -lcobalt -lpthread -lrt -march=armv7-a -mfpu=vfp3   -o cyclictest
>> cyclictest.o -lrt -lpthread -lrttest -L
>>
>> Also the clock calibration is (i already run the autotune utility),
>>
>> root@beaglebone:~# cat /proc/xenomai/clock/coreclk
>> gravity: irq=499 kernel=1999 user=4999
>> devices: timer=timer2, clock=ipipe_tsc
>>   status: on
>>    setup: 999
>>    ticks: 350959191461
>>
>> and finally i run cyclictest with Thanks for the interest!
>>
>> cyclictest -n -p 99 -D 1000 -i 250 -m
> No wonder why you get weird results, the cyclictest thread does not run
> with a real-time priority since it uses sched_setscheduler() which is
> not wrapped by cobalt (pthread_setschedparam() is). You can check this
> by looking at /proc/xenomai/sched/threads.
>
> The quick and dirty hack below fixes it, and amends the Makefile to
> switch to the Xenomai libs from a cross-compilation root, when the
> COBALT variable is mentioned on the make command line. You may need to
> do some fixup there if you don't install under $crossroot/usr/xenomai
> though.
>
> diff --git a/Makefile b/Makefile
> index a48e759..49301b6 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -28,7 +28,7 @@ CPPFLAGS += -D_GNU_SOURCE -Isrc/include
>   LDFLAGS ?=
>
>   ifneq ($(filter x86_64 i386 ia64 mips powerpc,$(machinetype)),)
> -NUMA 	:= 1
> +NUMA 	:= 0
>   ifdef HAVE_PARSE_CPUSTRING_ALL
>   	CFLAGS += -DHAVE_PARSE_CPUSTRING_ALL
>   endif
> @@ -47,6 +47,11 @@ ifeq ($(NUMA),1)
>   	NUMA_LIBS = -lnuma
>   endif
>
> +ifneq ($(COBALT),)
> +	CFLAGS += $(shell DESTDIR=$(COBALT) $(COBALT)/usr/bin/xeno-config
> --posix --cflags)
> +	LDFLAGS += $(shell DESTDIR=$(COBALT) $(COBALT)/usr/bin/xeno-config
> --posix --ldflags)
> +endif
> +
>   VPATH	= src/cyclictest:
>   VPATH	+= src/signaltest:
>   VPATH	+= src/pi_tests:
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 34053c5..92c7043 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -795,7 +795,7 @@ void *timerthread(void *param)
>
>   	memset(&schedp, 0, sizeof(schedp));
>   	schedp.sched_priority = par->prio;
> -	if (setscheduler(0, par->policy, &schedp))
> +	if (pthread_setschedparam(pthread_self(), par->policy, &schedp))
>   		fatal("timerthread%d: failed to set priority to %d\n", par->cpu,
> par->prio);
>
>   	/* Get current time */

