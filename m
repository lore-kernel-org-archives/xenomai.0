Message-ID: <463ECC7A.2040901@domain.hid>
Date: Mon, 07 May 2007 08:51:38 +0200
From: Johan Borkhuis <j.borkhuis@domain.hid>
MIME-Version: 1.0
References: <4639D724.5010702@domain.hid>	<1178198991.29605.54.camel@domain.hid>
	<463AE79E.2090901@domain.hid>
	<1178281926.29093.93.camel@domain.hid> <463B2A69.7080704@domain.hid>
In-Reply-To: <463B2A69.7080704@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Latency calculation and test
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai-help@domain.hid

Jan,

Jan Kiszka wrote:
> Let me bet before the race is over: your cyclictest switches to
> secondary (Linux) mode with its high prio threads (e.g. on termination),
> priority coupling is active (that's default), and Linux runs on behalf
> of cyclictest for several hundred us which causes the delay for low prio
> latency. The I-pipe tracer would tell you more BTW, see Xenomai wiki.
>
> Jan
>   
I compiled the kernel with option CONFIG_XENO_OPT_RPIDISABLE not set, 
but this makes no difference. I am running latency with priority 60, 
while the cyclictest is run with priorities from 80 - 71, so latency 
does have the lowest priority.

This is the output from latency:
RTD|  -5.357|  -4.420|  -0.648|   0|  -5.381|   1.585
RTD|  -5.381|  -4.276|  38.054|   0|  -5.381|  38.054 << Start
RTD|  -5.165|  -4.060|  11.963|   0|  -5.381|  38.054
RTD|  -5.213|  -4.084|  12.204|   0|  -5.381|  38.054
RTD|  -5.021|  -4.012| 679.759|   7|  -5.381| 679.759 << End
RTD|  -5.381|  -4.396|  -1.465|   7|  -5.381| 679.759

Grepping for XENO on /proc/config.gz gives the following output:
CONFIG_XENOMAI=y
CONFIG_XENO_OPT_NUCLEUS=m
CONFIG_XENO_OPT_PERVASIVE=y
# CONFIG_XENO_OPT_ISHIELD is not set
# CONFIG_XENO_OPT_RPIDISABLE is not set
CONFIG_XENO_OPT_SECURITY_ACCESS=y
CONFIG_XENO_OPT_PIPELINE_HEAD=y
CONFIG_XENO_OPT_PIPE=y
CONFIG_XENO_OPT_PIPE_NRDEV=32
CONFIG_XENO_OPT_REGISTRY=y
CONFIG_XENO_OPT_REGISTRY_NRSLOTS=512
CONFIG_XENO_OPT_SYS_HEAPSZ=128
CONFIG_XENO_OPT_STATS=y
CONFIG_XENO_OPT_DEBUG=y
# CONFIG_XENO_OPT_DEBUG_NUCLEUS is not set
# CONFIG_XENO_OPT_DEBUG_QUEUES is not set
CONFIG_XENO_OPT_WATCHDOG=y
CONFIG_XENO_OPT_TIMING_PERIODIC=y
CONFIG_XENO_OPT_TIMING_PERIOD=0
CONFIG_XENO_OPT_TIMING_TIMERLAT=0
CONFIG_XENO_OPT_TIMING_SCHEDLAT=0
# CONFIG_XENO_OPT_SCALABLE_SCHED is not set
CONFIG_XENO_OPT_TIMER_LIST=y
# CONFIG_XENO_OPT_TIMER_HEAP is not set
# CONFIG_XENO_OPT_TIMER_WHEEL is not set
# CONFIG_XENO_OPT_SHIRQ_LEVEL is not set
# CONFIG_XENO_OPT_SHIRQ_EDGE is not set
CONFIG_XENO_SKIN_NATIVE=m
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
CONFIG_XENO_OPT_NATIVE_INTR=y
CONFIG_XENO_SKIN_POSIX=m
CONFIG_XENO_OPT_POSIX_SHM=y
CONFIG_XENO_OPT_POSIX_INTR=y
CONFIG_XENO_OPT_DEBUG_POSIX=y
# CONFIG_XENO_SKIN_PSOS is not set
# CONFIG_XENO_SKIN_UITRON is not set
# CONFIG_XENO_SKIN_VRTX is not set
CONFIG_XENO_SKIN_VXWORKS=m
# CONFIG_XENO_SKIN_RTAI is not set
CONFIG_XENO_SKIN_RTDM=m
CONFIG_XENO_OPT_RTDM_FILDES=128
CONFIG_XENO_OPT_DEBUG_RTDM=y
# CONFIG_XENO_DRIVERS_16550A is not set
CONFIG_XENO_DRIVERS_TIMERBENCH=m
# CONFIG_XENO_DRIVERS_IRQBENCH is not set
CONFIG_XENO_DRIVERS_SWITCHTEST=m
# CONFIG_XENO_DRIVERS_CAN is not set

I will cleanup my cyclictest program and post it ASAP.

Kind regards,
    Johan Borkhuis

