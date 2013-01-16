Message-ID: <50F66343.4060508@xenomai.org>
Date: Wed, 16 Jan 2013 09:22:27 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50F5741A.9060404@grandegger.com> <50F5B1FD.3040901@xenomai.org>
	<50F658BA.7050107@grandegger.com>
In-Reply-To: <50F658BA.7050107@grandegger.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rtdm_iomap_to_user: fix caching and page fault issues
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 01/16/2013 08:37 AM, Wolfgang Grandegger wrote:

> On 01/15/2013 08:46 PM, Gilles Chanteperdrix wrote:
>> On 01/15/2013 04:22 PM, Wolfgang Grandegger wrote:
>>
>>> From: Wolfgang Grandegger <wg@denx.de>
>>>
>>> Pages mapped by rtdm_iomap_to_user() might be cached and may
>>> page fault on the first write. At least that's the behaviour
>>> we observed on an ARM mx6q system. This patch fixes these
>>> issues.
>>>
>>> Signed-off-by: Wolfgang Grandegger <wg@denx.de>
>>> ---
>>>  include/asm-generic/wrappers.h | 2 +-
>>>  ksrc/skins/rtdm/drvlib.c       | 8 +++++---
>>>  2 files changed, 6 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/include/asm-generic/wrappers.h b/include/asm-generic/wrappers.h
>>> index de1f0d7..e71bcc3 100644
>>> --- a/include/asm-generic/wrappers.h
>>> +++ b/include/asm-generic/wrappers.h
>>> @@ -394,7 +394,7 @@ static inline void *kzalloc(size_t size, int flags)
>>>  #define wrap_remap_io_page_range(vma,from,to,size,prot)  ({		\
>>>      (vma)->vm_page_prot = pgprot_noncached((vma)->vm_page_prot);	\
> 
> Hm, here pgprot_noncached() is already used.
> 
>>>      /* Sets VM_RESERVED | VM_IO | VM_PFNMAP on the vma. */		\
>>> -    remap_pfn_range(vma,from,(to) >> PAGE_SHIFT,size,prot);		\
>>> +    remap_pfn_range(vma,from,(to) >> PAGE_SHIFT,size,pgprot_noncached(prot));		\
>>
>>
>> Should not this be decided in the upper layers?
> 
> Upper layers? You mean calling xnarch_remap_io_page_range() with the
> protection argument "pgprot_noncached(PAGE_SHARED)" in rtdm_mmap_buffer()?


I mean users could want to map i/o regions cacheable, but as you say,
the pgprot_noncached is already hardcoded in the vma, so, I will merge
your patch.

-- 
                                                                Gilles.

