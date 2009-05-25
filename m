Message-ID: <4A1AA4F8.80101@domain.hid>
Date: Mon, 25 May 2009 16:02:32 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <200905251501.25400.shashank.bhatia@domain.hid>
In-Reply-To: <200905251501.25400.shashank.bhatia@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCDC66EEA90026D1BB4B053D2"
Subject: Re: [Xenomai-help] RT Task as a kernel module halts the whole system
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Shashank Bhatia <shashank.bhatia@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCDC66EEA90026D1BB4B053D2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

Shashank Bhatia schrieb:
> Dear All,
>=20
>             I wrote a simple RT task to be run as kernel module and tri=
ed to=20
> run it. As soon as i issue the insmod command, it halts the whole syste=
m.
> Please help me out,
>=20
> The code is as follows:
> [...]
>=20
>         err =3D rt_alarm_create(&alarm,"myAlarm");

looking at the xenomai docs [1], there are two rt_alarm_create() function=
s,
one for kernel-space and one for userspace:

int rt_alarm_create (RT_ALARM *alarm, const char *)
    Create an alarm object from user-space.

int rt_alarm_create (RT_ALARM *alarm, const char *name, rt_alarm_t handle=
r, void *cookie)
    Create an alarm object from kernel space.

It seems you are using the wrong one.

For a user-space alarm example and other code-snippets look in the direct=
ory
ksrc/skins/native/snippets/

kisda

[1] http://www.xenomai.org/documentation/branches/v2.4.x/html/api/index.h=
tml


>         err =3D rt_alarm_start(&alarm,ALARM_VAL,ALARM_INT);
>=20
> err=3Drt_task_create(&alarm_handler, "ALARMtask",STAK_SIZE,TASK_PRI,TAS=
K_MODE);
>=20
>         if(!err)
>                 rt_task_start(&alarm_handler,&alarm_hand_func,NULL);
>=20
>         return 0;                             // A non-zero return mean=
s=20
> hello_init failed; the module can't be loaded.
> }
>=20
> // End/Cleanup function
> static void hello_exit(void) {
>=20
>         //rt_task_delete(&alarm_handler);
>=20
>         rt_alarm_delete(&alarm);
>=20
>         printk(KERN_ALERT "Goodbye world!\n");
> }
>=20
> module_init(hello_init);
> module_exit(hello_exit);
>=20
> -------------------------------------
> Hi-Tech Gears Limited, Gurgaon, India
>=20
>=20
>=20
>=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>=20



--------------enigCDC66EEA90026D1BB4B053D2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFKGqT9IPTw9rIdn6oRAikrAJ46FydCR5ctbCJ69jeXvEgsmeJUkACeOFUT
uKiE2MbmB25eUWmWU1sT5KU=
=FfhB
-----END PGP SIGNATURE-----

--------------enigCDC66EEA90026D1BB4B053D2--

