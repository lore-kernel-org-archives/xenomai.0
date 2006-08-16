Message-ID: <44E32B21.8060508@domain.hid>
Date: Wed, 16 Aug 2006 16:26:41 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <44E2DC1C.2010304@domain.hid>
	<200608161231.53239.Sebastian.Smolorz@domain.hid>
	<44E2F8DE.4000806@domain.hid>
	<200608161305.54411.Sebastian.Smolorz@domain.hid>
In-Reply-To: <200608161305.54411.Sebastian.Smolorz@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig519DD2D60F05F3A73FD1BDFF"
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
--------------enig519DD2D60F05F3A73FD1BDFF
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Sebastian Smolorz wrote:
> Jan Kiszka wrote:
>> Sebastian Smolorz wrote:
>>> The possibility of redefinition was not the main goal here. As you
>>> mentioned it would be problematic. No, I introduced nanosecs_abs_t an=
d
>>> nanosecs_rel_t because they are more intuitive and more "speaking" to=
 the
>>> programmer. The meaning of a variable of such a type is clear at firs=
t
>>> sight.
>> Yeah, sounds reasonable to me. Then let's move these typedefs to rtdm.=
h
>> and document them as self-explanatory defines of the underlying standa=
rd
>> types, freezing their width and signedness at the same time.
>=20
> Agreed.
>=20
>> Actually, this would be useful for the driver API of RTDM as well.
>=20
> That's right. No objections from my side.
>=20

Done.

Though I checked things more then twice, some regression may be hidden,
specifically as I changed the signedness of timeout parameters of a few
RTDM driver API functions. All documented under
ksrc/skins/rtdm/API.CHANGES, and everyone is warned now.

Jan


--------------enig519DD2D60F05F3A73FD1BDFF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE4yshniDOoMHTA+kRAjogAJ4uiZ71q9KP2FjQUZ9jjj4lUThj8ACfclcH
C5UUTG2i13L2vmCYjnBorLY=
=j70f
-----END PGP SIGNATURE-----

--------------enig519DD2D60F05F3A73FD1BDFF--

