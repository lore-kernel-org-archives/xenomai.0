Message-ID: <44EC8EAB.8010201@domain.hid>
Date: Wed, 23 Aug 2006 19:21:47 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <DD39B5C3F4963040ADC9768BE7E430CB01081D6B@is-hdq-exchange.marel.net>
	<44EC8B62.8020306@domain.hid>
In-Reply-To: <44EC8B62.8020306@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigBF4195FCD1A4E4E9BA1A3043"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-help] Re: [Socketcan-users] Select on a RTCAN socket
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
Cc: Haukur Hafsteinsson <haukur@domain.hid>, xenomai-help <xenomai@xenomai.org>, socketcan-users@domain.hid, Daniel Schnell <danielsch@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBF4195FCD1A4E4E9BA1A3043
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi all,

Wolfgang Grandegger wrote:
> Hi Daniel,
>=20
> Daniel Schnell wrote:
>> Hi,
>>
>> =20
>>
>> I wanted to use select() on a socket to find out how many messages are=
=20
>> available. I have opened this socket to access the RTCAN sockets under=
=20
>> Xenomai. According to /usr/xenomai/lib/posix.wrappers select is not=20
>> "supported" by the realtime kernel. Accordingly it doesn't work. If i =

>> start the according task under SCHED_FIFO, the task simply hangs when =

>> initiating select(), in SCHED_OTHER it is simply returning: bad file=20
>> descriptor.
>=20
> select is not supported and cannot be used, indeed.

And select is tricky to provide under hard-RT constraints.

>=20
>> Any ideas ? Is there any other way to find out, how many messages are =

>> waiting ?
>=20
> Select returns the sockets which have data but it does not tell you how=
=20
> many messages are waiting. You could use separate threads to read from =

> sockets.
>=20
> BTW: this mail is off-topic on the socketcan MLs.

Mmh, do you mean it the other way around?

Anyway, is there a mechanism of the standard socket API the obtain the
current incoming queue length? Don't think so actually, but it wouldn't
be the first time I'm blind.

Jan


--------------enigBF4195FCD1A4E4E9BA1A3043
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE7I6rniDOoMHTA+kRAqTZAJwPAn9ojy7xoTj7cDyyDQ0bk+xZvACeKtWj
nHzb27doxl/+p4n5R4mqRLU=
=c0zT
-----END PGP SIGNATURE-----

--------------enigBF4195FCD1A4E4E9BA1A3043--

