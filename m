From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] Re: Xenomai v2.2-rc2. PowerPC 405GPr board does
	=?iso-8859-1?q?not=09start?= up
Date: Mon, 22 May 2006 18:08:38 +0200
References: <446F852B.7090400@domain.hid> <e4s8e4$7f9$1@domain.hid>
	<4471DB7E.9000402@domain.hid>
In-Reply-To: <4471DB7E.9000402@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605221808.38756.niklaus.giger@domain.hid>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Am Montag, 22. Mai 2006 17:40 schrieb Philippe Gerum:
> Niklaus Giger wrote:
> > Hi everybody
> >
> > Philippe Gerum wrote:
> >>Here is the second release candidate for the v2.2 branch. Short log
> >>follows:
<...>
> Could you try building all skins as modules with only the nucleus
> statically built into the kernel? I'd like to know whether the lockup
> occurs when one of the skin attempts to initialize, or if the problem is
> in the early Xenomai bootstrap. TIA,
Okay. With the following .config XENOMAI settings my target starts up without 
any problem till the login:

CONFIG_XENOMAI=y
CONFIG_XENO_OPT_NUCLEUS=y
CONFIG_XENO_OPT_PERVASIVE=y
CONFIG_XENO_OPT_SECURITY_ACCESS=y
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
# CONFIG_XENO_HW_FPU is not set
CONFIG_XENO_SKIN_NATIVE=m
# CONFIG_XENO_OPT_NATIVE_PIPE is not set
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
# CONFIG_XENO_SKIN_PSOS is not set
# CONFIG_XENO_SKIN_UITRON is not set
# CONFIG_XENO_SKIN_VRTX is not set
CONFIG_XENO_SKIN_VXWORKS=m
CONFIG_XENO_SKIN_RTAI=m
CONFIG_XENO_OPT_RTAI_SEM=y
CONFIG_XENO_OPT_RTAI_SHM=y
CONFIG_XENO_SKIN_RTDM=m
CONFIG_XENO_OPT_RTDM_FILDES=128
CONFIG_XENO_SKIN_UVM=m
# CONFIG_XENO_DRIVERS_16550A is not set
CONFIG_XENO_DRIVERS_TIMERBENCH=m

Diff to my old .config is:
4c4
< # Mon May 22 18:02:59 2006
---
> # Sun May 21 00:23:12 2006
74a75,76
> CONFIG_XENO_OPT_PIPE=y
> CONFIG_XENO_OPT_PIPE_NRDEV=32
113,114c115,117
< CONFIG_XENO_SKIN_NATIVE=m
< # CONFIG_XENO_OPT_NATIVE_PIPE is not set
---
> CONFIG_XENO_SKIN_NATIVE=y
> CONFIG_XENO_OPT_NATIVE_PIPE=y
> CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ=4096
125c128
< CONFIG_XENO_SKIN_POSIX=m
---
> CONFIG_XENO_SKIN_POSIX=y
129,133c132,137
< CONFIG_XENO_SKIN_VXWORKS=m
< CONFIG_XENO_SKIN_RTAI=m
< CONFIG_XENO_OPT_RTAI_SEM=y
< CONFIG_XENO_OPT_RTAI_SHM=y
< CONFIG_XENO_SKIN_RTDM=m
---
> CONFIG_XENO_SKIN_VXWORKS=y
>
> #
> # RTAI emulator unavailable, disable native API or build it as module
> #
> CONFIG_XENO_SKIN_RTDM=y
135c139
< CONFIG_XENO_SKIN_UVM=m
---
> CONFIG_XENO_SKIN_UVM=y
141c145
< CONFIG_XENO_DRIVERS_TIMERBENCH=m
---
> CONFIG_XENO_DRIVERS_TIMERBENCH=y

Thanks a lot for your help
-- 
Niklaus Giger

