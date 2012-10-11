Date: Thu, 11 Oct 2012 17:09:58 +0200
From: "Petr Cervenka" <grugh@centrum.cz>
MIME-Version: 1.0
Message-Id: <20121011170958.40C8E372@centrum.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Shared interrupts
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello everyone.

I have a problem when several devices share the same IRQ.
If there is one rt and one non-rt device, I have to return RTDM_IRQ_NONE =
| XN_ISR_PROPAGATE in my rtdm driver for rt device (when it was not handl=
ed by my driver).  I know that I loose deterministic rt response latency =
in such case.
When I return only RTDM_IRQ_NONE, the IRQ is disabled by Xenomai (with a =
message), probably because of infinite loop.

But when I share IRQ between 2 rt devices and return RTDM_IRQ_NONE | XN_I=
SR_PROPAGATE when it is not handled by my device, the IRQ gets disabled (=
perhaps by Linux, but thate is no message).

Concrete example:
1) interrupt occurs
first rt device handles interrupt and return RTDM_IRQ_HANDLED
second rt device doesn't  handle the interrupt and return RTDM_IRQ_NONE |=
 XN_ISR_PROPAGATE
no second interrupt occurs

I'm using xenomai 2.5.6, adeos 2.6.38.8-x86-2.10-01

My primary questions:
Is there a possibility to have the rtdm driver compatible with both cases=
?

Do I loose deterministic rt latency when there is no non-rt device?
I think that all my interrupts should be handled by rt devices in such ca=
se, so no propagating to linux should happen. Am I wrong?

Petr

