Message-ID: <469F3A7E.1010407@domain.hid>
Date: Thu, 19 Jul 2007 12:18:38 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <2862c2c80707190105j79e9357ehbba9285c2f8a250c@domain.hid>	<2ff1a98a0707190136o48f3934ar55a5fc579f719775@domain.hid>	<2862c2c80707190223mc3986a9y2b5567d1bcb96789@domain.hid>
	<2ff1a98a0707190235x3688e9a8g5022d98f196f5387@domain.hid>
In-Reply-To: <2ff1a98a0707190235x3688e9a8g5022d98f196f5387@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDEAF63035C50677CA1B3E83C"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Cross Compile the Xenomai-2.3.2 for AT91 - ld
 terminated with signal 11
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "Xenomai-help@domain.hid" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDEAF63035C50677CA1B3E83C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> On 7/19/07, Yeoh Chun Yeow <yeohchunyeow@domain.hid> wrote:
>> On 7/19/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrot=
e:
>>> On 7/19/07, Yeoh Chun Yeow <yeohchunyeow@domain.hid> wrote:
>>>> Dear all,
>>>>
>>>> I have tried to cross compile the xenomai-2.3.2 for AT91RM9200 but r=
un
>> in to
>>>> the following problems:
>>>>
>>>> (...)
>>>> collect2: ld terminated with signal 11 [Segmentation fault]
>>>> (...)
>>> No, Xenomai compilation flags trigger a bug of the toolchain you use.=

>>> Could you try xenomai-2.3.1 to see if the bug does not come from some=

>>> recent changes ?
>>> If you have the same problem with xenomai-2.3.1, I am afraid you will=

>>> have to change your toolchain.
>>>
>> Try out the xenomai-2.3.1, the error remains the same. Any recommendat=
ion of
>> the toolchain that works?
>=20
> There are two things you can try:
> - compile a toolchain yourself with crosstools
> http://kegel.com/crosstool/ but pay attention, not all combinations
> work, especially for ARM, so have a look at the following matrix
> http://kegel.com/crosstool/crosstool-0.43/buildlogs/ and pick a
> combination that is reported to work
> - get a toolchain from codesourcery at
> http://www.codesourcery.com/gnu_toolchains/arm/download.html
>=20

It should be this binutils bug:

http://www.ecos.sourceware.org/ml/binutils/2006-12/msg00309.html

So take care to pick a toolchain with the fitting version (or apply the
patch manually).

Jan


--------------enigDEAF63035C50677CA1B3E83C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGnzqBniDOoMHTA+kRAkRYAJkBdkU0z2Zo0gB79j/KS+AT4KlALACeOJLJ
BIweI+N2kn3CCsq2GIeY68g=
=UiAH
-----END PGP SIGNATURE-----

--------------enigDEAF63035C50677CA1B3E83C--

