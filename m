MIME-Version: 1.0
In-Reply-To: <20141119150924.GB825@sisyphus.hd.free.fr>
References: <CANKLDmuqm9F3OvPvX=6zj87rxNLqgK++19O1LAOJQj54-u4TwA@mail.gmail.com>
 <20141119094137.GA25848@sisyphus.hd.free.fr>
 <CANKLDmu2YU30PBhN2So_5rziitxPf9qjs0H-Y6cJTFq+jAt_ng@mail.gmail.com>
 <20141119095428.GB25848@sisyphus.hd.free.fr>
 <CANKLDmu4j6KZS+UeQq9GtW1rB9_9m6MX3upWK2vWtNpuO0bKBw@mail.gmail.com>
 <CANKLDmvyZEPe8Z5Us1fMJ05=ZGOtqJnDHg_-2n_cwo5hD_8bzw@mail.gmail.com>
 <20141119131004.GG29491@sisyphus.hd.free.fr>
 <CANKLDmsBnQVgH3o014AYURMTmMHKJ0bTydEr1pVUGP+GFbNnbQ@mail.gmail.com>
 <20141119140311.GB31401@sisyphus.hd.free.fr>
 <CANKLDmu5V8s2HzBfqPNRWf-KYZOQg8s7ULsHYsLjh7NPv3T4ew@mail.gmail.com>
 <20141119150924.GB825@sisyphus.hd.free.fr>
Date: Wed, 19 Nov 2014 16:11:30 +0100
Message-ID: <CANKLDmse_kMMSOfJFrLi0fw6LLSZNRihTXXWOLhYtfaNUkt8Cw@mail.gmail.com>
From: Henri Roosen <henriroosen@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] problems with ipipe-3.10 on i.MX6
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, Nov 19, 2014 at 4:09 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On Wed, Nov 19, 2014 at 04:03:40PM +0100, Henri Roosen wrote:
> > On Wed, Nov 19, 2014 at 3:03 PM, Gilles Chanteperdrix <
> > gilles.chanteperdrix@xenomai.org> wrote:
> >
> > > On Wed, Nov 19, 2014 at 02:33:51PM +0100, Henri Roosen wrote:
> > > > On Wed, Nov 19, 2014 at 2:10 PM, Gilles Chanteperdrix <
> > > > gilles.chanteperdrix@xenomai.org> wrote:
> > > >
> > > > > On Wed, Nov 19, 2014 at 01:56:20PM +0100, Henri Roosen wrote:
> > > > > > I reworked the driver now and the 'stalled head domain' is not
> there
> > > > > > anymore.
> > > > > > However, the other symptoms did not disappear.
> > > > > >
> > > > > > I currently observe 2 symptoms:
> > > > >
> > > > > As I said, I prefer handle one problem at a time, and pass to the
> > > > > next when we are finished with the current.
> > > > >
> > > > > > Either 1) a stall of the i.MX timer
> > > > >
> > > > > Who cares ? The i.MX timer has no reason to be used, the cortex a9
> > > > > local timers should be used. Or are you booting a kernel compiled
> > > > > without CONFIG_SMP ?
> > > > >
> > > >
> > > > I compiled without CONFIG_SMP as the symptoms seemed less random.
> > > However,
> > > > as you said, let's put this on ice for now and focus on the NULL
> pointer
> > > > dereference for now.
> > > >
> > > >
> > > > > > or 2) a kernel NULL pointer dereference.
> > > > > >
> > > > > > The kernel trace of the NULL pointer dereference is as below:
> > > > >
> > > > > Well the kernel trace is not exactly as below, because your mailer
> > > > > wrapped it, which makes it hard to read. Please try to get your
> > > > > mailer not to wrap the trace, or failing that, simply attach a
> plain
> > > > > text file with the trace.
> > > > >
> > > > > >
> > > > > > Unable to handle kernel NULL pointer dereference at virtual
> address
> > > > > 00000000
> > > > > > pgd = ce230000, hw pgd = ce230000
> > > > > > [00000000] *pgd=1e30d831, *pte=00000000, *ppte=00000000
> > > > > > Internal error: Oops: 80000007 [#1] PREEMPT ARM
> > > > > > Modules linked in: platform_imx(O) sigmatek_lrt(O)
> > > > > > CPU: 0 PID: 454 Comm: LRT:454 Tainted: G        W  O
> > > > > > 3.10.32-ipipe-00218-gcf143c6-dirty #100
> > > > > > task: ce00e780 ti: ce2d8000 task.ti: ce2d8000
> > > > > > PC is at 0x0
> > > > > > LR is at __ipipe_do_sync_stage+0x1cc/0x2c8
> > > > >
> > > > > __ipipe_do_sync_stage is jumping to address 0, some function
> pointer
> > > > > is NULL. You would have to disassemble __ipipe_do_sync_stage around
> > > > > offset 0x1cc to know what exactly. But it is probably an IRQ
> > > > > handler. You can modify __ipipe_do_sync_stage code to emit a printk
> > > > > with the irq number being currently being processed when its
> handler
> > > > > is NULL. We will know what IRQ number has an issue.
> > > > >
> > > >
> > > > Please find the log.txt file attached, which shows the IRQ number
> that
> > > has
> > > > the issue (150: ethernet) as well as the output of /proc/interrupts
> and
> > > > /proc/xenomai/irq
> > > >
> > > > I'll do some more tests to see if it is always IRQ 150.
> > >
> > > Ok, if it is always 150, could you show us how the ethernet driver
> > > does its request_irq ? If it does a set_type or something ?
> > >
> >
> > To request the irq, the following statement is called:
> > ret = request_irq(irq, fec_enet_interrupt, IRQF_DISABLED, pdev->name,
> ndev);
> > I didn't find a set_type.
> >
> > However, I'm not sure if I completely understood your question. Is it ok
> if
> > I point you to the file drivers/net/ethernet/freescale/fec_main.c, line
> > 1983.
> > (
> >
> http://git.xenomai.org/ipipe.git/tree/drivers/net/ethernet/freescale/fec_main.c?h=ipipe-3.10#n1983
> > )
>
> Ok, are you using the device tree or not?
>

Yes, using devicetree

>
> --
>                                             Gilles.
>
