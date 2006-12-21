Message-ID: <458A4E75.1020108@domain.hid>
Date: Thu, 21 Dec 2006 10:05:57 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: AW: [Xenomai-help] prepare kernel fails
References: <5D63919D95F87E4D9D34FF7748CE2C2A6F92C7@domain.hid>
	<45897750.6000905@domain.hid>
	<200612202109.34082.niklaus.giger@domain.hid>
	<200612202119.06051.niklaus.giger@domain.hid>
	<458A4B63.2020101@domain.hid>
In-Reply-To: <458A4B63.2020101@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB6C395629FAD250AE36B8941"
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
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB6C395629FAD250AE36B8941
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Niklaus Giger wrote:
>> Am Mittwoch, 20. Dezember 2006 21:09 schrieb Niklaus Giger:
>>
>>> Am Mittwoch, 20. Dezember 2006 18:48 schrieb Gilles Chanteperdrix:
>>>
>>>> Jan Kiszka wrote:
>>>>
>>>>> (Gilles?) has to run bootstrap
>>>> Done.
>>> Thanks.
>>>
>>> If would simplify setting up the buildbot if I could run "make distch=
eck"
>>> without a need to use sudo.
>>>
>>> Calling "make SUDO=3D distcheck" resulted in errors like:
>>> make[3]: Nothing to be done for `install-data-am'.
>>> mknod: `/tmp/am-dc-17903//dev/rtp0': Operation not permitted
>>>
>>> If you need too much time, I will just modify my sudoers to add anoth=
er
>>> script (to the scripts able to use sudo without passwords). But I wou=
ld
>>> prefert to be able to go the other way.
>> I just found out that "make SUDO=3Dfalse distcheck" builds the tarball=
 without=20
>> failures. Is this the way to go for the buildbot script?
>=20
> If you find it an acceptable solution, go that way.
>=20

Yeah, I this should be enough to test for distribution regressions.

Jan


--------------enigB6C395629FAD250AE36B8941
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFik51niDOoMHTA+kRArO/AJ9Kc7SnPXZQGkpaL2u1LD0IVs+oswCfQ5hE
TnYvaygSzBTA/UQQI38cVpo=
=S4P0
-----END PGP SIGNATURE-----

--------------enigB6C395629FAD250AE36B8941--

