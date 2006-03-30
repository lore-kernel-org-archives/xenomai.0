Message-ID: <442C42B5.2070506@domain.hid>
Date: Thu, 30 Mar 2006 22:42:29 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rt_task_delete() question
References: <442C19F2.206@domain.hid>
In-Reply-To: <442C19F2.206@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8F5BAB9191E59D4CE889F4BB"
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
To: Sean McGranaghan <smm@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8F5BAB9191E59D4CE889F4BB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Sean McGranaghan wrote:
> Hello all,
>=20
> I am posting this for a co-worker who is having problems with killing a=
=20
> real-time task. (He is joining the email list shortly but for now I wil=
l pass=20
> responses on to him.) Here is the scenario:
>=20
> 1. A Linux process starts up and detaches from the tty (daemon)
> 2. The daemon creates a xeno message queue
> 2. The daemon spawns a xeno task
> 3. The xeno task on startup binds to the queue rt_queue_bind()
> 4. The xeno task waits on the queue recv with infinite timeout
> 5. The daemon process goes to sleep in a join, waiting for the task to =
exit
> 6. Some time later another program starts
> 7. The other non-realtime program looks up the xeno task name via rt_ta=
sk_bind()
> 8. The other non-realtime program attempts to delete the task via rt_ta=
sk_delete()
>         Failed Attempt #1 - Non-realtime program calls rt_task_delete()=
 and gets
>                             a segmentation fault
>         Failed Attempt #2 - Non-realtime program spawns a realtime task=
 which
>                             binds to original task and tries rt_task_de=
lete().
>                             Also gets segmentation fault.
>=20
> The was attempted one a system running the latest Xenomai 2.1 release.
>=20
> What is the preferred method to start/join threads from a non-realtime =
context?
>=20
> Any help is appreciated.
>=20

rt_task_delete is not supposed to work across processes (Hmm, is this
detail documented somewhere?).

Use a normal Linux signal (e.g. SIGTERM) to terminate the daemon
process. For a clean termination, you should install a signal handler in
the daemon process which triggers an organised clean-up (all
RT-resources except tasks have to be released explicitly).

Jan


--------------enig8F5BAB9191E59D4CE889F4BB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFELEK1niDOoMHTA+kRAqGRAJwNI+ogOYQ9WUky7H8YtZwB58ie1QCdF+Zq
Z4zAjm4UZVdb7z9VvSI3xH4=
=Tzip
-----END PGP SIGNATURE-----

--------------enig8F5BAB9191E59D4CE889F4BB--

