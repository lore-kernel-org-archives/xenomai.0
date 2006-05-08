Message-ID: <445F4232.70201@domain.hid>
Date: Mon, 08 May 2006 15:05:54 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC][patch] per-process data.
References: <17502.13773.674199.219762@domain.hid>	<445E637A.5080706@domain.hid>
	<17502.32006.418774.459215@domain.hid>
In-Reply-To: <17502.32006.418774.459215@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6D11A909621A1F3A5AD34BEC"
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
--------------enig6D11A909621A1F3A5AD34BEC
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Likely I did not yet get the full picture: What prevents using anoth=
er
>  > adeos per-task key for this?=20
>=20
> We would need a per-task key for every skin that needs a per-process
> data,

Not necessarily, we could attach a chain of per-skin data objects to the
key pointer.

> but more importantly, we would need to track the clone syscalls
> (that would be another adeos event) in order to propagate the per-task
> data to each thread of the process. Or maybe ptds are inherited upon
> clone ?

Ok, I see the problem, no hook to save here.

>=20
> And why is it required to establish a new
>  > termination hook? Are there scenarios where the existing
>  > task-termination hook is not suited for the planned cleanup work?
>=20
> Because the existing hook is called once for every thread exit, whereas=

> the pexit event get triggered when the last thread of a process exits,
> this is the only moment we are sure we can destroy per-process data.
>=20
> Using the existing hook, we would need to decrement a reference counter=

> in the hook, but then we would (again) need to track the clone syscalls=

> in order to increment the reference counter.
>=20
> Both implementations require to add an adeos event, the one I chose, if=

> it works, avoid reference counting.
>=20

My motivation for suggesting the keys were avoiding the
hash-table-lookup for mm structs. If we maintain some pointer on a
per-thread basis, we would only have to walk over all skins, not all
colliding elements in a hash chain.

I cannot show any code to compare both approaches w/ complexity and
efficiency. Maybe your approach is actually leaner, but my feeling is
that something based on per-task pointers might have advantages as well.

Moreover, having a clone hook may open further doors: establishing hooks
to clone shadow threads...

Jan


--------------enig6D11A909621A1F3A5AD34BEC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEX0IyniDOoMHTA+kRAtNDAJ9aNq1S7UgcGOe2HZS4ylWoiqgb9wCbBybg
kVbI8lxm2piy6mReFl4gXJ0=
=r6ZN
-----END PGP SIGNATURE-----

--------------enig6D11A909621A1F3A5AD34BEC--

