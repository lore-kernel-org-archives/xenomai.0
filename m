From: "Jason Huang" <jason.huang@domain.hid>
Subject: RE: [Adeos-main] When to do __adeos_takeover() on ARM
Date: Fri, 25 Feb 2005 18:18:52 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <421D8BDF.5070601@domain.hid>
Message-id: <20050225175748.cc8e079ba0c14aba9ddfca21e6d650b2.in@domain.hid>
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: adeos-main@gna.org

I am trying to port 2.6.8.1 onto ARM9TDMI, TI's Innovator board.

I found the reason that it crashes when compiling into kernel is that: when
compiled in kernel, adp_pipelined is not checked; __adeos_handle_irq calls
handlers when adeos has not yet been completely initialized.

I forced adp_pipelined is checked even when adeos is compiled into kernel. Now
that the crashing is gone, I encountered another problem: still in
__adeos_handle_irq, somewhere down in __adeos_sync_stage, just before invoking
irq handler,
	if (adp == adp_root)
		adeos_hw_sti();
This, adeos_hw_sti, causes a new interrupt comes in; and this repeats
(__irq_svc->__adeos_handle_irq->__adeos_sync_stage->__irq_svc,...).

I got stuck here for two days.

Best regards.

Jason Huang
Wescon Technology
408-727-8818 x108 


> -----Original Message-----
> From: Philippe Gerum [mailto:rpm@xenomai.org]
> Sent: Thursday, February 24, 2005 12:10 AM
> To: Jason Huang
> Cc: adeos-main@gna.org
> Subject: Re: [Adeos-main] When to do __adeos_takeover() on ARM
> 
> Jason Huang wrote:
> > Dear list members,
> >
> > If __adeos_takeover is called in init(), the timer interrupt kicks in way
> before
> > adp->irqs[] have been initialized and hence adeos_switch_domain is not
> called
> > and the interrupt is not handled.
> >
> 
> If the takeover has not taken place, then the standard IRQ vectors
> should be in place after the interrupt layer has been initialized,
> therefore further interrupts should be handled by the regular Linux
> handlers as they would if Adeos was absent. Additionally,
> __adeos_switch_domain() is only called when more than a single domain
> exists, which sounds unlikely during the boot phase.
> 
> > Has anybody seen the problem? How/where do I place __adeos_takeover?
> 
> Which architecture are you working on?
> 
> >
> > Thanks in advance.
> >
> > Jason Huang
> > Wescon Technology
> > 408-727-8818 x108
> >
> >


