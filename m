From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <181804936ABC2349BE503168465576460FAB4A0C@exchserver.basler.com>
References: <181804936ABC2349BE503168465576460F9E6D9C@exchserver.basler.com>
	<181804936ABC2349BE503168465576460F9E6DA5@domain.hid>
	<4C66939A.1060509@domain.hid> <4C6697F8.1090409@domain.hid>
	<181804936ABC2349BE503168465576460FA508FF@exchserver.basler.com>
	<181804936ABC2349BE503168465576460FAB4A0C@exchserver.basler.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 19 Aug 2010 07:06:42 +0200
Message-ID: <1282194402.1730.365.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Page fault in real time task causes lockup
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steve Deiters <SteveDeiters@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2010-08-18 at 18:05 -0500, Steve Deiters wrote:
> > It turns out my problem was caused by an interrupt storm.  I 
> > had set up the interrupt to propagate to the Linux domain.  
> > When my rt task transferred to the Linux domain from the page 
> > fault it wasn't able to clear the device interrupt flag.  The 
> > interrupt was reenabled at the PIC level after Linux was done 
> > with it, and as soon as that happened it got interrupted again.
> > 
> > My fix was to disable the interrupt at the device level as 
> > soon as rt_intr_wait returns, and reenable it before calling 
> > rt_intr_wait.  I'm still not sure why I was getting that exception.
> 
> I'm still getting exceptions like I was getting before.  With the
> interrupt fix I had in there, the system stays responsive, just that
> task gets killed.  I'm still trying to track down the problem.
> 
> I'm using rt_intr_wait so I am synchronized with an external FPGA, but
> it is just periodic.  If I replace the rt_intr_wait with a timed wait
> with rt_wait_period it does not crash.  There seems to be some
> interaction with the rt_intr_wait I still do not understand.
> 
> I'm trying to make sense of the exception numbers it prints in messages
> like the following.  Maybe this will give me some better insight to what
> is happening.
> 
> [   24.480199] Xenomai: Switching dsp_task to secondary mode after
> exception #1792 in kernel-space at 0xc0062f48 (pid 595)

0x700, this is Program Check exception. Something goes really wrong in
some kernel space code; could you disassemble your kernel to locate that
code at 0xc0062f48?

> 
> I tried turning on the I-pipe tracer to get some more information, but
> it crashes on startup.
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



