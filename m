Message-ID: <51AC8209.4060507@xenomai.org>
Date: Mon, 03 Jun 2013 13:46:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4cacd80b.2131b.13ef60cf09e.Coremail.ericvic@163.com>
	<51A79898.50805@xenomai.org>
	<34806652.2924.13ef838eb26.Coremail.ericvic@163.com>
	<4855a071.2a22.13ef83b0d46.Coremail.ericvic@163.com>
	<51A835DE.5020409@xenomai.org>
	<700980f4.7d37.13ef927183f.Coremail.ericvic@163.com>
	<27b32d48.5247.13efee65625.Coremail.ericvic@163.com>
	<51A9C9EF.2040702@xenomai.org>
	<37d33293.2abd.13f07ada45c.Coremail.ericvic@163.com>
	<51AC31A2.5010907@xenomai.org>
	<7b78f3e.c5e4.13f092364eb.Coremail.ericvic@163.com>
In-Reply-To: <7b78f3e.c5e4.13f092364eb.Coremail.ericvic@163.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] freescale(imx53)  with xenomai patch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?5bWM5YWl5byP5bel56iL5biI?= <ericvic@163.com>
Cc: xenomai@xenomai.org

On 06/03/2013 10:24 AM, 嵌入式工程师 wrote:

> I have set the trigger type with Low trigger  and without disable and enable codes.
> if the interrupt is triggered the hardware will set the gpio with High 。
> It has the same problem.
> I do not why ?


Ok, could you tell me:
- what type you set for your interrupt (with irq_set_irq_type)?
- what is the shape of the signal?

Sorry for stating the obvious, but if the gpio is toggled every
500milliseconds and you set the irq type to level (low or high), the
interrupts is considered to be asserted by the interrupt controller
during 500 milliseconds, and so your interrupt handler is called
continuously during 500 milliseconds. In that case, what you would be
interested in would be to call:
 irq_set_irq_type(irq, IRQ_TYPE_EDGE_BOTH)
for instance.

Regards.

-- 
                                                                Gilles.

