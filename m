Subject: Re: Re: [Xenomai-help] IRQ1 forwarded to Linux?
From: Guillaume Boutillier <guillaume.boutillier@domain.hid>
In-Reply-To: <1146143577.3671.3.camel@domain.hid>
References: <1146143577.3671.3.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Apr 2006 16:44:50 +0200
Message-Id: <1146149090.2938.33.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org


Hello,

> > ROSSIER Daniel wrote:
> > > Hello,
> > >=20
> > > =20
> > >=20
> > > We have a small Xeno application which implements an interrupt servic=
e=20
> > > (ISR) on IRQ 1 (keyboard) =E2=80=93 quite stupid, but
> > >=20
> >=20
> > Sorry,
> >=20
> > - $ cat /proc/ipipe/Linux
> > + $ cat /proc/ipipe/Xenomai

I checked when I run my application...=20
But I couldn't understand the meaning of the different flags : accepted,
passed and grabbed?!=20

> >=20
> > when your test is loaded would be useful to understand why Linux still=20
> > gets the kbd IRQs.
> >=20
> > > just for testing. If we understand well, returning from the ISR with=20
> > > RET_INTR_HANDLED should not propagate the
> > >=20
> > > IRQ to the other domains, therefore to the Linux one, right?
> > >=20
> > > Why can we then keep working with the shell? (I expect that we can no=
t=20
> > > interact with the shell, even not see the echoed char.).
> > >=20
> > > =20
> > >=20
> > > Does Xenomai patch the keyb driver?
> > >
> >=20
> > No.
> >=20
> > > =20
> > >=20
> > > (We've seen that on /proc/xenomai/irq, we get the IRQ1 count, but NOT=
 on=20
> > > the /proc/interrupts, as expected).
> > >=20
> > > =20
> > >=20
> > > Thanks for your help
> > >=20
> > > =20
> > >=20
> > > Daniel
> > >=20
> > >=20
> > > ---------------------------------------------------------------------=
---
> > >=20
> > > _______________________________________________
> > > Xenomai-help mailing list
> > > Xenomai-help@domain.hid
> > > https://mail.gna.org/listinfo/xenomai-help
> >=20
> >=20
Thanks for your help

Guillaume Boutillier

> pi=C3=A8ce jointe message de courriel, "Message transf=C3=A9r=C3=A9 - Re:
> [Xenomai-help] IRQ1 forwarded to Linux?"
> Le jeudi 27 avril 2006 =C3=A0 15:12 +0200, S=C3=A9bastien Gerber a =C3=A9=
crit :
> > ROSSIER Daniel wrote:
> > > Hello,
> > >=20
> > > =20
> > >=20
> > > We have a small Xeno application which implements an interrupt servic=
e=20
> > > (ISR) on IRQ 1 (keyboard) =E2=80=93 quite stupid, but
> > >
> >=20
> > What does the following say?
> > $ cat /proc/ipipe/Linux
> >=20
> > > just for testing. If we understand well, returning from the ISR with=20
> > > RET_INTR_HANDLED should not propagate the
> > >=20
> > > IRQ to the other domains, therefore to the Linux one, right?
> > >=20
> > > Why can we then keep working with the shell? (I expect that we can no=
t=20
> > > interact with the shell, even not see the echoed char.).
> > >=20
> > > =20
> > >=20
> > > Does Xenomai patch the keyb driver?
> > >=20
> > > =20
> > >=20
> > > (We've seen that on /proc/xenomai/irq, we get the IRQ1 count, but NOT=
 on=20
> > > the /proc/interrupts, as expected).
> > >=20
> > > =20
> > >=20
> > > Thanks for your help
> > >=20
> > > =20
> > >=20
> > > Daniel
> > >=20
> > >=20
> > > ---------------------------------------------------------------------=
---
> > >=20
> > > _______________________________________________
> > > Xenomai-help mailing list
> > > Xenomai-help@domain.hid
> > > https://mail.gna.org/listinfo/xenomai-help
> >=20
> >=20


