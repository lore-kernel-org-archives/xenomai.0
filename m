From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 1 Apr 2015 10:47:17 -0400
Message-ID: <20150401144717.GQ29558@csclub.uwaterloo.ca>
References: <20150401135910.GO29558@csclub.uwaterloo.ca>
 <551BFEB2.1000009@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <551BFEB2.1000009@xenomai.org>
Subject: Re: [Xenomai] Hit BUG() in arch/arm/mm/pgd.c
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, Apr 01, 2015 at 04:20:34PM +0200, Philippe Gerum wrote:
> On 04/01/2015 03:59 PM, Lennart Sorensen wrote:
> > We are seeing occational hits on a BUG() statement in pgd.c:
> > 
> > static inline void pgd_holder_free(pgd_t *pgd)
> > {
> >         struct rb_node *node = pgd_table.rb_node;
> >         struct pgd_holder *p;
> >         unsigned long flags;
> > 
> >         pgd_table_lock(flags);
> > 
> >         while (node) {
> >                 p = rb_entry(node, struct pgd_holder, rb);
> >                 if ((unsigned long)pgd < (unsigned long)p->pgd)
> >                         node = node->rb_left;
> >                 else if ((unsigned long)pgd > (unsigned long)p->pgd)
> >                         node = node->rb_right;
> >                 else {
> >                         rb_erase(node, &pgd_table);
> >                         pgd_table_unlock(flags);
> >                         kfree(p);
> >                         return;
> >                 }
> >         }
> > 
> >         pgd_table_unlock(flags);
> > 
> >         BUG(); <- this one
> > }
> > 
> > Any idea how that could be happening?
> > 
> 
> That is a sanity check covering an unexpected situation, when a page
> table directory to be freed is not found in the map of active PGDs as
> tracked by the pipeline. Could you try the following change?
> 
> diff --git a/arch/arm/mm/pgd.c b/arch/arm/mm/pgd.c
> index a4aafb5..672e811 100644
> --- a/arch/arm/mm/pgd.c
> +++ b/arch/arm/mm/pgd.c
> @@ -299,8 +299,8 @@ no_pmd:
>  no_pud:
>  	pgd_clear(pgd);
>  	pud_free(mm, pud);
> -no_pgd:
>  	pgd_holder_free(pgd);
> +no_pgd:
> 
>  #ifdef CONFIG_ARM_LPAE
>  	/*

Sure I will give that a try.

-- 
Len Sorensen

