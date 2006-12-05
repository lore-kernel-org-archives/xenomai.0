Message-ID: <45753DAB.20207@domain.hid>
Date: Tue, 05 Dec 2006 10:36:43 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] [PATCH] I-pipe tracer for ARM
References: <E1GrHXk-00023w-Oq@domain.hid> <45745F6F.2050101@domain.hid>
	<E1GrWZ5-000089-Ou@domain.hid>
In-Reply-To: <E1GrWZ5-000089-Ou@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig56EBB03DB2F28A2CB7AF2BFA"
Sender: jan.kiszka@domain.hid
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Sebastian Smolorz <ssm@domain.hid>
Cc: adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig56EBB03DB2F28A2CB7AF2BFA
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Sebastian Smolorz wrote:
>>> <    +freeze  0xffffffff     0   97.444N __ipipe_frozen_ctrl+0x108
>>> (vfs_write+0xc4)
>> Hmm, takes quite a long time to complete the freeze though you only ha=
ve
>> 10 post-trace points (which defines its complexity). Unusual, also whe=
n
>> comparing with other traced functions.
>=20
> It seems that it doesn't depend on post-trace-points. When I reduce the=
m to 2=20
> the value for the freeze does not get smaller. Maybe it has something t=
o do=20
> with the following lines?

Are you tracing into vmalloc'ed memory? And what results do you get with
latency -f?

Jan


--------------enig56EBB03DB2F28A2CB7AF2BFA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFdT2rniDOoMHTA+kRAmLcAJ9PmOA8jn1Id7drnUYwEThwPXD/tACeNlVX
eCL4aAolYp+E9qMRBIewfpI=
=J+ff
-----END PGP SIGNATURE-----

--------------enig56EBB03DB2F28A2CB7AF2BFA--

