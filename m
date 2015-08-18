Date: Tue, 18 Aug 2015 22:34:07 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150818203407.GB14798@hermes.click-hack.org>
References: <55D321A2.6090201@sigmatek.at>
 <20150818124805.GB4740@hermes.click-hack.org>
 <55D33336.4020004@sigmatek.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55D33336.4020004@sigmatek.at>
Subject: Re: [Xenomai] Function to get state of lock variable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Netbal <wolfgang.netbal@sigmatek.at>
Cc: Xenomai Mailing List <xenomai@xenomai.org>

On Tue, Aug 18, 2015 at 03:29:26PM +0200, Wolfgang Netbal wrote:
> 
> 
> Am 2015-08-18 um 14:48 schrieb Gilles Chanteperdrix:
> >On Tue, Aug 18, 2015 at 02:14:26PM +0200, Wolfgang Netbal wrote:
> >>Hi All,
> >>
> >>is there a function te returns true or false if a rtdm_lock_t variable is
> >>set ?
> >>What I have to do is  to check in an interrupt routine if the list is
> >>locked,
> >>if this is the case I leave the interrupt handler befor accessing the list.
> >>
> >>I use the following code to lock the add and replace of list elements.
> >>
> >>static rtdm_lock_t opendev_list_lock;
> >>static int open(struct rtdm_dev_context *context, rtdm_user_info_t *
> >>user_info, int oflags)
> >>{
> >>     lrtdrv_context_t *ctx = (lrtdrv_context_t *) context->dev_private;
> >>     rtdm_lockctx_t s;
> >>
> >>....
> >>
> >>     rtdm_lock_get_irqsave(&opendev_list_lock, s);
> >>     list_add_tail(&ctx->opendev_entry, &lrtdrv_opendev_list);
> >>     rtdm_lock_put_irqrestore(&opendev_list_lock, s);
> >Well, if you are not running on a multiprocessor system, you can not
> >take interrupt during that section.
> >
> >And on a multiprocessor system, the time this code will hold the
> >lock is very short, so, it should not be a problem for an interrupt
> >one core to spin while another core is holding the lock.
> >
> >But we can probably add rtdm_lock_is_locked, yes.
> >
> I'm working on a multiprocessor system and when I boot the system between
> 200 and 1000 times I get one error, because the add and remove from the list
> will be done on boot.

I have read this sentence multiple times, but have not understood
what your problem is and how testing whether the spinlock is locked
will solve anything. So, again, note that:
- adding or removing an element to/from a list is so fast that
having to spin waiting for the lock in an interrupt handler is not a
problem, at all;
- doing if (!is_locked) lock() is racy: between the time you test
and the time you lock, the other cpu may well have taken the lock
and be in the process of updating the list, so, what you probably want
is a "trylock" operation, which tries and acquire the lock and fails
instead of spinning if it would have to wait.

> I tried to add a function rtdm_lock_is_locked but the thing is that the
> variables in struct arch_spinlock_t are different for different
> architectures, for example on ARM it is "u32 slock" and on x86 it is
> "__ticketpair_t head_tail".
> 
> If you have a hint for me which element of struct rtdm_lock_t I have to use
> to check if the list is locked I can add this on my own.
> If you think this the function rtdm_lock_is_locked should be added it would
> be great if you can add it for Xenomai 2.6.4 as well.

You are looking at the wrong abstraction level, rtdm_lock_t is just
a typedef for ipipe_spinlock_t, and all the spin* functions/macros
of the spinlock API apply to ipipe_spinlock_t, this includes
spin_is_locked() and spin_trylock(). Of course we need to add
rtdm_lock_is_locked and rtdm_lock_trylock, but in the meantime, you
can use the kernel functions directly.

-- 
					    Gilles.
https://click-hack.org

