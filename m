Subject: Re: [Xenomai-core] [BUG?] delayed PIC timer event
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <17723.29843.307241.50023@domain.hid>
References: <4537A5FA.509@domain.hid> <17723.29843.307241.50023@domain.hid>
Content-Type: text/plain
Date: Sun, 22 Oct 2006 16:03:49 +0200
Message-Id: <1161525830.4989.15.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

On Sun, 2006-10-22 at 15:39 +0200, Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Hi,
>  > 
>  > while actually cross-checking some user's problem with RTnet (not on
>  > Xenomai), I happen to stumble over another weirdness. Scenario:
>  > 
>  > RTnet under high load (>5 KHz network IRQ rate, large packets), "latency
>  > -p1000" as additional load, Pentium 266 MHz (tried boards from different
>  > vendors), kernel 2.6.17.13, Xenomai trunk, ipipe-1.5-00, CONFIG_M586TSC,
>  > !CONFIG_X86_UP_APIC
>  > 
>  > Main protagonists:
>  >  - "display-" (user, PID 909, prio 0/-1)
>  >  - "samplin" (user, PID 910, prio 99)
>  >  - stack manager (kernel, PID -1, prio 98)
>  >  - "client", the RTnet test (user, PID 903, prio 10)
>  > 
>  > So the sampling task is definitely the chief and should only be delayed
>  > by IRQ handlers. Generally it is (~120 us with i-pipe tracer enabled),
>  > but there happen to be delays of more than 500 us. Attached is such a trace.
>  > 
>  > Specifically suspicious is the fact that the timer IRQ, which should
>  > have popped up around -500, is not blocked by some hard IRQ lock. Rather
>  > it takes someone else (the RTnet test) to start another timer, and then
>  > the delayed event gets raised immediately. Hardware issue? Bug in
>  > Xenomai? With the same boot image on a P-III, this does not happen.
>  > 
>  > Any ideas what to check first are welcome.
> 
> I got similar behaviour on hardware where programming the timer for a
> too short delay did not work. The way to check this was to add :
> if (delay < 100)
>      printk("\n!!!! Short delay !!!!\n");
> 
> on the timer programming path.

Actually, there was a bug in the pipeline log syncer which has been
fixed in the latest patches for ppc and x86. This is a multi-arch issue
(__ipipe_sync_stage).

> 
-- 
Philippe.



