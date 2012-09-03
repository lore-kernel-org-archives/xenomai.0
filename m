Message-ID: <50453DCE.5020601@xenomai.org>
Date: Tue, 04 Sep 2012 01:31:26 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAHue_TVRdTsre3E7NxHtb=6XfxkL7_36nsLLxSkiF3kUJAJ5Vw@mail.gmail.com>	<5022B5E4.7040101@xenomai.org>	<CAHue_TWodrVNxhsxXZ6_xcOGWHDqVGe41qbY0=R3RhFjBedG+g@mail.gmail.com>	<50339840.1070202@xenomai.org>	<CAHue_TVSGuatTqL4fRFoOABo4KTm8dFPmRFp7QJNmpk=ZU7NtQ@mail.gmail.com>	<CAHue_TUKTiusLqfXK59O+PVoxONKAE2xQyBYOgjDh=dZZ2-b3w@mail.gmail.com>	<504503DC.4040908@xenomai.org>
	<CAHue_TX3+pr39Mso1SXA83NWVRNoeocD-zDcLPk5mKn-XCkQKQ@mail.gmail.com>
In-Reply-To: <CAHue_TX3+pr39Mso1SXA83NWVRNoeocD-zDcLPk5mKn-XCkQKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Cortex-a9 - please fix xenomai-fix-lfs-issue.patch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?TWFyY2luIEt1xZtrYQ==?= <marckuska@gmail.com>
Cc: xenomai@xenomai.org

On 09/04/2012 01:04 AM, Marcin Ku=C5=9Bka wrote:

>> (...)
>=20
>>
>>> I-pipe, 1.000 MHz clocksource\
>>
>=20
> I was so concentrated on making work kernel on hardware that I somehow
> ignored it.
>=20
>=20
>> A Cortex-A9 (in MP mode) should use the "global timer" clock source,
>>
>=20
> That's good news because I decided to switch off SMP option and systems=

> works only with one CPU

>

>=20
>>
>>> smsc911x smsc911x: eth0: MAC Address: 00:02:f7:00:40:9c
>>> ------------[ cut here ]------------
>>> WARNING: at mm/slab.c:2264 kmem_cache_create+0x690/0x6dc()
>>
>=20
>> I would investigate this first. This looks scary.
>>
>=20
> What do you mean by investigate - try other options? SLUB e.g.?


I mean look at mm/slab.c line 2264 what the warning means, understanding
how this can happen and fix it.

>> High latencies for a cortex-A9. Maybe you enabled all xenomai debug
>> options?
>=20
>=20
> That's right - all debug options are on.


Well, maybe some kernel debug option causes an issue.

>=20
>=20
>>> Xenomai: RTDM: closing file descriptor 0.
>>> Segmentation fault
>>
>> Well without a disassembly of the faulting code and the values of the
>> the registers, we have no idea. Could you post your kernel configurati=
on?
>>
>=20
> I attached my kernel config with my previous mail, but here it is:


"attached" is the key word, simply paste the configuration in the mail
body, this make it possible to reply quoting contents of the file. And
in plain text (it is useless to post HTML to the xenomai mailing list,
since the mails got converted to plain text anyway).

> *#*

> *# Kernel Performance Events And Counters*
> *#*
> *CONFIG_PERF_EVENTS=3Dy*
> *# CONFIG_PERF_COUNTERS is not set*
> *# CONFIG_DEBUG_PERF_USE_VMALLOC is not set*
> *CONFIG_VM_EVENT_COUNTERS=3Dy*
> *CONFIG_COMPAT_BRK=3Dy*
> *CONFIG_SLAB=3Dy*
> *# CONFIG_SLUB is not set*
> *# CONFIG_SLOB is not set*
> *CONFIG_PROFILING=3Dy*
> *CONFIG_TRACEPOINTS=3Dy*
> *CONFIG_OPROFILE=3Dy*
> *CONFIG_HAVE_OPROFILE=3Dy*
> *# CONFIG_KPROBES is not set*
> *CONFIG_HAVE_KPROBES=3Dy*
> *CONFIG_HAVE_KRETPROBES=3Dy*
> *CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=3Dy*
> *CONFIG_HAVE_CLK=3Dy*
> *CONFIG_HAVE_DMA_API_DEBUG=3Dy*
> *CONFIG_HAVE_HW_BREAKPOINT=3Dy*


