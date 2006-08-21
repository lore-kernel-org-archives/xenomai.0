Message-ID: <44E98E12.3030406@domain.hid>
Date: Mon, 21 Aug 2006 12:42:26 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] rtdm_irq_request
References: <E443EE6E95070D46896C24F5C44EA7F53A1624@domain.hid>
In-Reply-To: <E443EE6E95070D46896C24F5C44EA7F53A1624@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD98EC29D5737A3AB5CD9E3B5"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Harkema, G.A." <G.A.Harkema@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD98EC29D5737A3AB5CD9E3B5
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Harkema, G.A. wrote:
> Hello,
>=20
> =20
>=20
> I' am having some problems with using the rtdm_irq_request() function. =
I
> disabled my local APIC support in the kernel (2.6.17, xenomai 2.2.0). M=
y
> device (USB-HOST controller) shares his IRQ with the Ethernet
> card(e1000). After calling rtdm_irq_request() my system hangs. I tried
> to unload the e1000 module first and it seems to work fine. Can I share=

> non-realtime interrupts whit real-time interrupts. If yes, what went
> wrong.

Nope you can't share. The e1000 driver could otherwise cause priority
inversions when an Ethernet-related IRQ is pending, the IRQ line will
get disabled therefore, and thus succeeding RT-USB-originated IRQs will
be shadowed until Linux gets a chance to run again.

That the system hangs is due to the ungraceful way we currently handle
such exceptions. [@Dmitry: This is one example of the frequent problems
I was referring to...]

Jan


--------------enigD98EC29D5737A3AB5CD9E3B5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE6Y4SniDOoMHTA+kRAol3AJ4uD7Cftae967yqLtMqGN9PCyIrBwCdFqoR
wGAJ2GOUPcWcSE++PQytO+A=
=Ps7X
-----END PGP SIGNATURE-----

--------------enigD98EC29D5737A3AB5CD9E3B5--

