Message-ID: <440D3A08.2070303@domain.hid>
Date: Tue, 07 Mar 2006 08:45:12 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Problem booting xenomai r662 on PowerPc
References: <200603062025.54413.niklaus.giger@domain.hid>
In-Reply-To: <200603062025.54413.niklaus.giger@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: xenomai-core <xenomai@xenomai.org>

Niklaus Giger wrote:
> Hi
> 
> After a couple of month I try to recompile xenomai and now neither my 
> Powerbook nor my PPC405 build start up. I accepted all default values which 
> showed up done in a "make oldconfig" (e.g.
> All I get is:
> ## Transferring control to Linux (at address 00000000) ...
> id mach(): done
> MMU:enter
> MMU:hw init
> MMU:mapin
> MMU:setio
> MMU:exit
> setup_arch: enter
> setup_arch: bootmem
> ocp: exit

Which patch are you using? Which is the last patch that used to work? Does it 
still work on your config?

> The xeno-part of my config is:
> CONFIG_XENOMAI=y
> CONFIG_XENO_OPT_NUCLEUS=y
> CONFIG_XENO_OPT_PERVASIVE=y
> CONFIG_XENO_OPT_PIPE=y
> CONFIG_XENO_OPT_PIPE_NRDEV=32
> CONFIG_XENO_OPT_REGISTRY=y
> CONFIG_XENO_OPT_REGISTRY_NRSLOTS=512
> CONFIG_XENO_OPT_SYS_HEAPSZ=128
> # CONFIG_XENO_OPT_ISHIELD is not set
> CONFIG_XENO_OPT_STATS=y
> # CONFIG_XENO_OPT_DEBUG is not set
> CONFIG_XENO_OPT_WATCHDOG=y
> CONFIG_XENO_OPT_TIMING_PERIODIC=y
> CONFIG_XENO_OPT_TIMING_PERIOD=0
> CONFIG_XENO_OPT_TIMING_TIMERLAT=0
> CONFIG_XENO_OPT_TIMING_SCHEDLAT=0
> # CONFIG_XENO_OPT_SCALABLE_SCHED is not set
> CONFIG_XENO_OPT_TIMER_LIST=y
> # CONFIG_XENO_OPT_TIMER_HEAP is not set
> # CONFIG_XENO_OPT_SHIRQ_LEVEL is not set
> # CONFIG_XENO_OPT_SHIRQ_EDGE is not set
> # CONFIG_XENO_HW_FPU is not set
> CONFIG_XENO_SKIN_NATIVE=y
> CONFIG_XENO_OPT_NATIVE_PIPE=y
> CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ=4096
> CONFIG_XENO_OPT_NATIVE_SEM=y
> CONFIG_XENO_OPT_NATIVE_EVENT=y
> CONFIG_XENO_OPT_NATIVE_MUTEX=y
> CONFIG_XENO_OPT_NATIVE_COND=y
> CONFIG_XENO_OPT_NATIVE_QUEUE=y
> CONFIG_XENO_OPT_NATIVE_HEAP=y
> CONFIG_XENO_OPT_NATIVE_ALARM=y
> CONFIG_XENO_OPT_NATIVE_MPS=y
> CONFIG_XENO_OPT_NATIVE_INTR=y
> # CONFIG_XENO_SKIN_POSIX is not set
> # CONFIG_XENO_SKIN_PSOS is not set
> # CONFIG_XENO_SKIN_UITRON is not set
> # CONFIG_XENO_SKIN_VRTX is not set
> # CONFIG_XENO_SKIN_VXWORKS is not set
> # CONFIG_XENO_SKIN_RTAI is not set
> CONFIG_XENO_SKIN_RTDM=y
> CONFIG_XENO_SKIN_UVM=y
> # CONFIG_XENO_DRIVERS_16550A is not set
> # CONFIG_XENO_DRIVERS_TIMERBENCH is not set
> 
> DOes anybody have a clue?
> 
> Best regards


-- 

Philippe.

