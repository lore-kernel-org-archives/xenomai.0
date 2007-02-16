Message-ID: <45D61C5C.8090201@domain.hid>
Date: Fri, 16 Feb 2007 22:04:28 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <45D425B8.7070401@domain.hid> <45D60C78.5090106@domain.hid>
In-Reply-To: <45D60C78.5090106@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD05FA2B9C2F0FBCA7D301EEF"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: Magics of [CAN] message filtering
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Oliver Hartkopp <socketcan@domain.hid>
Cc: socketcan-core@domain.hid, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD05FA2B9C2F0FBCA7D301EEF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,

I just bluntly jump in and capture this posting for the original issue
behind it. :->

Oliver Hartkopp wrote:
> Hello Wolfgang,
>=20
> indeed you are right with all your examples.
>=20
> To get more practice i would suggest to check out the possibilities by =

> using the tools 'cangen', 'cansend' and 'candump'.
>=20
> E.g. these are /your/ examples on the virtual CAN interface vcan0:
>=20
>> The following filter will select all messages, extended and standard=20
>> messages:
>>
>>   rfilter[0].can_id   =3D 0x0;
>>   rfilter[0].can_mask =3D 0x0;
>>  =20
> candump vcan0
> or
> candump -m 0 -v 0 vcan0
> /* mask =3D value =3D 0 is the default */
>=20
>> The following filter will select only extended messages:
>>
>>   rfilter[0].can_id   =3D CAN_EFF_FLAG;
>>   rfilter[0].can_mask =3D CAN_EFF_FLAG;
>>
>>  =20
> candump -m 0x80000000 -v 0x80000000 vcan0
>> The following filter will select only standard messages:
>>
>>   rfilter[0].can_id   =3D CAN_EFF_FLAG | CAN_INV_FILTER;
>>   rfilter[0].can_mask =3D CAN_EFF_FLAG;
>>
>>  =20
> candump -m 0x80000000 -v 0x80000000 -i 1 vcan0

=2E..and I guess this would work as well:

candump -m 0x80000000 -v 0x00000000 vcan0

>> And RTR-Messages could be filtered in a similar way. Is this correct?
>>
>>  =20
> Yes. E.g.
>=20
> candump -m 0x40000000 -v 0x40000000 vcan0
>=20

Makes perfect sense, it's considering EFF and RTR as yet some more bits
of the CAN ID. That's what I actually tried to apply yesterday under
Xenomai and wondered why it didn't work. :o)

So, to align RT-Socket-CAN with plain Socket-CAN again, we (Xenomai) shou=
ld

a) include EFF and RTS transparently into mask building and ID
   comparison
b) add support for inverse masks

Wolfgang, as we currently have some "exception" specified in the CAN
profile, I would just fix the code in this regard (for 2.3.1). The two
changes above should be queued for Xenomai 2.4 together with a profile
and revision number update - to avoid breakage inside the stable series.

Jan


--------------enigD05FA2B9C2F0FBCA7D301EEF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF1hxdniDOoMHTA+kRAnK9AJ0VOe1O+uEWYh3jZQhyl12diYurngCffxKp
/NMjiyohfewIIM7uFG2AA5w=
=sXQb
-----END PGP SIGNATURE-----

--------------enigD05FA2B9C2F0FBCA7D301EEF--

