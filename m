Message-ID: <47DD5A2C.3050606@domain.hid>
Date: Sun, 16 Mar 2008 18:34:36 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <47DD3BF9.2@domain.hid> <47DD3FB4.5080305@domain.hid>
	<47DD424A.7040006@domain.hid> <47DD47F0.5020003@domain.hid>
	<47DD4C70.2040208@domain.hid> <47DD4E1F.9050400@domain.hid>
	<47DD4FDA.8020105@domain.hid> <47DD53EF.9070302@domain.hid>
	<47DD55CF.80903@domain.hid>
In-Reply-To: <47DD55CF.80903@domain.hid>
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
>>>>> Philippe Gerum wrote:
>>>>>> Jan Kiszka wrote:
>>>>>>> Philippe Gerum wrote:
>>>>>>>> Jan Kiszka wrote:
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> doesn't this patch [1] have some relevance for us as well? As we use
>>>>>>>>> xnarch_remap_io_page_range also for non-IO memory, I'm hesitating to
>>>>>>>>> suggest that we apply this unconditionally at xnarch level. Ideas welcome.
>>>>>>>>>
>>>>>>>> Yes, I think it makes a lot of sense on powerpc at least, since doing so will
>>>>>>>> set the PAGE_GUARDED bit as well, and we obviously want to avoid any
>>>>>>>> out-of-order access of I/O memory.
>>>>>>>>
>>>>>>>> (I don't see the reason to force the VM_RESERVED and VM_IO on the vma though,
>>>>>>>> since remap_pfn_range will do it anyway.)
>>>>>>> No, I was talking about cases where we may pass kmalloc'ed memory to
>>>>>>> xnarch_remap_io_page_range. In that case, caching and out-of-order
>>>>>>> access may be desired for performance reasons.
>>>>>>>
>>>>>> xnarch_remap_io_page_range is intended for I/O memory only, some assumptions are
>>>>>> made on this. rtdm_mmap_buffer() should be fixed; it would be much better to
>>>>>> define another internal interface at xnarch level to specifically perform
>>>>>> kmalloc mapping.
>>>>> Yeah, probably. But I think the issue is not just limited to RTDM. The
>>>>> xnheap can be kmalloc-hosted as well.
>>>>>
>>>> This one is used with DMA memory. What I would suggest, is something like this:
>>>>
>>>> --- ksrc/skins/rtdm/drvlib.c	(revision 3590)
>>>> +++ ksrc/skins/rtdm/drvlib.c	(working copy)
>>>> @@ -1738,9 +1738,12 @@
>>>>  		}
>>>>  		return 0;
>>>>  	} else
>>>> -#endif /* CONFIG_MMU */
>>>>  		return xnarch_remap_io_page_range(vma, maddr, paddr,
>>>>  						  size, PAGE_SHARED);
>>>> +#else
>>>> +	return xnarch_remap_kmem_page_range(vma, maddr, paddr,
>>>> +					    size, PAGE_SHARED);
>>>> +#endif /* CONFIG_MMU */
>>>>  }
>>>>
>>>>  static struct file_operations rtdm_mmap_fops = {
>>>>
>>>>
>>>> I.e. split the cases where MMU is absent from the one where MMU is there but we
>>>> come from rtdm_iomap_to_user.
>>> Makes no sense to me yet. With CONFIG_MMU we have 3 cases, not just two,
>>> no? We have to use mmap_data->src_paddr to tell kmem_page apart from
>>> io_page.
>> That's what the patch I sent right after this one does.
> 
> Nope, vaddr can be NULL in both cases, only paddr is differentiating.
> 
> This one should do what we need:
> 
> Index: ksrc/skins/rtdm/drvlib.c
> ===================================================================
> --- ksrc/skins/rtdm/drvlib.c	(Revision 3594)
> +++ ksrc/skins/rtdm/drvlib.c	(Arbeitskopie)
> @@ -1739,8 +1739,12 @@ static int rtdm_mmap_buffer(struct file 
>  		return 0;
>  	} else
>  #endif /* CONFIG_MMU */
> +	if (mmap_data->src_paddr)
>  		return xnarch_remap_io_page_range(vma, maddr, paddr,
>  						  size, PAGE_SHARED);
> +	else
> +		return xnarch_remap_kmem_page_range(vma, maddr, paddr,
> +						    size, PAGE_SHARED);
>  }
>  
>  static struct file_operations rtdm_mmap_fops = {
> 
> 

Ok. So if that's fine with you, I think we should merge that because the current
situation is error-prone.

For the time being, I've defined a remap_kmem wrapper which mirrors the previous
actions of the remap_io one, before I fixed the latter with the noncache
protection bits. At least we should get the same behaviour than previously wrt
to rtdm_mmap_buffer. This leaves some time to think about the kmem mapping modes
without breaking the current situation, but they should be correct now.

-- 
Philippe.

