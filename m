Message-ID: <43CF8ECF.4020805@domain.hid>
Date: Thu, 19 Jan 2006 14:06:23 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Missing IRQ end function on PowerPC
References: <43CE1C28.6060001@domain.hid>
	<17359.34362.870823.168739@domain.hid>
In-Reply-To: <17359.34362.870823.168739@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Wolfgang Grandegger wrote:
>  > Hello,
>  > 
>  > with RTnet over Xenomai and Linux 2.4 on PowerPC I realized that Xenomai 
>  > does not distinguish between a normal IRQ enable and an IRQ unmask at 
>  > the end of an ISR (to reenable the IRQ). In the latter case the IRQ 
>  > should be enabled on PowerPC as shown:
>  > 
>  >     if (rthal_irq_descp(irq)->handler->end != NULL)
>  >   	   rthal_irq_descp(irq)->handler->end(irq);
>  >      else
>  > 	   rthal_irq_descp(irq)->handler->enable(irq);
>  > 
>  > To handle this case properly, we need to different functions, I think.
> 
> I am not sure I understand what you mean. Would you want functions
> rthal_end_irq and xnarch_end_irq added and that this xnarch_end_irq
> would be called in xnintr_irq_handler when XN_ISR_ENABLE is set ?

Yes, that's what I have basically done to get the RTnet SCC enet driver 
working on my MPC8xx module. In arch/ppc/kernel/irq.c you can see how 
Linux re-enables interrupts at the end of it's ISR (see
http://cvs.gna.org/cvsweb/linux/v2.4/2.4.25-ppc/arch/ppc/kernel/irq.c?rev=1.1;cvsroot=adeos):

   507: 	 * The ->end() handler has to deal with interrupts which got
   508: 	 * disabled while the handler was running.
   509: 	 */
   510: 	if (desc->handler) {
   511: 		if (desc->handler->end)
   512: 			desc->handler->end(irq);
   513: 		else if (desc->handler->enable)
   514: 			desc->handler->enable(irq);

In PPC Linux 2.6 things are a bit different. The "end" functions seems 
to be mandatory now (I have to check more carefully).

Therefore we need a dedicated function to re-enable interrupts in the 
ISR. We could name it *_end_irq, but maybe *_enable_isr_irq is more 
obvious. On non-PPC archs it would translate to *_irq_enable. I 
realized, that *_irq_enable is used in various place/skins and therefore 
I have not yet provided a patch.

Wolfgang.



