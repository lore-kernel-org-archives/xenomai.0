Subject: Re: Mapping unchached memory with UDD
References: <c0aefe52-0ba1-72fb-88d8-edc1fc73880e@grandegger.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <09544b49-088d-e0e0-1dca-7f7df9ec12e0@xenomai.org>
Date: Thu, 14 Mar 2019 15:32:40 +0100
MIME-Version: 1.0
In-Reply-To: <c0aefe52-0ba1-72fb-88d8-edc1fc73880e@grandegger.com>
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


Hi Wolfgang,

On 3/14/19 11:38 AM, Wolfgang Grandegger via Xenomai wrote:
> Hello,
> 
> I'm writing a little UDD driver to handling interrupts and shared memory
> to communicate with a co-processor. Is it possible to setup and map a
> "mem_region" for *uncahced* memory. Will it be automatically uncached if
> it's of type UDD_MEM_PHY?
> 

Yep. Such requests is routed to RTDM's iomem mapping helper, which does:

static int mmap_iomem_helper(struct vm_area_struct *vma, phys_addr_t pa)
{
	pgprot_t prot = PAGE_SHARED;
	unsigned long len;

	len = vma->vm_end - vma->vm_start;
	...
	vma->vm_page_prot = pgprot_noncached(prot);

	return remap_pfn_range(vma, vma->vm_start, pa >> PAGE_SHIFT,
			       len, vma->vm_page_prot);
}

-- 
Philippe.

