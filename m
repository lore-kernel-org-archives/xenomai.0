Message-ID: <44B3AF69.4050100@domain.hid>
Date: Tue, 11 Jul 2006 16:02:17 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD86B9CBEE8A4F2F2E42D2920"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] fix xnheap_alloc rounding
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
--------------enigD86B9CBEE8A4F2F2E42D2920
Content-Type: multipart/mixed; boundary="------------040701060503040004090900"

This is a multi-part message in MIME format.
--------------040701060503040004090900
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

playing a stupid rt_heap user (actually I didn't just play this...), I
stumbled over this undocumented oddity:

rt_heap_create(&heap, name, 10000, H_PRIO|H_MAPPABLE);
rt_heap_alloc(&heap, 10000, TM_NONBLOCK, &ptr);

Creation is successful, allocation fails. The reason: while during
creation the net heap size is rounded down to page boundaries, the
allocation of memory > PAGE_SIZE is rounded up. One could add H_SINGLE
to the flags, but this may even result in allocating less memory than
the user expected, causing severe problems later.

How to resolve this best? I thought about rounding twice in
rt_head_create (one time the net size, the second time including the
overhead), but this encodes characteristics of the underlying heap
allocator into the skin (I have a generic heap allocator framework in
mind for 2.3). So I decided to do this rounding in xnheap_overhead()
instead, see attached patch. Hope I didn't skewed up any calculation. At
least the scenario above now works fine.

Jan

--------------040701060503040004090900
Content-Type: text/plain;
 name="xnheap_overhead-fix-rounding.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="xnheap_overhead-fix-rounding.patch"

Index: include/nucleus/heap.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/nucleus/heap.h	(revision 1322)
+++ include/nucleus/heap.h	(working copy)
@@ -109,8 +109,14 @@ extern xnheap_t kheap;
 #define xnheap_used_mem(heap)        ((heap)->ubytes)
 #define xnheap_max_contiguous(heap)  ((heap)->maxcont)
 #define xnheap_overhead(hsize,psize) \
-((sizeof(xnextent_t) + (((hsize) - sizeof(xnextent_t)) / (psize)) + \
- XNHEAP_MINALIGNSZ - 1) & ~(XNHEAP_MINALIGNSZ - 1))
+({ \
+    u_long rounded_hsize =3D (hsize + psize - 1) & ~(psize - 1); \
+    u_long overhead =3D ((sizeof(xnextent_t) + \
+	(((rounded_hsize) - sizeof(xnextent_t)) / (psize)) + \
+	XNHEAP_MINALIGNSZ - 1) & ~(XNHEAP_MINALIGNSZ - 1)); \
+    overhead +=3D rounded_hsize - hsize; \
+    overhead; \
+})
=20
 #define xnmalloc(size)     xnheap_alloc(&kheap,size)
 #define xnfree(ptr)        xnheap_free(&kheap,ptr)

--------------040701060503040004090900--

--------------enigD86B9CBEE8A4F2F2E42D2920
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEs69pniDOoMHTA+kRAmHzAJ9+g8OVFbLi3w+v2lF4G6TELbB8fQCdGBAx
BYm8ODZF0ZWAjK6mmHxGEdA=
=RpKu
-----END PGP SIGNATURE-----

--------------enigD86B9CBEE8A4F2F2E42D2920--

