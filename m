Message-ID: <46D2A840.8040301@domain.hid>
Date: Mon, 27 Aug 2007 12:32:32 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <10837d740708262338w2def2f9er8fd2ca589e681992@domain.hid>
In-Reply-To: <10837d740708262338w2def2f9er8fd2ca589e681992@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig20D548E61B7EBB86944EE28C"
Sender: jan.kiszka@domain.hid
Subject: Re: [Adeos-main] RT ISR re-entrance
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: =?ISO-8859-1?Q?=3F=3F?= <2hang.j1ng.home@domain.hid>
Cc: adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig20D548E61B7EBB86944EE28C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

?? wrote:
> hi all,
>=20
> In SMP system, an edge triggerred interrupt may be dispatched to multip=
le
> cpus, so the RT ISR of this interrupt may be involved on multiple cpus =
at
> the same time. The question comes: is RT ISR need to be reentrant as
> designed or do I miss something?

Good question. I would say: yes, it's the I-pipe user's job to take care
of re-entrance safety.

Vanilla Linux prevents this via the IRQ_INPROGRESS flag. Xenomai 2.4 and
since 2.3.2 achieves re-entrance protection for the registered driver
handler by holding the IRQ-related spinlock while calling into that
handler. Still, this isn't something the user should build his system
upon. It is rather recommended for determinism and efficiency reasons to
assign RT IRQs to a specific CPU.

HTH,
Jan


--------------enig20D548E61B7EBB86944EE28C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFG0qhFniDOoMHTA+kRAsNNAJ9tB/fVjS4GBz3F/DlbkMHxlbImyQCfbb2m
xhY/8+LEfnAZa5GlsEwYKvg=
=OsaE
-----END PGP SIGNATURE-----

--------------enig20D548E61B7EBB86944EE28C--

