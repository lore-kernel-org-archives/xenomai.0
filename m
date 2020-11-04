MIME-Version: 1.0
References: <08c61a3c-785b-c31b-1c95-e470203f1148@siemens.com>
In-Reply-To: <08c61a3c-785b-c31b-1c95-e470203f1148@siemens.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Wed, 4 Nov 2020 10:43:12 -0500
Message-ID: <CALLqZ8Q98+-okQcF3MRRg+KAqb2j4GYUEpG+4UF51GR6tCEQ6A@mail.gmail.com>
Subject: Re: [PATCH][ipipe-4.19-noarch] ipipe: mm: Drop un-COW from
 copy_pte_range
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On Wed, Nov 4, 2020 at 10:41 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> This is not needed, in fact, and it is in conflict with upcoming stable
> changes. Philippe writes:
>
> "IIRC, the reason was to ensure that any mapping duplicated from a
> parent process which has pinned its memory via an earlier call to
> __ipipe_disable_ondemand_mappings() would be immediately un-COWed upon
> fork() in the child process. On second thoughts, this is useless since
> the child process either:
>
> - if it has to, explicitly attaches to the real-time core, which ends up
>   calling mlock(), therefore causing these mappings to be un-COWed if
>   need be. IOW, there is no inheritance of the Cobalt context at
>   fork. Maybe at some point in time there was the assumption that such
>   context might be shared between both processes somehow, which has been
>   ruled out later on.
>
> - the child process does not attach to the real-time core, in which case
>   COW is a non-issue."
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>
> Greg, needed in case you update to 4.19.149 or later. Not needed for 5.4
> (I already left out that hunks).
>
>  mm/memory.c | 61 +++++------------------------------------------------
>  1 file changed, 5 insertions(+), 56 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index f36626dc30d0..797f7fe29454 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -129,11 +129,6 @@ EXPORT_SYMBOL(zero_pfn);
>   unsigned long highest_memmap_pfn __read_mostly;
>  -static inline void cow_user_page(struct page *dst,
> -                                struct page *src,
> -                                unsigned long va,
> -                                struct vm_area_struct *vma);
> -
>  /*
>   * CONFIG_MMU architectures set up ZERO_PAGE in their paging_init()
>   */
> @@ -950,8 +945,8 @@ struct page *vm_normal_page_pmd(struct vm_area_struct
> *vma, unsigned long addr,
>   static inline unsigned long
>  copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> -            pte_t *dst_pte, pte_t *src_pte, struct vm_area_struct *vma,
> -            unsigned long addr, int *rss, struct page *uncow_page)
> +               pte_t *dst_pte, pte_t *src_pte, struct vm_area_struct *vma,
> +               unsigned long addr, int *rss)
>  {
>         unsigned long vm_flags = vma->vm_flags;
>         pte_t pte = *src_pte;
> @@ -1029,21 +1024,6 @@ copy_one_pte(struct mm_struct *dst_mm, struct
> mm_struct *src_mm,
>          * in the parent and the child
>          */
>         if (is_cow_mapping(vm_flags) && pte_write(pte)) {
> -#ifdef CONFIG_IPIPE
> -               if (uncow_page) {
> -                       struct page *old_page = vm_normal_page(vma, addr,
> pte);
> -                       cow_user_page(uncow_page, old_page, addr, vma);
> -                       pte = mk_pte(uncow_page, vma->vm_page_prot);
> -
> -                       if (vm_flags & VM_SHARED)
> -                               pte = pte_mkclean(pte);
> -                       pte = pte_mkold(pte);
> -
> -                       page_add_new_anon_rmap(uncow_page, vma, addr,
> false);
> -                       rss[!!PageAnon(uncow_page)]++;
> -                       goto out_set_pte;
> -               }
> -#endif /* CONFIG_IPIPE */
>                 ptep_set_wrprotect(src_mm, addr, src_pte);
>                 pte = pte_wrprotect(pte);
>         }
> @@ -1091,27 +1071,13 @@ static int copy_pte_range(struct mm_struct
> *dst_mm, struct mm_struct *src_mm,
>         int progress = 0;
>         int rss[NR_MM_COUNTERS];
>         swp_entry_t entry = (swp_entry_t){0};
> -       struct page *uncow_page = NULL;
> -#ifdef CONFIG_IPIPE
> -       int do_cow_break = 0;
> -again:
> -       if (do_cow_break) {
> -               uncow_page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
> -               if (uncow_page == NULL)
> -                       return -ENOMEM;
> -               do_cow_break = 0;
> -       }
> -#else
> +
>  again:
> -#endif
>         init_rss_vec(rss);
>         dst_pte = pte_alloc_map_lock(dst_mm, dst_pmd, addr, &dst_ptl);
> -       if (!dst_pte) {
> -               if (uncow_page)
> -                       put_page(uncow_page);
> +       if (!dst_pte)
>                 return -ENOMEM;
> -       }
>         src_pte = pte_offset_map(src_pmd, addr);
>         src_ptl = pte_lockptr(src_mm, src_pmd);
>         spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
> @@ -1134,25 +1100,8 @@ static int copy_pte_range(struct mm_struct *dst_mm,
> struct mm_struct *src_mm,
>                         progress++;
>                         continue;
>                 }
> -#ifdef CONFIG_IPIPE
> -               if (likely(uncow_page == NULL) &&
> likely(pte_present(*src_pte))) {
> -                       if (is_cow_mapping(vma->vm_flags) &&
> -                           test_bit(MMF_VM_PINNED, &src_mm->flags) &&
> -                           ((vma->vm_flags|src_mm->def_flags) &
> VM_LOCKED)) {
> -                               arch_leave_lazy_mmu_mode();
> -                               spin_unlock(src_ptl);
> -                               pte_unmap(src_pte);
> -                               add_mm_rss_vec(dst_mm, rss);
> -                               pte_unmap_unlock(dst_pte, dst_ptl);
> -                               cond_resched();
> -                               do_cow_break = 1;
> -                               goto again;
> -                       }
> -               }
> -#endif
>                 entry.val = copy_one_pte(dst_mm, src_mm, dst_pte, src_pte,
> -                                        vma, addr, rss, uncow_page);
> -               uncow_page = NULL;
> +                                                       vma, addr, rss);
>                 if (entry.val)
>                         break;
>                 progress += 8;
> --
> 2.26.2


Ok, still working on 5.4 but I plan to do a final 4.19 release once 5.4 is
stable.

Greg

>
>
