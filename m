From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <8659178.81831292179675169.JavaMail.defaultUser@domain.hid>
References: <8659178.81831292179675169.JavaMail.defaultUser@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 12 Dec 2010 23:04:10 +0100
Message-ID: <1292191450.1837.22.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Interrupt handling vs. scheduler
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "mau.salvi@domain.hid" <mau.salvi@domain.hid>
Cc: xenomai@xenomai.org

On Sun, 2010-12-12 at 19:47 +0100, mau.salvi@domain.hid wrote:
> Hello to all,
>=20
> I observed a strange behaviour on oscilloscope during=20
> interrupt handling when RT periodic tasks reschedule happens.
>=20
> I have=20
> an interrupt generated every 1ms by a PCI card: the interrupt was=20
> handled into user-space with a RT task (priority 99) that sleeps on=20
> rt_intr_wait(), and the handler was created with I_NOAUTOENA flag, so=20
> there is a rt_intr_enable() call each cycle immediately before=20
> rt_intr_wait(). Into my code there is another task that works=20
> periodically on this PCI card data.
>=20
> Due to a "slip" between PC and PCI=20
> card hardware timers, sometimes there is an overlap between interrupt=20
> handling and periodic task wakeup: in detail, during interrupt=20
> handling, the periodic time for latter task expires, so wakeup must=20
> take place. In this (and only in this) condition I observe a wrong call=
=20
> to interrupt handling task immediately after the end of right handling:=
=20
> so, I have two consecutive interrupt calls, as the expire timer signal=
=20
> was delivered also to my interrupt handler. Task wakeup takes=20
> regularily place.
>=20
> This behaviour happens only if there is some other=20
> periodic task into my executable: without that, interrupts was properly=
=20
> handled every 1ms. "Strange" behaviour also happens if periodic task=20
> does nothing (waits rescheduling only).

What is the return value of rt_intr_wait() in both the valid and
spurious cases?

>=20
> I'm working on Ubuntu 10.04=20
> x86 with Xenomai 2.5.5.2 on a vanilla kernel 2.6.35.7, Adeos patch 2.7-
> 04.
> Hardware:  Intel Celeron M 512 MHz processor, motherboard with SMI=20
> services disabled by Xenomai at startup.
>=20
> I've seen that a new Adeos=20
> patch (2.8) was released for x86 arch, with more modifies into IRQ=20
> code: does new patch fixes this problem?

We don't know which problem this could be the symptom of, yet.

>=20
> Thanks in advance, bye
>=20
>=20
>=20
> Supera i limiti: raddoppia la velocit=C3=A0 da 10 a 20 Mega!   Risparmia =
con Tutto Incluso: telefono + adsl 20 mega a soli 29,95 =E2=82=AC al mese p=
er due anni!  SCONTO DI 240 EURO!  http://abbonati.tiscali.it/telefono-adsl=
/prodotti/tc/tuttoincluso/?WT.mc_id=3D01fw=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

--=20
Philippe.



