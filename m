Date: Fri, 21 Nov 2014 15:19:23 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141121141923.GB1223@sisyphus.hd.free.fr>
References: <20141121090857.GK4545@sisyphus.hd.free.fr>
 <546F14BE.1090209@web.de>
 <20141121111006.GA31011@sisyphus.hd.free.fr>
 <546F206A.4060506@web.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <546F206A.4060506@web.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTnet in Xenomai 3, status and future
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: rtnet-developers@lists.sourceforge.net, rtnet-users@lists.sourceforge.net, Xenomai <xenomai@xenomai.org>

On Fri, Nov 21, 2014 at 12:22:18PM +0100, Jan Kiszka wrote:
> On 2014-11-21 12:10, Gilles Chanteperdrix wrote:
> > On Fri, Nov 21, 2014 at 11:32:30AM +0100, Jan Kiszka wrote:
> >> On 2014-11-21 10:08, Gilles Chanteperdrix wrote:
> >>> Hi,
> >>>
> >>> as some of you may have seen, I have sent the pull request to
> >>> Philippe for the integration of RTnet in Xenomai 3, those of you who
> >>> want will be able to test it when Xenomai 3 next release candidate
> >>> is released. What will be in that release candidate is what was in
> >>> RTnet git, patched up to adapt it to the Linux and Xenomai API
> >>> changes that broke its compilation, and to add the bits and pieces
> >>> to be able to run some tests on the hardware I have (namely, the
> >>> 8139too, r8169, at91_ether and macb drivers).
> >>
> >> For x86, support for e1000e and possibly also igb will be very helpful.
> >> Those NICs dominate the market now, specifically due to their on-chip /
> >> on-board presence. I think those two drives are in better shape than the
> >> legacy ones.
> > 
> > When compiling Xenomai 3 with RTnet on x86 (32 and 64), I enabled
> > all the PCI drivers. So, they all compile as far as I know. I have
> > not tested them of course, but since the rtnet stack has not changed
> > (yet), they should continue to work if they were in a working state.
> 
> Ah, ok, perfect.
> 
> > 
> > 
> >>> - the NAPI will be implemented. The NAPI thread will run with the
> >>> priority of the highest priority waiting thread, and will call
> >>> rt_stack_deliver, in order not to increase the RX latency compared
> >>> to the current solution. This will make porting recent drivers easy
> >>> and has the additional advantage of irq handlers not creating large
> >>> irq masking sections like in the current design, which even borders
> >>> priority inversion if the bulk of the received packets is for RTmac
> >>> vnics or rtnetproxy.
> >>
> >> Will be an interesting feature. However, whenever you share a link for
> >> RT and non-RT packets, you do have an unavoidable prio-inversion risk.
> >> The way to mitigate this is non-RT traffic control.
> > 
> > This can only made on the sending side (which the solution I propose
> > for tx queuing should somewhat achieve, BTW). On the receive side,
> > the best we can do is get the NAPI thread to inherit the priority of
> > the highest priority waiter, and reschedule as soon as it delivers a
> > packet to a thread. So, the NAPI thread should not delay high
> > priority tasks not currently waiting for a packet if there is no
> > higher priority thread waiting for a packet.
> > 
> >>
> >>>
> >>> Maybe the RTnet drivers contain some modifications for low latency
> >>> like reducing the TX ring length, but I believe putting these
> >>> modifications in the drivers is not a so good idea: 
> >>
> >> The key modifications that were needed for drivers so far are:
> >>  - TX/RX time stamping support
> >>  - disabling of IRQ coalescing features for low-latency signaling
> >>  - support for pre-mapping rings (to avoid triggering IOMMU paths
> >>    during runtime)
> > 
> > Ok, thanks. Could you point me at a drivers which have these
> > modifications? Particularly the third one, because I believe
> > mainline has RX/TX time stamping as well, and the NAPI should handle
> > the second one.
> 
> Regarding time stamping: yes, mainline may have this now. You just need
> to check when it happens. The original philosophy was to have that as
> close to triggering the TX / receiving an RX event as feasible.
> 
> Regarding IRQ coalescing: This is a hardware feature that aims at
> optimizing throughput and lowering CPU load. As such, it works against
> the goal of lowering individual event latencies. However, maybe such
> things are controllable in standard drivers today, just not in a
> consistent way.

If you mean RX irq coalescing, I guess NAPI is just the same thing
done in software. For TX, I realized recently that the "TX complete"
irq, was kind of bad for performances, this results in way to many
interrupts when trying and generating traffic at full bandwidth.
Especially since we are not that much in a hurry for reclaiming the
TX packets memory, this does not impact latency visible to
application, so coalescing TX irq is desirable as well. But this all
seem to be doable in software. I will check that.

> And regarding premapping: Just look that rt_igb or rt_e1000e. See e.g.
> c05d7bbfba. This change is mandatory for RT, at least for dual-domain
> setups.

Ok, I will have a look, thanks.

-- 
					    Gilles.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 190 bytes
Desc: Digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20141121/7e25de0e/attachment.sig>
