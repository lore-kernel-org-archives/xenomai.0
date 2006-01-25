Message-ID: <43D7FC5B.2040202@domain.hid>
Date: Wed, 25 Jan 2006 23:31:55 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Signals
References: <20060118162407.A28495@domain.hid> <43D7DD8C.60306@domain.hid>
	<20060125162403.Y17353@domain.hid>
In-Reply-To: <20060125162403.Y17353@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig427D7C1B72701164CD160073"
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
--------------enig427D7C1B72701164CD160073
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Kent Borg wrote:
> On Wed, Jan 25, 2006 at 09:20:28PM +0100, Jan Kiszka wrote:
>>> rt_task_catch() and rt_task_notify()?
>> Those function are - in contrast to what to doc states - not yet
>> available in userspace.
>=20
> No wonder information on them is so sparse.
>=20
>> So far Xenomai is lacking the infrastructure to
>> deliver hard-RT signals to userspace threads, only the Linux signals a=
re
>> passed as usual.
>=20
> But they are passed, that is good.
>=20
>> Signals in multithreaded applications are tricky in general, even
>> without Xenomai. You may try to play with pthread_kill and
>> pthread_sigmask to control which thread receives a specific signal.
>=20
> I have a very simple architecture, one thread is launched by regular
> means, is launches the RT thread.  It is the parent thread that
> registers for the signal and (I think!) it is the one that gets the
> interrupt.

Try printing pthread_self in your signal handler to be sure.

>=20
>> When the signal receiver is a Xenomai thread, the usual things happen:=

>> blocking on RT-resources is cleared, the thread is migrated to seconda=
ry
>> mode, and the signal handler is invoked as one expects.
>=20
> Very interesting.  It sounds like Xenomai is doing cleanup I was
> trying to do by hand.  Maybe that is why I crapped the kernel, I am
> cleaning up stuff that doesn't exist anymore.  Should I deallocate my
> RT fifos?
>=20

No, the native skin does not perform much automatic cleanup, especially
not for userspace objects. If I'm not overseeing some detail, the only
thing that gets cleaned up automatically on process termination are
tasks. Even on unloading the native skin module (when being a module at
all anymore), no forgotten userspace object gets deleted. The posix skin
does such cleanup, but only globally, on module unload.

So the rule is the cleanup everything as long as you are able to (i.e.
your application didn't die due to some bug etc.)

Jan


--------------enig427D7C1B72701164CD160073
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD1/xbniDOoMHTA+kRAiM9AJwIFWdb4PxKdbCQ2JGS7MBV3BxCQwCfXvay
DnLe/OTs4qU1/H0laaAKlPA=
=k+ui
-----END PGP SIGNATURE-----

--------------enig427D7C1B72701164CD160073--

