Message-ID: <466030FF.3070503@domain.hid>
Date: Fri, 01 Jun 2007 16:45:19 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB0F3@domain.hid>	<465BE777.7010204@domain.hid>	<7289437c0705290347y20eeff5bq3e86cd0cd4984ddb@domain.hid>	<465C6268.1090704@domain.hid>	<18012.28254.882249.144005@domain.hid>	<7289437c0705292257u57e991a1l270d478fdf7f757d@domain.hid>	<7289437c0705300051i2634264avc5f2db1fcdb91da8@domain.hid>	<465D664E.3040700@domain.hid>	<465E8FA8.4030507@domain.hid>	<DD39B5C3F4963040ADC9768BE7E430CB01F54FE7@domain.hid>	<7289437c0705310558y6e1b4f8fue26c640d863ae041@domain.hid>	<465EC7C1.5080300@domain.hid>
	<465ECDEC.1030109@domain.hid> <465ECFCA.1070801@domain.hid>
	<465FD824.6010902@domain.hid> <465FDD44.1050404@domain.hid>
	<465FE255.90801@domain.hid> <465FE2A6.6040609@domain.hid>
	<46603129.5050502@domain.hid>
In-Reply-To: <46603129.5050502@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7F86CC9E2BA543F81D117D10"
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
--------------enig7F86CC9E2BA543F81D117D10
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Jan Kiszka wrote:
>> Wolfgang Grandegger wrote:
>>> Jan Kiszka wrote:
>>>> Wolfgang Grandegger wrote:
>>>>> Jan Kiszka wrote:
>>>>>> Wolfgang Grandegger wrote:
>>>>>>> Jan Kiszka wrote:
>>>>>>>> Perrine Martignoni wrote:
>>>>>>>>>> Perrine, did you happen to configure Xenomai with "configure
>>>>>>>>>> --host=3Darm
>>>>>>>>>> ..."? If yes (see config.log), please use "--host=3Darm-linux"=
=2E
>>>>>>>>>> This
>>>>>>>>>> solved all issues for me.
>>>>>>>>>>
>>>>>>>>>> Awaiting your feedback!
>>>>>>>>> I configure Xenomai with --host=3Darm.
>>>>>>>>> I tried to configure like this but it doesn't work :
>>>>>>>>>
>>>>>>>>> ./configure --build=3Darm-linux --host=3Darm-linux CC=3Darm-lin=
ux-gcc
>>>>>>>>                       ^^^^^^^^^
>>>>>>>> I guess you are not compiling Xenomai _on_ an ARM box, are you? =
:)
>>>>>>>> Try --build=3Di686-linux here.
>>>>>>> Or just omit it. Also CC=3D, CXX=3D, LD=3D ist not necessary. For=
 PowerPC
>>>>>>> with the ELDK, I just use
>>>>>>>
>>>>>>>   ./configure --host=3Dppc-linux
>>>>>>>
>>>>>>> to configure Xenomai.
>>>>>> Can we define a common ground for this in README.INSTALL, for all
>>>>>> archs?
>>>>>> The simpler, the better.
>>>>>>
>>>>>> I was heavily misled by the PPC section, because I do not
>>>>>> cross-compile
>>>>>> everyday, thus had to look up the procedure again and managed to p=
ick
>>>>>> the bad example...
>>>>> I had a closer look and realized, that passing just CC, CXX and LD =
to
>>>>> the configure script is not enough. There should at least also AR a=
nd
>>>>> RANLIB, otherwise the corresponding host tools are used. Then I thi=
nk,
>>>>> it should be equivalent to automatic tool assignment via --host.
>>>>>
>>>>> Also note, that "--host=3Darm" will also work with the ELDK, becaus=
e
>>>>> there
>>>>> are links arm-* to the tools arm-linux-*. I Perrine's configure
>>>>> examples
>>>>> above, arm-ar and arm-ranlib will then be used.
>>>> But the issue is that in this case configure is unable to find the
>>>> target OS and fails to detect that shared libs are supported for the=

>>>> target. Non-shared build fails with ELDK for unknown reasons.
>>> Why it is unable to find the target OS. Can you provide an example? A=
nd
>>
>> Look at the configure script. :o) [This is how I found the reason for
>> the non-shared build.]
>=20
> I'm still unable to reproduce that case, sorry. Could you be please sho=
w
> me the failing configure command. So far, I always got
>=20
>   checking for target architecture... ARM arm-unknown-none
>   arm
>=20
> Have I missed something?

No look below if your configure run is able to detect shared-libs
support. It shouldn't (how is OS "unknown" supposed to handle dynamic
linking?). Thus we fall back to static linking.

>=20
>>> non-shared builds only fail with the ARM uClibc toolchain from the EL=
DK.
>>> It builds fine with the normal ARM tool-chain.
>>
>> OK, good to know that the issue is confined.
>=20
> Comparing the output of configure, I see, that probing the following
> functions fails with arm-uclibc:
>=20
>   ac_cv_func_shm_open=3Dno
>   ac_cv_func_shm_unlink=3Dno
>   ac_cv_sched_setaffinity=3Dno

Are those services supported by uClibc? I think they aren't, and Xenomai
should already be able to deal with this.

>=20
> Still investigating...
>=20
> Wolfgang.
>=20

Jan


--------------enig7F86CC9E2BA543F81D117D10
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGYDD/niDOoMHTA+kRAlmGAJ9JR1q0nL7yMOgjv2VK7AjIh08RzgCbBASq
R926nqTs2d5k1MV0htkE5wo=
=MJSS
-----END PGP SIGNATURE-----

--------------enig7F86CC9E2BA543F81D117D10--

