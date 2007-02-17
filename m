Message-ID: <45D74FE2.7030001@domain.hid>
Date: Sat, 17 Feb 2007 19:56:34 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <45D425B8.7070401@domain.hid>
	<45D60C78.5090106@domain.hid>	<45D61C5C.8090201@domain.hid>
	<45D709E4.80409@domain.hid>	<45D73F0B.8090703@domain.hid>
	<45D74592.1020804@domain.hid>
In-Reply-To: <45D74592.1020804@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig06260C3FE65E1F11904403E2"
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: socketcan-core@domain.hid, Oliver Hartkopp <socketcan@domain.hid>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig06260C3FE65E1F11904403E2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Jan Kiszka wrote:
>> Oliver Hartkopp wrote:
>>> When you're touching anything inside your API, have you ever thought =
to add
>>>
>>> __attribute__ ((aligned(8)))
>>>
>>> to the data[8] element of the struct can_frame?
>>>
>>> This would enable you to make 64 bit compares directly in the data
>>> section of the can_frame ...
>>>
>>> typedef __u32 canid_t;
>>>
>>> struct can_frame {
>>>     canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
>>>     __u8    can_dlc; /* data length code: 0 .. 8 */
>>>     __u8    data[8] __attribute__ ((aligned(8)));
>>> };
>> [Swallowing down my well-known opinion on typeof(can_dlc) :)]
>>
>> Yes, this should be done, already for the more urging sake of
>> unambiguous layout of the structure across the kernel/user space borde=
r.
>=20
> Is this not already the case? At least the size of struct can_frame is =

> 16 bytes.

On all target archs? With all supported compilers? Better make it explici=
t.

Jan


--------------enig06260C3FE65E1F11904403E2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF10/iniDOoMHTA+kRAuq4AJ4s6f/u1WDogRKO6gTtmoo7ryaviQCdGiK8
NWgn/nWcVqKc1arRGyIZiMk=
=Eizs
-----END PGP SIGNATURE-----

--------------enig06260C3FE65E1F11904403E2--

