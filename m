Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Mar 2006 15:35:55 +0100
Message-ID: <FDBBB5CC70676540B3EF7CFE83FD94E0043100@domain.hid>
From: "ROSSIER Daniel" <Daniel.Rossier@domain.hid>
Subject: [Xenomai-core] IRQ latency with the ARM-9 based i.MXL/i.MX21 from
	Freescale
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


Hello,

We are still about to fix some timing issues with our Freescale =
i.MXL/i.MX21.

With our current port, we measured a delay between 6-7us between the =
timer IRQ and
its reprogramming; this actually corresponds more or less to the IRQ =
latency which is inherent to the=20
IRQ handling layer. However, with a simple Linux without Xenomai, we got =
a latency of 5 us.

Having a deep look at the IRQ entry point in ipipe-root.c - the patch we =
used comes from=20
the patch for ARM available in the CVS - we discovered that =
__ipipe_handle_irq is performed before
the timer reprogramming (i.e., before __ipipe_mach_set_dec()).
We moved the call to __ipipe_handle_irq() at the end of the function, =
and we then got a latency of 2us; this is great, but....

Does this change have an impact on the upper layers of Adeos? Timer =
reprogramming at this level shouldn't be affected
by other tasks, right? Can anybody confirm or not this?

I attached the function below.

Thanks a lot for your inputs.

Daniel

----------------

asmlinkage int __ipipe_grab_irq(int irq, struct pt_regs *regs)
{
	ipipe_declare_cpuid;

	if (irq =3D=3D __ipipe_mach_timerint) {

		__ipipe_tick_regs[cpuid].ARM_cpsr =3D regs->ARM_cpsr;
		__ipipe_tick_regs[cpuid].ARM_pc =3D regs->ARM_pc;

		__ipipe_handle_irq(irq, regs);

		ipipe_load_cpuid();

		if (__ipipe_decr_ticks !=3D __ipipe_mach_ticks_per_jiffy) {
			unsigned long long next_date, now;

			next_date =3D __ipipe_decr_next[cpuid];

			while ((now =3D __ipipe_read_timebase()) >=3D next_date)
				next_date +=3D __ipipe_decr_ticks;

			__ipipe_mach_set_dec(next_date - now);

			__ipipe_decr_next[cpuid] =3D next_date;
		}
	}
	else {
		__ipipe_handle_irq(irq, regs);

		ipipe_load_cpuid();
	}

	return (ipipe_percpu_domain[cpuid] =3D=3D ipipe_root_domain &&
		!test_bit(IPIPE_STALL_FLAG,
			  &ipipe_root_domain->cpudata[cpuid].status));
}

