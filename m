Message-ID: <44B8A259.1040608@domain.hid>
Date: Sat, 15 Jul 2006 10:07:53 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] fix xnheap_alloc rounding
References: <44B3AF69.4050100@domain.hid> <1152928135.5027.60.camel@domain.hid>
In-Reply-To: <1152928135.5027.60.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD6195BE020E440A2CE432725"
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
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD6195BE020E440A2CE432725
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Tue, 2006-07-11 at 16:02 +0200, Jan Kiszka wrote:
>> Hi,
>>
>> playing a stupid rt_heap user (actually I didn't just play this...), I=

>> stumbled over this undocumented oddity:
>>
>> rt_heap_create(&heap, name, 10000, H_PRIO|H_MAPPABLE);
>> rt_heap_alloc(&heap, 10000, TM_NONBLOCK, &ptr);
>>
>> Creation is successful, allocation fails. The reason: while during
>> creation the net heap size is rounded down to page boundaries, the
>> allocation of memory > PAGE_SIZE is rounded up. One could add H_SINGLE=

>> to the flags, but this may even result in allocating less memory than
>> the user expected, causing severe problems later.
>>
>> How to resolve this best? I thought about rounding twice in
>> rt_head_create (one time the net size, the second time including the
>> overhead), but this encodes characteristics of the underlying heap
>> allocator into the skin (I have a generic heap allocator framework in
>> mind for 2.3).
>=20
> The nucleus heap expects the caller to pass it the memory which is goin=
g
> to be used to fulfill allocation requests, so there is already a builti=
n
> dependency from any client heap manager on the nucleus implementation.
> Double rounding is therefore the way to go, since callers need to be
> fixed so that they provide enough memory to the xnheap manager when
> specializing its behaviour.

If this means to do the rounding in the clients without the help of some
well-defined xnheap-API, then I disagree. I have an alternative nucleus
heap manager in mind for the future that will have a different rounding
strategy for allocations. So we should cleanly hide such property behind
a xnheap service - either in the overhead calculation or in some
additional rounding service. But I do not see a need for splitting this
up yet.

>=20
>>  So I decided to do this rounding in xnheap_overhead()
>> instead, see attached patch. Hope I didn't skewed up any calculation. =
At
>> least the scenario above now works fine.
>>
>> Jan
>> plain text document attachment (xnheap_overhead-fix-rounding.patch)
>> Index: include/nucleus/heap.h
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- include/nucleus/heap.h	(revision 1322)
>> +++ include/nucleus/heap.h	(working copy)
>> @@ -109,8 +109,14 @@ extern xnheap_t kheap;
>>  #define xnheap_used_mem(heap)        ((heap)->ubytes)
>>  #define xnheap_max_contiguous(heap)  ((heap)->maxcont)
>>  #define xnheap_overhead(hsize,psize) \
>> -((sizeof(xnextent_t) + (((hsize) - sizeof(xnextent_t)) / (psize)) + \=

>> - XNHEAP_MINALIGNSZ - 1) & ~(XNHEAP_MINALIGNSZ - 1))
>> +({ \
>> +    u_long rounded_hsize =3D (hsize + psize - 1) & ~(psize - 1); \
>> +    u_long overhead =3D ((sizeof(xnextent_t) + \
>> +	(((rounded_hsize) - sizeof(xnextent_t)) / (psize)) + \
>> +	XNHEAP_MINALIGNSZ - 1) & ~(XNHEAP_MINALIGNSZ - 1)); \
>> +    overhead +=3D rounded_hsize - hsize; \
>> +    overhead; \
>> +})
>> =20
>>  #define xnmalloc(size)     xnheap_alloc(&kheap,size)
>>  #define xnfree(ptr)        xnheap_free(&kheap,ptr)
>> _______________________________________________
>> Xenomai-core mailing list
>> Xenomai-core@domain.hid
>> https://mail.gna.org/listinfo/xenomai-core



--------------enigD6195BE020E440A2CE432725
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEuKJZniDOoMHTA+kRAuNQAJ0TTt4cS5tPbSE8huFmQkpI0z9XdQCeO1+R
mCsCiKPmfm8ddhMfmMVNwvI=
=A2/y
-----END PGP SIGNATURE-----

--------------enigD6195BE020E440A2CE432725--

