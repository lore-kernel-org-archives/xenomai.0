Message-ID: <5339C5AC.4040409@xenomai.org>
Date: Mon, 31 Mar 2014 21:44:44 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20140331174555.GO17765@csclub.uwaterloo.ca>
 <5339B015.3080008@xenomai.org> <20140331182404.GP17765@csclub.uwaterloo.ca>
 <20140331191502.GQ17765@csclub.uwaterloo.ca> <5339BF3C.8090906@xenomai.org>
 <20140331191849.GR17765@csclub.uwaterloo.ca>
 <20140331193742.GS17765@csclub.uwaterloo.ca>
In-Reply-To: <20140331193742.GS17765@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Porting xenomai 2.6.3 and ipipe to 3.12 kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

On 03/31/2014 09:37 PM, Lennart Sorensen wrote:
> On Mon, Mar 31, 2014 at 03:18:49PM -0400, Lennart Sorensen wrote:
>> On Mon, Mar 31, 2014 at 09:17:16PM +0200, Gilles Chanteperdrix wrote:
>>> Are you sure you are loking at the right tree? I am talking about the
>>> raw/for-ipipe-3.12.0 tree in ipipe-gch.git, not the raw/ipipe-3.12.0
>>> tree in ipipe.git
>>
>> Oh, then no, wrong tree.
>>
>> Let me check the other one.
> 
> Ok that looks better.
> 
> Couple of things:
> 
> I think this is wrong:
> 
>   @@ -268,13 +298,22 @@ extern void flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr                               
>     * Harvard caches are synchronised for the user space address range.                                                                
>     * This is used for the ARM private sys_cacheflush system call.
>     */
>   -#define flush_cache_user_range(s,e)    __cpuc_coherent_user_range(s,e)
>   +#define flush_cache_user_range(s, e)                                   \                                                            
>   +       ({                                                              \                                                            
>   +               struct mm_struct *_mm = current->mm;                    \
>   +               unsigned long _s, _e;                                   \
>   +               _s = fcse_va_to_mva(_mm, s) & PAGE_MASK;                \
>   +               _e = PAGE_ALIGN(fcse_va_to_mva(_mm, e));                \
>   +               __cpuc_coherent_user_range(_s, _e);                     \                                                            
>   +       })                                                                                                                           
>    
>    /* 
>     * Perform necessary cache operations to ensure that data previously                                                                
> 
> The kernel specificly did NOT want the PAGE_MASK and PAGE_ALIGN and got
> rid of it.  At last that's what the commit that changed it said.  So I
> think the ipipe patch should follow that change too.  ie:
> 
>   @@ -268,13 +298,22 @@ extern void flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr                               
>     * Harvard caches are synchronised for the user space address range.                                                                
>     * This is used for the ARM private sys_cacheflush system call.
>     */
>   -#define flush_cache_user_range(s,e)    __cpuc_coherent_user_range(s,e)
>   +#define flush_cache_user_range(s, e)                                   \                                                            
>   +       ({                                                              \                                                            
>   +               struct mm_struct *_mm = current->mm;                    \
>   +               unsigned long _s, _e;                                   \
>   +               _s = fcse_va_to_mva(_mm, s);                            \
>   +               _e = fcse_va_to_mva(_mm, e);                            \
>   +               __cpuc_coherent_user_range(_s, _e);                     \                                                            
>   +       })                                                                                                                           
>    
>    /* 
>     * Perform necessary cache operations to ensure that data previously                                                                

Ok, thanks, will fix in 3.14 patch.

> 
> Also my version of arch/arm/include/asm/barrier.h turned out a bit
> different (I was trying to avoid changing the kernel code as much as
> possible).  Diff versus yours is:

I do not really see differences...



> +#define dmb(option) __asm__ __volatile__("" #option : : : "memory")

...except this which is wrong (ish, shst are probably not valid
instructions, and only make sense as suffixes after dmb). It should not
even compile.



-- 
                                                                Gilles.

