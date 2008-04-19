Message-ID: <480A3751.2020609@domain.hid>
Date: Sat, 19 Apr 2008 14:17:53 -0400
From: Tomas Kalibera <kalibera@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Interrupt handling questions
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org


Hi,

I've read the Adeos whitepaper ("Live with Adeos"), API docs, and looked 
at the sources, but I still have some interrupt handling questions.

First, the optimistic interrupt protection. Live with Adeos says that 
Adeos uses optimistic interrupt protection. In optimistic interrupt 
protection, the handled interrupt is not masked at entry to interrupt 
handler, but only on the second entry, if it really recurs. The 
recurring interrupt is handled after the first one is handled. The 
"optimism" is in hoping that the interrupt in fact would not recur and 
is motivated by saving time on masking/unmasking on the fast path.

However, the Xenomai API says (in kernel space rt_intr_create) that the 
handler is already called with the interrupt masked at hardware level. 
Unless the handler returns with RT_INTR_NOENABLE, the interrupt would be 
umasked at hardware level when the handler returns. Where is then the 
optimistic interrupt protection used ? And, does this really happen for 
all I/O interrupts (in particular, not only level triggered, but also 
edge triggered) ? And, are the interrupts also acknowledged by Xenomai ?

Live with Adeos says that a domain is stalled before entering an 
interrupt handler in the domain, which means that further interrupts are 
not delivered to the domain. The domain is automatically unstalled when 
the handler finishes. Does the stalling prevent all interrupts from 
being delivered to the domain ? Or does it only prevent the interrupt(s) 
that are being served by handlers presently running in the domain ?

Life with Adeos says that disabling an interrupt (rthal_irq_disable) 
disables the interrupt at hardware level and also locks out delivery of 
the interrupt to the current domain, preventing logged interrupts to be 
re-played. Similarly, it says that enabling an interrupt enables the 
interrupt at hardware level and unlocks its delivery to the current 
domain. Is the "locking delivery to current domain" the same as stalling 
the domain which happens when the handler is started ?

Life with Adeos also suggests that, because a domain is stalled when 
handler is invoked and interrupts are logged, handlers do not need to 
disable the handled interrupt at hardware level explicitly. But, aren't 
the handlers already called with the interrupt disabled at hardware 
level ? So how could the logging take place ?

Which is even more puzzling to me, the text suggests that not only the 
handled interrupt should not be disabled explicitly, but we should 
enable it to allow it being received by Xenomai and logged for the 
domain. The example uses rthal_intr_enable, which however would also 
unstall the domain, right ? So, wouldn't it  lead to logging of the 
interrupts, but to reentrant invocation of the handler ?

Thanks!

Tomas





