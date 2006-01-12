Message-ID: <43C6E2E5.4080900@domain.hid>
Date: Fri, 13 Jan 2006 00:14:45 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RT Heap in Userspace
References: <200601121136.38271.s.zimmermann@domain.hid>
In-Reply-To: <200601121136.38271.s.zimmermann@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1FF90A6B3ED416B559DB38E3"
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
To: Stephan Zimmermann <s.zimmermann@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1FF90A6B3ED416B559DB38E3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Stephan Zimmermann wrote:
> Hello again,
> based on your information about memory allocation, I tried out the foll=
owing:
>=20
> in main:
> // creating the Heap
> ret =3D rt_heap_create(&rt_heap,"Main-RT-Heap",rt_heapsize,H_FIFO);
>=20
> global:
> // overloaded operator new=20
> void* operator new(size_t size){
> 	void* newmem =3D NULL;
> 	int ret =3D rt_heap_alloc(&rt_heap,size,TM_INFINITE,&newmem);
> 	printf("new memory allocated: %i bytes, return %i\n",size,ret); fflush=
(NULL);
> 	return newmem;
> }
>=20
> This works fine, as long as I use a standard 'malloc' in my operator ne=
w. When=20
> executing the rt_... code, creating the heap returns 0 as expected. But=
=20
> trying to allocate some Memory insode of it using operator new fails wi=
th=20
> -EEINVAL.
>=20
> Reading the API-Doc more thoroughly, I saw a statement that H_SHARED is=
=20
> implicitly set, when a heap is created from Userspace (where my program=
=20
> executes).
> So, is ist possible to do what I try, or will I need to run in kernelsp=
ace for=20
> it? Maybe there is some 'trick' to do it?
>=20

If you do not depend on sharing the allocated memory between multiple
processes or kernel and user space, you may want to take a look at this
deterministic allocator library:

http://rtportal.upv.es/rtmalloc/allocators/tlsf/index.shtml

Should be straightforward to use it (at least it was with a previous
version I once tried).

Jan


--------------enig1FF90A6B3ED416B559DB38E3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDxuLlniDOoMHTA+kRAtmlAJ4nU+PhBEJR1bHLI12uIrkr4EfhsgCfbSH0
WRAbaoPpwWMbQOSasaLmj5Y=
=BzoI
-----END PGP SIGNATURE-----

--------------enig1FF90A6B3ED416B559DB38E3--

