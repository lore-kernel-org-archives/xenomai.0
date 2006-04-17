Message-ID: <4443992C.5000808@domain.hid>
Date: Mon, 17 Apr 2006 15:33:32 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] General question on Native Skin tasks
References: <6ee4c8380604161110y3c937a74t9186bad2d9af2058@domain.hid>
In-Reply-To: <6ee4c8380604161110y3c937a74t9186bad2d9af2058@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC92AE77BD5F2F8E2D0F6A4E8"
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
To: "Brian L." <bluczkie@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC92AE77BD5F2F8E2D0F6A4E8
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Brian L. wrote:
> If I create a native-skin RT_TASK from userspace with no flags, i.e.
>=20
> void task(void*)
> {
>     for (;;) ;
> }
> int main()
> {
>    RT_TASK t;
>    rt_task_create(&t, 0, 3, 0);
>    rt_task_start(&t,task,0);
>    (do something which blocks)
> }

mlockall left out for simplicity? Or is it also missing on your real
test? In the latter case, occasional application crashes are "normal"
(as described below).

Philippe, you suggested some code for detecting this. We should really,
really add this soon (maybe to the exception path)!

>=20
> Should that task starve all other tasks? In what ways is it different
> behaviorally from an ordinary posix thread? I ask because I have a
> thread that might be spinning and a frozen system (back in the rtlinux
> days, spinning in the real-time domain was a surefire way to freeze
> without any other sign of trouble). If it is the case that this task
> outweighs an ordinary linux thread/task, how can I make it the same?

A task that has high priority than other system tasks has to outweigh
them. This has nothing to to with POSIX (standard Linux included!),
RTLinux, Xenomai, or whatever. But Xenomai has a simple watchdog to
recover from run-away RT threads.

>=20
> Also,  I haven't completely tracked this down yet, but xenomai seems
> to be page-faulting in a loop and exploding rather spectacularly in a
> native-skin multithreaded program that doesn't do anything outside of
> relatively ordinary queue/mutex/task stuff. I'm upgrading to trunk to
> see if it goes away.
>=20
> Short of a serial cable, is there a way to capture Oops/Panic text as
> it flies by?

linux/Documentation/networking/netconsole.txt is another option.

Jan


--------------enigC92AE77BD5F2F8E2D0F6A4E8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEQ5ksniDOoMHTA+kRApjtAJ0TlXFOzOV+xZQDHg55Fyx9CyqzMwCggsI3
LpyGLOTx/Ilu5gu0kv83rCE=
=lcwe
-----END PGP SIGNATURE-----

--------------enigC92AE77BD5F2F8E2D0F6A4E8--

