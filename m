Message-ID: <465FDD44.1050404@domain.hid>
Date: Fri, 01 Jun 2007 10:48:04 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB0F3@domain.hid>	<465BE777.7010204@domain.hid>	<7289437c0705290347y20eeff5bq3e86cd0cd4984ddb@domain.hid>	<465C6268.1090704@domain.hid>	<18012.28254.882249.144005@domain.hid>	<7289437c0705292257u57e991a1l270d478fdf7f757d@domain.hid>	<7289437c0705300051i2634264avc5f2db1fcdb91da8@domain.hid>	<465D664E.3040700@domain.hid>	<465E8FA8.4030507@domain.hid>	<DD39B5C3F4963040ADC9768BE7E430CB01F54FE7@domain.hid>	<7289437c0705310558y6e1b4f8fue26c640d863ae041@domain.hid>	<465EC7C1.5080300@domain.hid>
	<465ECDEC.1030109@domain.hid> <465ECFCA.1070801@domain.hid>
	<465FD824.6010902@domain.hid>
In-Reply-To: <465FD824.6010902@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC147AF3B3F6E9F7F78EDDEC8"
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC147AF3B3F6E9F7F78EDDEC8
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Jan Kiszka wrote:
>> Wolfgang Grandegger wrote:
>>> Jan Kiszka wrote:
>>>> Perrine Martignoni wrote:
>>>>>> Perrine, did you happen to configure Xenomai with "configure
>>>>>> --host=3Darm
>>>>>> ..."? If yes (see config.log), please use "--host=3Darm-linux". Th=
is
>>>>>> solved all issues for me.
>>>>>>
>>>>>> Awaiting your feedback!
>>>>> I configure Xenomai with --host=3Darm.
>>>>> I tried to configure like this but it doesn't work :
>>>>>
>>>>> ./configure --build=3Darm-linux --host=3Darm-linux CC=3Darm-linux-g=
cc
>>>>                       ^^^^^^^^^
>>>> I guess you are not compiling Xenomai _on_ an ARM box, are you? :)
>>>> Try --build=3Di686-linux here.
>>> Or just omit it. Also CC=3D, CXX=3D, LD=3D ist not necessary. For Pow=
erPC
>>> with the ELDK, I just use
>>>
>>>   ./configure --host=3Dppc-linux
>>>
>>> to configure Xenomai.
>>
>> Can we define a common ground for this in README.INSTALL, for all arch=
s?
>> The simpler, the better.
>>
>> I was heavily misled by the PPC section, because I do not cross-compil=
e
>> everyday, thus had to look up the procedure again and managed to pick
>> the bad example...
>=20
> I had a closer look and realized, that passing just CC, CXX and LD to
> the configure script is not enough. There should at least also AR and
> RANLIB, otherwise the corresponding host tools are used. Then I think,
> it should be equivalent to automatic tool assignment via --host.
>=20
> Also note, that "--host=3Darm" will also work with the ELDK, because th=
ere
> are links arm-* to the tools arm-linux-*. I Perrine's configure example=
s
> above, arm-ar and arm-ranlib will then be used.

But the issue is that in this case configure is unable to find the
target OS and fails to detect that shared libs are supported for the
target. Non-shared build fails with ELDK for unknown reasons.

Jan


--------------enigC147AF3B3F6E9F7F78EDDEC8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGX91IniDOoMHTA+kRAgmJAJ9gXE35vYy75eJhtvGT/9ZF4/5RgwCfW93z
kBm2I29WXxc1qM1kiFeiNwM=
=04I2
-----END PGP SIGNATURE-----

--------------enigC147AF3B3F6E9F7F78EDDEC8--

