Message-ID: <465EC7C1.5080300@domain.hid>
Date: Thu, 31 May 2007 15:04:01 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB0F3@domain.hid>	<465BE777.7010204@domain.hid>	<7289437c0705290347y20eeff5bq3e86cd0cd4984ddb@domain.hid>	<465C6268.1090704@domain.hid>	<18012.28254.882249.144005@domain.hid>	<7289437c0705292257u57e991a1l270d478fdf7f757d@domain.hid>	<7289437c0705300051i2634264avc5f2db1fcdb91da8@domain.hid>	<465D664E.3040700@domain.hid>
	<465E8FA8.4030507@domain.hid>	<DD39B5C3F4963040ADC9768BE7E430CB01F54FE7@domain.hid>
	<7289437c0705310558y6e1b4f8fue26c640d863ae041@domain.hid>
In-Reply-To: <7289437c0705310558y6e1b4f8fue26c640d863ae041@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC33F1370BCDED19D3D85A50E"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] =?iso-8859-15?q?Xenomai_with_=B5Clibc?=
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Perrine Martignoni <perrmart@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC33F1370BCDED19D3D85A50E
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Perrine Martignoni wrote:
>> Perrine, did you happen to configure Xenomai with "configure --host=3D=
arm
>> ..."? If yes (see config.log), please use "--host=3Darm-linux". This
>> solved all issues for me.
>>
>> Awaiting your feedback!
>=20
> I configure Xenomai with --host=3Darm.
> I tried to configure like this but it doesn't work :
>=20
> ./configure --build=3Darm-linux --host=3Darm-linux CC=3Darm-linux-gcc
                      ^^^^^^^^^
I guess you are not compiling Xenomai _on_ an ARM box, are you? :)
Try --build=3Di686-linux here.

Jan


--------------enigC33F1370BCDED19D3D85A50E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGXsfBniDOoMHTA+kRAia2AKCDl3CoMvNNYsaNtrNL9+5SL9hoEACeIQCL
wN2aBhHhJZb63MWOjjJ4gsQ=
=gMqr
-----END PGP SIGNATURE-----

--------------enigC33F1370BCDED19D3D85A50E--

