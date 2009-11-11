Message-ID: <4AFAC4E1.1090109@domain.hid>
Date: Wed, 11 Nov 2009 15:06:25 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <6FCCA913376DD7488F4139A4D11B8F48FD1044@domain.hid>	<4AF99CAD.9070105@domain.hid>	<6FCCA913376DD7488F4139A4D11B8F48FD107D@troe2k1.cs.myharris.net>	<4AF9AD44.10000@domain.hid>	<6FCCA913376DD7488F4139A4D11B8F48FD1085@domain.hid>	<4AF9B6F2.9040206@domain.hid>	<6FCCA913376DD7488F4139A4D11B8F48FD10A9@domain.hid>	<4AF9D976.4020701@domain.hid>
	<6FCCA913376DD7488F4139A4D11B8F48FD1129@domain.hid>
In-Reply-To: <6FCCA913376DD7488F4139A4D11B8F48FD1129@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] rtdm_iomap_to_user with phys addr > 4GB
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Herrera-Bendezu, Luis" <lherrera@domain.hid>
Cc: xenomai@xenomai.org

Herrera-Bendezu, Luis wrote:
>  
> 
>> -----Original Message-----
>> From: jan.kiszka@domain.hid [mailto:jan.kiszka@domain.hid] 
>> Sent: Tuesday, November 10, 2009 4:22 PM
>> To: Herrera-Bendezu, Luis
>> Cc: xenomai@xenomai.org
>> Subject: Re: rtdm_iomap_to_user with phys addr > 4GB
>>
>> Herrera-Bendezu, Luis wrote:
>>>  
>>>
>>>> -----Original Message-----
>>>> From: Jan Kiszka [mailto:jan.kiszka@domain.hid] 
>>>> Sent: Tuesday, November 10, 2009 1:55 PM
>>>> To: Herrera-Bendezu, Luis
>>>> Cc: xenomai@xenomai.org
>>>> Subject: Re: rtdm_iomap_to_user with phys addr > 4GB
>>>>
>>>>
>>>> Herrera-Bendezu, Luis wrote:
>>>>>  
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Jan Kiszka [mailto:jan.kiszka@domain.hid] 
>>>>>> Sent: Tuesday, November 10, 2009 1:13 PM
>>>>>> To: Herrera-Bendezu, Luis
>>>>>> Cc: xenomai@xenomai.org
>>>>>> Subject: Re: rtdm_iomap_to_user with phys addr > 4GB
>>>>>>
>>>>>>
>>>>>> Herrera-Bendezu, Luis wrote:
>>>>>>>  
>>>>>>>
>>>>>>>> -----Original Message-----
>>>>>>>> From: Jan Kiszka [mailto:jan.kiszka@domain.hid] 
>>>>>>>> Sent: Tuesday, November 10, 2009 12:03 PM
>>>>>>>> To: Herrera-Bendezu, Luis
>>>>>>>> Cc: xenomai@xenomai.org
>>>>>>>> Subject: Re: rtdm_iomap_to_user with phys addr > 4GB
>>>>>>>>
>>>>>>>>
>>>>>>>> Herrera-Bendezu, Luis wrote:
>>>>>>>>> Hello,
>>>>>>>>>
>>>>>>>>> I am writing an RTDM driver to replace one that uses UIO. 
>>>>>> The device
>>>>>>>>> resides in a physical address > 4 GB on a PPC440EPx. The 
>>>> UIO could
>>>>>>>>> not handle this address so I made a proposal to address it, 
>>>>>>>> details at:
>> http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-April/070097.html
>>>>>>>>> Function rtdm_iomap_to_user() has same issue with the 
>>>> physical I/O
>>>>>>>>> address
>>>>>>>>>    unsigned long src_addr
>>>>>>>>>
>>>>>>>>> I am new to Xenomai and would like to get some ideas on 
>>>>>> how to solve
>>>>>>>>> this
>>>>>>>>> issue.
>>>>>>>> I think UIO as well as RTDM suffers from the same problem 
>>>> here: The
>>>>>>>> kernel service used to remap the physical memory 
>> (remap_pfn_range)
>>>>>>>> accepts unsigned long, not phys_addr_t. How is this 
>>>>>> supposed to work?
>>>>>>>> Jan
>>>>>>>>
>>>>>>>> -- 
>>>>>>>> Siemens AG, Corporate Technology, CT SE 2
>>>>>>>> Corporate Competence Center Embedded Linux
>>>>>>>>
>>>>>>> Actually, remap_pfn_range() gets passed the physical address left
>>>>>>> shifted by PAGE_SIZE in both UIO and RTDM 
>>>>>> (xnarch_remap_io_page_range,
>>>>>>> wrap_remap_io_page_range).
>>>>>> No, the target address is expressed in pages, the source in bytes.
>>>>>>
>>>>> That is true for rtdm_mmap_to_user but not for 
>>>> rtdm_iomap_to_user. See
>>>>> how
>>>>> mmap_data struct is set in both functions.
>>>>        struct rtdm_mmap_data mmap_data =
>>>>                { NULL, src_addr, vm_ops, vm_private_data };
>>>>
>>>> with src_addr = "physical I/O address to be mapped", setting
>>>> mmap_data.src_paddr -- are you looking at different code?
>>>>
>>> No, that is the code.
>> But there is nothing shifted, the shifting takes place in 
>> Xenomai's wrapper.
>>
>>>> Besides this, the key is how remap_pfn_page interprets the source
>>>> address argument.
>>>>
>>> I had used UIO with success (as described in link above). 
>> The equivalent
>>> code in UIO is (uio.c):
>>> static int uio_mmap_physical(struct vm_area_struct *vma)
>>> {
>>> 	struct uio_device *idev = vma->vm_private_data;
>>> 	int mi = uio_find_mem_index(vma);
>>> 	if (mi < 0)
>>> 		return -EINVAL;
>>>
>>> 	vma->vm_flags |= VM_IO | VM_RESERVED;
>>>
>>> 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>>>
>>> 	return remap_pfn_range(vma,
>>> 			       vma->vm_start,
>>> 			       idev->info->mem[mi].addr >> PAGE_SHIFT,
>>> 			       vma->vm_end - vma->vm_start,
>>> 			       vma->vm_page_prot);
>>> }
>>>
>>> where idev->info->mem[mi].addr, mem[.] is the list of 
>> mappable regions.
>>> Note that for UIO, the user application needs to mmap these 
>> regions to
>>> user space. This is a step that is not needed on RTDM, right?
>> OK, now I got my mistake: Confused by the wrong argument names of our
>> wrap_remap_io_page_range (and probably others) I thought that the
>> destination is given as page number, not the source.
>>
>> But before adding some fancy new service for this use case, I'd like to
>> understand how common it actually is (crazy embedded designs 
>> tend to pop
>> up and deprecate faster than such APIs...).
> I do not think this is a new service but a limitation in the design.
> The kernel supports it (application can mmap the device using /dev/mem)
> and the PPC (440EPx in particular) has PCI and internal peripherals
> located at addresses above 4 GB (I2C, SPI, etc.).

