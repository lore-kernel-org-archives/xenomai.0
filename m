From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <49FB6B30.80806@domain.hid>
References: <200904301508.29432@domain.hid> <200904301509.13094@domain.hid>
	<200904301510.8382@domain.hid> <200904301511.15875@domain.hid>
	<200904301512.9035@domain.hid> <200904301513.12716@domain.hid>
	<200904301514.6099@domain.hid> <200904301515.16182@domain.hid>
	<200904301516.696@domain.hid>  <49F9B123.7080203@domain.hid>
	<1241103352.26544.177.camel@domain.hid>  <49FA28F7.3060405@domain.hid>
	<1241170820.26544.209.camel@domain.hid>  <49FB6B30.80806@domain.hid>
Content-Type: text/plain
Date: Sat, 02 May 2009 00:07:10 +0200
Message-Id: <1241215630.26544.213.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rtdm_event_timedwait returns -EINTR
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Thomas Lockhart <Thomas.Lockhart@domain.hid>
Cc: Petr Cervenka <grugh@domain.hid>, xenomai-help <xenomai@xenomai.org>, "Lockhart, Thomas G" <thomas.g.lockhart@domain.hid>

On Fri, 2009-05-01 at 14:35 -0700, Thomas Lockhart wrote:
> >  Mmm, actually, I would bet that this latency is caused by an
> >  inter-CPU TLB flush request; this is a bug fixed in recent releases
> >  of the I-pipe patch, both for 2.6.28.9 and 2.6.29.1. There is no
> >  backport for 2.6.26, but you should be able to apply this commit
> >  manually:
> > 
> http://git.denx.de/?p=ipipe-2.6.git;a=commit;h=69f7e0c005eca37a04104dd85f30095791e8c2f7
> 
> That was easy to patch manually and seems to have helped a lot. I'm 
> still seeing an occasional "spike" of about 35usec or so every few 
> minutes but the majority of the spikes (hmm, the latency is still pretty 
> good so I hate to call them spikes; maybe "bumps"?) have gone away. 
> Thanks for the suggestion!
> 
> Would it be helpful if I integrated this patch into the 2.6.26 support?
> 

Yep.

>                                       - Tom
-- 
Philippe.



