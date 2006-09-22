Subject: Re: [Xenomai-core] 	[PATCH, RFC] Make ioremap'ed memory available
	through	rtdm_mmap_to_user()
From: Stelian Pop <stelian.pop@domain.hid>
In-Reply-To: <4513A5D0.3040507@domain.hid>
References: <1158337583.13530.20.camel@domain.hid>
	<450AD766.3000307@domain.hid>
	<1158613987.31164.9.camel@domain.hid>
	<45100DF6.8030209@domain.hid>
	<1158914149.14421.10.camel@domain.hid>
	<4513A5D0.3040507@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Date: Fri, 22 Sep 2006 13:34:33 +0200
Message-Id: <1158924874.19558.6.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Le vendredi 22 septembre 2006 =E0 10:58 +0200, Jan Kiszka a =E9crit :

> > 	d) make a special rtdm_mmap_iomem_to_user() function...
>=20
> Also an option. Specifically, it wouldn't break the existing API... Wha=
t
> about rtdm_iomap_to_user? Would you like to work out a patch in this
> direction?

Here it comes.

Index: include/rtdm/rtdm_driver.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/rtdm/rtdm_driver.h	(r=E9vision 1652)
+++ include/rtdm/rtdm_driver.h	(copie de travail)
@@ -1035,10 +1035,16 @@
 }
=20
 #ifdef CONFIG_XENO_OPT_PERVASIVE
