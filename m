Message-ID: <4BCB412E.3000807@domain.hid>
Date: Sun, 18 Apr 2010 19:28:14 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <cover.1271596366.git.Jan Kiszka
	jan.kiszka@domain.hid>	<de921a67d4cbffda35e9b27d8cea25f8e6492b58.1271596367.git.Jan	Kiszka
	jan.kiszka@domain.hid> <4BCB3DA9.4060505@domain.hid>
In-Reply-To: <4BCB3DA9.4060505@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7E5F17A4E3F5BC4D9D7F3B44"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH v3 17/24] rttest: Resolved test device
 conflicts via separate name spaces
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7E5F17A4E3F5BC4D9D7F3B44
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@domain.hid>
>>
>> Usually, all devices of some RTDM class use the same naming scheme. Bu=
t
>> as test devices are different as they do not provide compatible APIs,
>> let's give them separate name space for their device names. That final=
ly
>> resolves all the detection troubles that showed up once more than one
>> test device was registered.
>>
>> To allow addressing old drivers with new user space and vice versa, a
>> config switch is added to the former to select the naming scheme, and
>> the latter will try to open under both names.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
>=20
> Could we please have the devices named after the same name as the drive=
r?
> So switchtst -> switchtest
> tmbench->timerbench

We can (now that I know your preferences).

Jan


--------------enig7E5F17A4E3F5BC4D9D7F3B44
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkvLQTIACgkQitSsb3rl5xRtEgCfSYUcgetr9g41b2lpsSwwXUsO
MSgAoJ4JD15eaAVZDIheVmyY791vBkry
=KJbS
-----END PGP SIGNATURE-----

--------------enig7E5F17A4E3F5BC4D9D7F3B44--

