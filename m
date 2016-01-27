References: <20160114183423.69665622@md1em3qc>
 <1453821607-20836-1-git-send-email-henning.schild@siemens.com>
 <56A7D4AD.9090601@siemens.com> <20160127105448.65c467d2@md1em3qc>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <56A89C77.9050105@siemens.com>
Date: Wed, 27 Jan 2016 11:31:19 +0100
MIME-Version: 1.0
In-Reply-To: <20160127105448.65c467d2@md1em3qc>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] ipipe x86 mm: handle huge pages in memory
	pinning
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>, Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2016-01-27 10:54, Henning Schild wrote:
> On Tue, 26 Jan 2016 21:18:53 +0100
> Jan Kiszka <jan.kiszka@siemens.com> wrote:
> 
>> On 2016-01-26 16:20, Henning Schild wrote:
>>> In 4.1 huge page mapping of io memory was introduced, enable ipipe
>>> to handle that when pinning kernel memory.
>>>
>>> change that introduced the feature
>>> 0f616be120c632c818faaea9adcb8f05a7a8601f
>>>
>>> Signed-off-by: Henning Schild <henning.schild@siemens.com>
>>> ---
>>>  arch/x86/mm/fault.c | 16 ++++++++++++++++
>>>  1 file changed, 16 insertions(+)
>>>
>>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
>>> index fd5bbcc..5585610 100644
>>> --- a/arch/x86/mm/fault.c
>>> +++ b/arch/x86/mm/fault.c
>>> @@ -211,11 +211,19 @@ static inline pmd_t *vmalloc_sync_one(pgd_t
>>> *pgd, unsigned long address) pud_k = pud_offset(pgd_k, address);
>>>  	if (!pud_present(*pud_k))
>>>  		return NULL;
>>> +#if defined(CONFIG_IPIPE) && defined(CONFIG_HAVE_ARCH_HUGE_VMAP)
>>> +	if (pud_large(*pud))
>>> +		return pud_k;
>>> +#endif
>>>  
>>>  	pmd = pmd_offset(pud, address);
>>>  	pmd_k = pmd_offset(pud_k, address);
>>>  	if (!pmd_present(*pmd_k))
>>>  		return NULL;
>>> +#if defined(CONFIG_IPIPE) && defined(CONFIG_HAVE_ARCH_HUGE_VMAP)
>>> +	if (pmd_large(*pmd))
>>> +		return pmd_k;
>>> +#endif
>>>  
>>>  	if (!pmd_present(*pmd))
>>>  		set_pmd(pmd, *pmd_k);
>>> @@ -400,6 +408,10 @@ static inline int vmalloc_sync_one(pgd_t *pgd,
>>> unsigned long address) 
>>>  	if (pud_none(*pud) || pud_page_vaddr(*pud) !=
>>> pud_page_vaddr(*pud_ref)) BUG();
>>> +#if defined(CONFIG_IPIPE) && defined(CONFIG_HAVE_ARCH_HUGE_VMAP)
>>> +	if (pud_large(*pud))
>>> +		return 0;
>>> +#endif
>>>  
>>>  	pmd = pmd_offset(pud, address);
>>>  	pmd_ref = pmd_offset(pud_ref, address);
>>> @@ -408,6 +420,10 @@ static inline int vmalloc_sync_one(pgd_t *pgd,
>>> unsigned long address) 
>>>  	if (pmd_none(*pmd) || pmd_page(*pmd) != pmd_page(*pmd_ref))
>>>  		BUG();
>>> +#if defined(CONFIG_IPIPE) && defined(CONFIG_HAVE_ARCH_HUGE_VMAP)
>>> +	if (pmd_large(*pmd))
>>> +		return 0;
>>> +#endif
>>>  
>>>  	pte_ref = pte_offset_kernel(pmd_ref, address);
>>>  	if (!pte_present(*pte_ref))
>>>   
>>
>> Do we need the #ifdefs? If not, maybe just leave comments to establish
>> the relationship to I-pipe.
> 
> We do not, without ipipe the function is never called from a
> context where that check is required. If it was, this change or
> something similar would be in mainline.
> I see the ifdefs as kind of comments that establish the relationship to
> ipipe and the huge_vmap feature. Plus in all other cases a pointless
> check is not even compiled in.
> If comments should be used instead of ifdefs i will change that.

The optimal way of documenting the motivation for these changes is in a
changelog. Provided the patch will survive future I-pipe versions and
not be folded into a bigger patch (Philippe, please confirm), let's go
for that. Plan B is inline comments. But #ifdefs for documentation
purposes are not desirable.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

