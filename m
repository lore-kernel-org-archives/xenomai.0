Message-ID: <45F471A9.1040005@domain.hid>
Date: Sun, 11 Mar 2007 22:16:25 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] your pending RT-Socket-CAN problems (was rtcan
	driver. rtcan_sja_interrupt made interruptible)
References: <45F2B8BB.6060804@domain.hid>
	<45F2DE0A.1010207@domain.hid>		<bc4264770703110035g6625e8a1t4f195507d72aaf66@domain.hid>		<45F3CD2C.5000400@domain.hid>	<bc4264770703110402x55f7b13chca39ed02f983feac@domain.hid>
	<45F3F013.5000400@domain.hid>
In-Reply-To: <45F3F013.5000400@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4AD4B3D1B6F562D0D1A0B329"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4AD4B3D1B6F562D0D1A0B329
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> roland Tollenaar wrote:
>> So I really feel your suggestion of working with an (interruptible)
>> service-task and blocking IRQ's is a better approach.
>=20
> I agree that it would be nice to have that option and it's already on m=
y
> wish list. Patches are welcome, of course.

Threaded IRQs are no magic bullet. They can only help to push a problem
down the priority ladder, curing a problem symptom where possible.

Nevertheless, threaded IRQs for RTDM are planned. The yet open design
challenge is how to support driver writers best when they have to switch
between both models, e.g. during compile-time (keep in mind, you also
have to switch the locking: spinlock<->mutex).

Jan


--------------enig4AD4B3D1B6F562D0D1A0B329
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF9HGpniDOoMHTA+kRAsAhAJwNmFhN3HTFtZ3Rej12CPXgvQloaACcDX8n
GmWOcIBUK1EE7NMec49TDWs=
=O498
-----END PGP SIGNATURE-----

--------------enig4AD4B3D1B6F562D0D1A0B329--

