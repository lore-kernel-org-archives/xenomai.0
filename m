MIME-Version: 1.0
In-Reply-To: <54208009.5040504@xenomai.org>
References: <CAFvTJFEsnycSeft7DEeRFXFTXb8E8xLbzFANk2HVt50ikd14gQ@mail.gmail.com>
 <54206D56.7040509@xenomai.org>
 <CAFvTJFGhGfuficFeDLxnDZQT=gSnmtn95933_zi16YSbD8Q9uQ@mail.gmail.com>
 <54208009.5040504@xenomai.org>
Date: Tue, 23 Sep 2014 14:52:47 -0400
Message-ID: <CAFvTJFFJ=t9CXofcKhHbJVK6HnJ4-YmUt966TKXbx8MpM-zGJg@mail.gmail.com>
From: Sam Hajian <saeid.hajian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] kernel panic with IPIPE and LPAE on ARM OMAP5 board
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

> Then you are back to square 1: you have to debug the oops with
> disassembler and register values.
>

I found the location of the null pointer dereference in debug code and
managed to avoid it, here

static noinline struct kmem_cache_node *free_debug_processing(
        struct kmem_cache *s, struct page *page, void *object,
        unsigned long addr, unsigned long *flags)
{
        struct kmem_cache_node *n = get_node(s, page_to_nid(page));
        spin_lock_irqsave(&n->list_lock, *flags); // if "n" is null
jump to fail code, slad_unlock and return
        slab_lock(page);

Now the issue shows up in  __ipipe_pin_range_globally where it can not
handle kernel paging request. If try to return without doing anything
in this code, there system will just pause and no message or kernel
panic. Do you have any suggestion to make this code (
__ipipe_pin_range_globally) working with 3 level page table.

[    5.187539] SMP: Total of 2 processors activated.
[    5.197301] CPU: All CPU(s) started in SVC mode.
[    5.208879] devtmpfs: initialized
[    5.228559] VFP support v0.3: implementor 41 architecture 4 part 30
variant f rev 0
[    5.255349] Unable to handle kernel paging request at virtual
address 4f3f1c00
[    5.270246] pgd = c0003000, hw pgd = c0003000
[    5.279301] [4f3f1c00] *pgd=80000080005003, *pmd=00000000
[    5.290515] Internal error: Oops: a06 [#1] SMP ARM
[    5.300434] Modules linked in:
[    5.306824] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.12-1-am5726
#1 Debian 3.12.27-0.1RR5
[    5.324176] task: ee8f0000 ti: ee8f4000 task.ti: ee8f4000
[    5.335341] PC is at __ipipe_pin_range_globally+0xd8/0x12c
[    5.346675] LR is at 0xafff1ffe
[    5.353234] pc : [<c001c438>]    lr : [<afff1ffe>]    psr: 80000013
[    5.353234] sp : ee8f5d80  ip : ee83b018  fp : c06ca4f4
[    5.376955] r10: c0d8c760  r9 : 00000c00  r8 : 00000018
[    5.387758] r7 : 00000000  r6 : fffff000  r5 : 00000000  r4 : c0007000
[    5.401216] r3 : 4f3f1c00  r2 : 4f3f1000  r1 : 00000000  r0 : ae8d4003

