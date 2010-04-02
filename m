Message-ID: <4BB5AA44.6000006@domain.hid>
Date: Fri, 02 Apr 2010 10:26:44 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20100401230843.GF3755@domain.hid>
	<4BB53566.3010601@domain.hid> <4BB53643.2080604@domain.hid>
In-Reply-To: <4BB53643.2080604@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0840A3301C4E1934E9169B53"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] New scheduler class
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0840A3301C4E1934E9169B53
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Andreas Glatz wrote:
>>> Hi Philippe,
>>>
>>> At the Xenomai Users Meeting last year I asked you if Xenomai would o=
ffer a possibility to lower the priority of certain Xenomai tasks below t=
hat of Linux. We need this feature since we have tasks in our RT applicat=
ion which should only run when Linux is idle (A statistics collection tas=
k which part of the RT application and hard to isolate from this applicat=
ion).
>>>
>> What prevents using a borderline thread (if you need to interact with
>> blocking Xenomai services) with SCHED_OTHER and a Linux nice level of =
19?
>=20
> Well, this does not really guarantee that the thread will run only when=

> linux is idle. The thread will eat some cpu time, the nice level is not=

> a strict priority, as you know.

Where do you really need anything stricter? It's the opposite of "I need
true 100% CPU for my task, and that forever."

> But in fact, I wonder why Andreas wants
> a new scheduling policy for xenomai, what is needed, is simply a
> SCHED_IDLE (maybe it exists ?!) policy for Linux.
>=20

There is no such thing AFAIK. If you are concerned that some CPU
intensive low prio job eats too much CPU, you normally reduce its
nice-level and/or confine its CPU bandwidth via cgroups.

Jan


--------------enig0840A3301C4E1934E9169B53
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAku1qkoACgkQitSsb3rl5xSnlgCghbk3LVsirsEWaVx+sKDIJoGw
eYcAn0GDy2T5gCLQTCX+dbjQPF4N5AAW
=A1yX
-----END PGP SIGNATURE-----

--------------enig0840A3301C4E1934E9169B53--

