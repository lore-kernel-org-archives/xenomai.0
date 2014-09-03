From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 3 Sep 2014 08:54:22 -0400
Message-ID: <20140903125422.GI17690@csclub.uwaterloo.ca>
References: <20140828203532.GA17690@csclub.uwaterloo.ca>
 <53FF93A3.8070101@xenomai.org>
 <20140828220153.GE17690@csclub.uwaterloo.ca>
 <53FFA96E.2090904@xenomai.org>
 <20140828231625.GF17690@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140828231625.GF17690@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] Xenomai/Ipipe on arm with LPAE enabled not booting -
 now with crash message
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Thu, Aug 28, 2014 at 07:16:25PM -0400, Lennart Sorensen wrote:
> On Fri, Aug 29, 2014 at 12:13:02AM +0200, Gilles Chanteperdrix wrote:
> > On 08/29/2014 12:01 AM, Lennart Sorensen wrote:
> > > [   91.861761] PC is at _raw_spin_lock_irqsave+0x10/0x4c
> > > [   91.872209] LR is at _raw_spin_lock_irqsave+0xc/0x4c
> > > [   91.882479] pc : [<c0455c98>]    lr : [<c0455c94>]    psr: 20000153
> > > [   91.882479] sp : ee8f5dc0  ip : 20000153  fp : c0d97760
> > > [   91.906198] r10: 00000000  r9 : c006a46c  r8 : ee8f5e04
> > > [   91.916997] r7 : 00000000  r6 : ee83ba40  r5 : c0743af4  r4 : 00000000
> > > [   91.930451] r3 : c06c8b88  r2 : 00905000  r1 : 00000001  r0 : 00000000
> > 
> > You have to disassemble _raw_spin_lock_irqsave to see what is at offset
> > 0x10, and where it can come from.
> 
> I will give that a try next week when i am back at work.

OK so far I have:

static noinline struct kmem_cache_node *free_debug_processing(
        struct kmem_cache *s, struct page *page, void *object,
        unsigned long addr, unsigned long *flags)
{
        struct kmem_cache_node *n = get_node(s, page_to_nid(page));

pr_info("n: %p flags: %p\n", n, flags);
        spin_lock_irqsave(&n->list_lock, *flags);
        slab_lock(page);

        if (!check_slab(s, page))
                goto fail;

        if (!check_valid_pointer(s, page, object)) {
                slab_err(s, page, "Invalid object pointer 0x%p", object);
                goto fail;
        }

prints out:

[  176.234145] n:   (null) flags: ee8f5e04

n being NULL is obviously a bad thing.

-- 
Len Sorensen

