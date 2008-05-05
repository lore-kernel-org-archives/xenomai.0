Message-ID: <481F884E.5080201@domain.hid>
Date: Tue, 06 May 2008 00:21:02 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <481F6C7D.1050908@domain.hid>
In-Reply-To: <481F6C7D.1050908@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig99D3F06E1E1FFCA1637F7AB7"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Loosing serial interrupt
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Tomas Kalibera <kalibera@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig99D3F06E1E1FFCA1637F7AB7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Tomas Kalibera wrote:
> Hi,
>=20
> I am having problems with lost serial interrupts. Could you please
> explain to me why this happens ? I am probably missing something
> regarding scheduling in Xenomai...
> I prepared a program that triggers the problem, at least on my system.
>=20
> Thanks,
>=20
> Tomas
>=20
> The program works on my system as follows:
>=20
> 1. I run the program, it prints
>=20
> In interrupt, LStatus: 96
> In interrupt, read char, LStatus: 96
>=20
> [which means that it received a serial interrupt, because the
> transmitter receiver is empty]
>=20
> 2. I send a single character to the program over serial line
>=20
> 3. the program wakes up (10 seconds after (1))
>=20
> 4. the program prints
>=20
> I-NFO irq=3D4 hits=3D1
> PIC-ISR:0 PIC-IRR:0 PIC-IMR:128 UART-IIR:4 UART-LSR:97 UART-MSR:176
>=20
> [which means the interrupt at Xenomai level hit only once, although it
> should have twice, second time because of the received character
>  these too lines that repeat indefinitely, the interrupt not coming.
> although interrupts are enabled at PIC level]
>=20
> I use the "XT-PIC-XT" (8259A) interrupt controller. As far as I know,
> Linux sets up the controller to "edge triggering", but uses
> "handle_level_irq" for it. When received by Xenomai, the interrupt is
> masked and acked at PIC level ( "ack" means EOI at 8259A). When the
> interrupt handling in the program finishes, it unmasks the interrupt. I=

> verified  that my 8259A has a latch that can detect the UART interrupt
> even if masked, so that when unmasked again, it can be delivered.

Try to pass I_EDGE to rt_intr_create. The UART IRQs are edge-triggered,
so you have to enable the appropriate handling at kernel IRQ handler leve=
l.

Jan


--------------enig99D3F06E1E1FFCA1637F7AB7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFIH4hVniDOoMHTA+kRAh2qAJ957wy9CkEonLRJbKUmnYTGb8lQhwCfcQph
6MZ2u5jE0kO6FqL+A6ZRvfw=
=nJ1J
-----END PGP SIGNATURE-----

--------------enig99D3F06E1E1FFCA1637F7AB7--

