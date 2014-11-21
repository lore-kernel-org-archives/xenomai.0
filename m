MIME-Version: 1.0
In-Reply-To: <546EF065.9070206@xenomai.org>
References: <20141119151244.GC825@sisyphus.hd.free.fr>
 <CANKLDms+QDBcQ6qvK3KfMByLpsfkbt8jTOc8PEZ5VJ9q90SQKA@mail.gmail.com>
 <20141119154950.GD825@sisyphus.hd.free.fr>
 <CANKLDmtXvOEuu0aADjJ=ctjE1PQC_v2jt26PhyYri2q2p7r48Q@mail.gmail.com>
 <20141120082019.GH7011@sisyphus.hd.free.fr>
 <CANKLDmthksKWg3H1md+8xPNU0fbgEM2Q9+W2o+sx=7p=6tsNow@mail.gmail.com>
 <20141120090344.GJ7011@sisyphus.hd.free.fr>
 <CANKLDmt==uLHy8_1pZTDVtJZfhLPDviMUPekUFQdADRZZpX8iw@mail.gmail.com>
 <CANKLDmt4OApxTx-41pf40P0_5DUsxNSaNh+QtTL4fO52_adXjQ@mail.gmail.com>
 <CANKLDmsoet+Z-7eEuXhNJ6QSt9Dh4Sktur0MGCZBtwdBB073AQ@mail.gmail.com>
 <20141120184516.GC4545@sisyphus.hd.free.fr>
 <546EF065.9070206@xenomai.org>
Date: Fri, 21 Nov 2014 09:03:38 +0100
Message-ID: <CANKLDmuD4evzObPYqd64rfmNLD9NPqS3EZrSUZy_84mL44bpGg@mail.gmail.com>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, Nov 21, 2014 at 8:57 AM, Philippe Gerum <rpm@xenomai.org> wrote:

