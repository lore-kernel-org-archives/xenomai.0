Message-ID: <44F58E8A.3040000@domain.hid>
Date: Wed, 30 Aug 2006 15:11:38 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] [Fwd: Performance decrease]
References: <1156941389.4323.17.camel@domain.hid> <1156942089.4323.29.camel@domain.hid>
In-Reply-To: <1156942089.4323.29.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB4447DCBE4BF29AEC2CE41D3"
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
To: rpm@xenomai.org
Cc: xenomai@xenomai.org, Daniel Schnell <danielsch@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB4447DCBE4BF29AEC2CE41D3
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
>>  On the other side I cannot compile RTDM support in without it; the er=
ror message when linking vmlinux
>> at the end of the Kernel compile stage is:
>>> =20
>>>
>>> drvlib.c:(.text+0x19f8): undefined reference to `__va_to_kva'
>>>
>=20
> I guess that rtdm_mmap_buffer() should be made dependent on
> CONFIG_XENO_OPT_PERVASIVE too.

True. Will craft some patch.

>=20
>>> =20
>>>
>>>
>>>
>>> For what is the real-time support in user space option good for ?
>>>
>=20
> This allows running Xenomai applications in user-space, instead of
> implementing them as kernel modules.
>=20

Everyone planning to write kernel-space drivers and/or applications
should keep an eye on some non-technical aspect as well: the license.
That's no problem for in-house, unpublished work. But for things that
are to be given away / sold, one should recall that the kernel community
is more and more considering non-GPL modules in general as a license
infringement.

Jan


--------------enigB4447DCBE4BF29AEC2CE41D3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE9Y6KniDOoMHTA+kRAjzyAJ9hQk7xGU6Mxj5I1nzjdalSEk58SQCdG+Dh
wALWnn9eYuD2q5O+lbz42RQ=
=hY9w
-----END PGP SIGNATURE-----

--------------enigB4447DCBE4BF29AEC2CE41D3--

