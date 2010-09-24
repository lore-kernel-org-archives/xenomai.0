MIME-Version: 1.0
Sender: dothemango@domain.hid
Date: Fri, 24 Sep 2010 21:07:24 +0200
Message-ID: <AANLkTim0ROW9R84M2cmxBOKc3m2EUuPOUK5og0p5ErcN@mail.gmail.com>
From: martin mangard <martin@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] rt_task_start returns -38 (ENOSYS)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello

I installed Xenomai on a x86 machine (kernel 2.6.30 wih xenomai
2.4.10). In order to verify the installation I ran the
latency-testprogram from the test-suite.
The latency test program aborts with the error ENOSYS :


== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
latency: failed to start display task, code -38

This output ist generated if the call err =
rt_task_start(&display_task, &display, NULL); ---> fails.

As mentioned in the documentation this error occurs, if not all
necesary modules are loaded or configured.

during the startup following messages occur:

.
.
I-pipe: Domain Xenomai registered.
Xenomai: hal/i386 started.
Xenomai: real-time nucleus v2.4.10 (Flavor Crystal 7) loaded.
Xenomai: starting native API services.
Xenomai: starting POSIX services.
Xenomai: starting RTDM services.
Xenomai: starting RTAI emulator.
.
.


This is my configuration of the Kernel subsystem:
.
.

#
# Real-time sub-system
#
CONFIG_XENOMAI=y
CONFIG_XENO_GENERIC_STACKPOOL=y
CONFIG_XENO_OPT_NUCLEUS=y
CONFIG_XENO_OPT_PERVASIVE=y
# CONFIG_XENO_OPT_ISHIELD is not set
CONFIG_XENO_OPT_PRIOCPL=y
CONFIG_XENO_OPT_PIPELINE_HEAD=y
CONFIG_XENO_OPT_PIPE=y
CONFIG_XENO_OPT_PIPE_NRDEV=32
CONFIG_XENO_OPT_REGISTRY=y
CONFIG_XENO_OPT_REGISTRY_NRSLOTS=512
CONFIG_XENO_OPT_SYS_HEAPSZ=128
CONFIG_XENO_OPT_SYS_STACKPOOLSZ=128
CONFIG_XENO_OPT_STATS=y
CONFIG_XENO_OPT_DEBUG=y
CONFIG_XENO_OPT_DEBUG_NUCLEUS=y
CONFIG_XENO_OPT_DEBUG_QUEUES=y
CONFIG_XENO_OPT_DEBUG_REGISTRY=y
# CONFIG_XENO_OPT_DEBUG_TIMERS is not set
# CONFIG_XENO_OPT_WATCHDOG is not set
# CONFIG_XENO_OPT_SHIRQ is not set

#



#
# Interfaces
#
CONFIG_XENO_SKIN_NATIVE=y
CONFIG_XENO_OPT_NATIVE_PERIOD=0
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
CONFIG_XENO_OPT_DEBUG_NATIVE=y
CONFIG_XENO_SKIN_POSIX=y
CONFIG_XENO_OPT_POSIX_PERIOD=0
CONFIG_XENO_OPT_POSIX_SHM=y
# CONFIG_XENO_OPT_POSIX_INTR is not set
# CONFIG_XENO_OPT_POSIX_SELECT is not set
# CONFIG_XENO_OPT_DEBUG_POSIX is not set
# CONFIG_XENO_SKIN_PSOS is not set
# CONFIG_XENO_SKIN_UITRON is not set
# CONFIG_XENO_SKIN_VRTX is not set
# CONFIG_XENO_SKIN_VXWORKS is not set
CONFIG_XENO_SKIN_RTAI=y
CONFIG_XENO_OPT_RTAI_PERIOD=0
CONFIG_XENO_OPT_RTAI_FIFO=y
CONFIG_XENO_OPT_RTAI_SEM=y
CONFIG_XENO_OPT_RTAI_SHM=y
CONFIG_XENO_SKIN_RTDM=y
CONFIG_XENO_OPT_RTDM_PERIOD=0
CONFIG_XENO_OPT_RTDM_FILDES=128
# CONFIG_XENO_OPT_RTDM_SELECT is not set
CONFIG_XENO_OPT_DEBUG_RTDM=y


Which subsystem do I have to enable in order to be able to  start a
rt_task as used in the latency test program ?

Martin

