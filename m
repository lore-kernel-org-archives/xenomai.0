Message-ID: <44B29100.4070206@domain.hid>
Date: Mon, 10 Jul 2006 19:40:16 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] memset of heap crashes Xenomai-Task
References: <5D63919D95F87E4D9D34FF7748CE2C2A3F91A5@domain.hid>
	<17586.28969.44700.753766@domain.hid>
In-Reply-To: <17586.28969.44700.753766@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6AFEAB58666B7ED358B29504"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Roderik_Wildenburg@domain.hid, xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6AFEAB58666B7ED358B29504
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Roderik_Wildenburg@domain.hid wrote:
>  > Xenomai Version : 2.2-rc2
>  > Skin : native
>  > Kernel : 2.4.25
>  > Arch.: PPC
>  >=20
>  > I try to allocate as much memory as possible with the functions :
>  > rt_heap_create and
>  > rt_heap_alloc.
>  > (see also "Xenomai heap services" in this mailing list; see source
>  > attached)
>  >=20
>  > When I try to use the allocated memory with memset, the Xenomai-task=

>  > crashes with a "Segmentation fault".
>  >=20
>  > Is memset allowed to be used with Xenomai heaps ?
>=20
> memset should work with Xenomai heaps, I suspect your problem is rather=

> that the memory is not really allocated until you memset it, which fail=
s
> when no memory is available. In this case, calling memset on memory
> allocated with malloc should segfault the same way when the system
> memory is exhausted. IIRC, this behaviour is documented in mlockall
> manual page.

I wonder if this "virtual allocation" also applies to vmalloc'ed memory
like in this case. I don't think so, or the kernel would oops as well.

>=20
> Be careful with sysconf(_SC_AVPHYS_PAGES), it may include the swap size=
,
> but when mlocking memory, your application can not use swap pages, so,
> you should substract the size of swap, if any.
> Also, what is the value of /proc/sys/vm/overcommit_memory on your syste=
m
> ?
>=20

Jan


--------------enig6AFEAB58666B7ED358B29504
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEspEAniDOoMHTA+kRAhmGAJ90DPVT0PVnaZSpy9NJmJhhJBY2CQCfW6eI
/zGDl1W5ydiFmXy+aMyrLbQ=
=z0l+
-----END PGP SIGNATURE-----

--------------enig6AFEAB58666B7ED358B29504--

