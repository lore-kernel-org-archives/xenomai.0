Message-ID: <439C63A4.3080309@domain.hid>
Date: Sun, 11 Dec 2005 18:36:36 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [bug] vfree/kfree under hard IRQ locks
References: <439C18EC.1070500@domain.hid> <439C3A32.8020405@domain.hid>
In-Reply-To: <439C3A32.8020405@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig45BA03C36CA8D023438DD815"
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
--------------enig45BA03C36CA8D023438DD815
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
> Jan Kiszka wrote:
> 
>> Hi,
>>
>> I happened to stumble over this comment[1]. It made me curious,
>> especially as it is not totally correct (the loop is executed in IRQ-off
>> context, thus it *is* timecritical).
>>
> 
> Critical should be understood here in the sense that IRQs are off while
> the loop workload is high, which is fortunately not the case. Hence the
> comment.

Sure, there is not much to do inside the loop. But it does not scale
very well in case a significant number of elements are registered - and
they are scattered over a larger memory area so that cache missed strike us.

It's a bit theoretical, but I also think we can easily resolve it by
using Linux locks as soon as we can sanely sleep inside
xnheap_init/destroy_shared and xnheap_ioctl.

> 
>> While thinking about the possibility to convert the hard IRQ lock
>> protection of kheapq into some Linux mutex or whatever, I analysed the
>> contexts the users of this queue (__validate_heap_addr/xnheap_ioctl,
>> xnheap_init_shared, xnheap_destroy_shared) execute in. Basically, it is
>> Linux/secondary mode, but there are unfortunate exceptions:
>>
>> rt_heap_delete(): take nklock[2], then call xnheap_destroy_shared()[3].
>> The latter will call __unreserve_and_free_heap()[4] which calls Linux
>> functions like vfree()[5] or kfree()[6] -- I would say: not good! At
>> least on SMP we could easily get trapped by non-deterministic waiting on
>> Linux spinlocks inside those functions.
>>
>> The same applies to rt_queue_delete()[7].
>>
> 
> Good spot. Better not calling the heap deletion routines under nklock
> protection in the first place. The committed fix does just that for both
> rt_heap_delete and rt_queue_delete.

Ok, we no longer have IRQs locked over vfree/kfree, but task scheduling
is still suffering from potential delays. Wouldn't it be better to defer
such operations to an asynchronous Linux call?

Jan

--------------enig45BA03C36CA8D023438DD815
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDnGOoniDOoMHTA+kRAi0WAJ0Xo1XCk8q85QHRGnsfng2x9qMS9wCeMdd9
DDET/Zo0rCdL9K9BpjZ4lQE=
=uY0J
-----END PGP SIGNATURE-----

--------------enig45BA03C36CA8D023438DD815--

