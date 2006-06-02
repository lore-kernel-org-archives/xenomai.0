Message-ID: <44802CA1.3050301@domain.hid>
Date: Fri, 02 Jun 2006 14:18:41 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <447F72A0.8000000@domain.hid>
	<17536.10247.604874.412137@domain.hid>
In-Reply-To: <17536.10247.604874.412137@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB104B0EEE1B7197548C55F8F"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: [patch] static buffer for timer-bheap
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
--------------enigB104B0EEE1B7197548C55F8F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Hi,
>  >=20
>  > this patch moves the heap for scalable timer queues into the xnpod_t=

>  > structure instead of allocating it dynamically. This simplifies the =
pod
>  > initialisation and cleanup, which was not fully robust in this regar=
d
>  > anyway. If a pod is now considered too large (but we are discussion
>  > kbytes here), allocating its buffer via xnarch_sysalloc would be an =
option.
>  >=20
>  > In case this patch is acceptable, I would suggest merging it before =
2.2
>  > due to the contained (minor) fix.
>=20
> Since this memory is specific to the data structure, its allocation
> seems better by the data structure functions. It also make the binary
> heap structure reusable for other purposes.

That's what I added the DECLARE_BHEAP_CONTAINER macro for. Sorry, did
not mention this.

The idea is to leave the allocation policy up to the user instead of
enforcing it in the bheap layer. The current approach also implicitly
excludes its usage from RT contexts, BTW.

>=20
> Could you explain why the current scheme is not robust ?
>=20

Given a SMP system where the allocation fails right in the middle of the
per-CPU loop [1], cleanup will not be performed for already allocated hea=
ps.

Jan


[1]http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/pod.c?v=
=3DSVN-trunk#L432


--------------enigB104B0EEE1B7197548C55F8F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEgCyhniDOoMHTA+kRAq29AJ9RuuDY4CMyPHKiVfK5QpDn91oRLwCdGvUX
GQvslLFRlyGjznBRgMpZtuI=
=Gkcl
-----END PGP SIGNATURE-----

--------------enigB104B0EEE1B7197548C55F8F--

