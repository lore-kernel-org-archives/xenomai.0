Message-ID: <446DB76B.8030106@domain.hid>
Date: Fri, 19 May 2006 14:17:47 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] rtdm_safe_copy_from_user...
References: <446D92F2.6000706@domain.hid>
In-Reply-To: <446D92F2.6000706@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0F7CB53A118998B95F7E5BCA"
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
--------------enig0F7CB53A118998B95F7E5BCA
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Hello,
>=20
> I propose to add the following commonly used RTDM inline functions to
> rtdm_driver.h:
>=20
>    static inline int rtdm_safe_copy_from_user()
>    static inline int rtdm_safe_copy_to_user()

Yep, likely a convenient shortcut. Just a minor correction: the full
size should be checked, not just a single-byte range.

Those new services together with updated doc will go into trunk after
release 2.2. There are currently several RTDM extensions pending, so I
prefer to merge the whole packet and increment the revision number only
once.

>=20
> The attached patch also fixes a bug in rtdm_strncpy_from_user(). I thin=
k
> __xn_access_ok() returns a non-zero value if the access is safe. Has it=

> ever worked? I don't care about the real name.

Oops, obviously wrong and obviously yet unused. I fixed this in 2.1.x
and trunk.

Thanks for the patches!

Jan


--------------enig0F7CB53A118998B95F7E5BCA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEbbdrniDOoMHTA+kRApQNAJ9eO7v+NwbrHDU9U6B5uFG+Ha2RQACeIW1h
ExQHuYHZPRDm9l7Ug8fxmmU=
=Ne18
-----END PGP SIGNATURE-----

--------------enig0F7CB53A118998B95F7E5BCA--

