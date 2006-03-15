From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17432.5656.591747.248941@domain.hid>
Date: Wed, 15 Mar 2006 14:26:48 +0100
Subject: Re: [Xenomai-core] Synchronising TSC and periodic timer
In-Reply-To: <44180FB8.7080200@domain.hid>
References: <44172B67.2000609@domain.hid> <4417C14A.2010900@domain.hid>
	<44180FB8.7080200@domain.hid>
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
 > At worst, you would see an old timestamp from a previous shot while the timer IRQ 
 > announcing the most accurate one is still outstanding but untaken, but I think 
 > that you would still have something behaving in a monotonic way though.
 > 
 > > Does anyone ever studied if and how Linux synchronises across CPUs?
 > > There was some activity around the problematic AMD64 multicores, but I
 > > haven't looked at the details and if it's actually solved now.
 > > 
 > 
 > Only once during boot AFAICT, see arch/i386/kernel/smpboot.c. This said, TSC 
 > synchronization would not work on NUMA boxen.

I think Jan is talking about using TSC to get intra-ticks precise clock,
by adding tsc offsets to the time derived from the clock irqs count.
This would allow, for example, to run the "latency" test with the timer
set in periodic mode.

The issue with non-monotonic values happens if two clock interrupts are
distant from a bit more than one tick, because of the jitter. Reading
the time just before the second irq then yield a greater value than the
one read just after the second irq.

-- 


					    Gilles Chanteperdrix.

