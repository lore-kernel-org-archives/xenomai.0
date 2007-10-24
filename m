Message-ID: <471F4903.2070001@domain.hid>
Date: Wed, 24 Oct 2007 15:30:43 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <fd6a47a90710240611l76b68672g1af78f8cb5784753@domain.hid>
In-Reply-To: <fd6a47a90710240611l76b68672g1af78f8cb5784753@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] I-pipe fasteoi interrupt handling issue
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
To: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jeroen Van den Keybus wrote:
> On my Linux 2.6.23 with latest I-pipe patch (1.10-10), interrupts are
> dispatched twice if they are of the fasteoi type.
>  
> I have the impression that the I-pipe does the eoi() acknowledgement (in
> kernel/irq/chip.c: __ipipe_ack_fasteoi_irq) without first masking off
> the IRQ. As the interrupt line hasn't been cleared at this time, the
> interrupt is immediately reissued. Afterwards (in
> __ipipe_end_fasteoi_irq), unmasking is performed correctly nevertheless.
> If I add 'desc->chip->mask(irq);' before the 'desc->chip->eoi(irq);',
> Linux won't boot anymore; apparently the timer IRQs no longer make it to
> the APIC.

The reason this won't work is because ->mask() will also lock the
interrupt at I-pipe level, i.e. prevent the IRQ from flowing down the
pipeline (see ipipe_lock_irq). What we want here is only a physical
masking, not a physical+logical one, because we still want the incoming
IRQ to be dispatched to the kernel, albeit we ask the IO-APIC not to
send another one until we unmask the source (unmasking without masking
is ok, and simply leads to a no-op).

-- 
Philippe.

