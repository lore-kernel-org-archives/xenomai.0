Subject: Re: [Adeos-main] End of interrupt scheduling
From: Philippe Gerum <rpm@xenomai.org>
Reply-To: rpm@xenomai.org
In-Reply-To: <1102682214.13152.116.camel@domain.hid>
References: <008b01c4b5dd$04d20890$7405a8c0@domain.hid>
	 <1098196627.666.9.camel@domain.hid> <1098196994.666.11.camel@domain.hid>
	 <41B974E9.7080801@domain.hid>
	 <1102682214.13152.116.camel@domain.hid>
Content-Type: text/plain
Message-Id: <1102808406.696.97.camel@domain.hid>
Mime-Version: 1.0
Date: Sun, 12 Dec 2004 00:40:06 +0100
Content-Transfer-Encoding: 7bit
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
To: Michael Neuhauser <mike@domain.hid>
Cc: adeos-main@gna.org

On Fri, 2004-12-10 at 13:36, Michael Neuhauser wrote:
> On Fri, 2004-12-10 at 11:05, Andre Tousch wrote:
> > Hi,
> > 
> > I'm currently using an RTOS with Linux/Adeos on ARM.
> 
> What CPU & Kernel are you using? FYI: I'm currently working with an
> ARM920T CPU on Linux 2.4.21-rmk1-crus1.4.2 and found some issues - if
> this is relevant for you: I will post about it here soon.

If you want those fixes to become part of the standard Adeos patch for
ARM, please send them. This is the only way for such support to improve.

> 
> > [...]
> >
> > If I want to imitate the original RTOS behaviour, I have to schedule 
> > (RTOS scheduler) at end of interrupt.
> > I cannot do that in this domain's interrupt handler, since it would 
> > Schedule() with domain stalled, and thus the domain would not receive 
> > the interrupts until it gives control back to Adeos by suspending itself.
> >
> >[...]
> >
> > My question is, was there already a way to obtain this behaviour in Adeos?
> 
> Maybe I'm overlooking something, but why don't you unstall the pipeline
> in your interrupt handler? You don't have to wait for
> __adeos_sync_stage() to unstall it. Outline of interrupt handler:
> 
> 	do_irq_work();
> 	adeos_unstall_pipeline();
> 	rtos_schedule();
> 
> Of course you need to have registered a high priority domain in which
> the irq handler runs (irqs are hard disabled when entering a root domain
> irq-handler).
> 
> Mike
-- 

Philippe.


