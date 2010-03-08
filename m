From: Sinisa Denic <sinisa.denic@domain.hid>
Date: Mon, 8 Mar 2010 08:58:11 +0100
References: <201003021527.30130.sinisa.denic@domain.hid>
	<4B92317F.3010706@domain.hid>
In-Reply-To: <4B92317F.3010706@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201003080858.11552.sinisa.denic@domain.hid>
Subject: Re: [Xenomai-help] ARM cached,non-cached memory
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org.

On Saturday 06 March 2010 11:42:07 you wrote:
> Sinisa Denic wrote:
> > Hi, last year working with xenomai 2.4.2-3 we met problem (BUG) with
> > memory caching on ARM AT91sam9260 arch.
> > Then we were advised using non-cached memory and we've used it till
> > now,but in our next application it has big performace slow down effect
> > and I'm interested is this BUG solved in latest 2.4.10 - xenomai
> > Regards,Sinisa
>
> Actually, there may be something we can do. In heap.c, could you try
> replacing calls to pgprot_noncached with calls to pgprot_writecombine ?
>
> Here is a patch doing this for 2.4 head. I do not know whether it will
> apply to the version you are using. But I guess you will get the idea.
>
> diff --git a/ksrc/nucleus/heap.c b/ksrc/nucleus/heap.c
> index 1c02183..d40844b 100644
> --- a/ksrc/nucleus/heap.c
> +++ b/ksrc/nucleus/heap.c
> @@ -962,7 +962,7 @@ static inline void *__alloc_and_reserve_heap(size_t
> size, in t kmflags)
>                 else
>                         ptr = __vmalloc(size,
>                                         GFP_KERNEL | __GFP_HIGHMEM,
> -                                       pgprot_noncached(PAGE_KERNEL));
> +                                       pgprot_writecombine(PAGE_KERNEL));
>                 if (ptr == NULL)
>                         return NULL;
>
> @@ -1126,7 +1126,7 @@ static int xnheap_mmap(struct file *file, struct
> vm_area_struct *vma) unsigned long maddr = vma->vm_start;
>
>                 if (heap->archdep.kmflags == XNHEAP_GFP_NONCACHED)
> -                       vma->vm_page_prot =
> pgprot_noncached(vma->vm_page_prot); +                      
> vma->vm_page_prot = pgprot_writecombine(vma->vm_page_pro t);
>
>                 while (size > 0) {
>                         if (xnarch_remap_vm_page(vma, maddr, vaddr))
> @@ -1147,7 +1147,7 @@ static int xnheap_mmap(struct file *file, struct
> vm_area_s truct *vma)
>         (void)vaddr;
>         if ((heap->archdep.kmflags & ~XNHEAP_GFP_NONCACHED) != 0 ||
>             heap->archdep.kmflags == XNHEAP_GFP_NONCACHED)
> -               vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +               vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
>  #endif /* !CONFIG_MMU */
>
>         atomic_inc(&heap->archdep.numaps);

Ah, thank you Gilles we've already reconciled with destiny not to having 
cached memory. 
This is good news,but as I've read "write-combining does not guarantee that 
the combination of writes and reads is done in the correct order" and we 
could meet inconsistency in data - maybe.. 
Does Xeno treat this problem properly?
Sinisa