Please try disabling oprofile, tracepoints and profiling.


> *# CONFIG_XENO_OPT_DEBUG_NUCLEUS is not set*
> *CONFIG_XENO_OPT_DEBUG_XNLOCK=3Dy*


You do not need that without SMP.

> *# CONFIG_XENO_OPT_DEBUG_QUEUES is not set*
> *# CONFIG_XENO_OPT_DEBUG_REGISTRY is not set*
> *# CONFIG_XENO_OPT_DEBUG_TIMERS is not set*
> *CONFIG_XENO_OPT_DEBUG_SYNCH_RELAX=3Dy*
> *CONFIG_XENO_OPT_WATCHDOG=3Dy*
> *CONFIG_XENO_OPT_WATCHDOG_TIMEOUT=3D4*
> *# CONFIG_XENO_OPT_SHIRQ is not set*
> *CONFIG_XENO_OPT_SELECT=3Dy*
> *CONFIG_XENO_OPT_HOSTRT=3Dy*


> *#*
> *# Kernel Features*
> *#*
> *CONFIG_TICK_ONESHOT=3Dy*
> *# CONFIG_NO_HZ is not set*
> *CONFIG_HIGH_RES_TIMERS=3Dy*
> *CONFIG_GENERIC_CLOCKEVENTS_BUILD=3Dy*
> *# CONFIG_SMP is not set*
> *# CONFIG_VMSPLIT_3G is not set*
> *CONFIG_VMSPLIT_2G=3Dy*


Never tested that on ARM, always run with VMSPLIT_3G.

> *CONFIG_IPIPE_DEBUG=3Dy*
> *CONFIG_IPIPE_DEBUG_CONTEXT=3Dy*
> *CONFIG_IPIPE_DEBUG_INTERNAL=3Dy*
> *CONFIG_IPIPE_TRACE=3Dy*
> *CONFIG_IPIPE_TRACE_ENABLE=3Dy*
> *CONFIG_IPIPE_TRACE_MCOUNT=3Dy*
> *CONFIG_IPIPE_TRACE_IRQSOFF=3Dy*
> *CONFIG_IPIPE_TRACE_SHIFT=3D14*
> *CONFIG_IPIPE_TRACE_VMALLOC=3Dy*
> *CONFIG_IPIPE_TRACE_PANIC=3Dy*


Disable all that.


