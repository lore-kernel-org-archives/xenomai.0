Message-ID: <44DCB333.3090401@domain.hid>
Date: Fri, 11 Aug 2006 18:41:23 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <44DBCCD3.5070505@domain.hid> <44DC2B80.1020403@domain.hid>
	<44DCAE6B.4010608@domain.hid>
In-Reply-To: <44DCAE6B.4010608@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig78848213F30C430A9D9F1434"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: [patches] 1-bundle-email-spelling-help
	2-rfc-add-newer-bench-tests
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jim Cromie <jim.cromie@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig78848213F30C430A9D9F1434
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jim Cromie wrote:
> Jan Kiszka wrote:
>> Jim Cromie wrote:
>> =20
>>> im trying to inline this patch,
>>> pls let me know if its still ws fouled
>>> (in thunderbird, cp from svn diff |less, preformat b4 paste)
>>>
>>>
>>>
>>>
>>> Index: CREDITS
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> --- CREDITS     (revision 1412)
>>> +++ CREDITS     (working copy)
>>> @@ -43,7 +43,7 @@
>>> D: the map.
>>>
>>> N: Jim Cromie
>>> -E: jcromie@domain.hid
>>> +E: jim.cromie@domain.hid
>>> D: Comprehensive statistics collection for the testsuite.
>>> D: Validation test script. Various script fixes and sanitization.
>>>    =20
>>
>> Obviously damaged, at least here on the list (leading single whitespac=
e
>> missing in unmodified lines). This also applies to your second patch.
>>
>> The required steps with Thunderbird are: 1. start a new mail or reply =
as
>> HTML (bah!), 2. set the text style of everything to preformat, 3. swit=
ch
>> back to "Plain Text Only" under Options/Format. Hope somebody will onc=
e
>> hack a plugin for disabling line wrapping on demand without this dance=
=2E..
>>
>>  =20
> <marge-simpson-voice>  HRMM
> maybe copy-src is the factor - Ive had luck my way (which yours sounds
> like)
> when cpying the diff from an emacs window.
>=20
> No Matter  ( machts nichts, or after americanization,  MoxNix  )
> attachments are easier anyway, and RPM seems not to care either way.
>=20
> So, 2 patches:
>=20
> 1- bundle: email, Kconfig spelling, switchbench print in us, not ns.
> issues :
> - switchbench segfaults(iirc) for me - both before and after patch,
> so its not tested - and printf format purposely not tweaked, so as
> to give someone else the itch ;-)
>=20

Would you mind to attach a debugger and trace this a bit down? I do not
see this here. Or are there any special switches to apply?

>=20
> 2 -  add newer benchmark tests to xeno-test  RFC
> - irqbench (all 4 ways)

See my other mail. This requires a second box and some explanation for
the poor newbie who's just looking for a self-contained test run.

> - switchbench - segfaults
> - switchtest
> by the way, could we get renames ?    switch{,bench,test}/switch.c
>    is just unnecessarily confusing !
>=20
> issues :
> - are tests ready to add ?  perhaps, if optional ?
> - config dependence ignored
>    we have no guarantee of .config availability (or do we?)
> - XENOT_*  for tool(*) specific option setting from env
>        warrants better prefix, but XENOTEST_TOPTS_* seemed too much
>=20
> thanks
> -jimc
>=20

Jan


--------------enig78848213F30C430A9D9F1434
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE3LMzniDOoMHTA+kRAmUMAJ4sDNH6fVJApPVPvFXZi91YNTV45gCeIEHz
ogc9nIfi3+rFPMv42tX1svw=
=8Bsm
-----END PGP SIGNATURE-----

--------------enig78848213F30C430A9D9F1434--

