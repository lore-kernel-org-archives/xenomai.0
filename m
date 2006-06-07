Message-ID: <44871DF8.9010903@domain.hid>
Date: Wed, 07 Jun 2006 20:42:00 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [rfc] unit testing context switches.
References: <17536.40316.183366.284818@domain.hid>
	<17543.5163.684144.582942@domain.hid>
In-Reply-To: <17543.5163.684144.582942@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig367B7A46FA41342F32FF0AC4"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig367B7A46FA41342F32FF0AC4
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> --- /dev/null	2006-05-03 22:25:59.000000000 +0200
> +++ include/rtdm/rttesting.h	2006-06-07 18:50:14.000000000 +0200
> @@ -0,0 +1,188 @@
=2E..
> + *
> + * @{
> + */
> +
> +#ifndef _RTBENCHMARK_H
> +#define _RTBENCHMARK_H

Hmm, there might be further renamings required. Could you double-check
(e.g. grep -ri benchmark)?

Jan


--------------enig367B7A46FA41342F32FF0AC4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEhx34niDOoMHTA+kRAs2MAJ9ZmpMg+ku21FQVyuA70qOsZX6JYACfTMVN
ULGQof8QflhaAiZBQjAt+t4=
=gkY0
-----END PGP SIGNATURE-----

--------------enig367B7A46FA41342F32FF0AC4--

