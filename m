Message-ID: <4656C2D0.7000705@domain.hid>
Date: Fri, 25 May 2007 13:04:48 +0200
From: Johan Borkhuis <j.borkhuis@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Problem with interrupt enabling
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

Hello,

I am trying to create an RTDM interrupt handler for an external 
interrupt. I use a rtdm_irq_request, followed by a rtdm_irq_enable. This 
caused one interrupt to be processed, but subsequent interrupts were not 
processed.
After adding an extra rtdm_irq_enable to the ISR the interrupts are 
processed. When I look at the other drivers I don't see this. Is this 
needed, or is there a bug/feature in the interrupt handling on my platform?
(I use a MVME3100 with a ppc8540 processor and openPIC interrupt 
controller).

Kind regards,
    Johan Borkhuis

