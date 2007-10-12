From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <470F82FF.9020701@domain.hid>
References: <4705ED3B.4070600@domain.hid>
	<2ff1a98a0710050130j7e0db84dq838aab0417c8bd3f@domain.hid>
	<4705FE04.7000909@domain.hid> <1191576011.20623.114.camel@domain.hid>
	<470611FA.30103@domain.hid> <1191592977.20623.142.camel@domain.hid>
	<470A26BC.506@domain.hid> <1192015852.22917.197.camel@domain.hid>
	<470F7F2E.3020206@domain.hid>  <470F82FF.9020701@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Date: Fri, 12 Oct 2007 17:34:44 +0200
Message-Id: <1192203284.6499.135.camel@domain.hid>
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

On Fri, 2007-10-12 at 16:21 +0200, Jan Kiszka wrote:
> CHABAL David wrote:
> > Philippe Gerum a =E9crit :
> >>
> >> I suspect the tracer to induce massive cache misses on your setup, whi=
ch
> >> limits the interpretation we can have of this log. Could you apply the
> >> following patch, and post back the frozen log for the very same test?
> >> TIA,
> >>
> >> --- 2.6.20-ipipe-1.8-08/kernel/ipipe/core.c~    2007-09-16
> >> 16:54:34.000000000 +0200
> >> +++ 2.6.20-ipipe-1.8-08/kernel/ipipe/core.c    2007-10-10
> >> 13:05:28.000000000 +0200
> >> @@ -283,7 +283,7 @@
> >>      unsigned long flags;
> >>      int s;
> >> =20
> >> -    local_irq_save_hw(flags);
> >> +    local_irq_save_hw_notrace(flags);
> >>      __raw_spin_lock(lock);
> >>      ipipe_load_cpuid();
> >>      ipd =3D per_cpu(ipipe_percpu_domain, cpuid);
> >> @@ -302,7 +302,7 @@
> >>      ipd =3D per_cpu(ipipe_percpu_domain, cpuid);
> >>      if (!raw_demangle_irq_bits(&x))
> >>          __clear_bit(IPIPE_STALL_FLAG, &ipd->cpudata[cpuid].status);
> >> -    local_irq_restore_hw(x);
> >> +    local_irq_restore_hw_notrace(x);
> >>  }
> >> =20
> >>  /*
> >>
> > The freeze file enclosed is generated with this patch and the i8259.c
> > patch.
> >=20
> > ---|------------|------------|------------|--------|-------------------=
------
> >=20
> > RTS|       5.570|       9.400|      85.356|       0|    00:08:55/00:08:=
55
> >=20
> > Should I try without the I-pipe debugger ?
>=20
> Never say never, but the tracer most probably not causing these
> latencies. Currently, all points to the good-old programmable interrupt
> controller.
>=20
> Do you have CONFIG_X86_UP_IOAPIC enabled? If no, please try to do so.
>=20

Large spots are seen in the __ipipe_spin_lock_irqsave() routine, so we
are not running the XT-PIC mask/ack code proper. I just can't figure out
right now why the hardened spinlocking routine would cause such jitter
in UP mode, aside of a massive cache miss accessing the root stall bit.

David, I've just released the following Adeos patch, it is aimed at
improving the cache footprints of the I-pipe -- this is a backport of
what we now have in the 2.6.22/1.10 series. Please use this instead of
1.8-08, and try another set of traces.
http://download.gna.org/adeos/patches/v2.6/i386/adeos-ipipe-2.6.20-i386-1.1=
0-06.patch


--=20
Philippe.



