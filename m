Message-ID: <48F21999.1060508@domain.hid>
Date: Sun, 12 Oct 2008 17:36:57 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48F2118A.7010608@domain.hid>
In-Reply-To: <48F2118A.7010608@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig575EF7694C35B77060397528"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Using SIGWINCH to trigger priority change.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig575EF7694C35B77060397528
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Hi,
>=20
> I am working on using SIGWINCH to trigger priority changes in
> user-space. And I am afraid it will never really work:
> - Xenomai makes a difference between the base priority of a thread and
> its current priority. But pthread_getschedparam should return the base
> priority, not the current priority, so, we need a way to change the
> current priority of a thread without changing its base priority.
> - I do not know at what time we should trigger a signal to the thread
> whose priority is changing:
>   . if we send it as soon as we return to user-space (at the same time
> as when we handle LO_RENICE_REQ), if the thread whose priority is
> changing is not the current one, we potentially trigger a
> primary/secondary mode transition for this thread;
>   . if we wait for the target thread to return to secondary mode (via
> xnshadow_relax), any other thread in the same process which would read
> the target thread priority with pthread_getschedparam would not see tha=
t
> the priority has changed;
>   . we could do it as soon as a thread of the same process returns to
> secondary mode, but it looks complicated, and besides,
> pthread_getschedparam can safely be called from primary mode, so we
> still have the same issue as for the previous point.
>=20
> This is where I stopped thinking about this idea.

It would be nice to have pthread_getschedparam always in sync with the
shadow base prio. But if this is obviously at least very complicated (if
not infeasible), I would focus on getting the base prio right when the
thread switches to secondary mode (or if it already is there, of
course). That we cannot guarantee pthread_getschedparam returning the
same value that rt_task_set_priority applied should simply be documented.=


Jan


--------------enig575EF7694C35B77060397528
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkjyGZ4ACgkQniDOoMHTA+kgmwCfXg//qNZTr89uNYxKPUMNHivV
/lgAn2CV8tVZmviZfeB5MST83SbstiZg
=ubDf
-----END PGP SIGNATURE-----

--------------enig575EF7694C35B77060397528--

