Subject: Re: Mapping unchached memory with UDD
References: <c0aefe52-0ba1-72fb-88d8-edc1fc73880e@grandegger.com>
 <09544b49-088d-e0e0-1dca-7f7df9ec12e0@xenomai.org>
 <eba476d3-59a0-85ff-599e-4270af06d8f1@grandegger.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <b49ccf54-23d4-3b8d-fff9-3cf149bad830@xenomai.org>
Date: Sat, 16 Mar 2019 14:39:21 +0100
MIME-Version: 1.0
In-Reply-To: <eba476d3-59a0-85ff-599e-4270af06d8f1@grandegger.com>
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
To: Wolfgang Grandegger <wg@grandegger.com>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 3/16/19 12:48 PM, Wolfgang Grandegger wrote:
> Hello Philippe,
> 
> Am 14.03.19 um 15:32 schrieb Philippe Gerum:
>>
>> Hi Wolfgang,
>>
>> On 3/14/19 11:38 AM, Wolfgang Grandegger via Xenomai wrote:
>>> Hello,
>>>
>>> I'm writing a little UDD driver to handling interrupts and shared memory
>>> to communicate with a co-processor. Is it possible to setup and map a
>>> "mem_region" for *uncahced* memory. Will it be automatically uncached if
>>> it's of type UDD_MEM_PHY?
>>>
>>
>> Yep. Such requests is routed to RTDM's iomem mapping helper, which does:
>>
>> static int mmap_iomem_helper(struct vm_area_struct *vma, phys_addr_t pa)
>> {
>> 	pgprot_t prot = PAGE_SHARED;
>> 	unsigned long len;
>>
>> 	len = vma->vm_end - vma->vm_start;
>> 	...
>> 	vma->vm_page_prot = pgprot_noncached(prot);
>>
>> 	return remap_pfn_range(vma, vma->vm_start, pa >> PAGE_SHIFT,
>> 			       len, vma->vm_page_prot);
>> }
> 
> I was aware of that code! I suspected some other magic when mapping
> system memory with UDD_MEM_PHY. Maybe it's a barrier issue in the A9 or
> M4 code.
> 

Any DMA in between?


-- 
Philippe.

