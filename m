References: <b18a880f-9765-86e1-5274-ba8bfb0cc832@xenomai.org>
 <aa1018f6-a352-5814-7bf4-0a309d84a88a@ma-info.de>
 <20180117112452.1bb130c9@laptop.fritz.box>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <98376b05-0ed2-3171-7d9d-a77d42782d9f@xenomai.org>
Date: Wed, 17 Jan 2018 12:46:41 +0100
MIME-Version: 1.0
In-Reply-To: <20180117112452.1bb130c9@laptop.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] kernel panic xnclock
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ruggero <rrossi@atb-biomag.de>, "Gaus Bernhard, Dr. Mergenthaler GmbH & Co. KG" <bernhard.gaus@ma-info.de>, xenomai@xenomai.org


Hi,

On 01/17/2018 11:24 AM, ruggero wrote:
> Hello Philippe,
> Bernard asked me to take care of the problem.
>> Hello Bernhard,
>>
>> On 01/15/2018 12:07 PM, Gaus Bernhard, Dr. Mergenthaler GmbH & Co. KG
>> wrote:
>>> Hello Philippe,
>>> Our elpc system a running quite well but we get some sporadic
>>> kernel panic. We are using xenomai-3.0.6. Do you have any idea
>>> what's the problem her?
>>>
>>>
>>> [ 3377.645862] Unable to handle kernel paging request at virtual
>>> address 00100104
>>> [ 3377.654967] pgd = 80004000, hw pgd = be7b0000
>>> [ 3377.660456] [00100104] *pgd=00000000
>>> [ 3377.664992] Internal error: Oops: 817 [#1] PREEMPT SMP THUMB2
>>> [ 3377.672227] Modules linked in: clc_phyflex clc_clock [last
>>> unloaded: spi_imx]
>>> [ 3377.681313] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
>>> 3.18.20-xenomai-mergenthaler_0.0.1 #1
>>> [ 3377.691827] task: 806f8d28 ti: 806ee000 task.ti: 806ee000
>>> [ 3377.698637] PC is at xnclock_tick+0x27c/0x33c
>>> [ 3377.704129] LR is at xnclock_tick+0x1c1/0x33c  
>>
>> You may want to investigate about which source line xnclock_tick+0x27
>> corresponds to, this should go a long way identifying the issue.
>> Checking with addr2line, against a kernel built with debug information
>> would give you an answer.
> addr2line gives
> /phytec/x-i.MX6Linux/platform-phyFLEX-i.MX6/build-target/linux-3.18.20/include/linux/list.h:42
> that is the first line of the routine __list_add().
>  
> static inline void __list_add(struct list_head *new,
> 			      struct list_head *prev,
> 			      struct list_head *next)
> {
> 	next->prev = new;  ****** line 42
> 	new->next = next;
> 	new->prev = prev;
> 	prev->next = new;
> }
> 
> 
> This gives very little information, since __list_add is a general
> routine in the kernel.
> 
> The __list_add function is called by xnclock_tick+0x27c/0x33c, that is
> in kernel/xenomai/clock.c
> 
> From the comparison of the disasm of the kernel and the actual code in
> clock.c, it seems that xnclock_tick+0x27c/0x33c is actually in the
> (inline) routine 
> 
> xntimer_enqueue(timer, tmq); 
> (defined in include/xenomai/cobalt/kernel/timer.h)
> 
> xntimer_enqueue starts with a call to the inlined routine
> xntimerq_insert(q, &timer->aplink); 
> that, in case CONFIG_XENO_OPT_TIMER_LIST is defined,
> it is defined as (always in timer.h) 
> #define xntimerq_insert(q, h) xntlist_insert((q),(h))
> 
> in xntlist_insert (always defined in timer.h) there are two calls to
> list_add() (list.h: 61) 
> that it is the interface for __list_add. It looks
> like that xnclock_tick+0x27c/0x33c is actually the second one.
> 
> to summarize the stack of inlined calls we have:
> timer.h:108
> static inline void xntlist_insert(struct list_head *q, struct
> xntlholder *holder) {
> 	struct xntlholder *p;
> 
> 	if (list_empty(q)) {
> 		list_add(&holder->link, q);
> 		return;
> 	}
> 
> 	/*
> 	 * Insert the new timer at the proper place in the single
> 	 * queue. O(N) here, but this is the price for the increased
> 	 * flexibility...
> 	 */
> 	list_for_each_entry_reverse(p, q, link) {
> 		if ((xnsticks_t) (holder->key - p->key) > 0 ||
> 		    (holder->key == p->key && holder->prio <= p->prio))
> 		  break;
> 	}
> 
> 	list_add(&holder->link, &p->link); ********
> }
> 
> list.h:61
> static inline void list_add(struct list_head *new, struct list_head
> *head) {
> 	__list_add(new, head, head->next);
> }
> 
> and finally, from the kernel disassembly
> 
> static inline void list_add(struct list_head *new, struct list_head
> *head) {
> 	__list_add(new, head, head->next);
> 800912ee:	682b      	ldr	r3, [r5, #0]  --> load in
> r3 head->next next->prev = new;
> 800912f0:	605c      	str	r4, [r3, #4]  --> store
> r4 in next->prev [r3+#4]
> 
> and here, in one case over some millions, r3 is invalid (or something
> happen that makes r3 invalid)
> 
> At this point, I'm at my limits.  
> 
> In the kernel panic message, the offending virtual address is
> always 00100104 (69 cases).
> pgd is almost always 80004000 (66 cases of 69)
> hw pgd is obviously random
> *pgd is almost always 0
> stack dump says almost always
> [<800912f0>] (xnclock_tick) from
> [<7f83f2fd>](clc_clock_handler+0x2c/0x30 [clc_clock]) 
> (in two cases the calling address is different)
> 
> clc_clock_handler is in the clc module and I don't know how to explore
> it (but I'm sure I will not find anything wrong there!)
> 
>>
>> Determining whether using OPT_TIMER_LIST or OPT_TIMER_RBTREE has an
>> influence on the manifestation of this bug would be a good idea as
>> well.
> Definitely this bug happens only using OPT_TIMER_LIST. 
> 
> for the Xenomai mailing list: we are experiencing a similar, but
> different bug using OPT_TIMER_RBTREE. It seems that the
> RBTREE bug is much more deterministic: it happens almost always after
> 2-3 days running the system with a very high load. The OPT_TIMER_LIST
> is more random.
> However there is something to notice: after the kernel Oops happens
> once, the probability we get the same problem within few hours after
> reboot is quite high 
> 
> I hope you can help us,
> 

With those explanations, it looks clearer now. Please apply this patch:

diff --git a/drivers/mergenthaler/clc/ext-clock.c
b/drivers/mergenthaler/clc/ext-clock.c
index f460cfee2278..78fd59eb7e61 100644
--- a/drivers/mergenthaler/clc/ext-clock.c
+++ b/drivers/mergenthaler/clc/ext-clock.c
@@ -256,6 +256,7 @@ static inline struct clc_clock_device
*clock_to_clkdev(struct xnclock *clock)
 static int clc_clock_handler(rtdm_irq_t *irq_handle)
 {
 	struct clc_clock_device *clkdev;
+	spl_t s;

 	clkdev = rtdm_irq_get_arg(irq_handle, struct clc_clock_device);

@@ -264,7 +265,9 @@ static int clc_clock_handler(rtdm_irq_t *irq_handle)

 	clkdev->freerunning += xnclock_get_resolution(&clkdev->base);

+	xnlock_get_irqsave(&nklock, s);
 	xnclock_tick(&clkdev->base);
+	xnlock_put_irqrestore(&nklock, s);

 	return RTDM_IRQ_HANDLED;
 }

-- 
Philippe.

