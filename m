From: Stelian Pop <stelian.pop@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Date: Fri, 15 Sep 2006 18:26:23 +0200
Message-Id: <1158337583.13530.20.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-core] 
	[PATCH, RFC] Make ioremap'ed memory available through
	rtdm_mmap_to_user()
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

Hi,

I need to be able to map an IO memory buffer to userspace from a RTDM
driver.

rtdm_mmap_to_user() seems to do what I need, but it doesn't work. Its
code thinks that all virtual addresses between VMALLOC_START and
VMALLOC_END are obtained through vmalloc() and tries to call
xnarch_remap_vm_page() on them, which fails.

Virtual addresses coming from ioremap() need to go through
xnarch_remap_io_page_range(), and their physical address cannot be
obtained with a simple virt_to_phys().

A working patch is attached below, but there might (should ?) be a
better way to do it. Some of the code may also belong to
asm-generic/system.h instead of the RTDM skin.

Note that you may also need to EXPORT_SYMBOL(vmlist and vmlist_lock) in
mm/vmalloc.c if you want to build the RTDM skin as a module.

Comments ?

Stelian.

Index: ksrc/skins/rtdm/drvlib.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/rtdm/drvlib.c	(r=E9vision 1624)
+++ ksrc/skins/rtdm/drvlib.c	(copie de travail)
@@ -1377,6 +1377,7 @@
 {
     struct rtdm_mmap_data *mmap_data =3D filp->private_data;
     unsigned long vaddr, maddr, size;
+    struct vm_struct *vm;
=20
     vma->vm_ops =3D mmap_data->vm_ops;
     vma->vm_private_data =3D mmap_data->vm_private_data;
@@ -1385,7 +1386,21 @@
     maddr =3D vma->vm_start;
     size  =3D vma->vm_end - vma->vm_start;
=20
+    write_lock(&vmlist_lock);
+    for (vm =3D vmlist; vm !=3D NULL; vm =3D vm->next) {
+	if (vm->addr =3D=3D (void *)vaddr)
+	    break;
+    }
+    write_unlock(&vmlist_lock);
+
+    /* ioremap'ed memory */
+    if (vm && vm->flags & VM_IOREMAP)
+        return xnarch_remap_io_page_range(vma, maddr,
+					  vm->phys_addr,
+                                          size, PAGE_SHARED);
+    else
 #ifdef CONFIG_MMU
+    /* vmalloc'ed memory */
     if ((vaddr >=3D VMALLOC_START) && (vaddr < VMALLOC_END)) {
         unsigned long mapped_size =3D 0;
=20

--=20
Stelian Pop <stelian.pop@domain.hid>


