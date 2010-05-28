From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <2319761F7FA0D1479BA77EC2E0A8E7BCE8A603@domain.hid>
References: <181804936ABC2349BE503168465576460EBD5C0D@exchserver.basler.com>
	<1274047063.2972.1.camel@domain.hid>
	<2319761F7FA0D1479BA77EC2E0A8E7BCE8A603@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 28 May 2010 10:05:15 +0200
Message-ID: <1275033915.27918.31.camel@domain.hid>
Mime-Version: 1.0
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

On Wed, 2010-05-26 at 14:03 -0700, Abhijit Majumdar wrote:
> Hi
> 
> I get similar problem the xenomai posix skin. I have the latest version
> of Xenomai (2.5.3) and kernel 2.6.28. 
> 
> I am using clock_nanosleep(CLOCK_REALTIME, ......) to wait for 1
> millisecond. It freezes the system. However if I sleep for a second it
> is fine.
> 
> Philippe, should your fix work in my case too? 

I have no idea which platform you are running your code on, so my answer
won't be specific, but in short: it is unlikely. This could rather be an
application error. You may want to try the failing code in a small
standalone unit test, and post that code to the list if it still fails
in that context, so we could have a look.

> If so, can you please
> send the fix.
> 
> thanks
> Abhijit
> 
> -----Original Message-----
> From: xenomai-help-bounces@domain.hid [mailto:xenomai-help-bounces@domain.hid]
> On Behalf Of Philippe Gerum
> Sent: Sunday, May 16, 2010 2:58 PM
> To: Steve Deiters
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] rt_task_sleep causing crashes on PowerPC
> 
> On Fri, 2010-05-14 at 19:18 -0500, Steve Deiters wrote:
> > I am running Xenomai 2.5.3, I-pipe version 2.9-00, with Linux 2.6.33.4
> > on a PowerPC MPC5121.  With small values of sleep ticks passed to
> > rt_task_sleep, I get various sorts of crashes.  Here is a simple
> program
> > using a delay loop that exhibits the behavior.
> 
> <snip>
> 
> > 
> > I'm not sure if I have something misconfigured or what.  I am
> upgrading
> > from Xenomai 2.4.10 on an older kernel and I did not have this same
> > problem.
> > 
> 
> Bug confirmed here. Your setup is not involved, I'll send a fix asap.
> 
> > Thanks.
> > 
> > 
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
> 
> 


-- 
Philippe.



