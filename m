From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <49CCD081.3020203@domain.hid>
References: <49CC95A4.9010702@domain.hid> <1238145958.6815.145.camel@domain.hid>
	<49CC9E46.3050501@domain.hid> <1238149727.6815.151.camel@domain.hid>
	<49CCD081.3020203@domain.hid>
Content-Type: text/plain
Date: Fri, 27 Mar 2009 14:46:00 +0100
Message-Id: <1238161560.6815.187.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Meaning of cache locking in /proc/xenomai/faults
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: belatronix@domain.hid
Cc: xenomai@xenomai.org

On Fri, 2009-03-27 at 14:11 +0100, Axel Beierlein wrote:
> Philippe Gerum schrieb:
> > On Fri, 2009-03-27 at 10:37 +0100, Axel Beierlein wrote:
> >> Philippe Gerum schrieb:
> >>> On Fri, 2009-03-27 at 10:00 +0100, Axel Beierlein wrote:
> >>>> Hello,
> >>>>
> >>>> on my MPC5200 i have the following output of /proc/xenomai/faults
> >>>>
> >>>> TRAP         CPU0
> >>>>    0:            0    (Data or instruction access)
> >>>>    1:            0    (Alignment)
> >>>>    2:            0    (Altivec unavailable)
> >>>>    3:            0    (Program check exception)
> >>>>    4:            0    (Machine check exception)
> >>>>    5:            0    (Unknown)
> >>>>    6:            0    (Instruction breakpoint)
> >>>>    7:            0    (Run mode exception)
> >>>>    8:            0    (Single-step exception)
> >>>>    9:            0    (Non-recoverable exception)
> >>>>   10:            0    (Software emulation)
> >>>>   11:            0    (Debug)
> >>>>   12:            0    (SPE)
> >>>>   13:            0    (Altivec assist)
> >>>>   14:  -1072753084    (Cache-locking exception)
> >>>>   15:            0    (Kernel FP unavailable)
> >>>>
> >>>> Now i am trying to find out what the negative Value of Cache-locking and 
> >>>> what this Trap general mean and when it was triggered.
> >>> The negative value is only the sign of an overflow. However, a cache
> >>> locking exception is specific to FSL_BOOKE archs. What is your kernel
> >>> release and exact ppc platform configuration?
> > 
> > 
> > You can ignore the last two counters, when 2.4.25-ppc is involved, they
> > contain garbage in fact; this does not have any consequences beyond that
> > strange output. The patch below should fix them, actually leave them
> > zeroed.
> > 
> > --- include/asm-ppc/ipipe.h~	2008-06-08 16:15:51.000000000 +0200
> > +++ include/asm-ppc/ipipe.h	2009-03-27 11:22:31.000000000 +0100
> > @@ -80,7 +80,7 @@ do {						\
> >  #define IPIPE_TRAP_DEBUG	11	/* Debug exception */
> >  #define IPIPE_TRAP_SPE		12	/* SPE exception */
> >  #define IPIPE_TRAP_ALTASSIST	13	/* Altivec assist exception */
> > -#define IPIPE_NR_FAULTS		14
> > +#define IPIPE_NR_FAULTS		16
> >  /* Pseudo-vectors used for kernel events */
> >  #define IPIPE_FIRST_EVENT	IPIPE_NR_FAULTS
> >  #define IPIPE_EVENT_SYSCALL	(IPIPE_FIRST_EVENT)
> > 
> 
> Thank you Philippe for your Help.
> 
> By the way, can you, or someone else, point me to a message where are 
> the other traps are explained or can you give me short examples for 
> situations where the listed exceptions are triggered?
> For example: What is an alignment Trap and which situation can trigger 
> such a fault.
> 

You probably want to have alook at the PowerPC UISA documentation:
http://download.boulder.ibm.com/ibmdl/pub/software/dw/library/es-ppcbook1.zip

You will find common reasons for traps. Additionally, you should refer
to your core's reference manual, since it may have specifics regarding
why/when some exceptions are triggered. Alignment exception is usually
due to data placement, misaligned float ops are usual suspects, but
depending on your particular ppc core, other reasons for alignment traps
may exist (e.g. e300 cores fire this exception when using a particular
byte-zeroing instruction on cache-inhibited memory). In short, YMMV.

> Axel
-- 
Philippe.



