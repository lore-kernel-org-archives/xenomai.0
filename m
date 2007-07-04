Message-ID: <468B81E0.9050900@domain.hid>
Date: Wed, 04 Jul 2007 13:17:52 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <C0662F7F2A8A974FAA140822A2336BF0F17553@domain.hid>
In-Reply-To: <C0662F7F2A8A974FAA140822A2336BF0F17553@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDFB0544F135DB14C29370ACF"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] is rt_task_shadow ok?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Stolz, Stefan, PGR2" <Stefan.Stolz@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDFB0544F135DB14C29370ACF
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Stolz, Stefan, PGR2 wrote:
> Hello,
>=20
> i have a little question about rt_task_shadow(). I'm not sure if it is
> ok to use ist like i do in my application.
> The basic conditions of my app are:
>  - it is a embedded linux (Sysgo ELinOS) with Xenomai 2.0.4=20
>    (old but unfortunatly no newer version is available for ELinOS)

Role your own? For simple Xenomai applications it's ok to stick with
what Sysgo provides. But for more complex scenarios I would seriously
recommend to update Xenomai+kernel.

Using a recent version will enable you to gain better community support
and to exploit those nice enhancements and fixes we added in the meantime=
=2E

>  - the app listens on a tcp-port for commands from a client app.
>  - one command ist for starting a simulation of some signals on the
> parallel-port;=20
>    this simulation have to be hard-real-time
>=20
> at first the tcp-server-part was in a non-rt-app which startet the
> simulation-task with the normal xenomai-functions.
> While the simulation is running i have to exchange data between the
> tcp-server and the rt-task.=20
> The Problem is, that things like semaphores and mutexes doesn't work
> with nrt-tasks.
> now i found the rt_task_shadow-function. So after starting my app i cal=
l
> this funktion and switch the process into a xenomai task (with the lowe=
s
> priority). At the moment everything seems ok; but are there any known
> problems with this approach?

You already picked the recommended scheme: shadowed Linux task on the
borderline, mostly running under Linux control (SCHED_OTHER), but being
able to become RT for synchronisation with high-prio RT tasks.

Jan


--------------enigDFB0544F135DB14C29370ACF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGi4HjniDOoMHTA+kRAqb0AJ9uMBZxajDW2r+kdBtar/SLY4+/QwCfTePx
wGcRAjmUurp778+aGvpkAOE=
=BX7T
-----END PGP SIGNATURE-----

--------------enigDFB0544F135DB14C29370ACF--

