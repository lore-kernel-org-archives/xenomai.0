From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <49FA28F7.3060405@domain.hid>
References: <200904301508.29432@domain.hid> <200904301509.13094@domain.hid>
	<200904301510.8382@domain.hid> <200904301511.15875@domain.hid>
	<200904301512.9035@domain.hid> <200904301513.12716@domain.hid>
	<200904301514.6099@domain.hid> <200904301515.16182@domain.hid>
	<200904301516.696@domain.hid>  <49F9B123.7080203@domain.hid>
	<1241103352.26544.177.camel@domain.hid>  <49FA28F7.3060405@domain.hid>
Content-Type: text/plain
Date: Fri, 01 May 2009 11:40:20 +0200
Message-Id: <1241170820.26544.209.camel@domain.hid>
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

On Thu, 2009-04-30 at 15:40 -0700, Thomas Lockhart wrote:
> > Xenomai always tells the kernel that blocking (Xenomai) syscalls
> > _should_ be restarted when interrupted by a Linux signal (i.e.
> > -ERESTARTSYS is passed down to the kernel by the Xenomai core in that
> > case), and the kernel will actually restart that (Xenomai) syscall if no
> > handler was installed for such signal, or if SA_RESTART is set in the
> > sigaction() flags for the signal.
> 
> Thanks for the clarification. I was hoping my reply would expose my lack 
> of understanding :)
> 
> So I'm getting what I think are great results on my system with my 
> Xenomai-enabled software (a few usec jitter, ~10usec latency or offset 
> without anything special done when building or calibrating Xenomai. The 
> system is a fairly modern dual-processor Xeon desktop machine and 
> Xenomai is 2.4.7; kernel is 2.6.26 (needed for a third party device 
> driver which breaks with 2.6.27).
> 

Mmm, actually, I would bet that this latency is caused by an inter-CPU
TLB flush request; this is a bug fixed in recent releases of the I-pipe
patch, both for 2.6.28.9 and 2.6.29.1. There is no backport for 2.6.26,
but you should be able to apply this commit manually:

http://git.denx.de/?p=ipipe-2.6.git;a=commit;h=69f7e0c005eca37a04104dd85f30095791e8c2f7

> When running at a very low rate (10Hz) every 30 seconds or so there is a 
> latency spike of around 50usec. Not bad (and acceptable for my system 
> even at kHz rates), but it certainly stands out from the usual case.
> 
> Could this occasional extra latency be due to this signal interrupt and 
> transparent restart? Or should I dig around elsewhere?
> 
> TIA
> 
>                            - Tom
-- 
Philippe.



