Date: Tue, 28 Feb 2017 12:33:58 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20170228123358.03955486@md1em3qc>
In-Reply-To: <20170228113150.12549-1-henning.schild@siemens.com>
References: <20170228113150.12549-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] x86/mm: Fix vmalloc_fault() to handle large
 pages properly
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

This guy is mainline since a while, was discovered in the context of
ipipe and has been backported to stable kernels. But in 4.1 it came in
at 4.1.19 and ipipe sits on 18, so cherry pick it on ipipe-4.1.y.

Henning

Am Tue, 28 Feb 2017 12:31:50 +0100
schrieb Henning Schild <henning.schild@siemens.com>:

> From: Toshi Kani <toshi.kani@hpe.com>
> 
> [ Upstream commit f4eafd8bcd5229e998aa252627703b8462c3b90f ]
> 
> A kernel page fault oops with the callstack below was observed
> when a read syscall was made to a pmem device after a huge amount
> (>512GB) of vmalloc ranges was allocated by ioremap() on a x86_64  
> system:
> 
>      BUG: unable to handle kernel paging request at ffff880840000ff8
>      IP: vmalloc_fault+0x1be/0x300
>      PGD c7f03a067 PUD 0
>      Oops: 0000 [#1] SM
>      Call Trace:
>         __do_page_fault+0x285/0x3e0
>         do_page_fault+0x2f/0x80
>         ? put_prev_entity+0x35/0x7a0
>         page_fault+0x28/0x30
>         ? memcpy_erms+0x6/0x10
>         ? schedule+0x35/0x80
>         ? pmem_rw_bytes+0x6a/0x190 [nd_pmem]
>         ? schedule_timeout+0x183/0x240
>         btt_log_read+0x63/0x140 [nd_btt]
>          :
>         ? __symbol_put+0x60/0x60
>         ? kernel_read+0x50/0x80
>         SyS_finit_module+0xb9/0xf0
>         entry_SYSCALL_64_fastpath+0x1a/0xa4
> 
> Since v4.1, ioremap() supports large page (pud/pmd) mappings in
> x86_64 and PAE.  vmalloc_fault() however assumes that the vmalloc
> range is limited to pte mappings.
> 
> vmalloc faults do not normally happen in ioremap'd ranges since
> ioremap() sets up the kernel page tables, which are shared by
> user processes.  pgd_ctor() sets the kernel's PGD entries to
> user's during fork().  When allocation of the vmalloc ranges
> crosses a 512GB boundary, ioremap() allocates a new pud table
> and updates the kernel PGD entry to point it.  If user process's
> PGD entry does not have this update yet, a read/write syscall
> to the range will cause a vmalloc fault, which hits the Oops
> above as it does not handle a large page properly.
> 
> Following changes are made to vmalloc_fault().
> 
> 64-bit:
> 
>  - No change for the PGD sync operation as it handles large
>    pages already.
>  - Add pud_huge() and pmd_huge() to the validation code to
>    handle large pages.
>  - Change pud_page_vaddr() to pud_pfn() since an ioremap range
>    is not directly mapped (while the if-statement still works
>    with a bogus addr).
>  - Change pmd_page() to pmd_pfn() since an ioremap range is not
>    backed by struct page (while the if-statement still works
>    with a bogus addr).
> 
> 32-bit:
>  - No change for the sync operation since the index3 PGD entry
>    covers the entire vmalloc range, which is always valid.
>    (A separate change to sync PGD entry is necessary if this
>     memory layout is changed regardless of the page size.)
>  - Add pmd_huge() to the validation code to handle large pages.
>    This is for completeness since vmalloc_fault() won't happen
>    in ioremap'd ranges as its PGD entry is always valid.
> 
> Reported-by: Henning Schild <henning.schild@siemens.com>
> Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
> Acked-by: Borislav Petkov <bp@alien8.de>
> Cc: <stable@vger.kernel.org> # 4.1+
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Brian Gerst <brgerst@gmail.com>
> Cc: Denys Vlasenko <dvlasenk@redhat.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Luis R. Rodriguez <mcgrof@suse.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Toshi Kani <toshi.kani@hp.com>
> Cc: linux-mm@kvack.org
> Cc: linux-nvdimm@lists.01.org
> Link:
> http://lkml.kernel.org/r/1455758214-24623-1-git-send-email-toshi.kani@hpe.com
> Signed-off-by: Ingo Molnar <mingo@kernel.org> Signed-off-by: Henning
> Schild <henning.schild@siemens.com> ---
>  arch/x86/mm/fault.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index fd5bbcc..475106f 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -285,6 +285,9 @@ static noinline int vmalloc_fault(unsigned long
> address) if (!pmd_k)
>  		return -1;
>  
> +	if (pmd_huge(*pmd_k))
> +		return 0;
> +
>  	pte_k = pte_offset_kernel(pmd_k, address);
>  	if (!pte_present(*pte_k))
>  		return -1;
> @@ -356,8 +359,6 @@ void vmalloc_sync_all(void)
>   * 64-bit:
>   *
>   *   Handle a fault on the vmalloc area
> - *
> - * This assumes no large pages in there.
>   */
>  static inline int vmalloc_sync_one(pgd_t *pgd, unsigned long address)
>  {
> @@ -398,17 +399,23 @@ static inline int vmalloc_sync_one(pgd_t *pgd,
> unsigned long address) if (pud_none(*pud_ref))
>  		return -1;
>  
> -	if (pud_none(*pud) || pud_page_vaddr(*pud) !=
> pud_page_vaddr(*pud_ref))
> +	if (pud_none(*pud) || pud_pfn(*pud) != pud_pfn(*pud_ref))
>  		BUG();
>  
> +	if (pud_huge(*pud))
> +		return 0;
> +
>  	pmd = pmd_offset(pud, address);
>  	pmd_ref = pmd_offset(pud_ref, address);
>  	if (pmd_none(*pmd_ref))
>  		return -1;
>  
> -	if (pmd_none(*pmd) || pmd_page(*pmd) != pmd_page(*pmd_ref))
> +	if (pmd_none(*pmd) || pmd_pfn(*pmd) != pmd_pfn(*pmd_ref))
>  		BUG();
>  
> +	if (pmd_huge(*pmd))
> +		return 0;
> +
>  	pte_ref = pte_offset_kernel(pmd_ref, address);
>  	if (!pte_present(*pte_ref))
>  		return -1;


