Date: Tue, 2 Feb 2016 13:08:49 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20160202130849.44ee20d5@md1em3qc>
In-Reply-To: <20160129183948.GE24550@hermes.click-hack.org>
References: <1453821607-20836-1-git-send-email-henning.schild@siemens.com>
 <1453902069-18824-1-git-send-email-henning.schild@siemens.com>
 <56A9F314.9030808@xenomai.org> <20160128215313.7717dafb@md1em3qc>
 <56AB9D2B.1030905@xenomai.org>
 <20160129183948.GE24550@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH v2] ipipe x86 mm: handle huge pages in memory
 pinning
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On Fri, 29 Jan 2016 19:39:48 +0100
Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:

> On Fri, Jan 29, 2016 at 06:11:07PM +0100, Philippe Gerum wrote:
> > On 01/28/2016 09:53 PM, Henning Schild wrote:  
> > > On Thu, 28 Jan 2016 11:53:08 +0100
> > > Philippe Gerum <rpm@xenomai.org> wrote:
> > >   
> > >> On 01/27/2016 02:41 PM, Henning Schild wrote:  
> > >>> In 4.1 huge page mapping of io memory was introduced, enable
> > >>> ipipe to handle that when pinning kernel memory.
> > >>>
> > >>> change that introduced the feature
> > >>> 0f616be120c632c818faaea9adcb8f05a7a8601f
> > >>>
> > >>> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> > >>> ---
> > >>>  arch/x86/mm/fault.c | 8 ++++++++
> > >>>  1 file changed, 8 insertions(+)
> > >>>
> > >>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> > >>> index fd5bbcc..ca1e75b 100644
> > >>> --- a/arch/x86/mm/fault.c
> > >>> +++ b/arch/x86/mm/fault.c
> > >>> @@ -211,11 +211,15 @@ static inline pmd_t
> > >>> *vmalloc_sync_one(pgd_t *pgd, unsigned long address) pud_k =
> > >>> pud_offset(pgd_k, address); if (!pud_present(*pud_k))
> > >>>  		return NULL;
> > >>> +	if (pud_large(*pud))
> > >>> +		return pud_k;
> > >>>  
> > >>>  	pmd = pmd_offset(pud, address);
> > >>>  	pmd_k = pmd_offset(pud_k, address);
> > >>>  	if (!pmd_present(*pmd_k))
> > >>>  		return NULL;
> > >>> +	if (pmd_large(*pmd))
> > >>> +		return pmd_k;
> > >>>  
> > >>>  	if (!pmd_present(*pmd))
> > >>>  		set_pmd(pmd, *pmd_k);
> > >>> @@ -400,6 +404,8 @@ static inline int vmalloc_sync_one(pgd_t
> > >>> *pgd, unsigned long address) 
> > >>>  	if (pud_none(*pud) || pud_page_vaddr(*pud) !=
> > >>> pud_page_vaddr(*pud_ref)) BUG();
> > >>> +	if (pud_large(*pud))
> > >>> +		return 0;
> > >>>  
> > >>>  	pmd = pmd_offset(pud, address);
> > >>>  	pmd_ref = pmd_offset(pud_ref, address);
> > >>> @@ -408,6 +414,8 @@ static inline int vmalloc_sync_one(pgd_t
> > >>> *pgd, unsigned long address) 
> > >>>  	if (pmd_none(*pmd) || pmd_page(*pmd) !=
> > >>> pmd_page(*pmd_ref)) BUG();
> > >>> +	if (pmd_large(*pmd))
> > >>> +		return 0;
> > >>>  
> > >>>  	pte_ref = pte_offset_kernel(pmd_ref, address);
> > >>>  	if (!pte_present(*pte_ref))
> > >>>     
> > >>
> > >> I'm confused. Assuming the purpose of that patch is to exclude
> > >> huge I/O mappings from pte pinning, why does the changes to the
> > >> x86_32 version of the vmalloc_sync_one() helper actually prevent
> > >> such pinning, while the x86_64 version does not?  
> > > 
> > > No the purpose is to include them just like they were before.
> > > vanilla vmalloc_sync_one just must not be called on huge mappings
> > > because it cant handle them. The patch is supposed to make the
> > > function return successfully, stopping early when huge pages are
> > > detected.
> > > 
> > > It changes the implementation of both x86_32 and x86_64.
> > >   
> > 
> > Sorry, your answer confuses me even more. vmalloc_sync_one() _does_
> > the pinning, by copying over the kernel mapping, early in the
> > course of the routine for x86_64, late for x86_32.
> > 
> > Please explain why your changes prevent huge I/O mappings from being
> > pinned into the current page directory in the x86_32
> > implementation, but still allow this to be done in the x86_64
> > version. The section of code you patched in the latter case is
> > basically a series of sanity checks done after the pinning took
> > place, not before.
> > 
> > On a more general note, a better approach would be to filter out
> > calls to vmalloc_sync_one() for huge pages directly from
> > __ipipe_pin_mapping globally().  
> 
> Since the ioremap/vmalloc range is based on huge pages or not,
> globally (since the processes mapping are copied from the kernel
> mapping), we can probably even avoid the call to __ipipe_pin_mapping
> for hug page mappings. After all, since the mainline kernel is able
> to avoid calls to vmalloc_sync_one() for huge page mappings, the
> I-pipe should be able to do the same.

As said, my patch preserves the old ipipe behaviour, making it able to
deal with huge pages. Whether or not the pinning is required and on
which regions, is a valid but totally different question. Down in these
low-level functions you can not tell why the pinning was requested. It
has to be dealt with at a higher level.
But you are right, the kernel never ends up in vmalloc_sync_one for
these regions. Hence we can probably expect that in ioremapped region
is always mapped anyways. Since vmalloc_sync_one will ultimately also
be used when handling a #PF.

I just traced the change in lib/ioremap.c to
d41282baf7c1f2bb517d6df95571e7da865f5e37
Not too helpful, at least to me.

Henning 