-int rtdm_mmap_to_user(rtdm_user_info_t *user_info, void *src_addr, size_=
t len,
+int rtdm_mmap_to_user(rtdm_user_info_t *user_info,
+                      void *src_addr, size_t len,
                       int prot, void **pptr,
                       struct vm_operations_struct *vm_ops,
                       void *vm_private_data);
+int rtdm_iomap_to_user(rtdm_user_info_t *user_info,
+                       unsigned long src_addr, size_t len,
+                       int prot, void **pptr,
+                       struct vm_operations_struct *vm_ops,
+                       void *vm_private_data);
 int rtdm_munmap(rtdm_user_info_t *user_info, void *ptr, size_t len);
=20
 static inline int rtdm_read_user_ok(rtdm_user_info_t *user_info,
Index: ksrc/skins/rtdm/drvlib.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/rtdm/drvlib.c	(r=E9vision 1652)
+++ ksrc/skins/rtdm/drvlib.c	(copie de travail)
@@ -1368,7 +1368,8 @@
=20
 #if defined(CONFIG_XENO_OPT_PERVASIVE) || defined(DOXYGEN_CPP)
 struct rtdm_mmap_data {
-    void *src_addr;
+    void *src_vaddr;
+    unsigned long src_paddr;
     struct vm_operations_struct *vm_ops;
     void *vm_private_data;
 };
@@ -1376,16 +1377,22 @@
 static int rtdm_mmap_buffer(struct file *filp, struct vm_area_struct *vm=
a)
 {
     struct rtdm_mmap_data *mmap_data =3D filp->private_data;
-    unsigned long vaddr, maddr, size;
+    unsigned long vaddr, paddr, maddr, size;
=20
     vma->vm_ops =3D mmap_data->vm_ops;
     vma->vm_private_data =3D mmap_data->vm_private_data;
=20
-    vaddr =3D (unsigned long)mmap_data->src_addr;
+    vaddr =3D (unsigned long)mmap_data->src_vaddr;
+    paddr =3D (unsigned long)mmap_data->src_paddr;
+    if (!paddr)
+	    /* kmalloc memory */
+	    paddr =3D virt_to_phys((void *)vaddr);
+
     maddr =3D vma->vm_start;
     size  =3D vma->vm_end - vma->vm_start;
=20
 #ifdef CONFIG_MMU
+    /* Catch only vmalloc memory */
     if ((vaddr >=3D VMALLOC_START) && (vaddr < VMALLOC_END)) {
         unsigned long mapped_size =3D 0;
=20
@@ -1403,8 +1410,7 @@
         return 0;
     } else
 #endif /* CONFIG_MMU */
-        return xnarch_remap_io_page_range(vma, maddr,
-                                          virt_to_phys((void *)vaddr),
+        return xnarch_remap_io_page_range(vma, maddr, paddr,
                                           size, PAGE_SHARED);
 }
=20
@@ -1412,12 +1418,51 @@
     .mmap =3D rtdm_mmap_buffer,
 };
=20
+static int __rtdm_do_mmap(rtdm_user_info_t *user_info,
+                          struct rtdm_mmap_data *mmap_data,
+                          size_t len, int prot, void **pptr)
+{
+    struct file             *filp;
+    const struct file_operations    *old_fops;
+    void                    *old_priv_data;
+    void                    *user_ptr;
+
+    XENO_ASSERT(RTDM, xnpod_root_p(), return -EPERM;);
+
+    filp =3D filp_open("/dev/zero", O_RDWR, 0);
+    if (IS_ERR(filp))
+        return PTR_ERR(filp);
+
+    old_fops =3D filp->f_op;
+    filp->f_op =3D &rtdm_mmap_fops;
+
+    old_priv_data =3D filp->private_data;
+    filp->private_data =3D mmap_data;
+
+    down_write(&user_info->mm->mmap_sem);
+    user_ptr =3D (void *)do_mmap(filp, (unsigned long)*pptr, len, prot,
+                               MAP_SHARED, 0);
+    up_write(&user_info->mm->mmap_sem);
+
+    filp->f_op =3D (typeof(filp->f_op))old_fops;
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
+
 /**
  * Map a kernel memory range into the address space of the user.
  *
  * @param[in] user_info User information pointer as passed to the invoke=
d
  * device operation handler
- * @param[in] src_addr Kernel address to be mapped
+ * @param[in] src_addr Kernel virtual address to be mapped
  * @param[in] len Length of the memory range
  * @param[in] prot Protection flags for the user's memory range, typical=
ly
  * either PROT_READ or PROT_READ|PROT_WRITE
@@ -1462,50 +1507,84 @@
  *
  * Rescheduling: possible.
  */
-int rtdm_mmap_to_user(rtdm_user_info_t *user_info, void *src_addr, size_=
t len,
+int rtdm_mmap_to_user(rtdm_user_info_t *user_info,
+                      void *src_addr, size_t len,
                       int prot, void **pptr,
                       struct vm_operations_struct *vm_ops,
                       void *vm_private_data)
 {
-    struct rtdm_mmap_data   mmap_data =3D {src_addr, vm_ops, vm_private_=
data};
-    struct file             *filp;
-    const struct file_operations    *old_fops;
-    void                    *old_priv_data;
-    void                    *user_ptr;
+    struct rtdm_mmap_data   mmap_data =3D { src_addr, 0,
+                                          vm_ops, vm_private_data };
=20
+    return __rtdm_do_mmap(user_info, &mmap_data, len, prot, pptr);
+}
=20
-    XENO_ASSERT(RTDM, xnpod_root_p(), return -EPERM;);
+EXPORT_SYMBOL(rtdm_mmap_to_user);
=20
-    filp =3D filp_open("/dev/zero", O_RDWR, 0);
-    if (IS_ERR(filp))
-        return PTR_ERR(filp);
+/**
+ * Map an I/O memory range into the address space of the user.
+ *
+ * @param[in] user_info User information pointer as passed to the invoke=
d
+ * device operation handler
+ * @param[in] src_addr I/O physical address to be mapped
+ * @param[in] len Length of the memory range
+ * @param[in] prot Protection flags for the user's memory range, typical=
ly
+ * either PROT_READ or PROT_READ|PROT_WRITE
+ * @param[in,out] pptr Address of a pointer containing the desired user
+ * address or NULL on entry and the finally assigned address on return
+ * @param[in] vm_ops vm_operations to be executed on the vma_area of the
+ * user memory range or NULL
+ * @param[in] vm_private_data Private data to be stored in the vma_area,
+ * primarily useful for vm_operation handlers
+ *
+ * @return 0 on success, otherwise (most common values):
+ *
+ * - -EINVAL is returned if an invalid start address, size, or destinati=
on
+ * address was passed.
+ *
+ * - -ENOMEM is returned if there is insufficient free memory or the lim=
it of
+ * memory mapping for the user process was reached.
+ *
+ * - -EAGAIN is returned if too much memory has been already locked by t=
he
+ * user process.
+ *
+ * - -EPERM @e may be returned if an illegal invocation environment is
+ * detected.
+ *
+ * @note RTDM supports two models for unmapping the user memory range ag=
ain.
+ * One is explicite unmapping via rtdm_munmap(), either performed when t=
he
+ * user requests it via an IOCTL etc. or when the related device is clos=
ed.
+ * The other is automatic unmapping, triggered by the user invoking stan=
dard
+ * munmap() or by the termination of the related process. To track relea=
se of
+ * the mapping and therefore relinquishment of the referenced physical m=
emory,
+ * the caller of rtdm_mmap_to_user() can pass a vm_operations_struct on
+ * invocation, defining a close handler for the vm_area. See Linux
+ * documentaion (e.g. Linux Device Drivers book) on virtual memory manag=
ement
+ * for details.
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
+int rtdm_iomap_to_user(rtdm_user_info_t *user_info,
+                       unsigned long src_addr, size_t len,
+                       int prot, void **pptr,
+                       struct vm_operations_struct *vm_ops,
+                       void *vm_private_data)
+{
+    struct rtdm_mmap_data   mmap_data =3D { NULL, src_addr,
+                                          vm_ops, vm_private_data };
=20
-    old_fops =3D filp->f_op;
-    filp->f_op =3D &rtdm_mmap_fops;
-
-    old_priv_data =3D filp->private_data;
-    filp->private_data =3D &mmap_data;
-
-    down_write(&user_info->mm->mmap_sem);
-    user_ptr =3D (void *)do_mmap(filp, (unsigned long)*pptr, len, prot,
-                               MAP_SHARED, 0);
-    up_write(&user_info->mm->mmap_sem);
-
-    filp->f_op =3D (typeof(filp->f_op))old_fops;
-    filp->private_data =3D old_priv_data;
-
-    filp_close(filp, user_info->files);
-
-    if (IS_ERR(user_ptr))
-        return PTR_ERR(user_ptr);
-
-    *pptr =3D user_ptr;
-    return 0;
+    return __rtdm_do_mmap(user_info, &mmap_data, len, prot, pptr);
 }
=20
-EXPORT_SYMBOL(rtdm_mmap_to_user);
+EXPORT_SYMBOL(rtdm_iomap_to_user);
=20
-
 /**
  * Unmap a user memory range.
  *

--=20
Stelian Pop <stelian.pop@domain.hid>


