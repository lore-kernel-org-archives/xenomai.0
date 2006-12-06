Message-ID: <45774C35.3070101@domain.hid>
Date: Thu, 07 Dec 2006 00:03:17 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <b647ffbd0611111559y8e66c37m12deb64828a85d08@domain.hid>
In-Reply-To: <b647ffbd0611111559y8e66c37m12deb64828a85d08@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFA8211A2252CD54C83378220"
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
To: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFA8211A2252CD54C83378220
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
> Hello,
>=20
> following the recent discussion with Jan, here is a patch that aims at
> allowing xnintr_lock/unlock actually do what they were supposed to do i=
n
> the first instance.
>=20

[...]

>=20
> --- xenomai/ksrc/nucleus/intr-old.c	2006-11-12 00:17:56.000000000 +0100=

> +++ xenomai/ksrc/nucleus/intr.c	2006-11-12 00:22:15.000000000 +0100
> @@ -135,12 +135,14 @@ static inline void xnintr_shirq_lock(xni
>  {
>  #ifdef CONFIG_SMP
>  	xnarch_atomic_inc(&shirq->active);
> +	xnarch_memory_barrier();
>  #endif
>  }
> =20
>  static inline void xnintr_shirq_unlock(xnintr_shirq_t *shirq)
>  {
>  #ifdef CONFIG_SMP
> +	xnarch_memory_barrier();
>  	xnarch_atomic_dec(&shirq->active);
>  #endif
>  }

As Dmitry and I are still a bit undecided about who to evolve such RCU
locks best but still face this SMP bug in the current code, we are
suggesting now to merge the patch above as-is for 2.3 - before things
get lost for the release.

Jan


--------------enigFA8211A2252CD54C83378220
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFd0w1niDOoMHTA+kRAnU3AJ9PGTUuRNOaOX0CH0c4lyywFd7nFACaAkTK
TE9srpwhUPzx+sqm04llFCs=
=aDLC
-----END PGP SIGNATURE-----

--------------enigFA8211A2252CD54C83378220--

