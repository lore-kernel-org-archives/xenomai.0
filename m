Message-ID: <45100DF6.8030209@domain.hid>
Date: Tue, 19 Sep 2006 17:34:14 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] 	[PATCH, RFC] Make ioremap'ed memory available
	through	rtdm_mmap_to_user()
References: <1158337583.13530.20.camel@domain.hid>	
	<450AD766.3000307@domain.hid>
	<1158613987.31164.9.camel@domain.hid>
In-Reply-To: <1158613987.31164.9.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFCA54E96699EE4936FD2B903"
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
To: Stelian Pop <stelian.pop@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFCA54E96699EE4936FD2B903
Content-Type: multipart/mixed; boundary="------------090307080300050001040903"

This is a multi-part message in MIME format.
--------------090307080300050001040903
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Stelian Pop wrote:
> Le vendredi 15 septembre 2006 =E0 18:40 +0200, Jan Kiszka a =E9crit :
>=20
>> In case no one comes up with an easy, portable way to detect remapped
>> memory as well: What about some flags the caller of rtdm_mmap_to_user
>> has to pass, telling what kind of memory it is? Would simplify the RTD=
M
>> part, and the user normally knows quite well where the memory came fro=
m.
>> And I love to break APIs. :)
>=20
> This would be perfect. We could even reuse the prot field for that
> (PROT_READ | PROT_WRITE | PROT_VMALLOC | PROT_IOREMAP). Not the cleanes=
t
> solution, but it won't break the API this way.

It would not change the function signature, but its argument semantics.
We should better make a clean cut which signals via compiler errors that
something changed.

>=20
> Or maybe we should lower the API level a little bit, and let the user
> specify the physical address of the mapping instead of the virtual
> one....

How would this help? You still need the virtual address for VMA blocks
in order to collect the pages.

I really think a separate mem-type argument is what we should do. And
here comes a first patch in this direction. Only compile-tested so far,
feedback is welcome.

Jan

--------------090307080300050001040903
Content-Type: text/plain;
 name="rtdm-mmap-ioremap.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="rtdm-mmap-ioremap.patch"

Index: include/rtdm/rtdm_driver.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/rtdm/rtdm_driver.h	(revision 1648)
+++ include/rtdm/rtdm_driver.h	(working copy)
@@ -1021,6 +1021,25 @@ int rtdm_mutex_timedlock(rtdm_mutex_t *m
=20
 /* --- utility functions --- */
=20
+/*!
+ * @addtogroup util
+ * @{
+ */
+
+/*!
+ * @anchor RTDM_MEMTYPE_xxx @name Memory Types
+ * Flags defining the type of a memory region
+ * @{
+ */
+/** Allocated with kmalloc() */
+#define RTDM_MEMTYPE_KMALLOC        0x00
+/** Remapped physical memory */
+#define RTDM_MEMTYPE_IOREMAP        0x01
+/** Allocated with vmalloc() */
+#define RTDM_MEMTYPE_VMALLOC        0x02
+/** @} Memory Types */
+/** @} util */
+
 #define rtdm_printk(format, ...)    printk(format, ##__VA_ARGS__)
=20
 #ifndef DOXYGEN_CPP /* Avoid static inline tags for RTDM in doxygen */
@@ -1036,7 +1055,7 @@ static inline void rtdm_free(void *ptr)
=20
 #ifdef CONFIG_XENO_OPT_PERVASIVE
 int rtdm_mmap_to_user(rtdm_user_info_t *user_info, void *src_addr, size_=
t len,
-                      int prot, void **pptr,
+                      int mem_type, int prot, void **pptr,
                       struct vm_operations_struct *vm_ops,
                       void *vm_private_data);
 int rtdm_munmap(rtdm_user_info_t *user_info, void *ptr, size_t len);
Index: ksrc/skins/rtdm/drvlib.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/rtdm/drvlib.c	(revision 1648)
+++ ksrc/skins/rtdm/drvlib.c	(working copy)
@@ -1369,6 +1369,7 @@ void rtdm_nrtsig_pend(rtdm_nrtsig_t *nrt
 #if defined(CONFIG_XENO_OPT_PERVASIVE) || defined(DOXYGEN_CPP)
 struct rtdm_mmap_data {
     void *src_addr;
+    int mem_type;
     struct vm_operations_struct *vm_ops;
     void *vm_private_data;
 };
@@ -1386,7 +1387,7 @@ static int rtdm_mmap_buffer(struct file=20
     size  =3D vma->vm_end - vma->vm_start;
=20
 #ifdef CONFIG_MMU
-    if ((vaddr >=3D VMALLOC_START) && (vaddr < VMALLOC_END)) {
+    if (mmap_data->mem_type =3D=3D RTDM_MEMTYPE_VMALLOC) {
         unsigned long mapped_size =3D 0;
=20
         XENO_ASSERT(RTDM, (vaddr =3D=3D PAGE_ALIGN(vaddr)), return -EINV=
AL);
@@ -1419,6 +1420,8 @@ static struct file_operations rtdm_mmap_
  * device operation handler
  * @param[in] src_addr Kernel address to be mapped
  * @param[in] len Length of the memory range
+ * @param[in] mem_type Type of the passed memory range, see
+ * @ref RTDM_MEMTYPE_xxx
  * @param[in] prot Protection flags for the user's memory range, typical=
ly
  * either PROT_READ or PROT_READ|PROT_WRITE
  * @param[in,out] pptr Address of a pointer containing the desired user
@@ -1463,11 +1466,12 @@ static struct file_operations rtdm_mmap_
  * Rescheduling: possible.
  */
 int rtdm_mmap_to_user(rtdm_user_info_t *user_info, void *src_addr, size_=
t len,
-                      int prot, void **pptr,
+                      int mem_type, int prot, void **pptr,
                       struct vm_operations_struct *vm_ops,
                       void *vm_private_data)
 {
-    struct rtdm_mmap_data   mmap_data =3D {src_addr, vm_ops, vm_private_=
data};
+    struct rtdm_mmap_data   mmap_data =3D { src_addr, mem_type, vm_ops,
+                                          vm_private_data };
     struct file             *filp;
     const struct file_operations    *old_fops;
     void                    *old_priv_data;

--------------090307080300050001040903--

--------------enigFCA54E96699EE4936FD2B903
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFEA35niDOoMHTA+kRAm4PAJsEyTqNz5h40wlO7a4csS/KIQCJRwCcDQh0
dAg9k1cMHpcMPuzdfpjuQ6M=
=qN3T
-----END PGP SIGNATURE-----

--------------enigFCA54E96699EE4936FD2B903--

