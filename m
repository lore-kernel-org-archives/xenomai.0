Message-ID: <453FC819.9020900@domain.hid>
Date: Wed, 25 Oct 2006 22:24:57 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] invalid use of FPU in Xenomai context
References: <450B2BE1.1050105@domain.hid>	
	<20060916042719.M57867@domain.hid>	<450F0451.8070102@domain.hid>
	<1158614598.5009.71.camel@domain.hid> <453FC279.8040608@domain.hid>
In-Reply-To: <453FC279.8040608@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0EBF4555EDC1A063A626FFDE"
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
To: Jeff Webb <jeff.webb@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0EBF4555EDC1A063A626FFDE
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jeff Webb wrote:
> If I run the attached program, I get the following result:
>=20
>  [root]# ./mqtest2
>  CPU time limit exceeded
>=20
> The kernel log contains:
>=20
>  Oct 25 14:13:03 kernel: invalid use of FPU in Xenomai context at 0x804=
92f6

Can you do a backtrace in gdb?

>=20
> If I change the WRITE_SIZE #define at the top of the program to 511
> instead of 512, I do not get an error message, and the program works as=

> expected.
>=20
> I have tried this under two versions of Xenomai with the same result:
>  1) Xenomai 2.2.3 with the FPU patch posted here:
>     https://mail.gna.org/public/xenomai-help/2006-09/msg00157.html
>     (adeos-ipipe-2.6.17-i386-1.4-00.patch)
>  2) Xenomai 2.2.4 (adeos-ipipe-2.6.17-i386-1.5-00.patch)
>=20
> Other details:
>  Linux version 2.6.17.13
>  AMD Athlon(tm)64 X2 Dual Core Processor  4400+
>  Fedora Core 5
>  SMP kernel
>=20
> This is very similar to a problem I described last month that affected
> my linux-2.4 system:
> https://mail.gna.org/public/xenomai-help/2006-09/msg00143.html .=20
> Perhaps these problems are related.
>=20
> Does anyone see a problem with what I'm doing here?  If not, can you
> reproduce the problem?
>=20

Could you also try if this patch changes anything:

https://mail.gna.org/public/xenomai-core/2006-10/msg00069.html

(Could be the case if you happen to use some FPU-touching Linux driver.)

Jan


--------------enig0EBF4555EDC1A063A626FFDE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFP8gZniDOoMHTA+kRAqkFAJ9TiTep/GGCfoEmgaoJa0LV6gKhjgCcDafk
Cej68AHqs98gMYmTmIklijo=
=9IwI
-----END PGP SIGNATURE-----

--------------enig0EBF4555EDC1A063A626FFDE--

