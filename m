Message-ID: <551BFEB2.1000009@xenomai.org>
Date: Wed, 01 Apr 2015 16:20:34 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <20150401135910.GO29558@csclub.uwaterloo.ca>
In-Reply-To: <20150401135910.GO29558@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Hit BUG() in arch/arm/mm/pgd.c
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, xenomai@xenomai.org

On 04/01/2015 03:59 PM, Lennart Sorensen wrote:
> We are seeing occational hits on a BUG() statement in pgd.c:
> 
> static inline void pgd_holder_free(pgd_t *pgd)
> {
>         struct rb_node *node = pgd_table.rb_node;
>         struct pgd_holder *p;
>         unsigned long flags;
> 
>         pgd_table_lock(flags);
> 
>         while (node) {
>                 p = rb_entry(node, struct pgd_holder, rb);
>                 if ((unsigned long)pgd < (unsigned long)p->pgd)
>                         node = node->rb_left;
>                 else if ((unsigned long)pgd > (unsigned long)p->pgd)
>                         node = node->rb_right;
>                 else {
>                         rb_erase(node, &pgd_table);
>                         pgd_table_unlock(flags);
>                         kfree(p);
>                         return;
>                 }
>         }
> 
>         pgd_table_unlock(flags);
> 
>         BUG(); <- this one
> }
> 
> Any idea how that could be happening?
> 

That is a sanity check covering an unexpected situation, when a page
table directory to be freed is not found in the map of active PGDs as
tracked by the pipeline. Could you try the following change?

diff --git a/arch/arm/mm/pgd.c b/arch/arm/mm/pgd.c
index a4aafb5..672e811 100644
--- a/arch/arm/mm/pgd.c
+++ b/arch/arm/mm/pgd.c
@@ -299,8 +299,8 @@ no_pmd:
 no_pud:
 	pgd_clear(pgd);
 	pud_free(mm, pud);
-no_pgd:
 	pgd_holder_free(pgd);
+no_pgd:

 #ifdef CONFIG_ARM_LPAE
 	/*
-- 
Philippe.

