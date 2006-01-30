From: Stefan Kisdaroczi <kisda@domain.hid>
Date: Mon, 30 Jan 2006 23:11:33 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1353373.8XjP8BCRun";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601302311.48645.kisda@domain.hid>
Subject: [Xenomai-core] [PATCH] rt_heap reminder
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--nextPart1353373.8XjP8BCRun
Content-Type: multipart/mixed;
  boundary="Boundary-01=_V8o3D8BnqRRj8oO"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_V8o3D8BnqRRj8oO
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,

as a reminder (userspace, native skin, shared heap) [1]:
API documentation: "If the heap is shared, this value can be either zero, o=
r=20
the same value given to rt_heap_create()."
This is not true. As the heapsize gets altered in rt_heap_create for page s=
ize=20
alignment, the following call to rt_heap_alloc with the same value will fai=
l.

Ex:
rt_heap_create( ..., ..., 10000, ... )
rt_heap_alloc( ..., 10000, ..., .... ) -> This call fails

I suggest only accepting zero as a valid size for shared heaps.

about attached patch:
1) not tested
2) there are possible better names than H_ALL
3) the comments could be in a better english
4) i hope you get the idea

thx
kisda

[1] https://mail.gna.org/public/xenomai-core/2006-01/msg00177.html

--Boundary-01=_V8o3D8BnqRRj8oO
Content-Type: text/x-diff;
  charset="us-ascii";
  name="rt_heap.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="rt_heap.patch"

Index: include/native/heap.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- include/native/heap.h	(Revision 465)
+++ include/native/heap.h	(Arbeitskopie)
@@ -32,6 +32,9 @@
 #define H_DMA    0x100		/* Use memory suitable for DMA. */
 #define H_SHARED 0x200		/* Use mappable shared memory. */
=20
+/* Operation flags. */
+#define H_ALL    0x0	        /* Entire heap space. */
+
 typedef struct rt_heap_info {
=20
     int nwaiters;		/* !< Number of pending tasks. */
Index: ksrc/skins/native/heap.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- ksrc/skins/native/heap.c	(Revision 465)
+++ ksrc/skins/native/heap.c	(Arbeitskopie)
@@ -410,10 +410,9 @@
  * from.
  *
  * @param size The requested size in bytes of the block. If the heap
=2D * is shared, this value can be either zero, or the same value given
=2D * to rt_heap_create(). In any case, the same block covering the
=2D * entire heap space will always be returned to all callers of this
=2D * service.
+ * is shared, H_ALL should be passed, as always the same block
+ * covering the entire heap space will be returned to all callers of
+ * this service.
  *
  * @param timeout The number of clock ticks to wait for a block of
  * sufficient size to be available from a local heap (see
@@ -432,8 +431,7 @@
  * @return 0 is returned upon success. Otherwise:
  *
  * - -EINVAL is returned if @a heap is not a heap descriptor, or @a
=2D * heap is shared (i.e. H_SHARED mode) and @a size is non-zero but
=2D * does not match the actual heap size passed to rt_heap_create().
+ * heap is shared (i.e. H_SHARED mode) and @a size is not H_ALL.
  *
  * - -EIDRM is returned if @a heap is a deleted heap descriptor.
  *
@@ -503,12 +501,7 @@
=20
 	if (!block)
 	    {
=2D	    /* It's ok to pass zero for size here, since the requested
=2D	       size is implicitely the whole heap space; but if
=2D	       non-zero is given, it must match the actual heap
=2D	       size. */
=2D
=2D	    if (size > 0 && size !=3D xnheap_size(&heap->heap_base))
+	    if (size !=3D H_ALL)
 		{
 		err =3D -EINVAL;
 		goto unlock_and_exit;

--Boundary-01=_V8o3D8BnqRRj8oO--

--nextPart1353373.8XjP8BCRun
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD3o8kIPTw9rIdn6oRAiowAJ4nUjijNozXZC/ne/5PXyNv9uGTzwCfV7PJ
f1Ve9NG7dmZfeHAEk15HeZE=
=Tct/
-----END PGP SIGNATURE-----

--nextPart1353373.8XjP8BCRun--

