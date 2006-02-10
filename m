Message-ID: <43EBD9D6.5090404@domain.hid>
Date: Fri, 10 Feb 2006 01:09:58 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0252D96B301898EEB0404AEA"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] provide rtdm_mmap_to_user / rtdm_munmap
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
Cc: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0252D96B301898EEB0404AEA
Content-Type: multipart/mixed; boundary="------------080209010708080905050603"

This is a multi-part message in MIME format.
--------------080209010708080905050603
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi all,

this is a first attempt to add the requested mmap functionality to the
RTDM driver API. Anyone interested in this feature is invited to test my
patch (Rodrigo... ;) ). Comments on the implementation are welcome as wel=
l.

Philippe, I need xnarch_remap_page_range for this and added a #define
XENO_HEAP_MODULE hack to rtdm/drvlib.c therefore. What would you suggest
as a cleaner approach? Make this function available unconditionally or
introduce something like XENO_RTDM_MODULE? Moreover, isn't this
implementation also interesting for nucleus/heap.c?

Jan

--------------080209010708080905050603
Content-Type: text/x-patch;
 name="rtdm_mmap.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="rtdm_mmap.patch"

Index: include/rtdm/rtdm_driver.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/rtdm/rtdm_driver.h	(Revision 551)
+++ include/rtdm/rtdm_driver.h	(Arbeitskopie)
@@ -995,6 +995,10 @@
     xnfree(ptr);
 }
=20
+int rtdm_mmap_to_user(rtdm_user_info_t *user_info, void *src_addr, size_=
t len,
+                      int prot, void **pptr);
+int rtdm_munmap(rtdm_user_info_t *user_info, void *ptr, size_t len);
+
 static inline int rtdm_read_user_ok(rtdm_user_info_t *user_info,
                                     const void __user *ptr, size_t size)=

 {
Index: ksrc/skins/rtdm/drvlib.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/rtdm/drvlib.c	(Revision 551)
+++ ksrc/skins/rtdm/drvlib.c	(Arbeitskopie)
@@ -31,7 +31,9 @@
=20
=20
 #include <linux/delay.h>
+#include <linux/mman.h>
=20
+#define XENO_HEAP_MODULE
 #include <rtdm/rtdm_driver.h>
=20
=20
@@ -1286,7 +1288,7 @@
  * Rescheduling: never.
  */
 int rtdm_irq_disable(rtdm_irq_t *irq_handle);
-/** @} */
+/** @} Interrupt Management Services */
=20
=20
 /*!
@@ -1358,16 +1360,127 @@
  * environments.
  */
 void rtdm_nrtsig_pend(rtdm_nrtsig_t *nrt_sig);
-/** @} */
+/** @} Non-Real-Time Signalling Services */
=20
+#endif /* DOXYGEN_CPP */
=20
+
 /*!
  * @ingroup driverapi
  * @defgroup util Utility Services
  * @{
  */
=20
+static int rtdm_mmap_buffer(struct file *filp, struct vm_area_struct *vm=
a)
+{
+    return xnarch_remap_page_range(vma, vma->vm_start,
+                                   virt_to_phys(filp->private_data),
+                                   vma->vm_end - vma->vm_start, PAGE_SHA=
RED);
+}
+
+static struct file_operations rtdm_mmap_fops =3D {
+    .mmap =3D rtdm_mmap_buffer,
+};
+
 /**
+ * Map a kernel memory range into the address space of the user.
+ *
+ * @param[in] user_info User information pointer as passed to the invoke=
d
+ * device operation handler
+ * @param[in] src_addr Kernel address to be mapped
+ * @param[in] len Length of the memory range
+ * @param[in] prot Protection flags for the user's memory range, typical=
ly
+ * either PROT_READ or PROT_READ|PROT_WRITE
+ * @param[in,out] pptr Address of a pointer containing the desired user
+ * address or NULL on entry and the finally assigned address on return
+ *
+ * @return 0 on success, otherwise:
+ *
+ * - -EXXX is returned if .
+ *
+ * @note An RTDM driver is expected to invoke rtdm_munmap on every mappe=
d
+ * memory range either when the user requests it explicitly or when the
+ * related device is closed.
+ *
+ * Environments:
+ *
+ * This service can be called from:
+ *
+ * - Kernel module initialization/cleanup code
+ * - User-space task (non-RT)
+ *
+ * Rescheduling: possible.
+ */
+int rtdm_mmap_to_user(rtdm_user_info_t *user_info, void *src_addr, size_=
t len,
+                      int prot, void **pptr)
+{
+    struct file             *filp;
+    struct file_operations  *old_fops;
+    void                    *old_priv_data;
+    void                    *user_ptr;
+
+    filp =3D filp_open("/dev/zero", O_RDWR, 0);
+    if (IS_ERR(filp))
+        return PTR_ERR(filp);
+
+    old_fops =3D filp->f_op;
+    filp->f_op =3D &rtdm_mmap_fops;
+
+    old_priv_data =3D filp->private_data;
+    filp->private_data =3D src_addr;
+
+    down_write(&user_info->mm->mmap_sem);
+    user_ptr =3D (void *)do_mmap(filp, (unsigned long)*pptr, len, prot,
+                               MAP_SHARED, 0);
+    up_write(&user_info->mm->mmap_sem);
+
+    filp->f_op =3D old_fops;
+    filp->private_data =3D old_priv_data;
+
+    filp_close(filp, user_info->files);
+
+    if (IS_ERR(user_ptr))
+        return PTR_ERR(user_ptr);
+
+    *pptr =3D user_ptr;
+    return 0;
+}
+
+/**
+ * Unmap a user memory range.
+ *
+ * @param[in] user_info User information pointer as passed to
+ * rtdm_mmap_to_user() when requesting to map the memory range
+ * @param[in] ptr User address or the memory range
+ * @param[in] len Length of the memory range
+ *
+ * @return 0 on success, otherwise:
+ *
+ * - -EXXX is returned if .
+ *
+ * Environments:
+ *
+ * This service can be called from:
+ *
+ * - Kernel module initialization/cleanup code
+ * - User-space task (non-RT)
+ *
+ * Rescheduling: possible.
+ */
+int rtdm_munmap(rtdm_user_info_t *user_info, void *ptr, size_t len)
+{
+    int err;
+
+    down_write(&user_info->mm->mmap_sem);
+    err =3D do_munmap(user_info->mm, (unsigned long)ptr, len);
+    up_write(&user_info->mm->mmap_sem);
+
+    return err;
+}
+
+#ifdef DOXYGEN_CPP /* Only used for doxygen doc generation */
+
+/**
  * Real-time safe message printing on kernel console
  *
  * @param[in] format Format string (conforming standard @c printf())
@@ -1583,6 +1696,6 @@
  */
 int rtdm_in_rt_context(void);
=20
-/** @} */
+#endif /* DOXYGEN_CPP */
=20
-#endif /* DOXYGEN_CPP */
+/** @} Utility Services */

--------------080209010708080905050603--

--------------enig0252D96B301898EEB0404AEA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD69nXniDOoMHTA+kRAlw8AJ42sXbM32eFFXFu1FUOtcxvFVua5gCdEZ+e
LNNqpEI9Mi2tu19q9CXZ6ns=
=mAgS
-----END PGP SIGNATURE-----

--------------enig0252D96B301898EEB0404AEA--

