From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Wed, 10 May 2006 22:27:09 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605102227.09892.niklaus.giger@domain.hid>
Subject: [Xenomai-core] Kernel panic on rmmod xeno_vxworks
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hi

I compiled and started my test with a recent xenomai/trunk (revision 1068).
I booted into single user mode, did a "modprobe xeno_vxworks" (no problem) and 
then a "rmmod xeno_vxworks" and got as response on my PowerBook only
"Kernel panic: -not syncing: Aiee, killing interrupt handler".


Also when I try to run ksrc/skins/vxworks/demos/satch (after a make std)
I get the following info (using gdb):
(gdb) run
Starting 
program: /mnt/data.ng/hcu/kernel/xenomai-head/ksrc/skins/vxworks/demos/satch
[Thread debugging using libthread_db enabled]
[New Thread 805415264 (LWP 4168)]
[New Thread 805434592 (LWP 4171)]
[New Thread 805450976 (LWP 4172)]

Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 805434592 (LWP 4171)]
0x0fe76094 in vfprintf () from /lib/tls/libc.so.6
(gdb) info stack
#0  0x0fe76094 in vfprintf () from /lib/tls/libc.so.6
#1  0x0fe7e760 in printf () from /lib/tls/libc.so.6
#2  0x10001a6c in consumer_task (a0=269287424, a1=268894208, a2=269477288, 
a3=0, a4=0, a5=0, a6=269482760, a7=805474048,
    a8=2144297840, a9=268064096) at satch.c:99
#3  0x0ffa7714 in wind_task_trampoline (cookie=0x7fcf632c) 
at /mnt/data.ng/hcu/kernel/xenomai-head/src/skins/vxworks/taskLib.c:99
#4  0x0ffd08e8 in start_thread () from /lib/tls/libpthread.so.0
#5  0x0ffd08e8 in start_thread () from /lib/tls/libpthread.so.0
Previous frame inner to this frame (corrupt stack?)

The XENOMAI-parts of my config are:
grep XENO /boot/config-2.6.14
CONFIG_XENOMAI=y
CONFIG_XENO_OPT_NUCLEUS=y
CONFIG_XENO_OPT_PERVASIVE=y
CONFIG_XENO_OPT_SECURITY_ACCESS=y
CONFIG_XENO_OPT_PIPE=y
CONFIG_XENO_OPT_PIPE_NRDEV=32
CONFIG_XENO_OPT_REGISTRY=y
CONFIG_XENO_OPT_REGISTRY_NRSLOTS=512
CONFIG_XENO_OPT_SYS_HEAPSZ=128
# CONFIG_XENO_OPT_ISHIELD is not set
CONFIG_XENO_OPT_PIPELINE_HEAD=y
CONFIG_XENO_OPT_STATS=y
# CONFIG_XENO_OPT_DEBUG is not set
CONFIG_XENO_OPT_WATCHDOG=y
CONFIG_XENO_OPT_TIMING_PERIODIC=y
CONFIG_XENO_OPT_TIMING_PERIOD=1000000
CONFIG_XENO_OPT_TIMING_TIMERLAT=0
CONFIG_XENO_OPT_TIMING_SCHEDLAT=0
# CONFIG_XENO_OPT_SCALABLE_SCHED is not set
CONFIG_XENO_OPT_TIMER_LIST=y
# CONFIG_XENO_OPT_TIMER_HEAP is not set
# CONFIG_XENO_OPT_SHIRQ_LEVEL is not set
# CONFIG_XENO_OPT_SHIRQ_EDGE is not set
CONFIG_XENO_HW_FPU=y
CONFIG_XENO_SKIN_NATIVE=y
CONFIG_XENO_OPT_NATIVE_PIPE=y
CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ=4096
CONFIG_XENO_OPT_NATIVE_REGISTRY=y
CONFIG_XENO_OPT_NATIVE_SEM=y
CONFIG_XENO_OPT_NATIVE_EVENT=y
CONFIG_XENO_OPT_NATIVE_MUTEX=y
CONFIG_XENO_OPT_NATIVE_COND=y
CONFIG_XENO_OPT_NATIVE_QUEUE=y
CONFIG_XENO_OPT_NATIVE_HEAP=y
CONFIG_XENO_OPT_NATIVE_ALARM=y
CONFIG_XENO_OPT_NATIVE_MPS=y
# CONFIG_XENO_OPT_NATIVE_INTR is not set
# CONFIG_XENO_SKIN_POSIX is not set
# CONFIG_XENO_SKIN_PSOS is not set
# CONFIG_XENO_SKIN_UITRON is not set
# CONFIG_XENO_SKIN_VRTX is not set
CONFIG_XENO_SKIN_VXWORKS=m
CONFIG_XENO_SKIN_RTDM=y
CONFIG_XENO_OPT_RTDM_FILDES=128
CONFIG_XENO_SKIN_UVM=m
# CONFIG_XENO_DRIVERS_16550A is not set
CONFIG_XENO_DRIVERS_TIMERBENCH=m

Any help would be appreciated.

Best regards

-- 
Niklaus Giger

