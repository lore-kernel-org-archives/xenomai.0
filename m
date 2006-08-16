Message-ID: <44E2F8DE.4000806@domain.hid>
Date: Wed, 16 Aug 2006 12:52:14 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <44E2DC1C.2010304@domain.hid>
	<200608161231.53239.Sebastian.Smolorz@domain.hid>
In-Reply-To: <200608161231.53239.Sebastian.Smolorz@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE7029C3A8DBE9CE1E1267755"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: Time representation in RTDM profiles
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE7029C3A8DBE9CE1E1267755
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Sebastian Smolorz wrote:
> Jan Kiszka wrote:
>> the current representation of timeouts and timestamps in RTDM device
>> profiles is inconsistent.
>=20
> I would welcome a consistent time value representation above all RTDM=20
> profiles, too.
>=20
>> In the serial profile we use [u]int64_t=20
>> directly, the CAN profile defines its own types called
>> nanosecs_{abs|rel}_t (though they just wrap the int64 ones).
>>
>> What is the idea of nanosecs? Having a way to redefine that type looks=

>> nice, but it's unfortunately the ABI, so we cannot easily change it
>> without breaking apps.
>=20
> The possibility of redefinition was not the main goal here. As you ment=
ioned=20
> it would be problematic. No, I introduced nanosecs_abs_t and nanosecs_r=
el_t=20
> because they are more intuitive and more "speaking" to the programmer. =
The=20
> meaning of a variable of such a type is clear at first sight.
>=20

Yeah, sounds reasonable to me. Then let's move these typedefs to rtdm.h
and document them as self-explanatory defines of the underlying standard
types, freezing their width and signedness at the same time.

Actually, this would be useful for the driver API of RTDM as well.

Jan


--------------enigE7029C3A8DBE9CE1E1267755
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE4vjeniDOoMHTA+kRAm1fAJ9S44ehxrfEea2GVb/SsjK/zm4syQCffo0X
+DxONXpOQZD3HZxOmlQueoQ=
=fafQ
-----END PGP SIGNATURE-----

--------------enigE7029C3A8DBE9CE1E1267755--

