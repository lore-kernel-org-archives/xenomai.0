Message-ID: <439C7F72.90809@domain.hid>
Date: Sun, 11 Dec 2005 20:35:14 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Extensible heaps - needed for the future?
References: <439C654F.9080805@domain.hid> <439C6CB9.6050605@domain.hid>
In-Reply-To: <439C6CB9.6050605@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD3A59C2438293A08914C8744"
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD3A59C2438293A08914C8744
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
> Jan Kiszka wrote:
> 
>> Hi,
>>
>> I noticed that xnhead_extend() is not used at the moment [1], thus the
>> whole extent management is redundent for now. Are there plans to use it
>> in the future? Should we keep this feature?
>>
>> I'm asking as I still have the idea in my head of breaking up the heap
>> service and introducing a generic allocator interface to select
>> different heap allocators at compile time. So, should extensions be an
>> optional feature of an allocator?
> 
> 
> Keep in mind that the native API is a plain client of the abstract RTOS
> implemented by the nucleus, nothing more. What the native API does not
> use in this area would probably be useful to other clients though. For
> instance, the VRTX skin locally reimplements its own heap extension
> system that could be replaced by the nucleus one -- and should.
> 

I did not get your point yet. To ask more directly: what functionality
should a generic real-time allocator for arbitrary size objects should
provide then?

We currently have this situation regarding the heap core:

    xnheap_init(heap, heap_memory, heap_size, page_size)
    xnheap_destroy(heap, flush_handler, handler_cookie)

    xnheap_extend(heap, extent_memory, extent_size)

    block = xnheap_alloc(heap, size)
    xnheap_test_and_free(heap, block, release_check_function)

I did not list the other functions, which are more or less wrappers
around this core (i.e. they do not need to know how the heap memory is
managed internally).

For now I have two open topics on my list:

 o page_size is BSD-allocator specific, other algorithms may need other
   arguments. We will likely rather need good defaults (isn't the
   system's page size passed here anyway?) and maybe some other
   interface to tune them.

 o As far as I understood, xnhead_extend() adds another chunk of memory
   to an existing heap. That chunk is additionally considered when
   allocating some block from that heap. Side effect: the more chunks
   you add, the longer a search may become. As I did not find any user
   of this feature and as this inherent O(n) regarding the allocation
   requires careful usage anyway, I was wondering if it is actually
   useful. If a real-time heap is too small, I would rather reserve more
   initial size (just like XENO_OPT_SYS_HEAPSZ works).

Jan

--------------enigD3A59C2438293A08914C8744
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDnH9yniDOoMHTA+kRArsUAJ94Sh7LyNTwYhQjsZYKDk2RWcnZ8QCfQEpN
nCGRln4z76+7yki4AQ27GYo=
=oH3y
-----END PGP SIGNATURE-----

--------------enigD3A59C2438293A08914C8744--

