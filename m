Subject: Re: [Adeos-main] End of interrupt scheduling
From: Michael Neuhauser <mike@domain.hid>
In-Reply-To: <41B974E9.7080801@domain.hid>
References: <008b01c4b5dd$04d20890$7405a8c0@domain.hid>
	 <1098196627.666.9.camel@domain.hid> <1098196994.666.11.camel@domain.hid>
	 <41B974E9.7080801@domain.hid>
Content-Type: text/plain
Message-Id: <1102682214.13152.116.camel@domain.hid>
Mime-Version: 1.0
Date: Fri, 10 Dec 2004 13:36:54 +0100
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
To: adeos-main@gna.org

On Fri, 2004-12-10 at 11:05, Andre Tousch wrote:
> Hi,
> 
> I'm currently using an RTOS with Linux/Adeos on ARM.

What CPU & Kernel are you using? FYI: I'm currently working with an
ARM920T CPU on Linux 2.4.21-rmk1-crus1.4.2 and found some issues - if
this is relevant for you: I will post about it here soon.

> [...]
>
> If I want to imitate the original RTOS behaviour, I have to schedule 
> (RTOS scheduler) at end of interrupt.
> I cannot do that in this domain's interrupt handler, since it would 
> Schedule() with domain stalled, and thus the domain would not receive 
> the interrupts until it gives control back to Adeos by suspending itself.
>
>[...]
>
> My question is, was there already a way to obtain this behaviour in Adeos?

Maybe I'm overlooking something, but why don't you unstall the pipeline
in your interrupt handler? You don't have to wait for
__adeos_sync_stage() to unstall it. Outline of interrupt handler:

	do_irq_work();
	adeos_unstall_pipeline();
	rtos_schedule();

Of course you need to have registered a high priority domain in which
the irq handler runs (irqs are hard disabled when entering a root domain
irq-handler).

Mike
-- 
Dr. Michael Neuhauser                phone: +43 1 789 08 49 - 30
Firmix Software GmbH                   fax: +43 1 789 08 49 - 55
Vienna/Austria/Europe                      email: mike@domain.hid
Embedded Linux Development and Services    http://www.firmix.at/


