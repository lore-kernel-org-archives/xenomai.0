Date: Mon, 7 Mar 2016 08:58:00 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20160307085800.226ab10f@md1em3qc>
In-Reply-To: <20160208094428.065f22d6@md1em3qc>
References: <1453902069-18824-1-git-send-email-henning.schild@siemens.com>
 <1454504365-7015-1-git-send-email-henning.schild@siemens.com>
 <20160208094428.065f22d6@md1em3qc>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH v3] ipipe x86 mm: handle huge pages in memory
 pinning
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

Hey,

the patch went into 4.1.19, please rebase/merge so ipipe-4.1.y contains
it.

Henning

On Mon, 8 Feb 2016 09:44:28 +0100
Henning Schild <henning.schild@siemens.com> wrote:

> Hey,
> 
> i discussed the issue with the guy that introduced huge ioremap. He
> agreed that mainline also needs to handle huge pages in vmalloc_fault
> and came up with a very similar patch. (the discussion can partially
> be found in this lists archive)
> I assume it will soon hit mainline and will get backported to 4.1. So
> i guess we can just wait for that and use "nohugeiomap" until the
> issue is fixed mainline and merged in our 4.1.y branch.
> 
> Henning
> 
> On Wed, 3 Feb 2016 13:59:25 +0100
> Henning Schild <henning.schild@siemens.com> wrote:
> 
> > In 4.1 huge page mapping of io memory was introduced, enable ipipe
> > to handle that when pinning kernel memory.
> > 
> > change that introduced the feature
> > 0f616be120c632c818faaea9adcb8f05a7a8601f
> > 
> > Signed-off-by: Henning Schild <henning.schild@siemens.com>
> > ---
> >  arch/x86/mm/fault.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > This version has the 32bit case changed according to the problems
> > found in the review. That patch finally should keep the old
> > behaviour. But we should still discuss whether the old behaviour was
> > correct and should be kept. If the pinning it not required it should
> > be removed instead of beeing made more complex.
> > 
> > diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> > index fd5bbcc..e78bd09 100644
> > --- a/arch/x86/mm/fault.c
> > +++ b/arch/x86/mm/fault.c
> > @@ -211,6 +211,8 @@ static inline pmd_t *vmalloc_sync_one(pgd_t
> > *pgd, unsigned long address) pud_k = pud_offset(pgd_k, address);
> >  	if (!pud_present(*pud_k))
> >  		return NULL;
> > +	if (pud_large(*pud))
> > +		return NULL;
> >  
> >  	pmd = pmd_offset(pud, address);
> >  	pmd_k = pmd_offset(pud_k, address);
> > @@ -400,6 +402,8 @@ static inline int vmalloc_sync_one(pgd_t *pgd,
> > unsigned long address) 
> >  	if (pud_none(*pud) || pud_page_vaddr(*pud) !=
> > pud_page_vaddr(*pud_ref)) BUG();
> > +	if (pud_large(*pud))
> > +		return 0;
> >  
> >  	pmd = pmd_offset(pud, address);
> >  	pmd_ref = pmd_offset(pud_ref, address);
> > @@ -408,6 +412,8 @@ static inline int vmalloc_sync_one(pgd_t *pgd,
> > unsigned long address) 
> >  	if (pmd_none(*pmd) || pmd_page(*pmd) != pmd_page(*pmd_ref))
> >  		BUG();
> > +	if (pmd_large(*pmd))
> > +		return 0;
> >  
> >  	pte_ref = pte_offset_kernel(pmd_ref, address);
> >  	if (!pte_present(*pte_ref))  
> 
> 
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://xenomai.org/mailman/listinfo/xenomai


