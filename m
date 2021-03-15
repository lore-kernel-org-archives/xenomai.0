Subject: Re: [PATCH 4.19] ipipe: mm: Restore unCOW support for copy_pte_range
References: <ed8ae0bb-bf1d-60f0-e1b5-ca4cbd675076@siemens.com>
 <01998876-7e1e-2b84-cc65-8cda310083f2@siemens.com>
 <87mtvgwcq9.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <322cbb3f-839a-2141-33d7-58e15a653af0@siemens.com>
Date: Mon, 15 Mar 2021 11:00:57 +0100
MIME-Version: 1.0
In-Reply-To: <87mtvgwcq9.fsf@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>, Greg Gallagher <greg@embeddedgreg.com>

On 06.03.21 15:58, Philippe Gerum wrote:
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 05.03.21 12:38, Jan Kiszka via Xenomai wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> This is still needed to avoid that a real-time parent seems minor faults
>>> after forking for shared pages until they are finally unshared.
>>>
>>> This missing support became visible in Xenomai when running the complete
>>> smokey test suite on certain architectures/config combinations.
>>>
>>> Fixes: 0f0b6099c45f ("ipipe: mm: Drop un-COW from copy_pte_range")
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>
>>> For discussion. If there is a better pattern in reach, I'm happy to go 
>>> that path as well.
>>>
>>> Otherwise, this should go into our 4.19 branches (Greg, your arm64 isn't 
>>> in sync with noarch, you will need manual merging). Possibly, it already 
>>> applies to 5.4 as well, didn't check yet.
>>>
>>>  mm/memory.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++-----
>>>  1 file changed, 69 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index 4cc7c72a0b7e..f102f4de2213 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -141,6 +141,9 @@ EXPORT_SYMBOL(zero_pfn);
>>>  
>>>  unsigned long highest_memmap_pfn __read_mostly;
>>>  
>>> +static bool cow_user_page(struct page *dst, struct page *src,
>>> +			  struct vm_fault *vmf);
>>> +
>>>  /*
>>>   * CONFIG_MMU architectures set up ZERO_PAGE in their paging_init()
>>>   */
>>> @@ -957,8 +960,9 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
>>>  
>>>  static inline unsigned long
>>>  copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>>> -		pte_t *dst_pte, pte_t *src_pte, struct vm_area_struct *vma,
>>> -		unsigned long addr, int *rss)
>>> +	     pte_t *dst_pte, pte_t *src_pte, struct vm_area_struct *vma,
>>> +	     unsigned long addr, int *rss, pmd_t *src_pmd,
>>> +	     struct page *uncow_page)
>>>  {
>>>  	unsigned long vm_flags = vma->vm_flags;
>>>  	pte_t pte = *src_pte;
>>> @@ -1036,6 +1040,33 @@ copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>>>  	 * in the parent and the child
>>>  	 */
>>>  	if (is_cow_mapping(vm_flags) && pte_write(pte)) {
>>> +#ifdef CONFIG_IPIPE
>>> +		if (uncow_page) {
>>> +			struct page *old_page = vm_normal_page(vma, addr, pte);
>>> +			struct vm_fault vmf;
>>> +
>>> +			vmf.vma = vma;
>>> +			vmf.address = addr;
>>> +			vmf.orig_pte = pte;
>>> +			vmf.pmd = src_pmd;
>>> +
>>> +			if (cow_user_page(uncow_page, old_page, &vmf)) {
>>> +				pte = mk_pte(uncow_page, vma->vm_page_prot);
>>> +
>>> +				if (vm_flags & VM_SHARED)
>>> +					pte = pte_mkclean(pte);
>>> +				pte = pte_mkold(pte);
>>> +
>>> +				page_add_new_anon_rmap(uncow_page, vma, addr,
> 
>>> +						       false);
>>> +				rss[!!PageAnon(uncow_page)]++;
>>> +				goto out_set_pte;
>>> +			} else {
>>> +				/* unexpected: source page no longer present */
>>> +				WARN_ON_ONCE(1);
>>> +			}
>>> +		}
>>> +#endif /* CONFIG_IPIPE */
>>>  		ptep_set_wrprotect(src_mm, addr, src_pte);
>>>  		pte = pte_wrprotect(pte);
>>>  	}
>>> @@ -1083,13 +1114,27 @@ static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>>>  	int progress = 0;
>>>  	int rss[NR_MM_COUNTERS];
>>>  	swp_entry_t entry = (swp_entry_t){0};
>>> -
>>> +	struct page *uncow_page = NULL;
>>> +#ifdef CONFIG_IPIPE
>>> +	int do_cow_break = 0;
>>> +again:
>>> +	if (do_cow_break) {
>>> +		uncow_page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
>>> +		if (uncow_page == NULL)
>>> +			return -ENOMEM;
>>> +		do_cow_break = 0;
>>> +	}
>>> +#else
>>>  again:
>>> +#endif
>>>  	init_rss_vec(rss);
>>>  
>>>  	dst_pte = pte_alloc_map_lock(dst_mm, dst_pmd, addr, &dst_ptl);
>>> -	if (!dst_pte)
>>> +	if (!dst_pte) {
>>> +		if (uncow_page)
>>> +			put_page(uncow_page);
>>>  		return -ENOMEM;
>>> +	}
>>>  	src_pte = pte_offset_map(src_pmd, addr);
>>>  	src_ptl = pte_lockptr(src_mm, src_pmd);
>>>  	spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
>>> @@ -1112,8 +1157,25 @@ static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>>>  			progress++;
>>>  			continue;
>>>  		}
>>> +#ifdef CONFIG_IPIPE
>>> +		if (likely(uncow_page == NULL) && likely(pte_present(*src_pte))) {
>>> +			if (is_cow_mapping(vma->vm_flags) &&
>>> +			    test_bit(MMF_VM_PINNED, &src_mm->flags) &&
>>> +			    ((vma->vm_flags|src_mm->def_flags) & VM_LOCKED)) {
>>> +				arch_leave_lazy_mmu_mode();
>>> +				spin_unlock(src_ptl);
>>> +				pte_unmap(src_pte);
>>> +				add_mm_rss_vec(dst_mm, rss);
>>> +				pte_unmap_unlock(dst_pte, dst_ptl);
>>> +				cond_resched();
>>> +				do_cow_break = 1;
>>> +				goto again;
>>> +			}
>>> +		}
>>> +#endif
>>>  		entry.val = copy_one_pte(dst_mm, src_mm, dst_pte, src_pte,
>>> -							vma, addr, rss);
>>> +					 vma, addr, rss, src_pmd, uncow_page);
>>> +		uncow_page = NULL;
>>>  		if (entry.val)
>>>  			break;
>>>  		progress += 8;
>>> @@ -2348,8 +2410,8 @@ static inline int pte_unmap_same(struct mm_struct *mm, pmd_t *pmd,
>>>  	return same;
>>>  }
>>>  
>>> -static inline bool cow_user_page(struct page *dst, struct page *src,
>>> -				 struct vm_fault *vmf)
>>> +static bool cow_user_page(struct page *dst, struct page *src,
>>> +			  struct vm_fault *vmf)
>>>  {
>>>  	bool ret;
>>>  	void *kaddr;
>>>
>>
>> With this applied to ipipe-4.19 and 5.4 queues, related issues are gone, see
>>
>> https://source.denx.de/Xenomai/xenomai-images/-/pipelines/6670
>>
>> I'm inclined to take this for now so that we can move forward with other
>> topics. Any comments?
>>
> 
> Fine with me. This code can be simplified, working on it. I'll channel
> this through Dovetail.
> 

This didn't make into dovetail/v5.10 yet, did it? Asking because smokey
triggers tones of primary mode migrations over dovetail.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

