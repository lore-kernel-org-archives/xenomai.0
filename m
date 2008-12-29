Message-ID: <495908DA.7030304@domain.hid>
Date: Mon, 29 Dec 2008 18:28:58 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4958E439.9040503@domain.hid> <4958F2EE.8080804@domain.hid>
In-Reply-To: <4958F2EE.8080804@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig85DCF4DD00420B1FD81EDC5B"
Sender: jan.kiszka@domain.hid
Subject: Re: [Adeos-main] [PATCH] Fix include for kernel/panic.c
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig85DCF4DD00420B1FD81EDC5B
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> +++ b/kernel/panic.c
>> @@ -21,6 +21,7 @@
>>  #include <linux/debug_locks.h>
>>  #include <linux/random.h>
>>  #include <linux/kallsyms.h>
>> +#include <linux/ipipe_trace.h>
>=20
> That is not enough, when compiling a kernel without I-pipe enabled, the=

> compiler complains about ipipe_processor_id.

Good point. But I wonder where the ipipe_processor_id wrapper for the
disabled case is - can't find it in adeos-ipipe-2.6.26-arm-1.11-02.patch
right now.

Jan


--------------enig85DCF4DD00420B1FD81EDC5B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAklZCOAACgkQniDOoMHTA+no4QCeJyeIILjrg5lC/RCWLFKMRvMD
cyQAnRwbX5DX2H8CouX69GnzhfszXYZH
=37ZW
-----END PGP SIGNATURE-----

--------------enig85DCF4DD00420B1FD81EDC5B--

