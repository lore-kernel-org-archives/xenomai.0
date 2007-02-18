Message-ID: <45D899C2.8080000@domain.hid>
Date: Sun, 18 Feb 2007 19:24:02 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <45D425B8.7070401@domain.hid>	<45D60C78.5090106@domain.hid>	<45D61C5C.8090201@domain.hid>	<45D709E4.80409@domain.hid>	<45D73F0B.8090703@domain.hid>	<45D74592.1020804@domain.hid>
	<45D74FE2.7030001@domain.hid>
In-Reply-To: <45D74FE2.7030001@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig40B67B93DA741DE444941B04"
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
--------------enig40B67B93DA741DE444941B04
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Wolfgang Grandegger wrote:
>> Jan Kiszka wrote:
>>> Oliver Hartkopp wrote:
>>>> When you're touching anything inside your API, have you ever thought=
 to add
>>>>
>>>> __attribute__ ((aligned(8)))
>>>>
>>>> to the data[8] element of the struct can_frame?
>>>>
>>>> This would enable you to make 64 bit compares directly in the data
>>>> section of the can_frame ...
>>>>
>>>> typedef __u32 canid_t;
>>>>
>>>> struct can_frame {
>>>>     canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
>>>>     __u8    can_dlc; /* data length code: 0 .. 8 */
>>>>     __u8    data[8] __attribute__ ((aligned(8)));
>>>> };
>>> [Swallowing down my well-known opinion on typeof(can_dlc) :)]
>>>
>>> Yes, this should be done, already for the more urging sake of
>>> unambiguous layout of the structure across the kernel/user space bord=
er.
>> Is this not already the case? At least the size of struct can_frame is=
=20
>> 16 bytes.
>=20
> On all target archs? With all supported compilers? Better make it expli=
cit.

gcc -Os is such an example, toasting the assumed can_frame layout by
moving that 3-byte hole *after* data.

So this was an urging ABI bug, and I applied the alignment to both
stable and trunk Xenomai SVNs. Thanks to Oliver for insisting on this!

Jan


--------------enig40B67B93DA741DE444941B04
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFF2JnCniDOoMHTA+kRAqSPAJ9TSpGXSmNOH0jjpIf3GbzUntKLKwCfaJ8i
G/LlxxQGLhVg52ZojOuhFhc=
=M1aH
-----END PGP SIGNATURE-----

--------------enig40B67B93DA741DE444941B04--

