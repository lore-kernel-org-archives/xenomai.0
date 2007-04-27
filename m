Message-ID: <4631F925.2090100@domain.hid>
Date: Fri, 27 Apr 2007 15:22:45 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4850965.1177589052502.JavaMail.ngmail@domain.hid>	
	<4631E30B.6060701@domain.hid> <1177679680.5010.78.camel@domain.hid>
In-Reply-To: <1177679680.5010.78.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD1597B92C7E6BF4576C98DBF"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Xenomai and MSI enabled crashes kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD1597B92C7E6BF4576C98DBF
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Fri, 2007-04-27 at 13:48 +0200, Jan Kiszka wrote:
>=20
>>> I have attached my kernel config to this mail.
>>> Any idea on this? Is there anybody out there that has MSI running suc=
cesfully with the Xenomai adeos patch?
>> Hmm, from a glance at the 2.6.20 ipipe patch I would say that MSI is
>> currently unsupported. No related patch hunk makes it look suspicious =
to
>> me -- or is this supposed to work automagically, Philippe?
>=20
> Since genirq, MSI interrupts have their irq_chip descriptor managed by
> the IO-APIC support. What remains to be tested is the masking/unmasking=

> code, which is still implemented by the msi driver; unfortunately I hav=
e
> no PCI-Express hw at hand anymore, so I can't test CONFIG_PCI_MSI
> properly.
>=20
> At first sight, the issue Mathias raised looks like an out-of-bound
> array reference indexed on an unexpectedly large IRQ value; this would
> be quite a dumb bug, but the only way to check that is with proper hw.
>=20

=2E.. or instrumentation patches for Mathias' target, in case he has the
time to do some short-cycle tests.

Jan


--------------enigD1597B92C7E6BF4576C98DBF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGMfklniDOoMHTA+kRAjNXAJ43Zf/eLj1x1GZERYOIJB10L+tqWQCcDF83
f4m0Wj1YqQDXU71jMAvOFMQ=
=8QXZ
-----END PGP SIGNATURE-----

--------------enigD1597B92C7E6BF4576C98DBF--

