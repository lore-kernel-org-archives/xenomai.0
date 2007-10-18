Message-ID: <4717D535.3010709@domain.hid>
Date: Thu, 18 Oct 2007 23:50:45 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <200710182116.25461.paul_c@domain.hid>
In-Reply-To: <200710182116.25461.paul_c@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig84CEDAFE67D49F0C739A5565"
Sender: jan.kiszka@domain.hid
Subject: Re: [Adeos-main] 2.6.23 x86_64 broken for SMP ?
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Paul <paul_c@domain.hid>
Cc: adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig84CEDAFE67D49F0C739A5565
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Paul wrote:
> Attempting to compile on x86_64 with SMP enabled, getting quite a few f=
ailures=20
> cetered around ipipe_declare_cpuid being undeclared in=20
> arch/x86_64/kernel/ipipe.c. Should we be including ipipe_compat.h or=20
> following the lead set in arch/i386/kernel/ipipe.c ?

Nope, we should rather remove the obsolete code from the ipipe core. You
could simply kill ipipe_declare_cpuid and replace the cpuid spots with
ipipe_processor_id() (compare to latest i386 ipipe). Cleanup patches
always welcome!

Jan


--------------enig84CEDAFE67D49F0C739A5565
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHF9U4niDOoMHTA+kRAloqAJ4kFL08QaTCUe8E3+OkVkaCn9d95ACfbCn2
wCNX7gCKugZIq4q5XMQuruA=
=ubYk
-----END PGP SIGNATURE-----

--------------enig84CEDAFE67D49F0C739A5565--

