Message-ID: <552915AE.4000809@xenomai.org>
Date: Sat, 11 Apr 2015 14:38:06 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKk99t04WrAswcZb-YZJ2ZJzPjnev=Zq0S5cTr_u_E2Aftv-Xg@mail.gmail.com>
In-Reply-To: <CAKk99t04WrAswcZb-YZJ2ZJzPjnev=Zq0S5cTr_u_E2Aftv-Xg@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] How to propagate Interrupt down the pipeline in
 cobalt (xenoma 3.x)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Helder Daniel <hdaniel@ualg.pt>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/08/2015 02:35 PM, Helder Daniel wrote:
> But since with Xenomai 3.x the native API is not available in Kernel, and
> interrupts can not be handled in user spce,

More precisely, Xenomai 3 enforces handling of interrupt top-halves from
kernel space, which still allows to process bottom-halves from
user-space. The UDD driver (kernel/drivers/udd) provides for the
boilerplate support needed, just like UIO does for the regular kernel.

 I can not figure out a way to
> decide if an interrupt is to be propagated to Linux or not.
> 
> I tried to install both IRQs as shared handlers:
> 
> RT domain:
> ret = rtdm_irq_request(&intr, IRQ, irq_handler, RTDM_IRQTYPE_SHARED, name,
> NULL);
> 
> Linux domain:
> ret = request_irq(RTCIRQ, rtc_interrupt, 0, name, NULL));
> 
> and return from the RT ISR:
> 
> RTDM_IRQ_NONE.

- RTDM_IRQ_NONE
+ XN_ISR_PROPAGATE

Sharing IRQs between the rt domain and linux leads to a basic priority
inversion problem with level type interrupts, since one would have to
keep the IRQ line masked until the linux handler eventually had a chance
to process the same event. This would obviously delay the next interrupt
from the same device for the rt domain.

For this reason, their is no API for implementing such sharing
explicitly anymore, since it is discouraged. However, the mechanism is
still in place for the (rare) desperate cases when there would be no
other option, and the application could cope with the incurred delay.
This hack is enabled when a RTDM interrupt handler returns
XN_ISR_PROPAGATE, in which case the interrupt line is not unmasked upon
return from the handler, and the event is posted to the linux domain.

-- 
Philippe.

