Message-ID: <46222105.90900@domain.hid>
Date: Sun, 15 Apr 2007 14:56:37 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <461D65BC.2090406@domain.hid> <46220DC4.9040306@domain.hid>
In-Reply-To: <46220DC4.9040306@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAA6D3EAE20389D969D5F86FB"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] CAN_RAW, CAN_PROTO_RAW, and Socket-CAN
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
--------------enigAA6D3EAE20389D969D5F86FB
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Jan Kiszka wrote:
>> Hi Wolfgang,
>>
>> something is inconsistent about CAN_RAW in RT-Socket-CAN compared to
>> plain Socket-CAN. Also, the latter doesn't know any CAN_PROTO_xxx unle=
ss
>> I oversee something. Please have a look.
>=20
> There is CAN_PROTO_RAW defined and I have added some time ago CAN_RAW t=
o
> rtcan.h to be compatible with Socket-CAN:
>=20
>   /** Particular CAN protocols
>    *
>    *  Currently only the RAW protocol is supported.
>    */
>   #define CAN_RAW  0

Yes, I know. But the question remains which way to go for rtcan:
Socket-CAN doesn't know CAN_PROTO_*, RT-Socket-CAN comes with CAN_RAW as
well now, but having a different value. That should be resolved, on
whatever side, IMHO.

>=20
>> (I received a private complaint of a user trying to compile rtcan_rtt
>> against 2.3.x.)
>=20
> The latter definition is missing in 2.3.x, though and compiling
> rtcan_rtt.c from the trunk will fail for this reason. I'm going to fix
> it later today.

Good, thanks,
Jan


--------------enigAA6D3EAE20389D969D5F86FB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGIiEFniDOoMHTA+kRAkIcAJwKtKbraaLthXOKThMVa4Qa/fqHkgCfUWFj
OwVrvKgf1LBrWx6+xAkxgu4=
=FPui
-----END PGP SIGNATURE-----

--------------enigAA6D3EAE20389D969D5F86FB--

