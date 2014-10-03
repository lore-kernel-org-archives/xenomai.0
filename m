Date: Fri, 3 Oct 2014 10:57:57 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141003085757.GI2450@sisyphus.hd.free.fr>
References: <542BB31F.8070803@xenomai.org>
 <CACreCVK8axcEwipeOTxXp7cwAXz8jGOPqEG9j2dp8zosCZFrjA@mail.gmail.com>
 <542BC753.8000605@xenomai.org>
 <CACreCVJvfuMeRCVdE6NTPK=frJ3_-PL-TDrZy9U5fLAW7gWjcg@mail.gmail.com>
 <542D54C0.3070001@xenomai.org>
 <CACreCVLXpS5coAa3M4-pwWxYLzjiMZTr++_k8zOuyFVKhAfKWQ@mail.gmail.com>
 <542D87AA.6000607@xenomai.org>
 <CACreCVK=dt7Cj87FohsCLxpmGRXcUvuKS6Ki_=-yyxUW3L1oqQ@mail.gmail.com>
 <20141003072059.GA2450@sisyphus.hd.free.fr>
 <CACreCVLij_wUhe3pkpd7fjHKQV0=+NZf3a_EXoWzJu5v9Oon-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACreCVLij_wUhe3pkpd7fjHKQV0=+NZf3a_EXoWzJu5v9Oon-Q@mail.gmail.com>
Subject: Re: [Xenomai] Switchtest failures on ODROIDU3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: GP Orcullo <kinsamanka@gmail.com>
Cc: xenomai@xenomai.org

On Fri, Oct 03, 2014 at 04:45:53PM +0800, GP Orcullo wrote:
> On Fri, Oct 3, 2014 at 3:20 PM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
> > On Fri, Oct 03, 2014 at 11:35:33AM +0800, GP Orcullo wrote:
> >> The system managed to dump some error messages.
> >>
> >
> >> [  407.688809] INFO: rcu_preempt detected stalls on CPUs/tasks: { 3} (detected by 0, t=12002 jiffies, g=22447, c=22446, q=113448)
> >> [  407.694560] Task dump for CPU 3:
> >> [  407.697763] switchtest      R running      0  3979   3640 0x00000002
> >> [  407.704111] [<c0453ddc>] (__schedule+0x1fc/0x5f8) from [<00000010>] (0x10)
> >> [  587.714458] INFO: rcu_preempt detected stalls on CPUs/tasks: { 3} (detected by 2, t=48007 jiffies, g=22447, c=22446, q=443504)
> >> [  587.720205] Task dump for CPU 3:
> >> [  587.723407] switchtest      R running      0  3979   3640 0x00000002
> >> [  587.729755] [<c0453ddc>] (__schedule+0x1fc/0x5f8) from [<00000010>] (0x10)
> >> [  767.740128] INFO: rcu_preempt detected stalls on CPUs/tasks: { 3} (detected by 2, t=84012 jiffies, g=22447, c=22446, q=1136198)
> >> [  767.745964] Task dump for CPU 3:
> >> [  767.749167] switchtest      R running      0  3979   3640 0x00000002
> >> [  767.755515] [<c0453ddc>] (__schedule+0x1fc/0x5f8) from [<00000010>] (0x10)
> >> [  782.763027] ------------[ cut here ]------------
> >> [  782.763099] WARNING: at include/linux/ipipe_domain.h:212 __ipipe_dispatch_irq+0x35c/0x5a0()
> >> [  782.770380] Modules linked in: nfsv3 nfsv4 nfsd exportfs nfs_acl auth_rpcgss nfs lockd sunrpc vfat fat smsc95xx usbnet mii gpio_keys
> >> [  782.782218] [<c0015624>] (unwind_backtrace+0x0/0xf8) from [<c0026118>] (warn_slowpath_common+0x4c/0x64)
> >> [  782.791606] [<c0026118>] (warn_slowpath_common+0x4c/0x64) from [<c002614c>] (warn_slowpath_null+0x1c/0x24)
> >> [  782.801232] [<c002614c>] (warn_slowpath_null+0x1c/0x24) from [<c00886ac>] (__ipipe_dispatch_irq+0x35c/0x5a0)
> >> [  782.811035] [<c00886ac>] (__ipipe_dispatch_irq+0x35c/0x5a0) from [<c00200c8>] (combiner_handle_cascade_irq+0x80/0xf4)
> >> [  782.821620] [<c00200c8>] (combiner_handle_cascade_irq+0x80/0xf4) from [<c0019110>] (__ipipe_ack_irq+0xc/0x10)
> >
> > This is bad, can I see the code of the "combiner_handle_cascade_irq" function?
> >
>
> Here's the original code:
>
> static DEFINE_SPINLOCK(irq_controller_lock);
>
> ...
>
> static void combiner_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
> {
>     struct combiner_chip_data *chip_data = irq_get_handler_data(irq);
>     struct irq_chip *chip = irq_get_chip(irq);
>     unsigned int cascade_irq, combiner_irq;
>     unsigned long status;
>
>     chained_irq_enter(chip, desc);
>
>     spin_lock(&irq_controller_lock);
>     status = __raw_readl(chip_data->base + COMBINER_INT_STATUS);
>     spin_unlock(&irq_controller_lock);
>     status &= chip_data->irq_mask;
>
>     if (status == 0)
>         goto out;
>
>     combiner_irq = __ffs(status);
>
>     cascade_irq = combiner_irq + (chip_data->irq_offset & ~31);
>     if (unlikely(cascade_irq >= NR_IRQS))
>         do_bad_IRQ(cascade_irq, desc);
>     else
>         ipipe_handle_demuxed_irq(cascade_irq);
>
>  out:
>     chained_irq_exit(chip, desc);
> }
>
>
> I've changed the DEFINE_SPINLOCK to IPIPE_DEFINE_SPINLOCK and I got
> the same results.

Same results meaning you still have the warning in ipipe_domain ? Or
still have the lockup?

One of these functions uses local_irq_save/local_irq_restore, one
way to find which is to enable the I-pipe tracer, enable panic
backtrace, and put a BUG_ON(hard_irqs_enabled()) right before the
call to ipipe_handle_demuxed_irq. You probably can not call
do_bad_IRQ from here either, but I do not think this is your
problem, this checks looks a bit redundant: in order to check that
cascade_irq is always less than NR_IRQS, it is sufficient to check
that chip_data->irq_offset & ~31 is less than NR_IRQS - 32, which
can be done only once, and not repeated stupidly for every irq.

--
					    Gilles.

