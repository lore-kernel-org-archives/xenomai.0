Date: Wed, 4 Nov 2009 19:19:07 +0100
From: Richard Cochran <richardcochran@domain.hid>
Message-ID: <20091104181907.GA24561@domain.hid>
References: <20091103133407.GA9836@domain.hid>
	<1257259464.2210.32.camel@domain.hid>
	<20091104055659.GA5280@domain.hid>
	<1257328464.2210.66.camel@domain.hid>
	<20091104111536.GA14614@domain.hid>
	<1257334005.2210.86.camel@domain.hid>
	<20091104140832.GA32220@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091104140832.GA32220@domain.hid>
Subject: Re: [Xenomai-core] [Xenomai core] Freeze on MPC8572 and P2020 with
	SMP
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, Nov 04, 2009 at 03:08:32PM +0100, Richard Cochran wrote:
> On Wed, Nov 04, 2009 at 12:26:45PM +0100, Philippe Gerum wrote:
> > Ok, this is a porting issue. The critical IPI (IPIPE_CRITICAL_IPI) does
> > not seem to be properly handled on this platform.

Okay, after playing with the BDI3000 today, I have found out that both
cores end up running in infinite loops.

Core 0 runs this loop in ipipe_critical_enter() at
arch/powerpc/kernel/ipipe.c:278

	while (!cpus_equal(__ipipe_cpu_sync_map, lock_map))
		cpu_relax();

Dissambles to...

0xc000a5d4 <ipipe_critical_enter+368>: lwz     r0,-23316(r30)
0xc000a5d8 <ipipe_critical_enter+372>: xor     r0,r3,r0
0xc000a5dc <ipipe_critical_enter+376>: andi.   r9,r0,3
0xc000a5e0 <ipipe_critical_enter+380>: bne+    0xc000a5d4 <ipipe_critical_enter+368>

Core 1 runs an infinite loop in cpu_idle() calling into
ipipe_suspend_domain() now and again. The stack looks like:

#0  ipipe_suspend_domain () at kernel/ipipe/core.c:614
#1  0xc0008c0c in cpu_idle () at arch/powerpc/kernel/idle.c:62
#2  0xc030262c in start_secondary () at arch/powerpc/kernel/smp.c:556
#3  0xc0001ca8 in __secondary_start ()

I realize this is only the symptom, but now I'll study the code
leading up to this condition.

Any ideas on the prossible cause, Philippe?

Thanks,
Richard

