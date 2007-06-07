Message-ID: <46688B0A.8010909@domain.hid>
Date: Fri, 08 Jun 2007 00:47:38 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <200706071049.32906.ngustavson@domain.hid>	
	<200706071311.09891.ngustavson@domain.hid>
	<46684CCB.8010806@domain.hid>	
	<200706071337.07691.ngustavson@domain.hid>
	<46685C21.5020709@domain.hid> <1181255358.4998.202.camel@domain.hid>
In-Reply-To: <1181255358.4998.202.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD5FDCBFE41D62D5119193CD7"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Fwd: can't use message pipe - Cannot allocate
 memory
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD5FDCBFE41D62D5119193CD7
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Thu, 2007-06-07 at 21:27 +0200, Jan Kiszka wrote:
>> NZG wrote:
>>>>> Write does stop throwing errors with a pool of 16384.
>>>> Just repeating for confirmation: rt_pipe_create with smaller, but
>>>> non-zero pool sizes doesn't report some error?=20
>>> Incorrect, if it's created with smaller it does report an error. If i=
t's=20
>>> created with 0 however, it seems ok. (at least it doesn't throw an er=
ror)
>> You mean the write fails, but rt_pipe_create is fine. At least here, a=
nd
>> Philippe noticed the same. Looks like the margin for minimal-sized hea=
ps
>> is broken. 2*PAGE_SIZE should be 3*PAGE_SIZE net space, Philippe?
>=20
> Actually, rt_pipe_create() already rounds this value to 3*PAGE_SIZE,
> right before calling the sysalloc service.
>=20
> Here is the sequence of events that leads to the situation Nathan is
> seeing:
>=20
> - Passing poolsize =3D 1024 to rt_pipe_create() creates a local heap of=

> 12288 bytes (3 * PAGE_SZ), with 32 bytes of overhead taken from one of
> these pages to hold the meta-data.
>=20
> - 4112 bytes (4096 + sizeof(message header)) are then requested to this=

> local pool to hold the internal streaming buffer
> (XENO_OPT_NATIVE_PIPE_BUFSZ), which ends up consuming two pages, i.e.
> 8192 bytes, from this pool. The reason for this is due to the way the
> McKusick allocation scheme we use works; basically, block sizes greater=

> than the page size are always rounded to a multiple of the page size.
> Requested block sizes are always rounded up to the nearest power of two=
,
> which the allocator groups in pages holding blocks of the same size.
> This is not pretty wrt internal fragmentation, but quite efficient
> CPU-wise, when the page size is properly chosen wrt the most common
> allocation pattern, that is. Most importantly, blocks greater than a
> page will never lay on partially consumed pages (by other blocks). So,
> in our case, we started with three free pages, one already holds some
> meta-data, and we need two pages to fullfil the current allocation
> request. Therefore, after this request has suceeded, we have no page
> left in the pool.
>=20
> - When the write() call is issued, the pipe driver requests a 32 bytes
> block to hold the data moving from user-space to kernel space. Too bad,=

> we have no other page left to dedicate to blocks holding that size, so
> no block is available, which in turn causes write() to return -ENOMEM.

Ah, I see.

>=20
> This situation illustrates the conflict which is raised when small heap=
s
> (1k) are mapped on large page sizes (4k). Even when rounding them to a
> (small) multiple of the page size, the pool might rapidly run short of
> free pages, depending on the allocation pattern.

Reminds me of the TLSF allocator claiming to perform smartly also on
smaller hunks. But that code is still 32-bit-focused, and would still
need someone to define and run comparative tests on representative
Xenomai setups. :-/

>=20
> IOW, when configuring a heap, it is better to know which kind of block
> sizes are going to be requested from it, and reserve the appropriate
> number of pages for each different size when evaluating the total size
> of the heap.
>=20
> Yes, it's not that simple. No, I'm not that sorry.
>=20

For now, can we take XENO_OPT_NATIVE_PIPE_BUFSZ into account when
picking a reasonable minimum size in rt_pipe_create on behalf of a
close-fisted user?

Jan


--------------enigD5FDCBFE41D62D5119193CD7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGaIsKniDOoMHTA+kRAqPsAJ44nea717l0HacB6a9GK32vuRUJ/QCeN9Q5
WEH2AS7ZI41R/Tx3OYATZ8M=
=pSKq
-----END PGP SIGNATURE-----

--------------enigD5FDCBFE41D62D5119193CD7--

