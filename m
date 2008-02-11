Message-ID: <47B0B5B0.5050402@domain.hid>
Date: Mon, 11 Feb 2008 21:53:04 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <51CAD0CE1504444DBE77CBBE51A0135D376AFD@slcmail.slc.mew.int>
	<47B0ADE8.5060504@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D376B02@domain.hid>
	<47B0B1E0.7030701@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D376B08@domain.hid>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D376B08@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0B5DA972BAE29D4862B0241F"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] irq0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <sseeger@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0B5DA972BAE29D4862B0241F
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Steven Seeger wrote:
> All right. I'll re-use Philippe's patch that disables TSC on geode and
> compile the libs for use without TSC. However, this will not help my
> overhead problems, correct? Won't it make them worse?

That depends. If your timer IRQ goes off way more often than it should,=20
you burn much more power than you gain via the TSC short-cut. Plus, a=20
broken TSC can have much more evil side effects on your timing.

>=20
> If xenomai is using tsc, then that's a good thing. The timing is all
> correct it seems, and the jitter is low.

If the TSC is correct, yes. But we cannot tell if it's correct. Only you =

can try to systematically analyse all the effects you observed, apply=20
the tests we suggested, collect more data about what is going on. We can =

only help with a better picture of your system.

Jan


--------------enig0B5DA972BAE29D4862B0241F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHsLWwniDOoMHTA+kRAvO+AJ9YaKoD/NqAx2ssrPMz3DFfKo6MtgCcDAp7
RmGqqHvHYjyv7pVxoui9wyM=
=6ZsY
-----END PGP SIGNATURE-----

--------------enig0B5DA972BAE29D4862B0241F--

