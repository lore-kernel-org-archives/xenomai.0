Message-ID: <440205C3.80900@domain.hid>
Date: Sun, 26 Feb 2006 20:47:15 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2C957287A118D29284262EBF"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] set VM_RESERVED for remapped mem
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
--------------enig2C957287A118D29284262EBF
Content-Type: multipart/mixed; boundary="------------000006090807020603080303"

This is a multi-part message in MIME format.
--------------000006090807020603080303
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

while reviewing my own rtdm_mmap-code again, I noticed that the wrapped
remap_pfn_range() sets VM_RESERVED (+ some other bits) on the passed vma
while the compatibility function remap_page_range() doesn't do this.
This flag seems to exclude the vma from swapping considerations.

Adding the bit to the wrapper appears to me as the best way to catch
this on older kernels. And this should also make the VM_LOCKED setting
obsolete in nucleus/heap.c.

Feel free to correct/enlighten me.

Jan

--------------000006090807020603080303
Content-Type: text/x-patch;
 name="set-VM_RESERVED.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="set-VM_RESERVED.patch"

Index: include/asm-generic/wrappers.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-generic/wrappers.h	(Revision 600)
+++ include/asm-generic/wrappers.h	(Arbeitskopie)
@@ -46,8 +46,10 @@
 #define module_param_named(name,var,type,mode)  module_param(var,type,mo=
de)
=20
 /* VM */
-#define wrap_remap_page_range(vma,from,to,size,prot) \
-    remap_page_range(from,to,size,prot)
+#define wrap_remap_page_range(vma,from,to,size,prot) do { \
+    vma->flags |=3D VM_RESERVED; \
+    remap_page_range(from,to,size,prot); \
+} while (0)
 #define wrap_switch_mm(prev,next,task)	\
     switch_mm(prev,next,task,(task)->processor)
 #define wrap_enter_lazy_tlb(mm,task)	\
@@ -145,8 +147,10 @@
 #define wrap_remap_page_range(vma,from,to,size,prot)  \
     remap_pfn_range(vma,from,(to) >> PAGE_SHIFT,size,prot)
 #else /* LINUX_VERSION_CODE < KERNEL_VERSION(2,6,10) */
-#define wrap_remap_page_range(vma,from,to,size,prot)  \
-    remap_page_range(vma,from,to,size,prot)
+#define wrap_remap_page_range(vma,from,to,size,prot) do { \
+    vma->flags |=3D VM_RESERVED; \
+    remap_page_range(vma,from,to,size,prot); \
+} while (0)
 #endif /* LINUX_VERSION_CODE >=3D KERNEL_VERSION(2,6,10) */
 #define wrap_switch_mm(prev,next,task)	\
     switch_mm(prev,next,task)
Index: ksrc/nucleus/heap.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/nucleus/heap.c	(Revision 600)
+++ ksrc/nucleus/heap.c	(Arbeitskopie)
@@ -948,7 +948,6 @@
 	return -ENXIO;	/* Doesn't match the heap size. */
        =20
     vma->vm_ops =3D &xnheap_vmops;
-    vma->vm_flags |=3D VM_LOCKED;	/* Don't swap this out. */
     vma->vm_private_data =3D file->private_data;
=20
     vaddr =3D (unsigned long)heap->archdep.heapbase;

--------------000006090807020603080303--

--------------enig2C957287A118D29284262EBF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEAgXDniDOoMHTA+kRAqinAJ4ymonsv90vAVHv65beBL61iKB8GQCfVSi8
qOAd6sqEL5Vpb/c31VKhnNk=
=PNeb
-----END PGP SIGNATURE-----

--------------enig2C957287A118D29284262EBF--

