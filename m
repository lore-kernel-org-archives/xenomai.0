Message-ID: <44D74405.7000900@domain.hid>
Date: Mon, 07 Aug 2006 15:45:41 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Problems with rt_task_wait_period
References: <1903678222@domain.hid>
In-Reply-To: <1903678222@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig26A062F951E28DE3906B6355"
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
To: Steve Kreyer <steve.kreyer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig26A062F951E28DE3906B6355
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Steve Kreyer wrote:
> Hi,
>=20
> Iam new to xenomai.=20
> For warming up I try to run this little test program:
>=20
> -----------------------------------------------------------------------=

> #include <native/task.h>
> #include <stdio.h>
> #include <sys/mman.h>
>=20
> RT_TASK task1;
>=20
> void rt_task1(void* user_data){
>     int err =3D 0;
>     printf("%d\n", rt_task_set_periodic(NULL, TM_NOW, 100));

You are running in one-shot mode, thus all time units are in
*nanoseconds*. 100 ns cycles tend to pass quite quickly, thus the setup
actually fails (but it doesn't report this - a corner case for
considering this a bug).

>     err =3D rt_task_wait_period(NULL);
>     if(err){
>         fprintf(stderr, "Cannot wait periodic: %d, %d\n", err, EWOULDBL=
OCK);
>=20
>     }
> }
>=20
> int main(){
>     char* task1_data =3D NULL;
>     mlockall(MCL_CURRENT|MCL_FUTURE);
>     rt_timer_set_mode(TM_ONESHOT);
>     rt_task_spawn(&task1, "task1", 0, 99, 0, rt_task1, &task1_data);
>     sleep(10);
>     rt_task_delete(&task1);
>     return 0;
> }
> -----------------------------------------------------------------------=

>=20
> But rt_task_wait_period gives me always the Error EWOULDBLOCK, which me=
ans that I did not set the task periodic
> but which in fact I did... The call to rt_task_set_periodic is succesfu=
l.
> Can anyone help me figure out why? If you need additional infos please =
let me know...
>=20
> Thanks in advance!
>=20
> Steve
>=20

Jan


--------------enig26A062F951E28DE3906B6355
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE10QFniDOoMHTA+kRApiyAJ9Jq8R9Vwhu1HIaeqBErM+E3x/gBgCffBTM
1wVrAA/WqeEHLTVJXtsL5OQ=
=1XPv
-----END PGP SIGNATURE-----

--------------enig26A062F951E28DE3906B6355--

