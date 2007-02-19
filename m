Message-ID: <45D97B38.6060202@domain.hid>
Date: Mon, 19 Feb 2007 11:26:00 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Standard linux assignment of processes to CPUs
	depends on Xenomai Config
References: <24461688.1170430564542.JavaMail.ngmail@domain.hid>
In-Reply-To: <24461688.1170430564542.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9177D11214B11E7B27CB17FA"
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
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9177D11214B11E7B27CB17FA
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi everybody,
>=20
> I just noted another very interesting thing.
> When I have the Xenomai support built directly into the kernel (no modu=
les),
> the Linux scheduler assigns all Linux tasks to CPU 0 (I have a SMP with=
 a Dual Core CPU).
> Using e.g. taskset I can of course force tasks to run on CPU 1 but it w=
ill not be done
> automatically.
>=20
> However, when I use modules for the Xenomai stuff, the Linux scheduler =
assigns
> the tasks to both available CPUs...
>=20
> This behaviour looks very strange to me...
> My setup: Kernel 2.6.19.2, SMP, Pentium 4 D, Xenomai 2.3. + COW patches=
=2E
> Any idea on this?!?

Mathias, mind to re-check if this behaviour persists with latest SVN
(v2.3.x and/or trunk) and I-pipe 1.7-02? If yes, please file a short bug
report to

https://gna.org/bugs/?group=3Dxenomai

so that it doesn't get lost (we plan to manage non-trivial bug-tracking
increasingly via that channel).

I consider this a non-critical issue. Still, it has to be understood and
probably fixed.

Jan


--------------enig9177D11214B11E7B27CB17FA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF2Xs8niDOoMHTA+kRAnoJAJ4oCvHSNQy8BMrSeV69gv0FiNTN+QCdF21m
qR+WeJkCRa7QbyA3KOrDWbc=
=R24X
-----END PGP SIGNATURE-----

--------------enig9177D11214B11E7B27CB17FA--

