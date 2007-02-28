Message-ID: <45E582D5.8010800@domain.hid>
Date: Wed, 28 Feb 2007 14:25:41 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] CAN question
References: <bc4264770702270848t6a65ec84nb72f9df20a52ba8f@domain.hid>	
	<45E46D5C.8040001@domain.hid>
	<bc4264770702271434x6efb5955sd75768a39f14c187@domain.hid>
	<45E53578.5080204@domain.hid> <45E57FC7.8050404@domain.hid>
In-Reply-To: <45E57FC7.8050404@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0B1CDA81DA1018B5B462C8F6"
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
To: rolandtollenaar@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0B1CDA81DA1018B5B462C8F6
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Roland Tollenaar wrote:
> Hi Jan,
>=20
>>
>> Err? What are practical cases for you?
>>
>> Both modes are _debugging_ features.
>=20
> Huh? There only seem to be two flavours. Listen_only or loopback. Are
> you saying that for normal operation it does not matter at all what the=

> setting is? I.e. don't even have to bother setting the parameter?
>=20

Check the documentation of SIOCSCANCTRLMODE. It should clearly state
that those are modes can be activated additionally and independently.
Also check what happens in the existing rtcanconfig code, it underlines
this.

If you find an even better way to express this in the doc: patches are
welcome.

Jan


--------------enig0B1CDA81DA1018B5B462C8F6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF5YLVniDOoMHTA+kRAnrxAJwMmFRdwyIPRfgLgl29Wbt13yg1rQCePzwj
InO6P5WfHE0pRU9K2Ev/EMA=
=h1sX
-----END PGP SIGNATURE-----

--------------enig0B1CDA81DA1018B5B462C8F6--

