Message-ID: <44B4ED32.8040201@domain.hid>
Date: Wed, 12 Jul 2006 14:38:10 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] fix xnheap_alloc rounding
References: <44B3AF69.4050100@domain.hid>
	<17588.60046.972123.383913@domain.hid>
In-Reply-To: <17588.60046.972123.383913@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig209C6F98E68F0AA751C15563"
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig209C6F98E68F0AA751C15563
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Hi,
>  >=20
>  > playing a stupid rt_heap user (actually I didn't just play this...),=
 I
>  > stumbled over this undocumented oddity:
>  >=20
>  > rt_heap_create(&heap, name, 10000, H_PRIO|H_MAPPABLE);
>  > rt_heap_alloc(&heap, 10000, TM_NONBLOCK, &ptr);
>  >=20
>  > Creation is successful, allocation fails. The reason: while during
>  > creation the net heap size is rounded down to page boundaries, the
>  > allocation of memory > PAGE_SIZE is rounded up. One could add H_SING=
LE
>  > to the flags, but this may even result in allocating less memory tha=
n
>  > the user expected, causing severe problems later.
>  >=20
>  > How to resolve this best? I thought about rounding twice in
>  > rt_head_create (one time the net size, the second time including the=

>  > overhead), but this encodes characteristics of the underlying heap
>  > allocator into the skin (I have a generic heap allocator framework i=
n
>  > mind for 2.3). So I decided to do this rounding in xnheap_overhead()=

>  > instead, see attached patch. Hope I didn't skewed up any calculation=
=2E At
>  > least the scenario above now works fine.
>=20
> The problem I see with this patch is that you are counting=20
> (rounded_hsize - hsize) as part of the overhead, whereas you would like=
 to
> count it as free space. Would not it make more sense to do the rounding=

> in xnheap_init_mapped ?
>=20

I was thinking of the open-coded

allocate(heap_size + xnheap_overhead)
xnheap_init()

in many skins as well.

Jan


--------------enig209C6F98E68F0AA751C15563
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEtO0yniDOoMHTA+kRAsYMAJ9KvdhUARaPeow5ETp6zYYLGEDqCgCeOojb
wZyfkSzhX/16KnRdTJhQgaE=
=wg0j
-----END PGP SIGNATURE-----

--------------enig209C6F98E68F0AA751C15563--

