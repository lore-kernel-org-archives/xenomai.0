Message-ID: <43DFC50B.1090707@domain.hid>
Date: Tue, 31 Jan 2006 21:14:03 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] Shared irqs v.6
References: <b647ffbd0601311053s2f9f77c3m@domain.hid>	<43DFB5F9.50406@domain.hid>
	<b647ffbd0601311150t6092a758w@domain.hid>
In-Reply-To: <b647ffbd0601311150t6092a758w@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

Dmitry Adamushko wrote:
> On 31/01/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>> Dmitry Adamushko wrote:
>>> Hi,
>>>
>>> the previous version contained an ugly bug, namely the misuse of the
>>> test_and_set/clear_bit interface
>>> that led to a broken system from time to time.
>>>
>> What about the ISA/edge-triggered stuff? :D
>>
>> My problem is that we cannot test here on real hardware because all our
>> shared IRQs reside on PC104 cards.
> 
> 
> Could you provide me with some real piece of such code as an example?

May I remind you of the link to the linux kernel's 8250 driver I gave?
Or what do you mean with real code? xeno_16550A would become such a user
ideally only by adding one or two IRQ-registration flags.

> 
> Anyway, design-wise, it's about introducing a separate xnintr_handler() for
> such a special case to avoid getting a mixture with the rest of "sane" code.

Yep, I would vote for this approach as well.

> I mean that the support of shared interrupts for ISA boards (edge-triggered
> stuff) is a kind of emulation to overcome the shortcommings of the initial
> design on the hardware level. The hardware was just not supposed to support
> shared interrupt channels. So, let's keep it a bit aside from another code
> :o)

Unfortunately, this crappy hardware is still quite common in the
embedded domain.

> 
> xnintr_attach() will check for a special flag like XN_ISR_ISASHARED and
> attach e.g. xnintr_isairq_handler() instead of xnintr_irq_handler().
> 
> I'll post an extension to the rt_intr_create(..., const char *name, ...)
> tomorrow - made but not tested yet -
> 
> as well as the /proc support.
> 

This should be easy... Great!

Jan

