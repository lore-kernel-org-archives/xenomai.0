Message-ID: <460D0246.5030108@domain.hid>
Date: Fri, 30 Mar 2007 14:27:50 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <460C60E9.6010307@domain.hid> <460CB1BD.60602@domain.hid>
	<460CB32D.1040807@domain.hid> <E1HXG3e-0006Jz-Rb@domain.hid>
In-Reply-To: <E1HXG3e-0006Jz-Rb@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0A06461C4E4B8C51D6750059"
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
To: Sebastian Smolorz <ssm@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0A06461C4E4B8C51D6750059
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Sebastian Smolorz wrote:
> Jan Kiszka wrote:
>> Wolfgang Grandegger wrote:
>>> Jan Kiszka wrote:
>>>> Hi Wolfgang,
>>>>
>>>> it's late, so I may have misread somecode, but don't you "update" th=
e
>>>> iovec descriptors a user passes on send/recvmsg on return (namely
>>>> iovec_len)? I received some complaints about this /wrt to in-kernel =
CAN
>>>> stack usage.
>>> It's done here:
>>>
>>> http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/drivers/can/rt=
can_
>>> raw.c?v=3DSVN-trunk#881
>>>
>>> http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/drivers/can/rt=
can_
>>> raw.c?v=3DSVN-trunk#734
>>>
>>>
>>> I may have missed something. What are the real complaints? Is there a=

>>> test program?
>> Not yet (will commit the related patch to our RACK likely later today)=
=2E
>> It's simply sending frames while re-using the msg+iovec structs in a l=
oop.
>>
>>>> I always considered the same well-know behaviour of RTnet a bug, but=
 now
>>>> I found your code is doing this systematically, also for user space
>>>> callers. Is this behaviour undefined or even required according POSI=
X or
>>>> whatever?
>>> I don't know, it's Sebastian's Kode.
>> Hmm, hope he will not say that he imitated RTnet...
>=20
> Rather an imitation of the Linux kernel's behaviour. The memcpy_toiovec=
() and=20
> memcpy_fromiovec() functions [1] also modify the original iovec.=20
>=20
>=20
> [1] http://lxr.free-electrons.com/source/net/core/iovec.c
>=20

But that's the kernel's private (and user-safe) copy. I failed to find
it writing that back to user space.


--------------enig0A06461C4E4B8C51D6750059
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGDQJGniDOoMHTA+kRAqZBAJ9THYEPKTNXPbiimIkXJdABBDWDqACfSNV4
Jhz4OV1Ww19IpLzHbdB4aek=
=ZOju
-----END PGP SIGNATURE-----

--------------enig0A06461C4E4B8C51D6750059--

