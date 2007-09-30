Message-ID: <46FFC5FE.5080406@domain.hid>
Date: Sun, 30 Sep 2007 17:51:26 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1ce16a2c0709261252o67cebde3q8cf03a0d21a27288@domain.hid>
In-Reply-To: <1ce16a2c0709261252o67cebde3q8cf03a0d21a27288@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig04389E508A76167C98EDE9B4"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] rtdm driver development
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bachman Kharazmi <bahkha@domain.hid>
Cc: Xenomai <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig04389E508A76167C98EDE9B4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Bachman Kharazmi wrote:
> Hi
> I've implemented a ringbuffer which will buffer strings between a
> pipe-read-task=3D>[buffer]=3D>rtdm-rtserial-writetask
>=20
> The buffer has been implemented in userland and it works.
> But in kernelspace (everything in a loaded in a kernel-module) things
> doesn't work. It's the put(token) which doesn't work.
> The function is put(char* c){ ... }
>=20
> I've heard that there's an address difference. But how do I handle that=
?
>=20
> http://www.xenomai.org/documentation/trunk/html/api/group__util.html#g9=
ce418051ccb7dd2366128efb8674262
> is rtdm_strncpy_from_user() something I should use?
>=20
> exactlly what is: rtdm_user_info_t *  else than a pointer?
> Where do I declare it? There's no clickable link in the api for that th=
at type..
>=20
> The description sais: "User information pointer as passed to the
> invoked device operation handler"
> ...

Please have a look at xenomai/examples/rtdm/driver-api. Those tutorial
may give you some ideas. Feel free to suggest better descriptions of
that field above.

Jan


--------------enig04389E508A76167C98EDE9B4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFG/8X+niDOoMHTA+kRAu6ZAJ0fsiERdjhpGr2V6Tcw+SGJm2zDgACeNAVd
5sQTV1GmTQJfCi64ZALKsuY=
=f2O6
-----END PGP SIGNATURE-----

--------------enig04389E508A76167C98EDE9B4--

