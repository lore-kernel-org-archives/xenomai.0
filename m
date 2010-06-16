From: Travis Stratman <tstratman@domain.hid>
In-Reply-To: <2319761F7FA0D1479BA77EC2E0A8E7BCEDCE09@domain.hid>
References: <181804936ABC2349BE503168465576460EBD5C0D@exchserver.basler.com>
	<1274047063.2972.1.camel@domain.hid>
	<2319761F7FA0D1479BA77EC2E0A8E7BCE8A603@domain.hid>
	<1275033915.27918.31.camel@domain.hid>
	<2319761F7FA0D1479BA77EC2E0A8E7BCEDCE09@domain.hid>
Date: Wed, 16 Jun 2010 13:37:12 -0500
Message-Id: <1276713432.4890.549.camel@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_task_sleep causing crashes on PowerPC
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Abhijit Majumdar <abhijit.majumdar@domain.hid>
Cc: xenomai@xenomai.org, Steve Deiters <SteveDeiters@domain.hid>

Abhijit,

On Wed, 2010-06-16 at 11:34 -0700, Abhijit Majumdar wrote:
> Hi Philippe
> 
> I have attached a standalone test program which crashes my system. It
> uses poxis skin to create a simple task which sleeps for 10 micro sec
> and wakes up and continues to do so until the user kills the process.
> 
> Interesting things note -- 
> 
> 	1. If I uncomment the printf statement at the beginning of the
> while loop the program does not crash any more.
> 	2. OR if I use rt_task_sleep instead of clock_nanosleep it does
> not crash.

What happens if you use rt_printf() rather than printf() inside the
real-time loop. Some of the examples that I have sent you show the
correct usage for this function.

> 
> I am using xenomai 2.5.2 and the arm platform has kernel 2.6.28. I've
> cc-ed this email to a tech expert (Travis) of the vendor (EMAC) of the
> arm system. 
> 
> At the time of crashing I see the following error message on the screen
> ----
> 
> WARNING: at
> /home/travis/projects/customers/pivotal_systems/workspace/linux-2.6.
> 28-xenomai-pivotal/kernel/sched.c:4382 add_preempt_count+0x84/0x98()
> Modules linked in: at91_udc
> [<c002e374>] (dump_stack+0x0/0x14) from [<c004510c>]
> (warn_on_slowpath+0x4c/0x68
> )
> [<c00450c0>] (warn_on_slowpath+0x0/0x68) from [<c003dd44>]
> (add_preempt_count+0x
> 84/0x98)
>  r6:c38dc02c r5:00000000 r4:00000001
> [<c003dcc0>] (add_preempt_count+0x0/0x98) from [<c0045d24>]
> (vprintk+0x2c/0x3d4)
> [<c0045cf8>] (vprintk+0x0/0x3d4) from [<c00466c8>] (printk+0xe0/0x194)
> [<c00465e8>] (printk+0x0/0x194) from [<c00768f0>]
> (__xnpod_schedule+0x38c/0x550)
>  r3:00000003 r2:c039e3a0 r1:c3854000 r0:c032f630
>  r8:c480d408 r7:c3b98ca0 r6:c3b98ca0 r5:00000000 r4:c03a0d10
> [<c0076564>] (__xnpod_schedule+0x0/0x550) from [<c007698c>]
> (__xnpod_schedule+0x
> 428/0x550)
> [<c0076564>] (__xnpod_schedule+0x0/0x550) from [<c007698c>]
> (__xnpod_schedule+0x
> 428/0x550)
> [<c0076564>] (__xnpod_schedule+0x0/0x550) from [<c007698c>]
> (__xnpod_schedule+0x
> 428/0x550)
> [<c0076564>] (__xnpod_schedule+0x0/0x550) <1>Unable to handle kernel
> paging requ
> est at virtual address 00001008
> 
> 
> 
> Thanks for your help
> 
> Abhijit
> 
> 
> 
> 
> 
> 
> -----Original Message-----
> From: Philippe Gerum [mailto:rpm@xenomai.org] 
> Sent: Friday, May 28, 2010 1:05 AM
> To: Abhijit Majumdar
> Cc: Steve Deiters; xenomai@xenomai.org
> Subject: RE: [Xenomai-help] rt_task_sleep causing crashes on PowerPC
> 
> On Wed, 2010-05-26 at 14:03 -0700, Abhijit Majumdar wrote:
> > Hi
> > 
> > I get similar problem the xenomai posix skin. I have the latest
> version
> > of Xenomai (2.5.3) and kernel 2.6.28. 
> > 
> > I am using clock_nanosleep(CLOCK_REALTIME, ......) to wait for 1
> > millisecond. It freezes the system. However if I sleep for a second it
> > is fine.
> > 
> > Philippe, should your fix work in my case too? 
> 
> I have no idea which platform you are running your code on, so my answer
> won't be specific, but in short: it is unlikely. This could rather be an
> application error. You may want to try the failing code in a small
> standalone unit test, and post that code to the list if it still fails
> in that context, so we could have a look.
> 
> > If so, can you please
> > send the fix.
> > 
> > thanks
> > Abhijit
> > 
> > -----Original Message-----
> > From: xenomai-help-bounces@domain.hid
> [mailto:xenomai-help-bounces@domain.hid]
> > On Behalf Of Philippe Gerum
> > Sent: Sunday, May 16, 2010 2:58 PM
> > To: Steve Deiters
> > Cc: xenomai@xenomai.org
> > Subject: Re: [Xenomai-help] rt_task_sleep causing crashes on PowerPC
> > 
> > On Fri, 2010-05-14 at 19:18 -0500, Steve Deiters wrote:
> > > I am running Xenomai 2.5.3, I-pipe version 2.9-00, with Linux
> 2.6.33.4
> > > on a PowerPC MPC5121.  With small values of sleep ticks passed to
> > > rt_task_sleep, I get various sorts of crashes.  Here is a simple
> > program
> > > using a delay loop that exhibits the behavior.
> > 
> > <snip>
> > 
> > > 
> > > I'm not sure if I have something misconfigured or what.  I am
> > upgrading
> > > from Xenomai 2.4.10 on an older kernel and I did not have this same
> > > problem.
> > > 
> > 
> > Bug confirmed here. Your setup is not involved, I'll send a fix asap.
> > 
> > > Thanks.
> > > 
> > > 
> > > _______________________________________________
> > > Xenomai-help mailing list
> > > Xenomai-help@domain.hid
> > > https://mail.gna.org/listinfo/xenomai-help
> > 
> > 
> 
> 


