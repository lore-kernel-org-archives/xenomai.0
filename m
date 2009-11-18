Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2009 11:00:02 -0500
Message-ID: <6FCCA913376DD7488F4139A4D11B8F48FD17F8@domain.hid>
In-Reply-To: <4AFAC4E1.1090109@domain.hid>
References: <6FCCA913376DD7488F4139A4D11B8F48FD1044@domain.hid>	<4AF99CAD.9070105@domain.hid>	<6FCCA913376DD7488F4139A4D11B8F48FD107D@troe2k1.cs.myharris.net>	<4AF9AD44.10000@domain.hid>	<6FCCA913376DD7488F4139A4D11B8F48FD1085@domain.hid>	<4AF9B6F2.9040206@domain.hid>	<6FCCA913376DD7488F4139A4D11B8F48FD10A9@domain.hid>	<4AF9D976.4020701@domain.hid>
	<6FCCA913376DD7488F4139A4D11B8F48FD1129@domain.hid>
	<4AFAC4E1.1090109@domain.hid>
From: "Herrera-Bendezu, Luis" <lherrera@domain.hid>
Subject: Re: [Xenomai-core] rtdm_iomap_to_user with phys addr > 4G
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Jan,

>I think we can change rtdm_iomap_to_user to take src_addr as=20
>phys_addr_t
>and propagate this internally properly. We also need to add a wrapper
>for phys_addr_t for kernels that doesn't support this (<2.6.28). To my
>current understanding, this should be sufficient, right?
>

This is a diff against Xenomai version 2.4.8 and Linux version 2.6.28 to
handle RTDM mapping to user space of devices located at addresses > 4
GB.
Rather than modifying existing rtdm_iomap_to_user() API a new one is
added, rtdm_iomap_to_user64() (to mimic mmap64()). Since this is a user
API it can not use phys_addr_t so unsigned long long is used for the
interface.

I tried to use rtdm_iomap_to_user() on a kernel module initialization
section of my RTDM driver and passing NULL to user_info argument. This
causes an invalid memory access and system panic. How can this
function be called from kernel intialization code?

diff --git a/include/asm-generic/xenomai/system.h
b/include/asm-generic/xenomai/system.h
index 020e763..f2a9424 100644
--- a/include/asm-generic/xenomai/system.h
+++ b/include/asm-generic/xenomai/system.h
@@ -417,7 +417,7 @@ static inline int xnarch_remap_vm_page(struct
vm_area_struct *vma,
 static inline int xnarch_remap_io_page_range(struct file *filp,
 					     struct vm_area_struct *vma,
 					     unsigned long from,
-					     unsigned long to,
+					     phys_addr_t to,
 					     unsigned long size,
 					     pgprot_t prot)
 {
diff --git a/include/asm-generic/xenomai/wrappers.h
b/include/asm-generic/xenomai/wrappers.h
index 943ed34..319ac0d 100644
--- a/include/asm-generic/xenomai/wrappers.h
+++ b/include/asm-generic/xenomai/wrappers.h
@@ -400,4 +400,9 @@ static inline int wrap_raise_cap(int cap)
 }
 #endif /* LINUX_VERSION_CODE >=3D 2.6.29 */
=20
+/* For Linux versions < 2.6.28 */
+#ifndef phys_addr_t
+#define phys_addr_t unsigned long
+#endif
+
 #endif /* _XENO_ASM_GENERIC_WRAPPERS_H */
diff --git a/include/xenomai/rtdm/rtdm_driver.h
b/include/xenomai/rtdm/rtdm_driver.h
index 3026aff..181caef 100644
--- a/include/xenomai/rtdm/rtdm_driver.h
+++ b/include/xenomai/rtdm/rtdm_driver.h
@@ -1172,6 +1172,11 @@ int rtdm_iomap_to_user(rtdm_user_info_t
*user_info,
 		       int prot, void **pptr,
 		       struct vm_operations_struct *vm_ops,
 		       void *vm_private_data);
+int rtdm_iomap_to_user64(rtdm_user_info_t *user_info,
+			 unsigned long long src_addr, size_t len,
+			 int prot, void **pptr,
+			 struct vm_operations_struct *vm_ops,
+			 void *vm_private_data);
 int rtdm_munmap(rtdm_user_info_t *user_info, void *ptr, size_t len);
=20
 static inline int rtdm_read_user_ok(rtdm_user_info_t *user_info,
diff --git a/kernel/xenomai/skins/rtdm/drvlib.c
b/kernel/xenomai/skins/rtdm/drvlib.c
index 65c630f..0a710ee 100644
--- a/kernel/xenomai/skins/rtdm/drvlib.c
+++ b/kernel/xenomai/skins/rtdm/drvlib.c
@@ -1765,7 +1765,7 @@ void rtdm_nrtsig_pend(rtdm_nrtsig_t *nrt_sig);
 #if defined(CONFIG_XENO_OPT_PERVASIVE) || defined(DOXYGEN_CPP)
 struct rtdm_mmap_data {
 	void *src_vaddr;
-	unsigned long src_paddr;
+	phys_addr_t src_paddr;
 	struct vm_operations_struct *vm_ops;
 	void *vm_private_data;
 };
@@ -1773,14 +1773,15 @@ struct rtdm_mmap_data {
 static int rtdm_mmap_buffer(struct file *filp, struct vm_area_struct
*vma)
 {
 	struct rtdm_mmap_data *mmap_data =3D filp->private_data;
-	unsigned long vaddr, paddr, maddr, size;
+	unsigned long vaddr, maddr, size;
+	phys_addr_t paddr;
 	int ret;
=20
 	vma->vm_ops =3D mmap_data->vm_ops;
 	vma->vm_private_data =3D mmap_data->vm_private_data;
=20
 	vaddr =3D (unsigned long)mmap_data->src_vaddr;
-	paddr =3D (unsigned long)mmap_data->src_paddr;
+	paddr =3D (phys_addr_t)mmap_data->src_paddr;
 	if (!paddr)
 		/* kmalloc memory */
 		paddr =3D virt_to_phys((void *)vaddr);
@@ -1995,6 +1996,20 @@ int rtdm_iomap_to_user(rtdm_user_info_t
*user_info,
=20
 EXPORT_SYMBOL(rtdm_iomap_to_user);
=20
+int rtdm_iomap_to_user64(rtdm_user_info_t *user_info,
+			 unsigned long long src_addr, size_t len,
+			 int prot, void **pptr,
+			 struct vm_operations_struct *vm_ops,
+			 void *vm_private_data)
+{
+	struct rtdm_mmap_data mmap_data =3D
+		{ NULL, src_addr, vm_ops, vm_private_data };
+
+	return rtdm_do_mmap(user_info, &mmap_data, len, prot, pptr);
+}
+
+EXPORT_SYMBOL(rtdm_iomap_to_user64);
+
 /**
  * Unmap a user memory range.
  *

Luis

