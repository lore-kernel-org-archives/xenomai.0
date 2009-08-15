From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <alpine.DEB.2.00.0908142138480.7626@domain.hid>
References: <Pine.LNX.4.62.0908141030170.14595@domain.hid>
	<4A853707.10509@domain.hid>
	<Pine.LNX.4.62.0908141206480.14595@domain.hid>
	<1250244831.3019.17.camel@domain.hid>
	<Pine.LNX.4.62.0908141226340.14595@domain.hid>
	<1250262328.2933.0.camel@domain.hid>
	<alpine.DEB.2.00.0908142138480.7626@domain.hid>
Content-Type: text/plain
Date: Sat, 15 Aug 2009 16:01:54 +0200
Message-Id: <1250344914.2933.82.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] T_WARNSW ignored?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenoka09@domain.hid
Cc: xenomai@xenomai.org

On Fri, 2009-08-14 at 21:52 +0200, Waschk,Kolja wrote:
> >>> 0  277    10210      20412      0     00320186    2.5  Head_UDP_Thread
> > UDP, like... socket() interface?
> 
> No. There's a custom RTDM driver with a DMA completion ISR and an IOCTL_RT that
> can be used by the application to fetch a pointer to received data.  The thread
> has "UDP" in its name because the data comes in UDP-like packets over a
> Blackfin SPORT interface, and on other platforms (PC) the code indeed uses
> Ethernet and real sockets for reception.
> 

Ok.

> Hmm, the solution to my question may be very simple. In the past I had to
> enclose the ioctl call to the driver with explicit mode switches, because
> otherwise the application would always crash (remember my previous problem with
> the xnshadow_relax() symptom). They're still there. I somehow expected the
> SIGXCPU to occur even before the first ioctl is made. But if that doesn't
> happen, and an explicit call to rt_task_set_mode doesn't cause SIGXCPU,

Indeed, it does not, since clearing the T_PRIMARY bit this way is an
action which is supposed to be done willingly by the application code,
so there is normally no point in notifying it about the mode switch it
just asked for.

>  that
> may be the (silly) cause... Unfortunately I can't check right now. Will report
> if that's it...
> 
> Kolja
> 
> 
-- 
Philippe.



