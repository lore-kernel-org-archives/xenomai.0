Message-ID: <455E022D.2000306@domain.hid>
Date: Fri, 17 Nov 2006 19:40:45 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <b647ffbd0611111559y8e66c37m12deb64828a85d08@domain.hid>
In-Reply-To: <b647ffbd0611111559y8e66c37m12deb64828a85d08@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6EFFEF698B1E6CA0182593B8"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: [patch] memory barriers in intr.c ::
	xnintr_lock/unlock()
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>, Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6EFFEF698B1E6CA0182593B8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
> ...
> In case of linux, smp_mb__after_atomic_inc() and
> smp_mb__before_atomic_dec()
> would do the job. But so far, I decided not to add something like
> xnarch_memory_barrier__after_atomic_inc() :) , provided that both seem =
to
> end up being either mb() or barrier() at the same time (have to check m=
ore
> thoroughly) anyway.
>=20
> Any suggestions?

As we now know that this patch actually solves a real issue on SMP
(tested by Paolo in RTAI's RTDM variant recently), I would say /some/
form of it should quickly go into the branches.

Actually, this kind of locking via reference counter, may it be atomic
or per-cpu, is a generic pattern for many (RCU-like) use cases. We have
it in RTnet (and I guess it's broken there as well, sigh), and I could
imagine to use it more broadly in the future. This means we should think
about a generic interface (to reduce the probability to use it the wrong
way around...). And for such an interface, we will have a need of
efficient memory barriers.

I see two paths now:

A) If we go for atomic_inc/dec with such locking service,
xnarch_memory_barrier__after_atomic_inc & friends will be needed anyway
and could be already introduced now.

B) If we aim at per-cpu counters (complicates things, but SMP clearly
benefits), we may simply merge Dmitry's patch as is.

Any thoughts?

Jan


--------------enig6EFFEF698B1E6CA0182593B8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFXgItniDOoMHTA+kRAptzAJ9G81BWHoPeOgQcAKyMQ7rZQYW+wQCfRRJZ
jNUjSYZLDwUw0iR/rbKsej4=
=g7ZR
-----END PGP SIGNATURE-----

--------------enig6EFFEF698B1E6CA0182593B8--

