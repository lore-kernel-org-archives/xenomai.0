Message-ID: <546F14BE.1090209@web.de>
Date: Fri, 21 Nov 2014 11:32:30 +0100
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <20141121090857.GK4545@sisyphus.hd.free.fr>
In-Reply-To: <20141121090857.GK4545@sisyphus.hd.free.fr>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] RTnet in Xenomai 3, status and future
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Xenomai <xenomai@xenomai.org>, rtnet-developers@lists.sourceforge.net, rtnet-users@lists.sourceforge.net

On 2014-11-21 10:08, Gilles Chanteperdrix wrote:
> Hi,
> =

> as some of you may have seen, I have sent the pull request to
> Philippe for the integration of RTnet in Xenomai 3, those of you who
> want will be able to test it when Xenomai 3 next release candidate
> is released. What will be in that release candidate is what was in
> RTnet git, patched up to adapt it to the Linux and Xenomai API
> changes that broke its compilation, and to add the bits and pieces
> to be able to run some tests on the hardware I have (namely, the
> 8139too, r8169, at91_ether and macb drivers).

For x86, support for e1000e and possibly also igb will be very helpful.
Those NICs dominate the market now, specifically due to their on-chip /
on-board presence. I think those two drives are in better shape than the
legacy ones.

> =

> Doing that job, I have found a few things to fix or to do
> differently, and am now able to say how I would like to do it. This
> mail is cross-posted on the RTnet mailing list, because I believe it
> somewhat concerns RTnet users and developers.
> =

> We can divide RTnet into three parts:
> - the tools
> - the stack
> - the drivers
> =

> The tools are in good shape, I do not see any reason to fix them,
> except maybe for the rtcfg stuff where an ioctl uses filp_open in
> kernel-space which I find a bit useless, but this is not important,
> and can wait.
> =

> The stack is not in bad shape either. The code needs a bit of
> refreshing, for instance using Linux list and hash lists instead of
> open coding linked list. But this will not cause any API change, so
> can wait too.
> =

> The drivers, on the other hand, are a bit more worrying. They are
> based on seriously outdated versions of the corresponding Linux
> drivers, with support for much less hardware, and probably missing
> some bug fixes. So, putting the drivers into a better shape and
> making it easy to track mainline changes will be my first priority.
> =

> With the 3 drivers I had to adapt, I tested the two possible
> approach to updating a driver. For r8169 I hand picked in Linux
> driver what was needed to support the chip I have (a 8136) and
> adapted it to the code difference between the two versions of the
> driver. For at91_ether and macb drivers, I restarted from the
> current state of the mainline Linux. The second approach is easier
> and more satisfying than the first, because at least you can get all
> the mainline fixes, but to my taste, not easy enough.
> =

> I believe the first order of business is to change the rtdev API so
> that this port is easy, and in fact, if possible has a first
> automated step. So, I intend to change rtdm and rtdev API to reach
> this goal:
> - rt_stack_connect, rt_rtdev_connect, rt_stack_mark will be removed
> and replaced with mechanisms integrated in the rtdev API
> - rtdm_irq_request/rtdm_irq_free will be modified to have almost the
> same interface as request_irq, in particular removing the need for a
> driver to provide the storage for the rtdm_irq_t handles, which will
> then become unneeded. This makes life easier for drivers which
> register multiple irq handlers. =

> - rtdm_devm_irq_request or rtdev_irq_request will be introduced with
> a behaviour similar to devm_request_irq, that is automatic
> unregistration of the irqs handlers at device destruction. Because
> automatically adding the missing calls to rtdm_irq_free to a code
> using devm_request_irq is hard.

Sounds good.

> - the NAPI will be implemented. The NAPI thread will run with the
> priority of the highest priority waiting thread, and will call
> rt_stack_deliver, in order not to increase the RX latency compared
> to the current solution. This will make porting recent drivers easy
> and has the additional advantage of irq handlers not creating large
> irq masking sections like in the current design, which even borders
> priority inversion if the bulk of the received packets is for RTmac
> vnics or rtnetproxy.

Will be an interesting feature. However, whenever you share a link for
RT and non-RT packets, you do have an unavoidable prio-inversion risk.
The way to mitigate this is non-RT traffic control.

> =

> Maybe the RTnet drivers contain some modifications for low latency
> like reducing the TX ring length, but I believe putting these
> modifications in the drivers is not a so good idea: =


The key modifications that were needed for drivers so far are:
 - TX/RX time stamping support
 - disabling of IRQ coalescing features for low-latency signaling
 - support for pre-mapping rings (to avoid triggering IOMMU paths
   during runtime)

> - it means that the modification is to be made in each driver, and
> needs to be maintained;
> - in the particular case of the TX ring, reducing the number of
> queued packets in hardware is not a really precise way to guarantee
> a bounded latency, because the latency is proportional to the number
> of bytes queued, not on the number of packets, and ethernet packets
> have widely varying sizes.
> =

> So, I propose to try and implement these modifications in the rtdev
> stack. For the case of the TX ring, implementing a TX queue which
> keeps track of how much time are worth the number of bytes currently
> queued in hardware (including preamble and inter packets gap) and
> stop queuing when this value reaches a configurable threshold (the
> maximum TX latency), and restart the queue when this value reaches
> the interrupt latency. The queue will be ordered by sender priority,
> so that when a high priority thread queues a packet, the packet will
> never take more than the threshold to reach the wire, even if a low
> priority or the RTmac vnic drivers or rtnetproxy are using the full
> bandwidth (which will remain possible if the threshold is higher
> than the current average irq latency).
> =

> Please feel free to send any reaction to this mail.

Thanks for picking up this task, it is very welcome and should help to
keep this project alive! I ran out of time to take care of it, as people
surely noticed. But it was always my plan as well to hand this over to
the stronger Xenomai community when the code is in acceptable state.
It's great to see this happening now!

Jan


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20141121/9e13693=
b/attachment.sig>
