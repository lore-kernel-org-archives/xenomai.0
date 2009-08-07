From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1249643060.5957.12.camel@domain.hid>
References: <28c396720908070308t544c6cb7y45ed53c11dfee30c@domain.hid>
	<1249640396.5957.5.camel@domain.hid>
	<28c396720908070338o3e12cf83g273741e0fcb18d02@domain.hid>
	<1249643060.5957.12.camel@domain.hid>
Content-Type: text/plain
Date: Fri, 07 Aug 2009 13:04:43 +0200
Message-Id: <1249643083.5957.13.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Interrupt workqueue and Xenomai 2.4.0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Yang <hegallis@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2009-08-07 at 13:04 +0200, Philippe Gerum wrote:
> On Fri, 2009-08-07 at 11:38 +0100, Yang wrote:
> > Hi Philippe
> > 
> > 
> > Are you suggesting this is because IRQ is threaded in the version of
> > Xenomai I am using? Why would this cause problem?
> > 
> > 
> > If I understood right, as there are no rtai
> 
> eh?
> 
> >  level interrupt handler registered, the interrupt will be handled in
> > the linux domain (which I can see), except the interrupt never gets
> > cleared even if I disable_irq.
> > The biggest problem is that I queue_work in the linux interrupt
> > handler. But the work being queued never seems to be consumed by the
> > kthread which created by create_singlethread_workqueue. I can see the
> > kthread being created using "ps ax".
> > 
> > 
> > I am on kernel 2.6.22 with Xenomai 2.4.0. Could you be more specific
> > why this does not work? Is work queue not supported in this version?
> 
> No, I can't be more specific because I don't have enough bandwidth to
> debug 2.4.0 on a legacy uClinux kernel and pipeline support.
> 
> My feeling is that the issue could stem from the threaded IRQ model the
> legacy pipeline for Blackfin implements, which might create the
> conditions for your bug to trigger. Workqueues are likely not related to
> the problem at all.
> 
> In short, in your situation, I would upgrade to 2.6.28 + recent I-pipe
> support, then at this chance upgrade to 2.4.8, and have a try. If you
> really want to stick with 2.4.0 without giving a try to newer versions
> to help us finding whether the issue does exist there or not, then I'm
> afraid that you will be on your own.
> 
> > 
> > 
> > 
> > 
> > 2009/8/7 Philippe Gerum <rpm@xenomai.org>
> >         
> >         On Fri, 2009-08-07 at 11:08 +0100, Yang wrote:
> >         > Hi
> >         >
> >         > I am working on BF527 at the moment while we queue work item
> >         upon GPI
> >         > interrupt to a work queue as delayed work. This kernel
> >         driver works
> >         > fine without Xenomai patch turned on. However, it stops
> >         working after
> >         > applying Xenomai patch. It appears that the interrupt
> >         handler was
> >         > triggered but the work item in the work queue is not being
> >         processing
> >         > (by kernel thread which is supposed to work on).
> >         >
> >         >
> >         > my assumption was that ipipe should pass through non-rt
> >         interrupts to
> >         > Linux domain. Linux kernel tasks such as work queue will
> >         still be
> >         > handled in the same way by kthread. However, it seems that
> >         >
> >         > 1. the interrupt line never gets cleared
> >         >
> >         > 2. kthread which handles work structure in the work queue
> >         not doing
> >         > its work (or cannot switch to linux kthread context I
> >         suspect)
> >         >
> >         > Any suggestions?
> >         
> >         
> >         Yes, I understand this may not be the kind of suggestion you
> >         want, but
> >         you should definitely upgrade to 2.4.8, and use the 2.6.28
> >         kernel that
> >         comes with a recent uClinux/blackfin distro.
> >         
> >         IRQs are no more threaded there.
> >         
> >         >
> >         >
> >         > Thanks
> >         >
> >         >
> >         > _______________________________________________
> >         > Xenomai-help mailing list
> >         > Xenomai-help@domain.hid
> >         > https://mail.gna.org/listinfo/xenomai-help
> >         --
> >         Philippe.
> >         
> >         
> > 
> > 
> > 
> > -- 
> > Regards,
> > Yang
> > 
-- 
Philippe.



