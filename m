Message-ID: <4351642C.2020607@domain.hid>
Date: Sat, 15 Oct 2005 22:18:52 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <43514FE1.80703@domain.hid>
In-Reply-To: <43514FE1.80703@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: Testing the adeos-ipipe-2.6.13-ppc-1.0-00.patch
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

Wolfgang Grandegger wrote:
> Hello Philippe,
> 
> I got Xenomai working on a Ocotea-Board (AMCC 440GX) and a low-end
> TQM855L-Module (MPC 855) under Linux 2.6.14-rc3 :-). The patch applied
> with a few hunks and one easy to fix reject and I had to correct two
> problems. One with FEW_CONTEXT (see attached patch) and the second with

Applied.

> "#include <asm/offsets.h>" in "xenomai/arch/ppc/hal/switch.S". The
> include file does not exist (any more) in the kernel tree and therefore

This was useless anyway, so I've removed it too.

> I commented out the line. I'm going to perform latency tests on various
> 4xx and 8xx boards next week.

This will help a lot, thanks.

  Here are some preliminary figures of the
> TQM855L-Module (CPU 80 MHz, Bus 40 MHz, 4 kB I-Cache 4 kB D-Cache):
> 
> bash-2.05b# ./cruncher -p 500
> Calibrating cruncher...3025953, 334, 334, 334, 334, done -- ideal
> computation time = 334 us.
> 1000 samples, 1000 hz freq (pid=338, policy=SCHED_FIFO, prio=99)
> --------
> Nanosleep jitter: min = 118 us, max = 474 us, avg = 155 us
> Execution jitter: min = 32 us (9%), max = 100 us (29%), avg = 47 us (14%)
> --------
> 
> bash-2.05b# ./switch -p 500
> == Sampling period: 500 us
> == Do not interrupt this program
> RTH|     lat min|     lat avg|     lat max|        lost
> RTD|      110400|      120200|      206600|           0
> 

Min lat is huge, there's a lot of room for improving the intrinsic latency...

> bash-2.05b# ./latency -p 500
> == Sampling period: 500 us
> ---|------------|------------|------------|--------|-------------------------
> RTS|       70000|       84000|      183200|       0|    00:00:50/00:00:50
> 
> Have a nice weekend.
> 

You too, thanks.

> Wolfgang.
> 
> 
> ------------------------------------------------------------------------
> 
> + diff -u linux-2.6.14-rc3-g4c234921-ipipe/arch/ppc/kernel/ipipe-root.c.FEW_CONTEXTS linux-2.6.14-rc3-g4c234921-ipipe/arch/ppc/kernel/ipipe-root.c
> --- linux-2.6.14-rc3-g4c234921-ipipe/arch/ppc/kernel/ipipe-root.c.FEW_CONTEXTS	2005-10-15 12:03:40.000000000 +0200
> +++ linux-2.6.14-rc3-g4c234921-ipipe/arch/ppc/kernel/ipipe-root.c	2005-10-15 13:56:29.000000000 +0200
> @@ -35,6 +35,7 @@
>  #include <asm/atomic.h>
>  #include <asm/io.h>
>  #include <asm/time.h>
> +#include <asm/mmu_context.h>
>  
>  extern irq_desc_t irq_desc[];
>  

-- 

Philippe.