I think /dev/mem works by chance as it uses off_t to address the source,
and that is 64 bit even on 32 bit hosts.

But I just collected the confirmation that this extension of the PPC's
physical address range is indeed an increasingly common thing. It's
still a fairly new one, so the kernel is obviously also still in the
conversion process. Maybe poking those people again makes some sense.

>> And what was the final conclusion on LKML? As far as I understood the
>> UIO maintainer, the proposal was rejected. Any different follow-ups on
>> this that I missed? Of course, if you have a special design you can
>> always patch your kernel and Xenomai to fit these special purposes. But
>> for upstream support, kernel or Xenomai, it requires a clean and
>> portable model.
> There were no follow-ups and the reply concerning the required changes
> was:
> "I guess you'd have to look at the whole memory management stuff of each
>  architecture to find out which kind of memory can be mapped with
> addresses
>  above unsigned long. Hardware often needs more than one contigous
> pages.
>  It might well be possible that a certain arch could have RAM for user
> virtual
>  addresses above 4GB, but no hardware. I don't know PPC well enough to
> say
>  anything about its behaviour."
> 
> In the mean time, it would be helpful if you have some suggestions on
> how to
> change RTDM to handle this case.
> 

I think we can change rtdm_iomap_to_user to take src_addr as phys_addr_t
and propagate this internally properly. We also need to add a wrapper
for phys_addr_t for kernels that doesn't support this (<2.6.28). To my
current understanding, this should be sufficient, right?

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

