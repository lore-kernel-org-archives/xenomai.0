Message-ID: <4C0AA430.4000205@domain.hid>
Date: Sat, 05 Jun 2010 21:23:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4C07BA95.9080402@domain.hid>
	<1275759652.18250.178.camel@domain.hid>
	<4C0A9960.8040609@domain.hid>
In-Reply-To: <4C0A9960.8040609@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [RFC][PATCH 2/2] x86: Add support for
	ipipe_get_irq_regs
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>, Philippe Gerum <rpm@xenomai.org>

Jan Kiszka wrote:
> Philippe Gerum wrote:
>> On Thu, 2010-06-03 at 16:22 +0200, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@domain.hid>
>>>
>>> Implement the x86 arch bits for ipipe_get_irq_regs support. This allows
>>> to drop __ipipe_tick_regs and use the new service instead.
>> I'm unsure whether this patch would actually replace __ipipe_tick_regs
>> properly, particularly regarding how the profiling code works.
> 
> tick_regs are a "workaround", this approach appears to me way closer to
> how native works.

We do not want ipipe_tick_regs to work the way the native kernel works.
We want to fool the kernel by passing it the value of the registers at
the moment of the real timer tick so that its accounting works more or
less reliably. When the kernel used the real registers it got the
accounting wrong.


-- 
					    Gilles.

