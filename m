Message-ID: <472465E8.3030903@domain.hid>
Date: Sun, 28 Oct 2007 11:35:20 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <47226B5E.2050303@domain.hid> <47227713.9020804@domain.hid>
	<47228277.40800@domain.hid>
In-Reply-To: <47228277.40800@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig229BB56EF38AFA3A1880D8B4"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] I-pipe/i386 for 2.6.24-rc1 - x86/x86_64 merge to
 come
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig229BB56EF38AFA3A1880D8B4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> http://download.gna.org/adeos/patches/v2.6/i386/adeos-ipipe-2.6.24-rc=
1-i386-1.10-11.patch
>>>
>>> PS: slightly tested here. Looks ok, sun is still shining, birds are
>>> still singing, hardware is not burning - yet.
>>>
>> Will let you know the result from my box soon.
>=20
> Appears to work fine here as well, including SMP. Just one oddity so
> far: /sys/module/xeno_nucleus is missing, thus a way to tune module
> parameters of the built-in nucleus. xeno_hal or xeno_native, e.g., are
> there. Strange.

Mainline bug, fix is on the way:

http://lkml.org/lkml/2007/10/28/27

Jan


--------------enig229BB56EF38AFA3A1880D8B4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHJGXoniDOoMHTA+kRAhXAAJ9d7/1TFK832TR9GVetkyxTka5C/wCfVOyX
d3eL6XPADd2S42ggL93tbs8=
=ZOBJ
-----END PGP SIGNATURE-----

--------------enig229BB56EF38AFA3A1880D8B4--

