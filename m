Message-ID: <44EA0DB4.1080302@domain.hid>
Date: Mon, 21 Aug 2006 21:47:00 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Re: [Socketcan-users] send error: permission denied
References: <DD39B5C3F4963040ADC9768BE7E430CBFFAD9F@is-hdq-exchange.marel.net>
	<44EA096D.9080208@domain.hid>
In-Reply-To: <44EA096D.9080208@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig67B6167A7405055B0ADA0041"
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>, socketcan-users@domain.hid, Daniel Schnell <danielsch@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig67B6167A7405055B0ADA0041
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Hi Daniel,
>=20
> Daniel Schnell wrote:
>> Hi,
>>
>> =20
>>
>> I am new to socket can.
>>
>> =20
>>
>> I wanted to test the rtcan driver in combination with Linux and
>> Xenomai and made a little program according to the rtcansend program
>> but with some response time measurements.
>>
>> =20
>>
>> However after setting up the socket I get =E2=80=93EPERM when trying t=
o send a
>> packet to the can device. As the documentation doesn=E2=80=99t state a=
nything
>> about this error when calling rt_dev_send() I wonder why the error if
>> at all doesn=E2=80=99t appear earlier if I try to setup the socket. Th=
e test
>> program already ran nicely when I tested the peak can drivers for
>> linux. I just changed the driver specific calls.
>>
>> =20
>>
>> Attached you find the complete test file, the function task() is the
>> one to blame.
>>
>> =20
>>
>> I am a bit stuck with this, so maybe someone can give me a slight hint=

>> in what i am doing wrong.
>=20
> I tried your program on my system and got the same error. The problem
> is, that rt_dev_send() is called from non-RT context, which is illegal.=


=2E..but should not matter if the caller is a Xenomai thread in "Linux" m=
ode.

> At a first glance, it's not obvious to me why. Therefore I added the
> Xenomai Help ML to the CCs.

How did you all compile the program [1]? Using xeno-config
--posix-cflags / --posix-ldflags?

Jan


PS: Daniel, if you go the POSIX way, you don't have to use rt_dev_, you
can use the normal POSIX API directly. That services will be wrapped on
the Xenomai core just like pthread&friends.

[1]https://lists.berlios.de/pipermail/socketcan-users/attachments/2006082=
1/ff454f48/cantest_rt.obj


--------------enig67B6167A7405055B0ADA0041
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE6g20niDOoMHTA+kRAnRTAJ4tOQG+Ke7cDZgb+IE10s3tbWdQBwCdFAzq
NwuFnUoZLkwkDw4zF0dv6mM=
=yqo2
-----END PGP SIGNATURE-----

--------------enig67B6167A7405055B0ADA0041--

