Message-ID: <44259797.8050106@domain.hid>
Date: Sat, 25 Mar 2006 20:18:47 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] gdb and heaps
References: <1143279446.13244.257499314@domain.hid>
	<44252103.2010604@domain.hid>
In-Reply-To: <44252103.2010604@domain.hid>
Content-Type: multipart/mixed; boundary="------------010905080407060003090204"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------010905080407060003090204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
> Alessandro Pittaluga wrote:
> 
>> Hi,
>>
>> When trying to access with gdb to variables allocated on a shared heap,
>> the following message is returned:
>> (gdb) print mypointer
>> $5 = (MYTYPE *) 0xb7dc4020
>> (gdb) print *mypointer
>> Cannot access memory at address 0xb7dc4020
>>
>> All the applications (kernel and userland) are accessing correctly to
>> the  heap-allocated memory.
>> Is this the expected behaviour or there's something wrong in my
>> installation?
>>
> 
> Your installation is correct, GDB and Xenomai are too; unfortunately, 
> the following explanation is still accurate, i.e. a restriction in the 
> ptrace support:
> http://sourceware.redhat.com/ml/gdb/2004-01/msg00152.html
> 
> Since you can call routines inside your program from the GDB cli, the 
> best solution at hand would be to implement the suggestion found in this 
> post: e.g.
> 
> void print_heap (void)
> {
>     ... output the heap contents...
> }
> 
> and,
> 
> (gdb) call print_heap()
> 
> You could even pass arguments to print_heap() for customizing your output.
> 
> A possible option to work around that would be to stop having heaps 
> marked as I/O regions though, but the kernel-provided remapping helper 
> we use currently forces this property. I'll look at this when time allows.
> 

Well, actually, I find this issue annoying enough from the user POV to 
require an immediate fix. Could you please try the attached patch 
(applies against 2.1.0 and trunk/), and let me know of the outcome? TIA,

-- 

Philippe.

--------------010905080407060003090204
Content-Type: text/x-patch;
 name="heap-no-vmio.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="heap-no-vmio.patch"

Index: include/asm-generic/wrappers.h
===================================================================
--- include/asm-generic/wrappers.h	(revision 793)
+++ include/asm-generic/wrappers.h	(working copy)
@@ -46,8 +46,12 @@
 #define module_param_named(name,var,type,mode)  module_param(var,type,mode)
 
 /* VM */
-#define wrap_remap_page_range(vma,from,to,size,prot) ({ \
+#define wrap_remap_vm_page(vma,from,to) ({ \
     vma->vm_flags |= VM_RESERVED; \
+    remap_page_range(from,virt_to_phys((void *)to),PAGE_SIZE,PAGE_SHARED); \
+})
+#define wrap_remap_io_page_range(vma,from,to,size,prot) ({ \
+    vma->vm_flags |= VM_RESERVED; \
     remap_page_range(from,to,size,prot); \
 })
 #define wrap_switch_mm(prev,next,task)	\
@@ -144,12 +148,29 @@
 
 /* VM */
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,10)
-#define wrap_remap_page_range(vma,from,to,size,prot)  \
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,15)
+#define wrap_remap_vm_page(vma,from,to) ({ \
+    vma->vm_flags |= VM_RESERVED; \
+    vm_insert_page(vma,from,vmalloc_to_page((void *)to));	\
+})
+#else /* LINUX_VERSION_CODE < KERNEL_VERSION(2,6,15) */
+/* Actually, this is a best-effort, and has the unwanted side-effet of
+ * setting the VM_IO flag on the vma, which prevents GDB inspection of
+ * the mmapped memory. Anyway, this legacy would only hit setups using
+ * oldish 2.6 kernel revisions. */
+#define wrap_remap_vm_page(vma,from,to) \
+	remap_pfn_range(vma,from,(to) >> PAGE_SHIFT,PAGE_SHIFT,PAGE_SHARED)
+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,15) */
+#define wrap_remap_io_page_range(vma,from,to,size,prot)  \
     /* Sets VM_RESERVED | VM_IO | VM_PFNMAP on the vma. */ \
     remap_pfn_range(vma,from,(to) >> PAGE_SHIFT,size,prot)
 #else /* LINUX_VERSION_CODE < KERNEL_VERSION(2,6,10) */
-#define wrap_remap_page_range(vma,from,to,size,prot) do { \
+#define wrap_remap_vm_page(vma,from,to) ({ \
     vma->vm_flags |= VM_RESERVED; \
+    remap_page_range(from,virt_to_phys((void *)to),PAGE_SIZE,PAGE_SHARED); \
+})
+#define wrap_remap_io_page_range(vma,from,to,size,prot) do { \
+    vma->vm_flags |= VM_RESERVED; \
     remap_page_range(vma,from,to,size,prot); \
 } while (0)
 #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,10) */
Index: include/asm-generic/system.h
===================================================================
--- include/asm-generic/system.h	(revision 793)
+++ include/asm-generic/system.h	(working copy)
@@ -346,15 +346,22 @@
 
 #endif /* CONFIG_SMP */
 
