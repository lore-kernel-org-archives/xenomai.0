Message-ID: <445E637A.5080706@domain.hid>
Date: Sun, 07 May 2006 23:15:38 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC][patch] per-process data.
References: <17502.13773.674199.219762@domain.hid>
In-Reply-To: <17502.13773.674199.219762@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAC63BEE4D490B51AE39D0E5A"
Sender: jan.kiszka@domain.hid
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
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAC63BEE4D490B51AE39D0E5A
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Hi,
>=20
> for review, here are patches that provide Xenomai skins with a
> per-process per-skin data structures. It will allow skins to do
> per-process cleanup for example, or the posix skin to maintain a
> per-process signal mask.

That sounds promising!

>=20
> In order to use it, the skins must pass an eventcb function to the
> xnshadow_register_interface service. This eventcb function gets called
> when:
> - a process bind the interfaces, the eventcb has to allocate the
>   per-process structure and must return a pointer to an xnppd_holder_t
>   member of this structure;=20
> - the process exits, the eventcb function is then passed the
>   xnppd_holder_t pointer and may free the container structure.
>=20
> The patch also add a service called xnppd_get, which must be passed the=

> skin magic, and returns the xnppd_holder_t pointer attached to the
> current process.
>=20
> This support relies on a new adeos event called "PEXIT" for
> process-exit, that get triggered in the mmput function when a process
> mm_struct get deallocated.

Likely I did not yet get the full picture: What prevents using another
adeos per-task key for this? And why is it required to establish a new
termination hook? Are there scenarios where the existing
task-termination hook is not suited for the planned cleanup work?

>=20
> These patches are not ready for inclusion, they are not tested
> yet.
>=20

Jan


--------------enigAC63BEE4D490B51AE39D0E5A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEXmOAniDOoMHTA+kRAk8bAJ4mzhYcR42+azgvs8octul3EeuHHgCfQay1
FMH191bCB20oje6BjFsVhTs=
=WEgW
-----END PGP SIGNATURE-----

--------------enigAC63BEE4D490B51AE39D0E5A--