> *CONFIG_DEBUG_OBJECTS=3Dy*
> *CONFIG_DEBUG_OBJECTS_SELFTEST=3Dy*
> *CONFIG_DEBUG_OBJECTS_FREE=3Dy*
> *CONFIG_DEBUG_OBJECTS_TIMERS=3Dy*
> *CONFIG_DEBUG_OBJECTS_WORK=3Dy*
> *CONFIG_DEBUG_OBJECTS_RCU_HEAD=3Dy*
> *CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=3Dy*
> *CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=3D1*
> *CONFIG_DEBUG_SLAB=3Dy*
> *CONFIG_DEBUG_SLAB_LEAK=3Dy*
> *CONFIG_DEBUG_KMEMLEAK=3Dy*
> *CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE=3D400*
> *# CONFIG_DEBUG_KMEMLEAK_TEST is not set*
> *# CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set*
> *CONFIG_DEBUG_RT_MUTEXES=3Dy*
> *CONFIG_DEBUG_PI_LIST=3Dy*
> *# CONFIG_RT_MUTEX_TESTER is not set*
> *CONFIG_DEBUG_SPINLOCK=3Dy*
> *CONFIG_DEBUG_MUTEXES=3Dy*
> *CONFIG_DEBUG_LOCK_ALLOC=3Dy*
> *CONFIG_PROVE_LOCKING=3Dy*
> *CONFIG_PROVE_RCU=3Dy*
> *CONFIG_PROVE_RCU_REPEATEDLY=3Dy*
> *CONFIG_SPARSE_RCU_POINTER=3Dy*
> *CONFIG_LOCKDEP=3Dy*
> *# CONFIG_LOCK_STAT is not set*
> *# CONFIG_DEBUG_LOCKDEP is not set*
> *CONFIG_TRACE_IRQFLAGS=3Dy*
> *# CONFIG_DEBUG_ATOMIC_SLEEP is not set*
> *# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set*
> *CONFIG_STACKTRACE=3Dy*
> *# CONFIG_DEBUG_STACK_USAGE is not set*
> *# CONFIG_DEBUG_KOBJECT is not set*
> *CONFIG_DEBUG_BUGVERBOSE=3Dy*
> *CONFIG_DEBUG_INFO=3Dy*
> *# CONFIG_DEBUG_INFO_REDUCED is not set*
> *CONFIG_DEBUG_VM=3Dy*
> *CONFIG_DEBUG_WRITECOUNT=3Dy*
> *CONFIG_DEBUG_MEMORY_INIT=3Dy*
> *CONFIG_DEBUG_LIST=3Dy*
> *# CONFIG_TEST_LIST_SORT is not set*
> *CONFIG_DEBUG_SG=3Dy*
> *CONFIG_DEBUG_NOTIFIERS=3Dy*
> *CONFIG_DEBUG_CREDENTIALS=3Dy*
> *CONFIG_ARCH_WANT_FRAME_POINTERS=3Dy*
> *CONFIG_FRAME_POINTER=3Dy*
> *# CONFIG_BOOT_PRINTK_DELAY is not set*
> *# CONFIG_RCU_TORTURE_TEST is not set*
> *# CONFIG_BACKTRACE_SELF_TEST is not set*
> *# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set*
> *# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set*
> *# CONFIG_LKDTM is not set*
> *# CONFIG_FAULT_INJECTION is not set*
> *# CONFIG_LATENCYTOP is not set*
> *# CONFIG_SYSCTL_SYSCALL_CHECK is not set*
> *CONFIG_DEBUG_PAGEALLOC=3Dy*
> *CONFIG_WANT_PAGE_DEBUG_FLAGS=3Dy*
> *CONFIG_PAGE_POISONING=3Dy*
> *CONFIG_NOP_TRACER=3Dy*
> *CONFIG_HAVE_FUNCTION_TRACER=3Dy*
> *CONFIG_HAVE_FUNCTION_GRAPH_TRACER=3Dy*
> *CONFIG_HAVE_DYNAMIC_FTRACE=3Dy*
> *CONFIG_HAVE_FTRACE_MCOUNT_RECORD=3Dy*
> *CONFIG_HAVE_C_RECORDMCOUNT=3Dy*
> *CONFIG_RING_BUFFER=3Dy*
> *CONFIG_EVENT_TRACING=3Dy*
> *CONFIG_EVENT_POWER_TRACING_DEPRECATED=3Dy*
> *CONFIG_CONTEXT_SWITCH_TRACER=3Dy*
> *CONFIG_RING_BUFFER_ALLOW_SWAP=3Dy*
> *CONFIG_TRACING=3Dy*
> *CONFIG_GENERIC_TRACER=3Dy*
> *CONFIG_TRACING_SUPPORT=3Dy*
> *CONFIG_FTRACE=3Dy*


Disable FTRACE. You should also remove all these kernel debugging
options, they probably have nothing to do with the issue you are seeing.

>> Also, if you have all Xenomai and I-pipe debug options enabled, could
>> you try disabling them?
>>
>> I will, first thing in the morning.
>=20
>> Xenomai: suspending kernel thread 82922908 ('rtk5/0') at 0x8005bbc8
>> after exception #0x0
>>
>> This looks like the same bug as in the previous mail. We desperately
>> would like to know what is at 0x8005bbc8
>>
>=20
> But I don't have j-tag available to use - at least for now.
> KGDB as far as I know doesn't correspond to xenomai 2.6.1, am I right? =
Or
> maybe it is worth trying to use kgdb to specify the value of those
> addresses?


You do not need a JTAG to know what is at a given address: simply use
objdump on the kernel image. You can add some printks in Xenomai to
print the register values. I am afraid porting the I-pipe patch to a new
board requires a minimum of knowledge in kernel development, and this is
usually a job done in less than a week, so, I advise you to ask someone
around with some knowledge in kernel development to help you.


--=20
                                                                Gilles.