-static inline int xnarch_remap_page_range(struct vm_area_struct *vma,
-					  unsigned long uvaddr,
-					  unsigned long paddr,
-					  unsigned long size,
-					  pgprot_t prot)
+static inline int xnarch_remap_vm_page(struct vm_area_struct *vma,
+				       unsigned long from,
+				       unsigned long to)
 {
-    return wrap_remap_page_range(vma,uvaddr,paddr,size,prot);
+    return wrap_remap_vm_page(vma,from,to);
 }
 
+static inline int xnarch_remap_io_page_range(struct vm_area_struct *vma,
+					     unsigned long from,
+					     unsigned long to,
+					     unsigned long size,
+					     pgprot_t prot)
+{
+    return wrap_remap_io_page_range(vma,from,to,size,prot);
+}
+
 #ifdef XENO_POD_MODULE
 
 #ifdef CONFIG_SMP
Index: ksrc/skins/rtdm/drvlib.c
===================================================================
--- ksrc/skins/rtdm/drvlib.c	(revision 793)
+++ ksrc/skins/rtdm/drvlib.c	(working copy)
@@ -1390,9 +1390,9 @@
     vma->vm_ops = mmap_data->vm_ops;
     vma->vm_private_data = mmap_data->vm_private_data;
 
-    return xnarch_remap_page_range(vma, vma->vm_start,
-                                   virt_to_phys(mmap_data->src_addr),
-                                   vma->vm_end - vma->vm_start, PAGE_SHARED);
+    return xnarch_remap_io_page_range(vma, vma->vm_start,
+				      virt_to_phys(mmap_data->src_addr),
+				      vma->vm_end - vma->vm_start, PAGE_SHARED);
 }
 
 static struct file_operations rtdm_mmap_fops = {
Index: ksrc/nucleus/heap.c
===================================================================
--- ksrc/nucleus/heap.c	(revision 793)
+++ ksrc/nucleus/heap.c	(working copy)
@@ -920,6 +920,10 @@
     return kva;
 }
 
+#else /* !CONFIG_MMU */
+
+#define __va_to_kva(va) (va)
+
 #endif /* CONFIG_MMU */
 
 static int xnheap_mmap (struct file *file,
@@ -952,23 +956,14 @@
 
     vaddr = (unsigned long)heap->archdep.heapbase;
 
-    /* MMU-less vmalloc() is a wrapper to kmalloc(), so it always
-       provides contiguous memory, and we always ask for kmalloc-based
-       heaps in such context. */
-
-#ifdef CONFIG_MMU
     if (!heap->archdep.kmflags)
 	{
 	unsigned long maddr = vma->vm_start;
 
 	while (size > 0)
 	    {
-	    if (xnarch_remap_page_range(vma,
-					maddr,
-					__pa(__va_to_kva(vaddr)),
-					PAGE_SIZE,
-					PAGE_SHARED))
-		return -ENXIO;
+	    if (xnarch_remap_vm_page(vma,maddr,vaddr))
+		return -EAGAIN;
 
 	    maddr += PAGE_SIZE;
 	    vaddr += PAGE_SIZE;
@@ -976,13 +971,12 @@
 	    }
 	}
     else
-#endif /* CONFIG_MMU */
-	if (xnarch_remap_page_range(vma,
-				    vma->vm_start,
-				    virt_to_phys((void *)vaddr),
-				    size,
-				    PAGE_SHARED))
-	    return -ENXIO;
+	if (xnarch_remap_io_page_range(vma,
+				       vma->vm_start,
+				       virt_to_phys((void *)vaddr),
+				       size,
+				       PAGE_SHARED))
+	    return -EAGAIN;
 
     atomic_inc(&heap->archdep.numaps);
 
@@ -1047,7 +1041,6 @@
 
     /* Size must be page-aligned. */
 
-#ifdef CONFIG_MMU
     if (!kmflags)
 	{
 	ptr = vmalloc(size);
@@ -1061,7 +1054,6 @@
 	    SetPageReserved(virt_to_page(__va_to_kva(vaddr)));
 	}
     else /* Otherwise, we have been asked for some vmalloc() space. */
-#endif /* CONFIG_MMU */
 	{
         ptr = kmalloc(size,kmflags);
 
@@ -1086,7 +1078,6 @@
 
     vabase = (unsigned long)ptr;
 
-#ifdef CONFIG_MMU
     if (!kmflags)
 	{
         for (vaddr = vabase; vaddr < vabase + size; vaddr += PAGE_SIZE)
@@ -1095,7 +1086,6 @@
 	vfree(ptr);
 	}
     else
-#endif /* CONFIG_MMU */
 	{
 	for (vaddr = vabase; vaddr < vabase + size; vaddr += PAGE_SIZE)
 	    ClearPageReserved(virt_to_page(vaddr));
@@ -1112,9 +1102,6 @@
     spl_t s;
     int err;
 
-#ifndef CONFIG_MMU
-    memflags = memflags ?: GFP_USER;
-#endif /* CONFIG_MMU */
     heapsize = PAGE_ALIGN(heapsize);
     heapbase = __alloc_and_reserve_heap(heapsize,memflags);
 

--------------010905080407060003090204--

