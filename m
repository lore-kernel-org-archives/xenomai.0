Message-ID: <4EE1C949.2030404@domain.hid>
Date: Fri, 09 Dec 2011 09:39:37 +0100
From: Damir Anicic <Damir.Anicic@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Novice - help needed
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi!

(Sorry for a long mail)

This is my first xenomai instalation.

Xenomai 2.6.0
linux kernel 2.6.38.8
on Ubuntu 11.10
on (normal) desktop intel PC ( Core(TM)2 Duo CPU )

All compiled and booted (it does boot xemonai-kernel):

xeno config:
$xenomai_root/configure --enable-x86-sep --enable-x86-tsc --enable-smp

kernel config(xeno):
 >>> grep XENO .config | grep =y
CONFIG_XENOMAI=y
CONFIG_XENO_GENERIC_STACKPOOL=y
CONFIG_XENO_FASTSYNCH=y
CONFIG_XENO_OPT_NUCLEUS=y
CONFIG_XENO_OPT_PERVASIVE=y
CONFIG_XENO_OPT_PRIOCPL=y
CONFIG_XENO_OPT_PIPELINE_HEAD=y
CONFIG_XENO_OPT_PIPE=y
CONFIG_XENO_OPT_VFILE=y
CONFIG_XENO_OPT_STATS=y
CONFIG_XENO_OPT_DEBUG=y
CONFIG_XENO_OPT_DEBUG_XNLOCK=y
CONFIG_XENO_OPT_WATCHDOG=y
CONFIG_XENO_OPT_SHIRQ=y
CONFIG_XENO_OPT_SELECT=y
CONFIG_XENO_OPT_HOSTRT=y
CONFIG_XENO_OPT_TIMING_PERIODIC=y
CONFIG_XENO_OPT_TIMER_LIST=y
CONFIG_XENO_HW_FPU=y
CONFIG_XENO_HW_SMI_DETECT=y
CONFIG_XENO_HW_SMI_WORKAROUND=y
CONFIG_XENO_HW_SMI_ALL=y
CONFIG_XENO_SKIN_NATIVE=y
CONFIG_XENO_OPT_NATIVE_PIPE=y
CONFIG_XENO_OPT_NATIVE_SEM=y
CONFIG_XENO_OPT_NATIVE_EVENT=y
CONFIG_XENO_OPT_NATIVE_MUTEX=y
CONFIG_XENO_OPT_NATIVE_COND=y
CONFIG_XENO_OPT_NATIVE_QUEUE=y
CONFIG_XENO_OPT_NATIVE_BUFFER=y
CONFIG_XENO_OPT_NATIVE_HEAP=y
CONFIG_XENO_OPT_NATIVE_ALARM=y
CONFIG_XENO_OPT_NATIVE_MPS=y
CONFIG_XENO_OPT_DEBUG_NATIVE=y
CONFIG_XENO_SKIN_POSIX=y
CONFIG_XENO_OPT_POSIX_SELECT=y
CONFIG_XENO_OPT_DEBUG_POSIX=y
CONFIG_XENO_SKIN_VXWORKS=y
CONFIG_XENO_OPT_DEBUG_VXWORKS=y
CONFIG_XENO_SKIN_RTDM=y
CONFIG_XENO_OPT_RTDM_SELECT=y
CONFIG_XENO_OPT_DEBUG_RTDM_APPL=y
CONFIG_XENO_DRIVERS_TIMERBENCH=y
CONFIG_XENO_DRIVERS_IRQBENCH=y
CONFIG_XENO_DRIVERS_SWITCHTEST=y

 >>> uname -a
Linux pc8084 2.6.38.8-xenomai #6 SMP PREEMPT Thu Dec 8 15:51:53 CET 2011 
i686 i686 i386 GNU/Linux

 >>> dmesg | grep -i i-pipe
[    0.000000] I-pipe 2.10-01: pipeline enabled.
[    0.321045] I-pipe: Domain Xenomai registered.

 >>> dmesg | grep -i xeno
[    0.321045] Xenomai: hal/i386 started.
[    0.321045] Xenomai: scheduling class idle registered.
[    0.321045] Xenomai: scheduling class rt registered.
[    0.321045] Xenomai: real-time nucleus v2.6.0 (Movin' On) loaded.
[    0.321045] Xenomai: debug mode enabled.
[    0.321045] Xenomai: starting native API services.
[    0.321045] Xenomai: starting POSIX services.
[    0.321045] Xenomai: starting RTDM services.
[    0.321045] Xenomai: starting VxWorks services.

 >>> ls -R /proc/xenomai
/proc/xenomai:
acct  affinity  apc  faults  heap  interfaces  irq  latency  lock  
registry  rtdm  sched  schedclasses  stat  timebases  timer  timerstat  
version

/proc/xenomai/interfaces:
native  posix  rtdm  sys  vxworks

/proc/xenomai/registry:
usage

/proc/xenomai/rtdm:
fildes  named_devices  open_fildes  protocol_devices  rttest-irqbench0  
rttest-switchtest0  rttest-timerbench0

/proc/xenomai/rtdm/rttest-irqbench0:
information

/proc/xenomai/rtdm/rttest-switchtest0:
information

/proc/xenomai/rtdm/rttest-timerbench0:
information

/proc/xenomai/schedclasses:
rt

/proc/xenomai/schedclasses/rt:
threads

/proc/xenomai/timerstat:
master  vxworks

 >>> ls /dev/rt*
/dev/rtc     /dev/rtp0   /dev/rtp11  /dev/rtp14  /dev/rtp17  /dev/rtp2   
/dev/rtp22  /dev/rtp25  /dev/rtp28  /dev/rtp30  /dev/rtp5  /dev/rtp8
/dev/rtc0    /dev/rtp1   /dev/rtp12  /dev/rtp15  /dev/rtp18  /dev/rtp20  
/dev/rtp23  /dev/rtp26  /dev/rtp29  /dev/rtp31  /dev/rtp6  /dev/rtp9
/dev/rtheap  /dev/rtp10  /dev/rtp13  /dev/rtp16  /dev/rtp19  /dev/rtp21  
/dev/rtp24  /dev/rtp27  /dev/rtp3   /dev/rtp4   /dev/rtp7




But:

 >>> cd /usr/xenomai/bin

 >>> sudo ./mutex-torture-native
simple_wait
FAILURE: simple mutex_lock 1: 1 (Operation not permitted) instead of 0


 >>> sudo ./mutex-torture-posix
Xenomai Posix skin init: pthread_setschedparam: Function not implemented


 >>> sudo ./clocktest
Xenomai Posix skin init: pthread_setschedparam: Function not implemented


 >>> sudo ./wakeup-time
== Sampling period: 100 us
== Do not interrupt this program


Please help,

Damir




