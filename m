Message-ID: <43D7DD8C.60306@domain.hid>
Date: Wed, 25 Jan 2006 21:20:28 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Signals
References: <20060118162407.A28495@domain.hid>
In-Reply-To: <20060118162407.A28495@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3DC857DE922FC93DFD16F1CA"
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
To: Kent Borg <kentborg@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3DC857DE922FC93DFD16F1CA
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Kent Borg wrote:
> Thanks for the news that gdb should just work.
>=20
> Now I am wondering about signals.  I want to be able to send a regular
> Linux signal to a userland realtime process.  Do I use the regular
> signal() to install a signal handler?  When would I use
> rt_task_catch() and rt_task_notify()?

Those function are - in contrast to what to doc states - not yet
available in userspace. So far Xenomai is lacking the infrastructure to
deliver hard-RT signals to userspace threads, only the Linux signals are
passed as usual.

>=20
> What about multiple threads?  I have 2 threads running.  It seems that
> the thread that called signal() is the one landing in the handler
> routine.  I would like to set some flags for the second thread to see,
> so it can cleanup things before quiting, but it seems that my second
> thread isn't running after I send the signal.  I also think I am
> corrupting something, because if I set up a loop that launches and
> kills my program, my machine freezes up after a dozen cycles.  I
> commented out most of my guts and it still freezes up.

Signals in multithreaded applications are tricky in general, even
without Xenomai. You may try to play with pthread_kill and
pthread_sigmask to control which thread receives a specific signal.

When the signal receiver is a Xenomai thread, the usual things happen:
blocking on RT-resources is cleared, the thread is migrated to secondary
mode, and the signal handler is invoked as one expects.

Jan


--------------enig3DC857DE922FC93DFD16F1CA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD192MniDOoMHTA+kRAn3OAJ9ylIh9Pkbx6WIGWhciIW5lqQ/vzQCdGE2z
/NCJO1qgZgISkjTVSGLQSbI=
=5hXr
-----END PGP SIGNATURE-----

--------------enig3DC857DE922FC93DFD16F1CA--

