MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18368.24026.551410.454239@domain.hid>
Date: Sat, 23 Feb 2008 18:54:34 +0100
In-Reply-To: <47C02491.203@domain.hid>
References: <47C020A9.3050704@domain.hid>
	<47C02491.203@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] [RFC][PATCH 4/4] Recursive FIFO ticket xnlock
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai-core@domain.hid

Jan Kiszka wrote:
 > The root of all this: When Nick Piggin posted his first suggestion for
 > ticket spinlocks on LKML, I immediately liked the idea. For details
 > check LWN [1], in a nutshell: This algorithm enforces strict FIFO order
 > for the admission to contended spinlocks, thus it improves the
 > determinism on SMP systems with more than 2 CPUs.
 > 
 > Meanwhile, ticket spinlocks are mainline (2.6.25). But that version has
 > to drawbacks for us: it doesn't support nesting like xnlock does, and it
 > is x86-only so far.
 > 
 > So I designed a version for Xenomai which is both nestable and
 > arch-independent. It is certainly not as optimal as mainline's version,
 > but our code path stresses the locking code differently anyway.
 > 
 > This thing here /seems/ to work, but I'm lacking CPUs at home to test.
 > You can't truly stress ticket locks with only a single dual-core :-/.
 > QEMU runs into a live-lock with -smp 2, this patch applied and two
 > moderate latency loops, but that might be an artifact of its
 > single-threaded VCPU scheduling. And kvm currently locks up under SMP
 > even without any change, but kvm and SMP is a story of its own. There is
 > hope: 16-way is waiting at work... :)

Xenomai uses a Big Kernel Lock, an approach known to not scale very
well. So, if we want to scale correctly on machines with many cpus, we
should change our locking strategy first.

-- 


					    Gilles Chanteperdrix.

