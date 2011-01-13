From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4D2E27C4.7040106@domain.hid>
References: <6FCCA913376DD7488F4139A4D11B8F48016311A5@domain.hid>
	<4D1FAE66.8080005@domain.hid>
	<6FCCA913376DD7488F4139A4D11B8F4801673CAB@troe2k1.cs.myharris.net>
	<4D24E3AC.2000904@domain.hid> <4D24EB92.3050104@domain.hid>
	<4D24F0B7.7010604@domain.hid>
	<6FCCA913376DD7488F4139A4D11B8F4801673CD4@domain.hid>
	<4D25C9D6.4030707@domain.hid> <4D2CE77C.7000109@domain.hid>
	<6FCCA913376DD7488F4139A4D11B8F4801674163@domain.hid>
	<4D2DAE16.2060805@domain.hid>
	<6FCCA913376DD7488F4139A4D11B8F48016741A9@domain.hid>
	<4D2DD61E.7000006@domain.hid>
	<6FCCA913376DD7488F4139A4D11B8F48016741F6@domain.hid>
	<4D2E10E4.7040608@domain.hid>
	<6FCCA913376DD7488F4139A4D11B8F4801674280@domain.hid>
	<1294870292.1828.258.camel@domain.hid>  <4D2E27C4.7040106@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 13 Jan 2011 09:27:28 +0100
