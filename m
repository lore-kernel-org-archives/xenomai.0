Message-ID: <439C18EC.1070500@domain.hid>
Date: Sun, 11 Dec 2005 13:17:48 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF19EB92308E488FB928BF585"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [bug] vfree/kfree under hard IRQ locks
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF19EB92308E488FB928BF585
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi,

I happened to stumble over this comment[1]. It made me curious,
especially as it is not totally correct (the loop is executed in IRQ-off
context, thus it *is* timecritical).

While thinking about the possibility to convert the hard IRQ lock
protection of kheapq into some Linux mutex or whatever, I analysed the
contexts the users of this queue (__validate_heap_addr/xnheap_ioctl,
xnheap_init_shared, xnheap_destroy_shared) execute in. Basically, it is
Linux/secondary mode, but there are unfortunate exceptions:

rt_heap_delete(): take nklock[2], then call xnheap_destroy_shared()[3].
The latter will call __unreserve_and_free_heap()[4] which calls Linux
functions like vfree()[5] or kfree()[6] -- I would say: not good! At
least on SMP we could easily get trapped by non-deterministic waiting on
Linux spinlocks inside those functions.

The same applies to rt_queue_delete()[7].

To clarify the relevance: These issues only concern the native skin, and
they only hit during init and cleanup. Anyway, should get fixed.

Jan


[1]http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/heap.c?v=SVN-trunk#L845
[2]http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/skins/native/heap.c?v=SVN-trunk#L353
[3]http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/skins/native/heap.c?v=SVN-trunk#L365
[4]http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/heap.c?v=SVN-trunk#L1157
[5]http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/heap.c?v=SVN-trunk#L1092
[6]http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/heap.c?v=SVN-trunk#L1100
[7]http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/skins/native/queue.c?v=SVN-trunk#L338


--------------enigF19EB92308E488FB928BF585
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDnBjzniDOoMHTA+kRAnqXAJ9UZhioLz7R3Sx3rPyUPiTRB0w93gCfdpvA
Io7Zqpf/FbsjnyRPJaMMM1c=
=3+KG
-----END PGP SIGNATURE-----

--------------enigF19EB92308E488FB928BF585--

