Message-ID: <45E1B345.4050304@domain.hid>
Date: Sun, 25 Feb 2007 17:03:17 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] x86_64 - Initial results.
References: <200702241526.22786.paul_c@domain.hid>
	<200702250106.32393.paul_c@domain.hid> <45E15EAA.1040300@domain.hid>
	<200702251557.19205.paul_c@domain.hid>
In-Reply-To: <200702251557.19205.paul_c@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig054485F57A2272D42B5F067B"
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
To: Paul <paul_c@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig054485F57A2272D42B5F067B
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Paul wrote:
> On Sunday 25 February 2007 10:02, Jan Kiszka wrote:
>>>> Rather the CONFIG_IPIPE_TRACE feature, with the IRQs off tracking op=
tion
>>>> set
>=20
>> Please grab trace/frozen instead, enable verbose mode, and increase
>> back_trace_points so that the reported latency is fully covered. See
>=20
> OK - Recompiled with the 1.04 patch for UP with the ipipe trace support=
=2E After=20
> cutting Xorg's configs to a minimum (vesa driver, no Glx/dri support), =

> latency runs OK and reports some pretty horrible numbers when X starts =
(no=20
> WM). Enabling the tracer, and starting/stopping X, the system either lo=
cks up=20
> or latency goes in to a zombie state.
>=20
>  The attached trace logs provide little information - Also included dme=
sg and=20
> kernel config.

One more try please: we also need CONFIG_IPIPE_TRACE_MCOUNT.

Jan


--------------enig054485F57A2272D42B5F067B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF4bNFniDOoMHTA+kRArirAJ0T8FEHrqTWzjKq9AwEdGAsWO05IACfSA1c
t083QOkTgYg6M5XHcsJXxhQ=
=7kgE
-----END PGP SIGNATURE-----

--------------enig054485F57A2272D42B5F067B--

