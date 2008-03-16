Message-ID: <47DD4E1F.9050400@domain.hid>
Date: Sun, 16 Mar 2008 17:43:11 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <47DD3BF9.2@domain.hid> <47DD3FB4.5080305@domain.hid>
	<47DD424A.7040006@domain.hid> <47DD47F0.5020003@domain.hid>
	<47DD4C70.2040208@domain.hid>
In-Reply-To: <47DD4C70.2040208@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] pgprot_noncached for io-remapping?
Reply-To: rpm@xenomai.org
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
Cc: Xenomai-core@domain.hid

Jan Kiszka wrote:
> Philippe Gerum wrote:
>> Jan Kiszka wrote:
>>> Philippe Gerum wrote:
>>>> Jan Kiszka wrote:
>>>>> Hi,
>>>>>
>>>>> doesn't this patch [1] have some relevance for us as well? As we use
>>>>> xnarch_remap_io_page_range also for non-IO memory, I'm hesitating to
>>>>> suggest that we apply this unconditionally at xnarch level. Ideas welcome.
>>>>>
>>>> Yes, I think it makes a lot of sense on powerpc at least, since doing so will
>>>> set the PAGE_GUARDED bit as well, and we obviously want to avoid any
>>>> out-of-order access of I/O memory.
>>>>
>>>> (I don't see the reason to force the VM_RESERVED and VM_IO on the vma though,
>>>> since remap_pfn_range will do it anyway.)
>>> No, I was talking about cases where we may pass kmalloc'ed memory to
>>> xnarch_remap_io_page_range. In that case, caching and out-of-order
>>> access may be desired for performance reasons.
>>>
>> xnarch_remap_io_page_range is intended for I/O memory only, some assumptions are
>> made on this. rtdm_mmap_buffer() should be fixed; it would be much better to
>> define another internal interface at xnarch level to specifically perform
>> kmalloc mapping.
> 
> Yeah, probably. But I think the issue is not just limited to RTDM. The
> xnheap can be kmalloc-hosted as well.
>

This one is used with DMA memory. What I would suggest, is something like this:

--- ksrc/skins/rtdm/drvlib.c	(revision 3590)
+++ ksrc/skins/rtdm/drvlib.c	(working copy)
@@ -1738,9 +1738,12 @@
 		}
 		return 0;
 	} else
-#endif /* CONFIG_MMU */
 		return xnarch_remap_io_page_range(vma, maddr, paddr,
 						  size, PAGE_SHARED);
+#else
+	return xnarch_remap_kmem_page_range(vma, maddr, paddr,
+					    size, PAGE_SHARED);
+#endif /* CONFIG_MMU */
 }

 static struct file_operations rtdm_mmap_fops = {


I.e. split the cases where MMU is absent from the one where MMU is there but we
come from rtdm_iomap_to_user.

> Jan
> 


-- 
Philippe.

