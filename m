Subject: Re: [Adeos-main] Adding void * to interrupt isr
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200403181437.13187.roloff@domain.hid>
References: <200403181437.13187.roloff@domain.hid>
Content-Type: text/plain
Message-Id: <1079697841.1345.61.camel@domain.hid>
Mime-Version: 1.0
Date: Fri, 19 Mar 2004 13:04:01 +0100
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
To: Dirk Roloff <roloff@domain.hid>
Cc: adeos-main@gna.org

Hi Dirk,

On Thu, 2004-03-18 at 14:37, Dirk Roloff wrote:
> Hi All,
> 
> after implementing my device driver in a adeos domain, i am missing a pointer to my device struct in the isr.
> Under Linux the prototype of request_irq is:
> 
> int request_irq(unsigned int irq, void (*gest)(int, void *, struct pt_regs *), unsigned long drap_interrupt, const char *devname, void *dev_id); 
> 
> as you see / know the last parameter is a void * dev_id. This dev_id is not handled by the kernel and just past as 
> second parm to the isr.
> This makes it easy to handle more the one device withe the same driver, or pass some infos to the isr.
> 
> ToDo:
> 
> * adding a void * to adomain_t.irq
>  
> * change adeos_virtualize_irq() and  adeos_alloc_irq() save the dev_id in  
> adomain_t.
> 
> * change the call to irq handler passing dev_id;
> 
> * Change all calls to adeos_virtualize_irq to pass a NULL dev_id  while init pipeline for linux.
> 
> * Change dokumentation
> 

The x86 port uses some hand-crafted assembly portions to call the IRQ
handler in arch/i386/kernel/adeos.c (__adeos_call_c_(root)_irq_handler).
You will need to push the additional arg here too.

> 
> What do you think about this ? I would do and test this an supply a patch. Who would add this to the current cvs.
> 

The current way of handling this situation is to have the domains manage
their own irq -> dev_id map internally, but I guess that sticking a bit
more to the usual kernel interface would be better. However this change
should be made asap, i.e. before the API is somewhat frozen by customary
use/habits. So the answer to your question is yes. Since there are four
different archs currently supported by Adeos to deal with, we will need
to push such changes to them too. Please send a patch for x86, and we'll
see at that point how we integrate it smoothly into all ports.

> To make the prototypes equal we maybe add also struct pt_regs * but i do not know which regs should be
> the isr.
> 

pt_regs are not relevant over Adeos since IRQ handlers are not always
called on behalf of the incoming interrupt frame, but could be delayed
in the pipeline. The only exception is for the timer interrupt where the
regs are kept so that the process accounting is properly done when the
pipelining is active, but logging all pt_regs to have them delivered
later to any regular handler seems clearly overkill without buying us
much.

> Regards 
> Dirk
> 
> 
> 
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main
-- 

Philippe.


