Message-ID: <43DE5E05.1030302@domain.hid>
Date: Mon, 30 Jan 2006 19:42:13 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RTDM timing problems
References: <200601301611.53089.lbocseg@domain.hid>
In-Reply-To: <200601301611.53089.lbocseg@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8FF3009D2A4DB577F22DA539"
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
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8FF3009D2A4DB577F22DA539
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
> Hi,
>=20
> I just can't understand what is happening.
>=20
> The above code on my driver initialization gives the following results.=

>=20
>         start_time =3D rtdm_clock_read();
> 	rtdm_task_busy_sleep(43000);
> 	temp_time =3D rtdm_clock_read();
> 	   rtdm_printk(KERN_INFO "%u - %u =3D %u\n",(unsigned int) temp_time, =
(unsigned=20
> int) start_time, (unsigned int) (temp_time-start_time));
>=20
> 	   rtdm_printk(KERN_INFO "%u - %u =3D %u\n",(unsigned int)=20
> (temp_time&0xffffffff), (unsigned int) start_time&0xffffffff, (unsigned=
 int)=20
> ((temp_time-start_time)&0xffffffff));
>=20
>=20
> As I expected, both printk gave the same (wrong?) result:
> 3175950208 - 2800623168 =3D 375327040
>=20
> I was waiting something near to 43000, shouldn't I?
>=20
> Please, can someone explain me what is going on...
>=20

Basically confirmed:

I-pipe: Domain Xenomai registered.
Xenomai: hal/x86 started.
Xenomai: real-time nucleus v2.1-rc2 (Champagne) loaded.
Xenomai: starting RTDM services.
4194262080 - 2680902336 =3D 1513359744


But when I additionally load xeno_posix to get the system timer started:

Xenomai: starting POSIX services.
3899754503 - 3899706087 =3D 48416


The point is that rtdm_clock_read() relies on the nucleus timer being
started. Otherwise, it just returns plain wrong numbers.

This makes me scream again for that damn timer being started
AUTOMATICALLY! I guess Philippe knows what I'm talking about... ;)
Meanwhile, we should state this in the docs. At least for 2.0.x, this
will remain true anyway.

Jan


--------------enig8FF3009D2A4DB577F22DA539
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD3l4GniDOoMHTA+kRAjUfAKCCiTso3cIYNV6VMPEoh8D4vrteCACfYuaX
NvC+YC187OUiBQvkP8UqKfc=
=lwxW
-----END PGP SIGNATURE-----

--------------enig8FF3009D2A4DB577F22DA539--

