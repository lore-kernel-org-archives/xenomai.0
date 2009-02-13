Message-ID: <49960610.2090207@domain.hid>
Date: Sat, 14 Feb 2009 00:45:20 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <20090213114426.b684eb1399accf59cf50bd4742b49228.7ef98e2e0b.wbe@domain.hid>
In-Reply-To: <20090213114426.b684eb1399accf59cf50bd4742b49228.7ef98e2e0b.wbe@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Use of Linux wake_up() system call in Xenomai
 RTDM thread in kernel mode
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: tarr@domain.hid
Cc: xenomai@xenomai.org

tarr@domain.hid wrote:
> Folks --
> 
> I would like to use a Linux wake_up() system call in a RTDM periodic task
> to signal a Linux driver xxx_poll() function that uses the poll_wait().
> 
> Is this appropriate?
> 

Nope.

> If so, should I disable interrupts in the xxx_poll() function around the
> poll_wait()
> using the rtdm_lock_irqsave()?
> 
> If not, any suggestions on how to get the same functionality?
>

You have to go through a proxy to do that; calling a regular kernel service from
an RTDM task context in kernel space which only runs in primary mode would sink
the boat. Remember that Xenomai may have preempted the Linux machinery in the
middle of nowhere to process an event, which turned out to reschedule your RTDM
task immediately, regardless of what Linux was doing at that time.

RTDM has a dedicated interface to create such proxies, namely rtdm_nrtsig_*
http://www.xenomai.org/documentation/branches/v2.4.x/html/api/group__nrtsignal.html

In short, the code should register a non-RT handler (rtdm_nrtsig_init) which the
RT side can schedule for execution (rtdm_nrtsig_pend), as soon as Xenomai
quiesces and Linux gets back in control in a safe context. The handler in
question runs in a virtual interrupt context, so wake_up() may be called from
there, like anything you may call from a regular Linux IRQ handler.

> My thanks for any assistance.
> 
> Cheers --
> Steve Tarr
> tarr@domain.hid
> 
>  
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.