> On 11/20/2014 07:45 PM, Gilles Chanteperdrix wrote:
> > On Thu, Nov 20, 2014 at 05:24:42PM +0100, Henri Roosen wrote:
> >> On Thu, Nov 20, 2014 at 10:54 AM, Henri Roosen <henriroosen@gmail.com>
> >> wrote:
> >>
> >>>
> >>>
> >>> On Thu, Nov 20, 2014 at 10:14 AM, Henri Roosen <henriroosen@gmail.com>
> >>> wrote:
> >>>
> >>>>
> >>>>
> >>>> On Thu, Nov 20, 2014 at 10:03 AM, Gilles Chanteperdrix <
> >>>> gilles.chanteperdrix@xenomai.org> wrote:
> >>>>
> >>>>> On Thu, Nov 20, 2014 at 09:52:44AM +0100, Henri Roosen wrote:
> >>>>>> On Thu, Nov 20, 2014 at 9:20 AM, Gilles Chanteperdrix <
> >>>>>> gilles.chanteperdrix@xenomai.org> wrote:
> >>>>>>
> >>>>>>> On Thu, Nov 20, 2014 at 09:13:49AM +0100, Henri Roosen wrote:
> >>>>>>>> On Wed, Nov 19, 2014 at 4:49 PM, Gilles Chanteperdrix <
> >>>>>>>> gilles.chanteperdrix@xenomai.org> wrote:
> >>>>>>>>
> >>>>>>>>> On Wed, Nov 19, 2014 at 04:43:08PM +0100, Henri Roosen wrote:
> >>>>>>>>>> On Wed, Nov 19, 2014 at 4:12 PM, Gilles Chanteperdrix <
> >>>>>>>>>> gilles.chanteperdrix@xenomai.org> wrote:
> >>>>>>>>>>
> >>>>>>>>>>> On Wed, Nov 19, 2014 at 04:11:30PM +0100, Henri Roosen wrote:
> >>>>>>>>>>>> On Wed, Nov 19, 2014 at 4:09 PM, Gilles Chanteperdrix <
> >>>>>>>>>>>> gilles.chanteperdrix@xenomai.org> wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>>> On Wed, Nov 19, 2014 at 04:03:40PM +0100, Henri Roosen
> >>>>> wrote:
> >>>>>>>>>>>>>> On Wed, Nov 19, 2014 at 3:03 PM, Gilles Chanteperdrix <
> >>>>>>>>>>>>>> gilles.chanteperdrix@xenomai.org> wrote:
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> On Wed, Nov 19, 2014 at 02:33:51PM +0100, Henri
> >>>>> Roosen
> >>>>>>> wrote:
> >>>>>>>>>>>>>>>> On Wed, Nov 19, 2014 at 2:10 PM, Gilles
> >>>>> Chanteperdrix <
> >>>>>>>>>>>>>>>> gilles.chanteperdrix@xenomai.org> wrote:
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> On Wed, Nov 19, 2014 at 01:56:20PM +0100, Henri
> >>>>> Roosen
> >>>>>>>>> wrote:
> >>>>>>>>>>>>>>>>>> I reworked the driver now and the 'stalled head
> >>>>>>> domain'
> >>>>>>>>> is
> >>>>>>>>>>> not
> >>>>>>>>>>>>> there
> >>>>>>>>>>>>>>>>>> anymore.
> >>>>>>>>>>>>>>>>>> However, the other symptoms did not disappear.
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> I currently observe 2 symptoms:
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> As I said, I prefer handle one problem at a
> >>>>> time, and
> >>>>>>> pass
> >>>>>>>>> to
> >>>>>>>>>>> the
> >>>>>>>>>>>>>>>>> next when we are finished with the current.
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> Either 1) a stall of the i.MX timer
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> Who cares ? The i.MX timer has no reason to be
> >>>>> used,
> >>>>>>> the
> >>>>>>>>>>> cortex a9
> >>>>>>>>>>>>>>>>> local timers should be used. Or are you booting a
> >>>>>>> kernel
> >>>>>>>>>>> compiled
> >>>>>>>>>>>>>>>>> without CONFIG_SMP ?
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> I compiled without CONFIG_SMP as the symptoms
> >>>>> seemed less
> >>>>>>>>> random.
> >>>>>>>>>>>>>>> However,
> >>>>>>>>>>>>>>>> as you said, let's put this on ice for now and
> >>>>> focus on
> >>>>>>> the
> >>>>>>>>> NULL
> >>>>>>>>>>>>> pointer
> >>>>>>>>>>>>>>>> dereference for now.
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> or 2) a kernel NULL pointer dereference.
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> The kernel trace of the NULL pointer
> >>>>> dereference is
> >>>>>>> as
> >>>>>>>>> below:
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> Well the kernel trace is not exactly as below,
> >>>>> because
> >>>>>>> your
> >>>>>>>>>>> mailer
> >>>>>>>>>>>>>>>>> wrapped it, which makes it hard to read. Please
> >>>>> try to
> >>>>>>> get
> >>>>>>>>> your
> >>>>>>>>>>>>>>>>> mailer not to wrap the trace, or failing that,
> >>>>> simply
> >>>>>>>>> attach a
> >>>>>>>>>>>>> plain
> >>>>>>>>>>>>>>>>> text file with the trace.
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> Unable to handle kernel NULL pointer
> >>>>> dereference at
> >>>>>>>>> virtual
> >>>>>>>>>>>>> address
> >>>>>>>>>>>>>>>>> 00000000
> >>>>>>>>>>>>>>>>>> pgd = ce230000, hw pgd = ce230000
> >>>>>>>>>>>>>>>>>> [00000000] *pgd=1e30d831, *pte=00000000,
> >>>>>>> *ppte=00000000
> >>>>>>>>>>>>>>>>>> Internal error: Oops: 80000007 [#1] PREEMPT ARM
> >>>>>>>>>>>>>>>>>> Modules linked in: platform_imx(O)
> >>>>> sigmatek_lrt(O)
> >>>>>>>>>>>>>>>>>> CPU: 0 PID: 454 Comm: LRT:454 Tainted: G
> >>>>>   W  O
> >>>>>>>>>>>>>>>>>> 3.10.32-ipipe-00218-gcf143c6-dirty #100
> >>>>>>>>>>>>>>>>>> task: ce00e780 ti: ce2d8000 task.ti: ce2d8000
> >>>>>>>>>>>>>>>>>> PC is at 0x0
> >>>>>>>>>>>>>>>>>> LR is at __ipipe_do_sync_stage+0x1cc/0x2c8
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> __ipipe_do_sync_stage is jumping to address 0,
> >>>>> some
> >>>>>>>>> function
> >>>>>>>>>>>>> pointer
> >>>>>>>>>>>>>>>>> is NULL. You would have to disassemble
> >>>>>>>>> __ipipe_do_sync_stage
> >>>>>>>>>>> around
> >>>>>>>>>>>>>>>>> offset 0x1cc to know what exactly. But it is
> >>>>> probably
> >>>>>>> an
> >>>>>>>>> IRQ
> >>>>>>>>>>>>>>>>> handler. You can modify __ipipe_do_sync_stage
> >>>>> code to
> >>>>>>> emit
> >>>>>>>>> a
> >>>>>>>>>>> printk
> >>>>>>>>>>>>>>>>> with the irq number being currently being
> >>>>> processed
> >>>>>>> when
> >>>>>>>>> its
> >>>>>>>>>>>>> handler
> >>>>>>>>>>>>>>>>> is NULL. We will know what IRQ number has an
> >>>>> issue.
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> Please find the log.txt file attached, which shows
> >>>>> the
> >>>>>>> IRQ
> >>>>>>>>> number
> >>>>>>>>>>>>> that
> >>>>>>>>>>>>>>> has
> >>>>>>>>>>>>>>>> the issue (150: ethernet) as well as the output of
> >>>>>>>>>>> /proc/interrupts
> >>>>>>>>>>>>> and
> >>>>>>>>>>>>>>>> /proc/xenomai/irq
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> I'll do some more tests to see if it is always IRQ
> >>>>> 150.
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> Ok, if it is always 150, could you show us how the
> >>>>> ethernet
> >>>>>>>>> driver
> >>>>>>>>>>>>>>> does its request_irq ? If it does a set_type or
> >>>>> something ?
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> To request the irq, the following statement is called:
> >>>>>>>>>>>>>> ret = request_irq(irq, fec_enet_interrupt,
> >>>>> IRQF_DISABLED,
> >>>>>>>>> pdev->name,
> >>>>>>>>>>>>> ndev);
> >>>>>>>>>>>>>> I didn't find a set_type.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> However, I'm not sure if I completely understood your
> >>>>>>> question.
> >>>>>>>>> Is
> >>>>>>>>>>> it ok
> >>>>>>>>>>>>> if
> >>>>>>>>>>>>>> I point you to the file
> >>>>>>>>> drivers/net/ethernet/freescale/fec_main.c,
> >>>>>>>>>>> line
> >>>>>>>>>>>>>> 1983.
> >>>>>>>>>>>>>> (
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>
> >>>>>>>
> >>>>>
> http://git.xenomai.org/ipipe.git/tree/drivers/net/ethernet/freescale/fec_main.c?h=ipipe-3.10#n1983
> >>>>>>>>>>>>>> )
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Ok, are you using the device tree or not?
> >>>>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>> Yes, using devicetree
> >>>>>>>>>>>
> >>>>>>>>>>> You are sure your devicetree has all the necessary
> >>>>> parameters for
> >>>>>>>>>>> the ethernet interrupt ?
> >>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>> Yes, should be all in the included imx6qdl.dtsi file. Our
> >>>>> board .dts
> >>>>>>> file
> >>>>>>>>>> includes the file and just sets the correct pinctrl, phy-mode
> >>>>> and
> >>>>>>> status
> >>>>>>>>> to
> >>>>>>>>>> okay, similar to what other boards do.
> >>>>>>>>>>
> >>>>>>>>>> Ethernet communication is working and we are getting
> >>>>> interrupts at
> >>>>>>> first,
> >>>>>>>>>> just after a while it stops working because of the NULL pointer
> >>>>>>>>> dereference.
> >>>>>>>>>> Any suggestion how to trace down this specific handler getting
> >>>>>>> NULL-ed?
> >>>>>>>>>
> >>>>>>>>> You can try using the I-pipe tracer. Enable the I-pipe tracer,
> >>>>>>>>> trigger a panic before printing anything when the bug happens (by
> >>>>>>>>> the way, which pointer is NULL, is it the irq handler, or the
> >>>>>>>>> interrupt acknowledge routine ?). Modify the I-pipe tracer to
> >>>>> store
> >>>>>>>>> the current value of the handler instead of the timestamp in the
> >>>>>>>>> I-pipe trace structure, and the function printing the traces to
> >>>>> cast
> >>>>>>>>> the timestamp to a pointer and print its value instead of
> >>>>> computing
> >>>>>>>>> a difference. With enough back trace points, it should be clear
> >>>>> in
> >>>>>>>>> the trace generated which function sets the pointer to NULL.
> >>>>>>>>>
> >>>>>>>>> Alternatively, if you are ready to spend time in your processor
> >>>>>>>>> documentation, you can look for a way to program its hardware
> >>>>>>>>> breakpoints registers to watch the handler address once it has
> >>>>> been
> >>>>>>>>> set.
> >>>>>>>>>
> >>>>>>>>> I found out the irq-handler doesn't get NULL-ified. Instead, the
> >>>>> ipd
> >>>>>>>> points to the xenomai domain at the moment of handling the irq
> 150.
> >>>>>>>> However, it is only requested and registered in the Linux domain.
> >>>>>>>>
> >>>>>>>> I'll use the I-pipe tracer now to make a trace at the moment the
> >>>>> 150
> >>>>>>>> interrupt gets handled in the xenomai domain..
> >>>>>>>
> >>>>>>> Yes, please, do not forget to ask for a large number of back trace
> >>>>> points.
> >>>>>>>
> >>>>>>> Please find attached the ipipetrace.txt file.
> >>>>>>
> >>>>>>
> >>>>>>> --
> >>>>>>>                                             Gilles.
> >>>>>>>
> >>>>>
> >>>>>> Unable to handle kernel NULL pointer dereference at virtual address
> >>>>> 00000000
> >>>>>> pgd = ce1b0000, hw pgd = ce1b0000
> >>>>>> [00000000] *pgd=1e236831, *pte=00000000, *ppte=00000000
> >>>>>> --> IRQ handler irq 150 == NULL!! domain Xenomai
> >>>>>
> >>>>> Please put the panic or trace freeze before printing anything and
> >>>>> the whole dumping. This will remove a lot of useless stuff from the
> >>>>> trace.
> >>>>>
> >>>>> Please find attached the ipipetrace_2.txt file (this time I was able
> to
> >>>> capture it via /proc/ipipe/trace/frozen instead of the terminal
> logging).
> >>>>
> >>>
> >>> I noticed we have a taskswitch hook set, which might blur the trace
> >>> results. So if you are interested in a trace without the taskswitch
> hook
> >>> set, then please find attached ipipetrace_3.txt. Sorry for the
> >>> inconvenience.
> >>>
> >>
> >> I was actually wondering how __ipipe_next_irq() could come up with 150
> when
> >> in the xenomai domain.
> >>
> >> I'm not sure, but the code in __ipipe_do_sync_stage() looks a bit
> strange
> >> to me:
> >> first p is set to the __ipipe_current_context and ipd to p->domain.
> Later
> >> in the for-loop, p get updated again to __ipipe_current_context again
> (so
> >> it is expected to change) but ipd is not updated to be set to the
> p->domain
> >> again.
> >> Was that on purpose or is the ipd = p->domain; statement missing inside
> the
> >> for-loop?
> >
> > Looks strange. Have you tried adding ipd = p->domain under p =
> > __ipipe_current_context ?
> >
>
> The callee may not switch domain over an interrupt handler. Only CPU
> migration may happen, which is what this assignment cares about.
>
> rules in IRQ context over sync_stage are:
>
> - no domain migration
> - CPU migration possible over the root domain only
>
> Each CPU holds an array of per-domain context areas, each context area
> backlinks to the domain descriptor.
>
>
I'll instrument the code to detect domain migration, but I guess that is
what we are facing.

Is the domain migration visible in the ipipe-trace / how can I trace down
to the point where domain migration happens?

Thanks!
Henri

--
> Philippe.
>
