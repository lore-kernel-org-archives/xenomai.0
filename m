From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <470F978B.1000005@domain.hid>
References: <4705ED3B.4070600@domain.hid>
	<2ff1a98a0710050130j7e0db84dq838aab0417c8bd3f@domain.hid>
	<4705FE04.7000909@domain.hid> <1191576011.20623.114.camel@domain.hid>
	<470611FA.30103@domain.hid> <1191592977.20623.142.camel@domain.hid>
	<470A26BC.506@domain.hid> <1192015852.22917.197.camel@domain.hid>
	<470F7F2E.3020206@domain.hid>  <470F82FF.9020701@domain.hid>
	<1192203284.6499.135.camel@domain.hid>  <470F978B.1000005@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Date: Fri, 12 Oct 2007 18:43:51 +0200
Message-Id: <1192207431.6499.161.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] awful latencies (~110us)
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2007-10-12 at 17:49 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Fri, 2007-10-12 at 16:21 +0200, Jan Kiszka wrote:
> >> CHABAL David wrote:
> >>> Philippe Gerum a =E9crit :
> >>>> I suspect the tracer to induce massive cache misses on your setup, w=
hich
> >>>> limits the interpretation we can have of this log. Could you apply t=
he
> >>>> following patch, and post back the frozen log for the very same test?
> >>>> TIA,
> >>>>
> >>>> --- 2.6.20-ipipe-1.8-08/kernel/ipipe/core.c~    2007-09-16
> >>>> 16:54:34.000000000 +0200
> >>>> +++ 2.6.20-ipipe-1.8-08/kernel/ipipe/core.c    2007-10-10
> >>>> 13:05:28.000000000 +0200
> >>>> @@ -283,7 +283,7 @@
> >>>>      unsigned long flags;
> >>>>      int s;
> >>>> =20
> >>>> -    local_irq_save_hw(flags);
> >>>> +    local_irq_save_hw_notrace(flags);
> >>>>      __raw_spin_lock(lock);
> >>>>      ipipe_load_cpuid();
> >>>>      ipd =3D per_cpu(ipipe_percpu_domain, cpuid);
> >>>> @@ -302,7 +302,7 @@
> >>>>      ipd =3D per_cpu(ipipe_percpu_domain, cpuid);
> >>>>      if (!raw_demangle_irq_bits(&x))
> >>>>          __clear_bit(IPIPE_STALL_FLAG, &ipd->cpudata[cpuid].status);
> >>>> -    local_irq_restore_hw(x);
> >>>> +    local_irq_restore_hw_notrace(x);
> >>>>  }
> >>>> =20
> >>>>  /*
> >>>>
> >>> The freeze file enclosed is generated with this patch and the i8259.c
> >>> patch.
> >>>
> >>> ---|------------|------------|------------|--------|-----------------=
--------
> >>>
> >>> RTS|       5.570|       9.400|      85.356|       0|    00:08:55/00:0=
8:55
> >>>
> >>> Should I try without the I-pipe debugger ?
> >> Never say never, but the tracer most probably not causing these
> >> latencies. Currently, all points to the good-old programmable interrupt
> >> controller.
> >>
> >> Do you have CONFIG_X86_UP_IOAPIC enabled? If no, please try to do so.
> >>
> >=20
> > Large spots are seen in the __ipipe_spin_lock_irqsave() routine, so we
> > are not running the XT-PIC mask/ack code proper. I just can't figure out
>=20
> As there are no function calls between spin_lock and unlock, the passed
> time is accounted to the spin_lock function by the tracer. Thus, the
> delay could perfectly include potential I/O stalls as well.
>=20

Indeed, that's true. Too bad we can only rely on mcount() style
instrumentation, this is deceptive here.

> > right now why the hardened spinlocking routine would cause such jitter
> > in UP mode, aside of a massive cache miss accessing the root stall bit.
> >=20
> > David, I've just released the following Adeos patch, it is aimed at
> > improving the cache footprints of the I-pipe -- this is a backport of
> > what we now have in the 2.6.22/1.10 series. Please use this instead of
> > 1.8-08, and try another set of traces.
> > http://download.gna.org/adeos/patches/v2.6/i386/adeos-ipipe-2.6.20-i386=
-1.10-06.patch
> >=20
>=20
> At this chance, what about instrumenting mask_and_ack_8259A with
> ipipe_trace_special() calls to get a more fine-grained picture of what
> is going on there?

Yes, good idea. Too many crappy hardwares need many tracepoints...

For now, I really wonder which part of the slave ack causes such delay.
David, please apply this, this should send some more traces enclosing
the execution of the suspected code:=20

--- 2.6.20-ipipe-1.8-08/arch/i386/kernel/i8259.c~	2007-10-05 15:47:41.00000=
0000 +0200
+++ 2.6.20-ipipe-1.8-08/arch/i386/kernel/i8259.c	2007-10-12 18:19:31.000000=
000 +0200
@@ -185,10 +185,13 @@
=20
 handle_real_irq:
 	if (irq & 8) {
+		ipipe_trace_special(0x11, irq);
 		inb(PIC_SLAVE_IMR);	/* DUMMY - (do we need this?) */
+		ipipe_trace_special(0x22, irq);
 		outb(cached_slave_mask, PIC_SLAVE_IMR);
 		outb(0x60+(irq&7),PIC_SLAVE_CMD);/* 'Specific EOI' to slave */
 		outb(0x60+PIC_CASCADE_IR,PIC_MASTER_CMD); /* 'Specific EOI' to master-IR=
Q2 */
+		ipipe_trace_special(0x33, irq);
 	} else {
 		inb(PIC_MASTER_IMR);	/* DUMMY - (do we need this?) */
 		outb(cached_master_mask, PIC_MASTER_IMR);

>  Remember, we are calling about ~30 us here, so
> caching effects - given the involved code size - are not really that like=
ly.

Not on this code size, I agree.

> Jan
>=20
--=20
Philippe.



