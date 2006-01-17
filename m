From: Stefan Kisdaroczi <kisda@domain.hid>
Subject: Re: [Xenomai-core] rt_heap in userspace, heapsize [patch]
Date: Tue, 17 Jan 2006 22:37:47 +0100
References: <43CCF7C2.6070403@domain.hid>
In-Reply-To: <43CCF7C2.6070403@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3653500.7y9pJvtYna";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601172237.56905.kisda@domain.hid>
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

--nextPart3653500.7y9pJvtYna
Content-Type: multipart/mixed;
  boundary="Boundary-01=_rOWzDeY/I1NErdt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_rOWzDeY/I1NErdt
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi again,

I looked at the sources now...

Am Tuesday 17 January 2006 14:57 schrieb Stefan Kisdaroczi:
> Hi,
>
> I made a small test with rt_heap_ in userspace,
> i think I understood the actual limitations of the userspace support.
> I used 10000 as heapsize. Xenomai 2.1-RC2/x86.
>
> This should alloc the entire heap, according to the API documentation:
> rt_heap_create( ..., ..., 10000, ... )
> rt_heap_alloc( ..., 10000, ..., .... ) -> This call fails, but it should
> work
API documentation: "If the heap is shared, this value can be either zero, o=
r=20
the same value given to rt_heap_create()."

Looking at the code, calculating the right value can be tricky and would=20
depend on xeno-internals. rt_heap_inquire would be another way to get it.

Only accepting 0 would be less confusing. See (untested) patch as as=20
suggestion.

> Using heapsize 0 it works:
> rt_heap_create( ..., ..., 10000, ... )
> rt_heap_alloc( ..., 0, ..., .... )
>
> rt_heap_inquire shows a heapsize of 12228 (IIRC).
> So, this would probably work (untested):
> rt_heap_create( ..., ..., 10000, ... )
> rt_heap_alloc( ..., 12228, ..., .... )
>
> The 2228 bytes difference seems to be the space needed for the heap contr=
ol
> structures.
>
> I think the following should be fixed:
> 1) rt_create_alloc should alter the heapsize the same as rt_heap_create
> does=20
Makes no sense, after looking at the code.

> > 2) rt_heap_inquire should return the _real_ heapsize=20
The real heap space can be bigger than the requested, so this can happen.

thx again
kisda

--Boundary-01=_rOWzDeY/I1NErdt
Content-Type: text/x-diff;
  charset="utf-8";
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

--Boundary-01=_rOWzDeY/I1NErdt--

--nextPart3653500.7y9pJvtYna
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDzWO0IPTw9rIdn6oRAnZFAJ0ZmaRP6/t1YbtCcGCqaRbJ6eg6hQCeKB64
1z803D4IzXblMGY95H5Md3w=
=K1L5
-----END PGP SIGNATURE-----

--nextPart3653500.7y9pJvtYna--

