Message-ID: <48FDB900.5080102@domain.hid>
Date: Tue, 21 Oct 2008 13:12:00 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4B2EEE69E41E524EB7FCDC62A15D68D8018D0159@domain.hid>
In-Reply-To: <4B2EEE69E41E524EB7FCDC62A15D68D8018D0159@domain.hid>
Content-Type: multipart/mixed; boundary="------------000408080805090004000104"
Subject: Re: [Xenomai-help] rtdm_iomap_to_user on PPC
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: thomas.debes@domain.hid
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------000408080805090004000104
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

thomas.debes@domain.hid wrote:
> Hello Alexis, hello Philippe,
>=20
> thanks for your suggestions - the protection bits did the trick! Adding t=
hem to xnarch_remap_io_page_range(...) in rtdm_mmap_buffer() solved the pro=
blem. We already tried this few months ago using
>=20
> pgprot_val(vma->vm_page_prot) |=3D _PAGE_NO_CACHE | _PAGE_GUARDED | PAGE_=
SHARED;
>=20
> but missed the fact that xnarch_remap_io_page_range only takes PAGE_SHARE=
D instead of use vma->vm_page_prot as its 5th parameter. I am not sure weth=
er this extension will have side effects on other architectures. Maybe ther=
e is a better place for this fix. What do you think?
>

Not all archs will have the same requirements, unfortunately. Could you try=
 the
attached patch? It also makes sure that prefetchable PCI memory won't be
accessed as page guarded in 2.6. TIA,

> Thanks again!
>=20
> Thomas
>=20
>=20
>=20
>=20
>> -----Urspr=FCngliche Nachricht-----
>> Von: xenomai-help-bounces@domain.hid=20
>> [mailto:xenomai-help-bounces@domain.hid] Im Auftrag von Philippe Gerum
>> Gesendet: Sonntag, 19. Oktober 2008 20:11
>> An: Gilles Chanteperdrix
>> Cc: xenomai@xenomai.org
>> Betreff: Re: [Xenomai-help] rtdm_iomap_to_user on PPC
>>
>> Gilles Chanteperdrix wrote:
>>> Philippe Gerum wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> Alexis Berlemont wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On Friday 17 October 2008 06:46,=20
>> thomas.debes@domain.hid wrote:
>>>>>>> No comments or ideas? Providing this feature is=20
>> essential for our=20
>>>>>>> CPCI drivers. We have to port some Linux applications=20
>> to Xenomai=20
>>>>>>> which use that mmap stuff intensely.
>>>>>>>
>>>>>>> Thanks again!
>>>>>>>
>>>>>>> Thomas
>>>>>>>
>>>>>>>> -----Urspr=FCngliche Nachricht-----
>>>>>>>> Von: xenomai-help-bounces@domain.hid=20
>>>>>>>> [mailto:xenomai-help-bounces@domain.hid] Im Auftrag von=20
>>>>>>>> thomas.debes@domain.hid
>>>>>>>> Gesendet: Mittwoch, 8. Oktober 2008 11:49
>>>>>>>> An: xenomai@xenomai.org
>>>>>>>> Betreff: [Xenomai-help] rtdm_iomap_to_user on PPC
>>>>>>>>
>>>>>>>> Hello,
>>>>>>>>
>>>>>>>> in the following thread I was asking for a solution to use
>>>>>>>> rtdm_iomap_to_user() on PPC (MPC5200, Denx 2.4.25)
>>>>>> In 2.4 kernel, rtdm_iomap_to_user() is based on the function=20
>>>>>> remap_page_range (with vma->vm_flags |=3D VM_RESERVED).
>>>>>>
>>>>>> Once, I had to develop a classical Linux driver (for PPC) which=20
>>>>>> provided mmap functionalites so as to let a user=20
>> application mmap a=20
>>>>>> buffer allocated thanks to __get_free_pages().
>>>>>>
>>>>>> On a 2.6 kernel, I used remap_pfn_range() and it works=20
>> great but on=20
>>>>>> 2.4 kernel the function remap_page_range() did not work as I=20
>>>>>> expected. I had a quick look on its implementation and I=20
>> found that=20
>>>>>> instead of mapping my buffer it mapped newly allocated=20
>> zeroed pages (if my memories are correct).
>>>>>> If I remember well, these pages were allocated in lazy=20
>> mode. That=20
>>>>>> could explain the freeze of your whole system: in case a RT=20
>>>>>> application in primary mode tries to access the mmapped buffer.
>>>>> Well, normally, the fault should cause the RT application=20
>> to switch=20
>>>>> to secondary mode and be handled gracefully from there,=20
>> unless there=20
>>>>> is a bug hidden in Xenomai or I-pipe. Besides, RT applications=20
>>>>> usually use "mlockall", so the kernel should make all the pages=20
>>>>> present and not rely on further faults (at least, is it=20
>> how it works on 2.6).
>>>> powerpc may still trigger minor faults upon TLB misses=20
>> though. That=20
>>>> arch has a software-assisted MMU.
>>> Ok, and can these faults cause lockups when they happen in=20
>> primary mode?
>> Unless I messed up things in the I-pipe patch, no. Depending=20
>> on the MMU management code, some of them will reach the Linux=20
>> fault handler and trigger the mode switch via the Xenomai=20
>> fault handler, others will be processed directly from the=20
>> low-level exception code when it is possible to fix up the=20
>> mapping from there.
>>
>> As I mentioned a long time ago, the issue is more likely=20
>> related to the protection bits used with PCI memory=20
>> resources, which do require additional fixup on powerpc=20
>> (_PAGE_GUARDED and _PAGE_NO_CACHE come to mind here).
>>
>> --
>> Philippe.
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
>>
>=20
> Achtung: Neue E-Mail-Adresse! Attention: New e-mail-address! thomas.debes=
@domain.hid
> --------------------------------------------------------
> manroland AG
> Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
> Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus Rall,=
 Paul Steidle  =20
> Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht Of=
fenbach HRB-Nr. 42592
> USt-Ident-Nr. DE 250200933
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>=20


--=20
Philippe.

--------------000408080805090004000104
Content-Type: text/x-diff;
 name="platform-dependent-phys-access-prot.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="platform-dependent-phys-access-prot.patch"

Index: include/asm-generic/system.h
===================================================================
--- include/asm-generic/system.h	(revision 4270)
+++ include/asm-generic/system.h	(working copy)
@@ -409,13 +409,16 @@
     return wrap_remap_vm_page(vma,from,to);
 }
 
-static inline int xnarch_remap_io_page_range(struct vm_area_struct *vma,
+static inline int xnarch_remap_io_page_range(struct file *filp,
+					     struct vm_area_struct *vma,
 					     unsigned long from,
 					     unsigned long to,
 					     unsigned long size,
 					     pgprot_t prot)
 {
-    return wrap_remap_io_page_range(vma,from,to,size,prot);
+	return wrap_remap_io_page_range(vma,from,to,size,
+					wrap_phys_mem_prot(filp, (to) >> PAGE_SHIFT,
+							   size, prot));
 }
 
 static inline int xnarch_remap_kmem_page_range(struct vm_area_struct *vma,
Index: include/asm-powerpc/wrappers.h
===================================================================
--- include/asm-powerpc/wrappers.h	(revision 4270)
+++ include/asm-powerpc/wrappers.h	(working copy)
@@ -31,6 +31,9 @@
 
 #define CONFIG_MMU 1
 
+#define wrap_phys_mem_prot(filp,pfn,size,prot)  \
+  __pgprot(pgprot_val(prot) | _PAGE_NO_CACHE | _PAGE_GUARDED)
+
 #define atomic_inc_and_test(v) (atomic_inc_return(v) == 0)
 #define show_stack(p,sp)       print_backtrace(sp)	/* Only works for current. */
 
@@ -51,6 +54,9 @@
 
 #else /*  LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)  */
 
+#define wrap_phys_mem_prot(filp,pfn,size,prot) \
+  phys_mem_access_prot(filp, pfn, size, prot)
+
 #ifdef CONFIG_PPC64
 #define wrap_range_ok(task,addr,size) \
     __access_ok(((__force unsigned long)(addr)),(size),(task->thread.fs))
Index: ksrc/skins/rtdm/drvlib.c
===================================================================
--- ksrc/skins/rtdm/drvlib.c	(revision 4270)
+++ ksrc/skins/rtdm/drvlib.c	(working copy)
@@ -1807,7 +1807,7 @@
 	} else
 #endif /* CONFIG_MMU */
 	if (mmap_data->src_paddr)
-		return xnarch_remap_io_page_range(vma, maddr, paddr,
+	  	return xnarch_remap_io_page_range(filp, vma, maddr, paddr,
 						  size, PAGE_SHARED);
 	else
 		return xnarch_remap_kmem_page_range(vma, maddr, paddr,
Index: ksrc/nucleus/heap.c
===================================================================
--- ksrc/nucleus/heap.c	(revision 4270)
+++ ksrc/nucleus/heap.c	(working copy)
@@ -1053,7 +1053,7 @@
 			vaddr += PAGE_SIZE;
 			size -= PAGE_SIZE;
 		}
-	} else if (xnarch_remap_io_page_range(vma,
+	} else if (xnarch_remap_io_page_range(file,vma,
 					      vma->vm_start,
 					      virt_to_phys((void *)vaddr),
 					      size, PAGE_SHARED))

--------------000408080805090004000104--

