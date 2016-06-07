Date: Tue, 7 Jun 2016 19:00:50 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160607170050.GA13922@hermes.click-hack.org>
References: <574D9B03.8080706@sigmatek.at>
 <20160531141646.GG5951@hermes.click-hack.org>
 <574EE886.2020907@sigmatek.at>
 <20160601141238.GC14103@hermes.click-hack.org>
 <574FEB2D.5010509@sigmatek.at>
 <20160602082318.GB1801@hermes.click-hack.org>
 <5755204C.6090701@sigmatek.at>
 <20160606153545.GA376@hermes.click-hack.org>
 <5756D673.4080408@sigmatek.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5756D673.4080408@sigmatek.at>
Subject: Re: [Xenomai] Performance impact after switching from 2.6.2.1 to
 2.6.4
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Netbal <wolfgang.netbal@sigmatek.at>
Cc: xenomai@xenomai.org

On Tue, Jun 07, 2016 at 04:13:07PM +0200, Wolfgang Netbal wrote:
> 
> 
> Am 2016-06-06 um 17:35 schrieb Gilles Chanteperdrix:
> > On Mon, Jun 06, 2016 at 09:03:40AM +0200, Wolfgang Netbal wrote:
> >>
> >> Am 2016-06-02 um 10:23 schrieb Gilles Chanteperdrix:
> >>> On Thu, Jun 02, 2016 at 10:15:41AM +0200, Wolfgang Netbal wrote:
> >>>> Am 2016-06-01 um 16:12 schrieb Gilles Chanteperdrix:
> >>>>> On Wed, Jun 01, 2016 at 03:52:06PM +0200, Wolfgang Netbal wrote:
> >>>>>> Am 2016-05-31 um 16:16 schrieb Gilles Chanteperdrix:
> >>>>>>> On Tue, May 31, 2016 at 04:09:07PM +0200, Wolfgang Netbal wrote:
> >>>>>>>> Dear all,
> >>>>>>>>
> >>>>>>>> we have moved our application from "XENOMAI 2.6.2.1 + Linux 3.0.43" to
> >>>>>>>> "XENOMAI 2.6.4. + Linux 3.10.53". Our target is an i.MX6DL. The system
> >>>>>>>> is now up and running and works stable. Unfortunately we see a
> >>>>>>>> difference in the performance. Our old combination (XENOMAI 2.6.2.1 +
> >>>>>>>> Linux 3.0.43) was slightly faster.
> >>>>>>>>
> >>>>>>>> At the moment it looks like that XENOMAI 2.6.4 calls
> >>>>>>>> xnpod_schedule_handler much more often then XENOMAI 2.6.2.1 in our old
> >>>>>>>> system.  Every call of xnpod_schedule_handler interrupts our main
> >>>>>>>> XENOMAI task with priority = 95.
> As I wrote above, I get interrupts 1037 handled by rthal_apc_handler()
> and 1038 handled by xnpod_schedule_handler() while my realtime task
> is running on kernel 3.10.53 with Xenomai 2.6.4.
> On kernel 3.0.43 with Xenomai 2.6.4 there are no interrupts, except the
> once that are send by my board using GPIOs, but this virtual interrupts
> are assigned to Xenomai and Linux as well but I didn't see a handler 
> installed.
> I'm pretty sure that these interrupts are slowing down my system, but
> where do they come from ?
> why didn't I see them on Kernel 3.0.43 with Xenomai 2.6.4 ?
> how long do they need to process ?

How do you mean you do not see them? If you are talking about the
rescheduling API, it used no to be bound to a virq (so, it would
have a different irq number on cortex A9, something between 0 and 31
that would not show in the usual /proc files), I wonder if 3.0 is
before or after that. You do not see them in /proc, or you see them
and their count does not increase?

As for where they come from, this is not a mystery, the reschedule
IPI is triggered when code on one cpu changes the scheduler state
(wakes up a thread for instance) on another cpu. If you want to
avoid it, do not do that. That means, do not share mutex between
threads running on different cpus, pay attention for timers to be
running on the same cpu as the thread they signal, etc...

The APC virq is used to multiplex several services, which you can
find by grepping the sources for rthal_apc_alloc:
./ksrc/skins/posix/apc.c:       pse51_lostage_apc = rthal_apc_alloc("pse51_lostage_handler",
./ksrc/skins/rtdm/device.c:     rtdm_apc = rthal_apc_alloc("deferred RTDM close", rtdm_apc_handler,
./ksrc/nucleus/registry.c:          rthal_apc_alloc("registry_export", &registry_proc_schedule, NULL);
./ksrc/nucleus/pipe.c:      rthal_apc_alloc("pipe_wakeup", &xnpipe_wakeup_proc, NULL);
./ksrc/nucleus/shadow.c:            rthal_apc_alloc("lostage_handler", &lostage_handler, NULL);
./ksrc/nucleus/select.c:        xnselect_apc = rthal_apc_alloc("xnselectors_destroy",

It would be interesting to know which of these services is triggered
a lot. One possibility I see would be root thread priority
inheritance, so it would be caused by mode switches. This brings the
question: do your application have threads migrating between primary
and secondary mode, do you see the count of mode switches increase
with the kernel changes, do you have root thread priority
inheritance enabled?

-- 
					    Gilles.
https://click-hack.org

