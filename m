Message-ID: <4B86EDC2.7010905@domain.hid>
Date: Thu, 25 Feb 2010 22:38:10 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <CF7FB0793253794F9F45991443E5FE2006483DE98C@us194mx002.tycoelectronics.net>
In-Reply-To: <CF7FB0793253794F9F45991443E5FE2006483DE98C@us194mx002.tycoelectronics.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig459948B2FD06ACE47F53D5C2"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] mlockall error after calling mlockall()
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Charlton, John" <john.charlton@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig459948B2FD06ACE47F53D5C2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Charlton, John wrote:
> I have a xenomai application that runs without problems with xenomai-2.=
4.6.1/linux-2.6.27.7. When run under xenomai-2.5.1/linux-2.6.32.7 it fail=
s with the warning: Xenomai: process memory not locked (missing mlockall?=
).  I verified that mlockall() is being called before any xenomai calls a=
re made as follows with out error:
>=20

I'm afraid that warning is misleading.

>   // lock process in memory for xenomai
>   int err =3D mlockall(MCL_CURRENT | MCL_FUTURE);
>   if (err)
>   {
>     fprintf(stderr, "TimerInit: mlockall failed to lock process into me=
mory: %d\n", err);
>     exit(1);
>   }
>   fprintf(stdout, "TimerInit: Locked process memory\n");
>=20
> The relevant message in dmesg output is:
> Xenomai: watchdog triggered -- signaling runaway thread 'timerloop-2166=
'

That is the actual error message, likely pointing to an application bug.
Try to attach gdb to your application, it will catch the signal and
allow to dump a stack trace that should give some hint what loops
endlessly here.

>=20
> This occurs when creating a native xenomai task (created by CanFestival=
 library) with the following code with no errors:
>=20
> void StartTimerLoop(TimerCallback_t _init_callback)
> {
>   int ret =3D 0;
>   stop_timer =3D 0;
>   init_callback =3D _init_callback;
>=20
>   char taskname[32];
>   snprintf(taskname, sizeof(taskname), "timerloop-%d", getpid());
>=20
>   printf("Starting timerloop task %s\n", taskname);
>   /* create timerloop_task */
>   ret =3D rt_task_create(&timerloop_task, taskname, 0, 50, T_JOINABLE);=

>   if (ret) {
>     printf("Failed to create timerloop_task, code %d\n",errno);
>     return;
>   }
>=20
>   /* start timerloop_task */
>   ret =3D rt_task_start(&timerloop_task,&timerloop_task_proc,NULL);
>   if (ret) {
>     printf("Failed to start timerloop_task, code %u\n",errno);
>     goto error;
>   }
>=20
>   return;
>=20
> error:
>   cleanup_all();
> }
>=20
> Debug output is displayed from the timerloop_task indicating that the t=
ask starts, but the mlockall warning is displayed before those outputs an=
d the application already begins to shut down.

Way more interesting is how timerloop_task_proc looks like. Can you post
a complete test case? Besides that this would allow us to help you with
the runaway timerloop, I would like to understand why this wrong warning
is dumped in user space.

Jan


--------------enig459948B2FD06ACE47F53D5C2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkuG7cYACgkQitSsb3rl5xRHcACcD8mtCCaO4f9LaFMWrG0W9zEl
G6AAn0lqHzC94LvB8qsrA5Prj6nuQRo8
=rBHx
-----END PGP SIGNATURE-----

--------------enig459948B2FD06ACE47F53D5C2--

