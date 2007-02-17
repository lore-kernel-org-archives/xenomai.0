Message-ID: <45D74F70.2090200@domain.hid>
Date: Sat, 17 Feb 2007 19:54:40 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: Extended CAN frame filtering
References: <45D338C2.9030203@domain.hid> <45D5A56F.8080900@domain.hid>
	<45D711DF.8060802@domain.hid> <45D741AE.9020501@domain.hid>
	<45D7475E.1030504@domain.hid>
In-Reply-To: <45D7475E.1030504@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAF128FDBA180BE267B034796"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAF128FDBA180BE267B034796
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
>>> Index: ksrc/drivers/can/rtcan_raw_filter.c
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> --- ksrc/drivers/can/rtcan_raw_filter.c    (revision 2193)
>>> +++ ksrc/drivers/can/rtcan_raw_filter.c    (working copy)
>>> @@ -55,13 +55,13 @@ void rtcan_raw_print_filter(struct rtcan
>>>  static inline void rtcan_raw_mount_filter(can_filter_t *recv_filter,=

>>>                        can_filter_t *filter)
>>>  {
>>> -   if (filter->can_id & CAN_EFF_FLAG)
>>> -    recv_filter->can_mask =3D ((filter->can_mask & CAN_EFF_MASK) |
>>> -                 CAN_EFF_FLAG);
>>> -    else
>>> -    recv_filter->can_mask =3D (filter->can_mask & CAN_SFF_MASK);
>>> -
>>> -    recv_filter->can_id =3D filter->can_id & recv_filter->can_mask;
>>> +    if (filter->can_id & CAN_INV_FILTER) {
>>> +    recv_filter->can_id =3D filter->can_id & ~CAN_INV_FILTER;
>>> +    recv_filter->can_mask =3D filter->can_mask | CAN_INV_FILTER;
>>> +    } else {
>>> +    recv_filter->can_id =3D filter->can_id;
>>> +    recv_filter->can_mask =3D filter->can_mask & ~CAN_INV_FILTER;
>>> +    }
>>
>> Why do you push CAN_INV_FILTER internally into the mask instead of
>> keeping it in the filter's ID - as the pseudo code above states?
>=20
> To simplify the filter calculation. It actually avoids the expression
> (filter->can_id & ~CAN_INV_FILTER). As this is in a very frequently
> called function, I think it's worth the trick.
>=20

Ack. I missed that point on first run.

Jan


--------------enigAF128FDBA180BE267B034796
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF109wniDOoMHTA+kRAk+4AJ4qhU25QErsceW0Cq63KZujQjQE4QCfSvwB
PpDEIjjuas6sDXaGwq7nVUg=
=CqTB
-----END PGP SIGNATURE-----

--------------enigAF128FDBA180BE267B034796--

