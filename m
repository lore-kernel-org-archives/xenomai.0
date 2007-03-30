Message-ID: <460CB32D.1040807@domain.hid>
Date: Fri, 30 Mar 2007 08:50:21 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <460C60E9.6010307@domain.hid> <460CB1BD.60602@domain.hid>
In-Reply-To: <460CB1BD.60602@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8A61BEF0AAF84E7A9DB0B2EA"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: iovec overwriting by CAN stack
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8A61BEF0AAF84E7A9DB0B2EA
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Jan Kiszka wrote:
>> Hi Wolfgang,
>>
>> it's late, so I may have misread somecode, but don't you "update" the
>> iovec descriptors a user passes on send/recvmsg on return (namely
>> iovec_len)? I received some complaints about this /wrt to in-kernel CA=
N
>> stack usage.
>=20
> It's done here:
>=20
> http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/drivers/can/rtca=
n_raw.c?v=3DSVN-trunk#881
>=20
> http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/drivers/can/rtca=
n_raw.c?v=3DSVN-trunk#734
>=20
>=20
> I may have missed something. What are the real complaints? Is there a
> test program?

Not yet (will commit the related patch to our RACK likely later today).
It's simply sending frames while re-using the msg+iovec structs in a loop=
=2E

>=20
>> I always considered the same well-know behaviour of RTnet a bug, but n=
ow
>> I found your code is doing this systematically, also for user space
>> callers. Is this behaviour undefined or even required according POSIX =
or
>> whatever?
>=20
> I don't know, it's Sebastian's Kode.
>=20

Hmm, hope he will not say that he imitated RTnet...

Jan


--------------enig8A61BEF0AAF84E7A9DB0B2EA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGDLMtniDOoMHTA+kRAo72AJ0ZRg9TZAu1J8koNBJNPZaAS7yTywCdHDDd
XmQ8IYfz2Q5aFt03VXnYxiQ=
=ShRb
-----END PGP SIGNATURE-----

--------------enig8A61BEF0AAF84E7A9DB0B2EA--