Message-ID: <1294907248.1860.9.camel@domain.hid>
Mime-Version: 1.0
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, 2011-01-12 at 23:14 +0100, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
> > On Wed, 2011-01-12 at 16:57 -0500, Herrera-Bendezu, Luis wrote:
> >>> -----Original Message-----
> >>> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> >>> Sent: Wednesday, January 12, 2011 3:37 PM
> >>> To: Herrera-Bendezu, Luis
> >>> Cc: xenomai@xenomai.org
> >>> Subject: Re: [Xenomai-help] [Xenomai -help] User space access to DMA memory
> >>>
> >>> Herrera-Bendezu, Luis wrote:
> >>>>> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> >>>>> Sent: Wednesday, January 12, 2011 11:26 AM
> >>>>> To: Herrera-Bendezu, Luis
> >>>>> Cc: xenomai@xenomai.org
> >>>>> Subject: Re: [Xenomai-help] [Xenomai -help] User space access to DMA memory
> >>>>>
> >>>>> Herrera-Bendezu, Luis wrote:
> >>>>>>> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> >>>>>>> Sent: Wednesday, January 12, 2011 8:35 AM
> >>>>>>> To: Herrera-Bendezu, Luis
> >>>>>>> Cc: xenomai@xenomai.org
> >>>>>>> Subject: Re: [Xenomai-help] [Xenomai -help] User space access to DMA memory
> >>>>>>>
> >>>>>>> Herrera-Bendezu, Luis wrote:
> >>>>>>>>> -----Original Message-----
> >>>>>>>>> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> >>>>>>>>> Sent: Tuesday, January 11, 2011 6:28 PM
> >>>>>>>>> To: Herrera-Bendezu, Luis
> >>>>>>>>> Cc: xenomai@xenomai.org
> >>>>>>>>> Subject: Re: [Xenomai-help] [Xenomai -help] User space access to DMA memory
> >>>>>>>>>
> >>>>>>>>> Gilles Chanteperdrix wrote:
> >>>>>>>>>> Herrera-Bendezu, Luis wrote:
> >>>>>>>>>>> On 01/05/2011 5:29 PM Gilles Chanteperdrix wrote:
> >>>>>>>>>>>> Steven A. Falco wrote:
> >>>>>>>>>>>>> On 01/05/2011 04:33 PM, Gilles Chanteperdrix wrote:
> >>>>>>>>>>>> Ok. Could you try to do the same operation with the native API? You just
> >>>>>>>>>>>> have to pass H_SHARED | H_DMA | H_NONCACHED as flags to rt_heap_create
> >>>>>>>>>>>> to get the same effect as pci_dma_alloc_coherent.
> >>>>>>>>>>>>
> >>>>>>>>>>>> Just to see if the error lies in RTDM implementation or in Xenomai
> >>>>>>>>>>>> generic code.
> >>>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>> (...)
> >>>>>>>>>> What about the other thing I asked you to test?
> >>>>>>>>>>
> >>>>>>>>> Ping? Any news about this test?
> >>>>>>>> rt_heap_create() with flags H_SHARED | H_DMA | H_NONCACHED report -EINVAL.
> >>>>>>>> Documentation indicates that H_NONCACHE is not compatible with H_DMA.
> >>>>>>> Right, supporting H_NONCACHED | H_DMA would mean that we would have to
> >>>>>>> use kmalloc/get_free_pages then establish a non-cached mapping in
> >>>>>>> kernel-space with vm_map_ram.
> >>>>>>>
> >>>>>>> Could you try with H_NONCACHED, but without H_DMA? Of course, the
> >>>>>>> mapping can not be used for DMA, as it will probably not be physically
> >>>>>>> contiguous, but at least you can try whether accessing in user-space a
> >>>>>>> non-cached mapping works.
> >>>>>> It does work but unless an external unit writes to heap memory it would
> >>>>>> be difficult to verify that the non-cached memory actually works, i.e.
> >>>>>> access from user space gets expected value(s).
> >>>>> I am quite confident this works.
> >>>>>
> >>>>>>> In any case, we see a defect in the RTDM interface here: we can not ask
> >>>>>>> the mapping to be mapped non-cacheable, which somewhat defeats the
> >>>>>>> purpose of pci_alloc_consistent. I do not know enough the powerpc
> >>>>>>> architecture to know whether this could be the cause of your issue (the
> >>>>>>> same physical area mapped twice, once cached, once non-cached). However,
> >>>>>>> on the ARM architecture, for instance, it is bad.
> >>>>>>>
> >>>>>> Let me summarize the ideas discussed so far to allocate consistent memory
> >>>>>> suitable for DMA and corresponding mapping to user space:
> >>>>>> * rt_heap cannot be created with both H_NONCACHED and H_DMA. But it is
> >>>>>>   automatically mapped to user space with rt_heap_bind().
> >>>>>>
> >>>>>>   A solution can be to allocate heap with H_SHARED | H_DMA, somehow
> >>>>>>   get bus address of single block of memory (rt_heap { sba } ?) to
> >>>>>>   used for DMA operations.
> >>>>> The test with rt_heap was just a test to have a comparison between
> >>>>> xnheap code and rtdm_mmap. But we may indeed want to fix mmappable
> >>>>> xnheaps later on.
> >>>>>
> >>>>>> * RTDM interface rtdm_mmap/unmap cannot handle non-cacheable memory.
> >>>>>>
> >>>>>>   A solution can be to allocate GFP_DMA memory with kmalloc(), use
> >>>>>>   rtdm_mmap to map to user space. Programmatically make memory
> >>>>>>   consistent before/after DMA transfer to/from external unit, e.g.
> >>>>>>   dma_sync_single_for_device()/dma_sync_single_for_cpu(). This is
> >>>>>>   similar to what streaming DMA mappings do.
> >>>>>>
> >>>>>> * Ideally, it should be possible to take memory allocated from
> >>>>>>   dma_alloc_coherent()/pci_alloc_consistent() and mapped it to
> >>>>>>   user space using rtdm_mmap().
> >>>>> To check that the non-cacheable mapping is indeed the problem, here is a
> >>>>> patch which adds the possibility to add non-cacheable mappings:
> >>>>>
> >>>>> diff --git a/ksrc/skins/rtdm/drvlib.c b/ksrc/skins/rtdm/drvlib.c
> >>>>> index 3495e63..ec0ddae 100644
> >>>>> --- a/ksrc/skins/rtdm/drvlib.c
> >>>>> +++ b/ksrc/skins/rtdm/drvlib.c
> >>>>> @@ -1791,6 +1791,7 @@ void rtdm_nrtsig_pend(rtdm_nrtsig_t *nrt_sig);
> >>>>>
> >>>>> #if defined(CONFIG_XENO_OPT_PERVASIVE) || defined(DOXYGEN_CPP)
> >>>>> struct rtdm_mmap_data {
> >>>>> +	int noncached;
> >>>>> 	void *src_vaddr;
> >>>>> 	phys_addr_t src_paddr;
> >>>>> 	struct vm_operations_struct *vm_ops;
> >>>>> @@ -1815,6 +1816,9 @@ static int rtdm_mmap_buffer(struct file *filp,
> >>>>> struct vm_area_struct *vma)
> >>>>> 	maddr = vma->vm_start;
> >>>>> 	size = vma->vm_end - vma->vm_start;
> >>>>>
> >>>>> +	if (mmap_data->noncached)
> >>>>> +		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> >>>>> +
> >>>>> #ifdef CONFIG_MMU
> >>>>> 	/* Catch vmalloc memory (vaddr is 0 for I/O mapping) */
> >>>>> 	if ((vaddr >= VMALLOC_START) && (vaddr < VMALLOC_END)) {
> >>>>> @@ -1975,6 +1979,24 @@ int rtdm_mmap_to_user(rtdm_user_info_t *user_info,
> >>>>> 		      void *vm_private_data)
> >>>>> {
> >>>>> 	struct rtdm_mmap_data mmap_data = {
> >>>>> +		.noncached = 0,
> >>>>> +		.src_vaddr = src_addr,
> >>>>> +		.src_paddr = 0,
> >>>>> +		.vm_ops = vm_ops,
> >>>>> +		.vm_private_data = vm_private_data
> >>>>> +	};
> >>>>> +
> >>>>> +	return rtdm_do_mmap(user_info, &mmap_data, len, prot, pptr);
> >>>>> +}
> >>>>> +
> >>>>> +int rtdm_mmap_noncached_to_user(rtdm_user_info_t *user_info,
> >>>>> +				void *src_addr, size_t len,
> >>>>> +				int prot, void **pptr,
> >>>>> +				struct vm_operations_struct *vm_ops,
> >>>>> +				void *vm_private_data)
> >>>>> +{
> >>>>> +	struct rtdm_mmap_data mmap_data = {
> >>>>> +		.noncached = 1,
> >>>>> 		.src_vaddr = src_addr,
> >>>>> 		.src_paddr = 0,
> >>>>> 		.vm_ops = vm_ops,
> >>>>> @@ -2043,6 +2065,7 @@ int rtdm_iomap_to_user(rtdm_user_info_t *user_info,
> >>>>> 		       void *vm_private_data)
> >>>>> {
> >>>>> 	struct rtdm_mmap_data mmap_data = {
> >>>>> +		.noncached = 0,
> >>>>> 		.src_vaddr = NULL,
> >>>>> 		.src_paddr = src_addr,
> >>>>> 		.vm_ops = vm_ops,
> >>>>>
> >>>>> Simply call rtdm_mmap_noncached_to_user instead of rtdm_mmap_to_user.
> >>>>>
> >>>> Get same kernel panic error as before with this patch. I need to look closer
> >>>> at what are the memory allocation functions used by pci_ and dma_.
> >>> Could you try rtdm_iomap_to_user (but beware, pass the physical address
> >>> returned by pointer by pci_alloc_consistent)? virt_to_page, or __pa will
> >>> not work with vmalloc/ioremap addresses. And pci_alloc_consistent
> >>> probably returns a vmalloc mapping due to the fact that the mapping
> >>> needs to be non-cacheable, which will happen if your powerpc does not
> >>> support cache snooping, and define CONFIG_NOT_COHERENT_CACHE.
> >>>
> >> Your suggestion works. Can you highlight why it fails when using
> >> rtdm_mmap_to_user()?
> > 
> > Because unlike the former, it does not get the right platform-dependent
> > protection bits for the vma from phys_mem_access_prot() for this kind of
> > memory.
> 
> There is another issue: the memory returned by pci_alloc_consistent
> should be handled as vmalloc memory, but it is allocated in a separated
> area, the CONSISTENT_BASE, CONSISTENT_END area. So the test:
> 
> if ((vaddr >= VMALLOC_START) && (vaddr < VMALLOC_END))
> 
> returns false, and the memory is handled as if it were kmalloced memory.
> 

This is the reason why calling rtdm_mmap_to_user for mapping coherent
memory is not appropriate in the first place, because as the doc states,
it is for mapping kernel memory pages, but DMA/PCI coherent memory may
have platform-dependent specifics which make it a different kind of
beast. Perhaps the documentation should stress this aspect, so that
rtdm_iomap_to_user() is considered instead.

-- 
Philippe.



