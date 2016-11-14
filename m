From: Lowell Gilbert <kludge@be-well.ilk.org>
References: <44eg2nuhee.fsf@be-well.ilk.org> <44a8dbueie.fsf@be-well.ilk.org>
 <d9406df2-c733-579b-8494-036c7e138e7b@xenomai.org>
Date: Mon, 14 Nov 2016 16:56:30 -0500
In-Reply-To: <d9406df2-c733-579b-8494-036c7e138e7b@xenomai.org> (Philippe
 Gerum's message of "Mon, 14 Nov 2016 10:09:41 +0100")
Message-ID: <44inrphgj5.fsf@lowell-desk.lan>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Xenomai] irqchip missing?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Philippe Gerum <rpm@xenomai.org> writes:

> On 11/07/2016 11:11 PM, Lowell Gilbert wrote:
>> Lowell Gilbert <kludge@be-well.ilk.org> writes:
>> 
>>> I have a system based on a Cortex A9. When I was running under Xenomai
>>> 2.6, I was able to grab interrupts in RTDM. A few months ago, I updated
>>> from a 3.16 Linux kernel and 2.6.4 Xenomai to a 4.1 kernel with 3.0.2
>>> Xenomai. I'm trying to grab the same IRQ now, and the irqchip doesn't
>>> seem to have a set_affinity callback, so I get a kernel dump.
>> 
>> ipipe_set_irq_affinity() is being called with a GPIO chip, instead of
>> the GIC that I expect. Why would that be?
>> 
>
> ipipe_set_irq_affinity() receives an interrupt number, not an IC
> descriptor. Are you referring to the irq_set_affinity() handler from the
> irq_chip descriptor instead? Please be specific about the code you refer
> to (call site).

In ipipe_set_irq_affinity(), I checked irq_get_chip(irq)->name. That
gave me "gpio-dwapb" rather than "GIC".  There is no irq_set_affinity
driver on that chip, and so it crashes.

I haven't figured out how the chip table gets set up.

Be well.

