MIME-Version: 1.0
Sender: had2006@gmail.com
Date: Wed, 8 Apr 2015 13:35:55 +0100
Message-ID: <CAKk99t04WrAswcZb-YZJ2ZJzPjnev=Zq0S5cTr_u_E2Aftv-Xg@mail.gmail.com>
From: Helder Daniel <hdaniel@ualg.pt>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] How to propagate Interrupt down the pipeline in cobalt
	(xenoma 3.x)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>, Helder Daniel <hdaniel@ualg.pt>

Hi,

I am trying to propagate an interrupt from the real time kernel to the
linux domain.

I have 2 drivers (two LKMs), one a RTDM for Cobalt and the other for Linux.
Each one installs an ISR for IRQ 8 (RTC) that just rtdm_printks and printks
a message to kernel log.

RTC is programmed to generate interrupts each second.

While both LKMs are inserted, since since the RT domain is the first in the
pipeline, the RT ISR handles the interrupt, which never arrives the Linux
NON-RT ISR.

Only when the module with the RT ISR is removed, interrupt arrive to the
Linux NON RT ISR.
Which is fine.

But I am trying to propagate interrupts down the pipeline.
With Xenomai 2.6.x we can create an interrupt object with the native API
and specify that the interrupt is to be propagated:

err = rt_intr_create(&intr, "RTCInt", RTCIRQ, I_PROPAGATE);

But since with Xenomai 3.x the native API is not available in Kernel, and
interrupts can not be handled in user spce, I can not figure out a way to
decide if an interrupt is to be propagated to Linux or not.

I tried to install both IRQs as shared handlers:

RT domain:
ret = rtdm_irq_request(&intr, IRQ, irq_handler, RTDM_IRQTYPE_SHARED, name,
NULL);

Linux domain:
ret = request_irq(RTCIRQ, rtc_interrupt, 0, name, NULL));

and return from the RT ISR:

RTDM_IRQ_NONE.

but it did not worked.

It is still possible to control propagation of interrupts in xenomai 3.x?







-- 
Helder Daniel
UALG - FCT
DEEI

http://w3.ualg.pt/~hdaniel
