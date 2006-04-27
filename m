Message-ID: <4450B194.4030707@domain.hid>
Date: Thu, 27 Apr 2006 13:57:08 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] IRQ1 forwarded to Linux?
References: <FDBBB5CC70676540B3EF7CFE83FD94E0210DD5@domain.hid>
In-Reply-To: <FDBBB5CC70676540B3EF7CFE83FD94E0210DD5@domain.hid>
Content-Type: text/plain; charset=windows-1252; format=flowed
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
To: ROSSIER Daniel <Daniel.Rossier@domain.hid>
Cc: xenomai@xenomai.org

ROSSIER Daniel wrote:
> Hello,
>=20
> =20
>=20
> We have a small Xeno application which implements an interrupt service=20
> (ISR) on IRQ 1 (keyboard) =96 quite stupid, but
>

What does the following say?
$ cat /proc/ipipe/Linux

> just for testing. If we understand well, returning from the ISR with=20
> RET_INTR_HANDLED should not propagate the
>=20
> IRQ to the other domains, therefore to the Linux one, right?
>=20
> Why can we then keep working with the shell? (I expect that we can not=20
> interact with the shell, even not see the echoed char.).
>=20
> =20
>=20
> Does Xenomai patch the keyb driver?
>=20
> =20
>=20
> (We've seen that on /proc/xenomai/irq, we get the IRQ1 count, but NOT o=
n=20
> the /proc/interrupts, as expected).
>=20
> =20
>=20
> Thanks for your help
>=20
> =20
>=20
> Daniel
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


--=20

Philippe.

