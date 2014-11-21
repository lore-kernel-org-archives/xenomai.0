Date: Fri, 21 Nov 2014 12:10:06 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141121111006.GA31011@sisyphus.hd.free.fr>
References: <20141121090857.GK4545@sisyphus.hd.free.fr>
 <546F14BE.1090209@web.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <546F14BE.1090209@web.de>
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

On Fri, Nov 21, 2014 at 11:32:30AM +0100, Jan Kiszka wrote:
> On 2014-11-21 10:08, Gilles Chanteperdrix wrote:
> > Hi,
> > 
> > as some of you may have seen, I have sent the pull request to
> > Philippe for the integration of RTnet in Xenomai 3, those of you who
> > want will be able to test it when Xenomai 3 next release candidate
> > is released. What will be in that release candidate is what was in
> > RTnet git, patched up to adapt it to the Linux and Xenomai API
> > changes that broke its compilation, and to add the bits and pieces
> > to be able to run some tests on the hardware I have (namely, the
> > 8139too, r8169, at91_ether and macb drivers).
> 
> For x86, support for e1000e and possibly also igb will be very helpful.
> Those NICs dominate the market now, specifically due to their on-chip /
> on-board presence. I think those two drives are in better shape than the
> legacy ones.

When compiling Xenomai 3 with RTnet on x86 (32 and 64), I enabled
all the PCI drivers. So, they all compile as far as I know. I have
not tested them of course, but since the rtnet stack has not changed
(yet), they should continue to work if they were in a working state.


> > - the NAPI will be implemented. The NAPI thread will run with the
> > priority of the highest priority waiting thread, and will call
> > rt_stack_deliver, in order not to increase the RX latency compared
> > to the current solution. This will make porting recent drivers easy
> > and has the additional advantage of irq handlers not creating large
> > irq masking sections like in the current design, which even borders
> > priority inversion if the bulk of the received packets is for RTmac
> > vnics or rtnetproxy.
> 
> Will be an interesting feature. However, whenever you share a link for
> RT and non-RT packets, you do have an unavoidable prio-inversion risk.
> The way to mitigate this is non-RT traffic control.

This can only made on the sending side (which the solution I propose
for tx queuing should somewhat achieve, BTW). On the receive side,
the best we can do is get the NAPI thread to inherit the priority of
the highest priority waiter, and reschedule as soon as it delivers a
packet to a thread. So, the NAPI thread should not delay high
priority tasks not currently waiting for a packet if there is no
higher priority thread waiting for a packet.

> 
> > 
> > Maybe the RTnet drivers contain some modifications for low latency
> > like reducing the TX ring length, but I believe putting these
> > modifications in the drivers is not a so good idea: 
> 
> The key modifications that were needed for drivers so far are:
>  - TX/RX time stamping support
>  - disabling of IRQ coalescing features for low-latency signaling
>  - support for pre-mapping rings (to avoid triggering IOMMU paths
>    during runtime)

Ok, thanks. Could you point me at a drivers which have these
modifications? Particularly the third one, because I believe
mainline has RX/TX time stamping as well, and the NAPI should handle
the second one.

> 
> > - it means that the modification is to be made in each driver, and
> > needs to be maintained;
> > - in the particular case of the TX ring, reducing the number of
> > queued packets in hardware is not a really precise way to guarantee
> > a bounded latency, because the latency is proportional to the number
> > of bytes queued, not on the number of packets, and ethernet packets
> > have widely varying sizes.
> > 
> > So, I propose to try and implement these modifications in the rtdev
> > stack. For the case of the TX ring, implementing a TX queue which
> > keeps track of how much time are worth the number of bytes currently
> > queued in hardware (including preamble and inter packets gap) and
> > stop queuing when this value reaches a configurable threshold (the
> > maximum TX latency), and restart the queue when this value reaches
> > the interrupt latency. The queue will be ordered by sender priority,
> > so that when a high priority thread queues a packet, the packet will
> > never take more than the threshold to reach the wire, even if a low
> > priority or the RTmac vnic drivers or rtnetproxy are using the full
> > bandwidth (which will remain possible if the threshold is higher
> > than the current average irq latency).
> > 
> > Please feel free to send any reaction to this mail.
> 
> Thanks for picking up this task, it is very welcome and should help to
> keep this project alive! I ran out of time to take care of it, as people
> surely noticed. But it was always my plan as well to hand this over to
> the stronger Xenomai community when the code is in acceptable state.
> It's great to see this happening now!

Thanks, as you know I have used RTnet a long time ago on an (ARM
IXP465 based) ISP mixed IPBX/DSL internet gateway when working for
this ISP, and I always wanted to contribute back the ideas I had
implemented or could not even implement at the time.

-- 
					    Gilles.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 190 bytes
Desc: Digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20141121/6ba87a9a/attachment.sig>
