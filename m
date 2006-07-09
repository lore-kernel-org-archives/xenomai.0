Message-ID: <44B13AC9.3050307@domain.hid>
Date: Sun, 09 Jul 2006 19:20:09 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] PB to patch a 2.6.16 kernel with
	an	adeos-ipipe-2.6.14-ppc
References: <5B122FD931231D408AC32630D1B1F7290C8BBB60@domain.hid>
In-Reply-To: <5B122FD931231D408AC32630D1B1F7290C8BBB60@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig722A21D6755443D7840D10D0"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Thomas, Brieuc (GE Healthcare)" <Brieuc.Thomas@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig722A21D6755443D7840D10D0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thomas, Brieuc (GE Healthcare) wrote:
> Hi everybody !=20
>=20
> I've got a PPC-MPC8540 target with a 2.6.16 patch from the provider. I
> would like to patch my 2.6.16 kernel with an adeos-ipipe-2.6.14-ppc. Ha=
s
> somebody already done this? =20
> Up to now, I've done the patch manually and the compilation with
> xenomai-2.1.2...

Migrating some version steps upward in 2.6.x can be problematic. Also
the patches you got from the board vendor may collide with ipipe. What
conflicts did you have to resolve? Were you able to verify if those were
not related to relevant functional changes in the kernel?

> When I launch my target, the boot run without errors. But when I launch=

> an Xenomai application (like latency) I've got a "kernel oops" message
> (during the task creation).

What does the oops precisely say, what's the backtrace about?

> can somebody help me to patch correctly my kernel?

Is your kernel patch publicly available? What parts does it touch
(critical for ipipe are IRQ and timer management).

Maybe someone from the PPC fraction on this list can comment on the
status of vanilla 2.6.16 vs. 2.6.14, also wrt ipipe/xenomai.

Jan


--------------enig722A21D6755443D7840D10D0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEsTrJniDOoMHTA+kRAmFtAJ9ctFVt9mOjK4XGaPZMEqFvNKdiUwCdH1ln
MCL4dqboo5IjHGFN4wffnMs=
=kD14
-----END PGP SIGNATURE-----

--------------enig722A21D6755443D7840D10D0--

