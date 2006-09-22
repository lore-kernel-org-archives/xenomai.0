Subject: Re: [Xenomai-core] 	[PATCH, RFC] Make ioremap'ed memory available
	through	rtdm_mmap_to_user()
From: Stelian Pop <stelian.pop@domain.hid>
In-Reply-To: <45100DF6.8030209@domain.hid>
References: <1158337583.13530.20.camel@domain.hid>
	<450AD766.3000307@domain.hid>
	<1158613987.31164.9.camel@domain.hid>
	<45100DF6.8030209@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Date: Fri, 22 Sep 2006 10:35:48 +0200
Message-Id: <1158914149.14421.10.camel@domain.hid>
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

[Sorry for the delay, I was quite busy those days and unable to test the
patch...]

Le mardi 19 septembre 2006 =E0 17:34 +0200, Jan Kiszka a =E9crit :
> >=20
> > Or maybe we should lower the API level a little bit, and let the user
> > specify the physical address of the mapping instead of the virtual
> > one....
>=20
> How would this help? You still need the virtual address for VMA blocks
> in order to collect the pages.

Actualy we need both the virtual address (for vmalloc case) and the
physical address (for ioremap case).

> +    if (mmap_data->mem_type =3D=3D RTDM_MEMTYPE_VMALLOC) {
[...]

This still won't work because for RTDM_MEMTYPE_IOREMAP
virt_to_phys((void *)vaddr) doesn't return the physical address.

So we still need to either:
	a) walk the vmlist struct to find out the needed vm->phys_addr (which
will probably won't work in 2.4, or even in earlier 2.6 kernels)

	b) pass both the physical and the virtual adresses in the
rtdm_mmap_to_user prototype (the physical address would be used only
when RTDM_MEMTYPE_IOREMAP is specified)

	c) make 'src_addr' be a virtual address in some cases, and a physical
address in ioremap case.

	d) make a special rtdm_mmap_iomem_to_user() function...

The (tested) patch below implements the b) case.

Index: include/rtdm/rtdm_driver.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/rtdm/rtdm_driver.h	(r=E9vision 1652)
+++ include/rtdm/rtdm_driver.h	(copie de travail)
@@ -1021,6 +1021,25 @@
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
@@ -1035,8 +1054,9 @@
 }
=20
 #ifdef CONFIG_XENO_OPT_PERVASIVE
-int rtdm_mmap_to_user(rtdm_user_info_t *user_info, void *src_addr, size_=
t len,
-                      int prot, void **pptr,
+int rtdm_mmap_to_user(rtdm_user_info_t *user_info,
+                      void *src_vaddr, unsigned long src_paddr, size_t l=
en,
+                      int mem_type, int prot, void **pptr,
                       struct vm_operations_struct *vm_ops,
                       void *vm_private_data);
 int rtdm_munmap(rtdm_user_info_t *user_info, void *ptr, size_t len);
Index: ksrc/skins/rtdm/drvlib.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/rtdm/drvlib.c	(r=E9vision 1652)
+++ ksrc/skins/rtdm/drvlib.c	(copie de travail)
@@ -1368,7 +1368,9 @@
=20
 #if defined(CONFIG_XENO_OPT_PERVASIVE) || defined(DOXYGEN_CPP)
 struct rtdm_mmap_data {
-    void *src_addr;
+    void *src_vaddr;
+    unsigned long src_paddr;
+    int mem_type;
     struct vm_operations_struct *vm_ops;
     void *vm_private_data;
 };
@@ -1376,17 +1378,22 @@
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
     maddr =3D vma->vm_start;
     size  =3D vma->vm_end - vma->vm_start;
=20
+    if (mmap_data->mem_type =3D=3D RTDM_MEMTYPE_IOREMAP)
+	    paddr =3D mmap_data->src_paddr;
+    else
+	    paddr =3D virt_to_phys((void *)vaddr);
+
 #ifdef CONFIG_MMU
-    if ((vaddr >=3D VMALLOC_START) && (vaddr < VMALLOC_END)) {
+    if (mmap_data->mem_type =3D=3D RTDM_MEMTYPE_VMALLOC) {
         unsigned long mapped_size =3D 0;
=20
         XENO_ASSERT(RTDM, (vaddr =3D=3D PAGE_ALIGN(vaddr)), return -EINV=
AL);
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
@@ -1417,8 +1423,12 @@
  *
  * @param[in] user_info User information pointer as passed to the invoke=
d
  * device operation handler
- * @param[in] src_addr Kernel address to be mapped
+ * @param[in] src_vaddr Kernel virtual address to be mapped
+ * @param[in] src_paddr Kernel physical address to be mapped (used only =
for IO
+ * memory, i.e. mem_type=3DRTDM_MEMTYPE_IOREMAP)
  * @param[in] len Length of the memory range
+ * @param[in] mem_type Type of the passed memory range, see
+ * @ref RTDM_MEMTYPE_xxx
  * @param[in] prot Protection flags for the user's memory range, typical=
ly
  * either PROT_READ or PROT_READ|PROT_WRITE
  * @param[in,out] pptr Address of a pointer containing the desired user
@@ -1462,12 +1472,14 @@
  *
  * Rescheduling: possible.
  */
-int rtdm_mmap_to_user(rtdm_user_info_t *user_info, void *src_addr, size_=
t len,
-                      int prot, void **pptr,
+int rtdm_mmap_to_user(rtdm_user_info_t *user_info,
+                      void *src_vaddr, unsigned long src_paddr, size_t l=
en,
+                      int mem_type, int prot, void **pptr,
                       struct vm_operations_struct *vm_ops,
                       void *vm_private_data)
 {
-    struct rtdm_mmap_data   mmap_data =3D {src_addr, vm_ops, vm_private_=
data};
+    struct rtdm_mmap_data   mmap_data =3D { src_vaddr, src_paddr, mem_ty=
pe,
+                                          vm_ops, vm_private_data };
     struct file             *filp;
     const struct file_operations    *old_fops;
     void                    *old_priv_data;


--=20
Stelian Pop <stelian.pop@domain.hid>


