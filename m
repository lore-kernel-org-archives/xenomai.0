Message-ID: <4D25C9D6.4030707@domain.hid>
Date: Thu, 06 Jan 2011 14:55:34 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <6FCCA913376DD7488F4139A4D11B8F48016311A5@domain.hid>	<4D1FAE66.8080005@domain.hid>	<6FCCA913376DD7488F4139A4D11B8F4801673CAB@troe2k1.cs.myharris.net>
	<4D24E3AC.2000904@domain.hid> <4D24EB92.3050104@domain.hid>
	<4D24F0B7.7010604@domain.hid>
	<6FCCA913376DD7488F4139A4D11B8F4801673CD4@domain.hid>
In-Reply-To: <6FCCA913376DD7488F4139A4D11B8F4801673CD4@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [Xenomai -help] User space access to DMA memory
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Herrera-Bendezu, Luis" <lherrera@domain.hid>
Cc: xenomai@xenomai.org

Herrera-Bendezu, Luis wrote:
> On 01/05/2011 5:29 PM Gilles Chanteperdrix wrote:
>> Steven A. Falco wrote:
>>> On 01/05/2011 04:33 PM, Gilles Chanteperdrix wrote:
>>>> Herrera-Bendezu, Luis wrote:
>>>>> Gilles:
>>>>>
>>>>>> Herrera-Bendezu, Luis wrote:
>>>>>>> Hello:
>>>>>>>
>>>>>>> I have the following setup:
>>>>>>> PPC405EX
>>>>>>> Linux 2.6.30.3
>>>>>>> Xenomai 2.4.10
>>>>>>> I-pipe 2.7-02
>>>>>>> ppc_4xx-gcc (GCC) 4.2.2
>>>>>>> Configuration file is attached
>>>>>> Do you have the same issue with the latest version of the I-pipe patch
>>>>>> for this same version of the Linux kernel? It should be 2.8-00.
>>>>> Tried I-pipe 2.8-00 which needs Linux 2.6.32.
>>>> Sorry, I misread the ftp list, I was rather thinking about:
>>>> http://download.gna.org/adeos/patches/v2.6/powerpc/older/adeos-ipipe-2.6.30.3-powerpc-DENX-2.7-
>> 06.patch
>>>>
>>>>  It resulted on same problem
>>>>> as reported with Linux 2.6.30.3 I-pipe 2.7-02.
>>>>>
>>>>> Was there any particular set of changes that you expected it could fix the
>>>>> problem? Do you think more recent versions may work? If yes, which version
>>>>> could be tried?
>>>> Yes, there was a fix, specifially in the powerpc tree, with mappings
>>>> issue. But I think it is older than 2.6.32.
>>>>
>>>> Now that I look at your message again, your problem seems more likely to
>>>> be in your code. Specifically, you say: "bus address returned by
>>>> pci_alloc_consistent()". I do not think pci_alloc_consistent return
>>>> value is a bus address. The dma_handle returned by pointer probably is.
>>>> But I am not sure you are supposed to know this.
>>> pci_alloc_consistent() returns two values.  The kernel address is
>>> returned directly (as a void *), and the bus address is returned
>>> through the dma_handle pointer (third function argument).
>>>
>>> Luis' original email indicated that he tried rtdm_mmap_to_user()
>>> on the kernel address, and he tried rtdm_iomap_to_user() on the
>>> bus address. Either way caused the crash he reported.
>> Ok. Could you try to do the same operation with the native API? You just
>> have to pass H_SHARED | H_DMA | H_NONCACHED as flags to rt_heap_create
>> to get the same effect as pci_dma_alloc_coherent.
>>
>> Just to see if the error lies in RTDM implementation or in Xenomai
>> generic code.
>>
>>
>>> We have a home-grown program (mm) that basically opens /dev/mem
>>> and allows peek/poke.  Using that with the bus address works to
>>> access the memory.  We also pass that address to our hardware,
>>> and it correctly DMAs the data.  So we believe the bus address
>>> is correct.
>> You mean much like devmem2? Now even part of the busybox?
>>
>>> I believe Luis has also tried a third approach - allocating with
>>> kzalloc(size, GFP_DMA), and using rtdm_mmap_to_user() on the
>>> resulting pointer.  That works, but getting the bus address is
>>> a bit ugly - basically page_to_phys(virt_to_page()) of the pointer.
>>>
>>> So there is something different about the way pci_alloc_consistent()
>>> allocates memory as compared to kzalloc(GFP_DMA).  kzalloc(GFP_DMA)
>>> works with rtdm_mmap_to_user() but pci_alloc_consistent() does
>>> not.
>> This gives me an idea. Could you try the following patch? Even before
>> trying the native API.
>>
>> diff --git a/ksrc/skins/rtdm/drvlib.c b/ksrc/skins/rtdm/drvlib.c
>> index 3495e63..d7dd3db 100644
>> --- a/ksrc/skins/rtdm/drvlib.c
>> +++ b/ksrc/skins/rtdm/drvlib.c
>> @@ -1810,7 +1810,7 @@ static int rtdm_mmap_buffer(struct file *filp, struct vm_area_struct *vma)
>> 	vaddr = (unsigned long)mmap_data->src_vaddr;
>> 	paddr = mmap_data->src_paddr;
>> 	if (paddr == 0)	/* kmalloc memory? */
>> -		paddr = __pa(vaddr);
>> +		paddr = page_to_phys(virt_to_page(vaddr));
>>
>> 	maddr = vma->vm_start;
>> 	size = vma->vm_end - vma->vm_start;
>>
>>
>> --
>>                                                                Gilles.
> 
> Note: patch was slightly modified to:
> 
> diff --git a/ksrc/skins/rtdm/drvlib.c b/ksrc/skins/rtdm/drvlib.c
> index 8922689..c8967db 100644
> --- a/ksrc/skins/rtdm/drvlib.c
> +++ b/ksrc/skins/rtdm/drvlib.c
> @@ -1784,7 +1784,8 @@ static int rtdm_mmap_buffer(struct file *filp, struct vm_a
>         paddr = mmap_data->src_paddr;
>         if (!paddr)
>                 /* kmalloc memory */
> -               paddr = virt_to_phys((void *)vaddr);
> +               paddr = page_to_phys(virt_to_page(vaddr)) +
> +                 (unsigned long)(vaddr % PAGE_SIZE);

I do not think you are supposed to pass a non aligned address to
rtdm_mmap_to_user.

What about the other thing I asked you to test?

-- 
					    Gilles.

