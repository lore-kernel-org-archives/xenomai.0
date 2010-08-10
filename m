Message-ID: <4C611708.30702@domain.hid>
Date: Tue, 10 Aug 2010 02:08:24 -0700
From: Bob Feretich <bob.feretich@domain.hid>
MIME-Version: 1.0
References: <4C5A26C4.3050702@domain.hid>	<4C5A631B.1040604@domain.hid>	<4C5CC360.7070707@domain.hid>
	<AANLkTikC5DvkOQDfGFWL7b8KXFYd+1OkZrQ0Gc+GzzZr@domain.hid>
	<4C60A3B8.2000603@domain.hid>
	<8A042E82-C083-4876-AFF5-6D51A291C486@domain.hid>
In-Reply-To: <8A042E82-C083-4876-AFF5-6D51A291C486@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] RTDM driver structure - an update
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Guenter Ebermann <guenter.ebermann@domain.hid>
Cc: xenomai@xenomai.org

  Gunther,
Thank you for the information.
No, the my hardware interrupt line is not being shared by other devices. 
So I really don't want it to be considered "shared". However, my concern 
was on how driver IRQ request calls are handled.

If a driver invokes request_irq() without the SHARED flag, I would 
expect Linux to reject subsequent request_irq() calls for the same IRQ 
made by other drivers. Similarly, if the first driver invokes 
request_irq() with the SHARED flag, I would expect Linux to accept 
subsequent request_irq() calls for the same IRQ made by other drivers 
if-and-only-if the other requests are made with the SHARED flag.

My temporary fix for the problem I encountered required me to request 
the same IRQ from Linux via request_irq() and then from Xenomai via 
rtdm_irq_request(). I had expected the Xenomai request to fail. However, 
that expectation assumed that there are interlocks between the 
environments. I perceived problems in either case. If there are no 
interlocks, then both a real-time driver and a non-real-time driver may 
be loaded to service the same IRQ and be ignorant of each other. This 
would probably be bad.

If there are interlocks...
Then for a non-shared IRQ, the first driver to request the IRQ would 
receive it. All other requestors, regardless of whether they are Xenomai 
or Linux would be refused.
For a shared IRQ, the rules get much more complex. I believe that the 
first driver to request the IRQ would receive it, but if the driver 
specified the SHARED flag sharing would restricted the environment of 
that first driver. Requests made from the other environment should be 
rejected whether or not they specify SHARED.
Since my temporary fix (requesting and receiving a non-shared IRQ in 
both the Linux and Xenomai environments) worked, if proved that there 
were no interlocks. Phillippe stated that this is a flaw in the current 
version of Xenomai.

Regards,
Bob

On 8/10/2010 12:43 AM, Guenter Ebermann wrote:
> Hi Bob,
>
> Am 10.08.2010 um 02:56 schrieb Bob Feretich:
>> Do I need to mark the IRQ SHARED in the request_irq()?
>> Does executing a rtdm_irq_request(), without the SHARED flag, fail if
>> the IRQ was reserved via request_irq()? (The purpose of the flag is not
>> documented in the API manual.)
>> Do I need to specify the SHARED flag in both request_irq() and
>> rtdm_irq_request()? I'd rather not allow any other driver access to my IRQ.
> I am relatively new to xenomai, but perhaps I can shed some light on shared
> IRQs: Shared IRQs are used if more than one device share one interrupt line.
> E.g.: Two PCI cards use the same interrupt line.
>
> The cards output has high-resistance if the interrupt is disabled.  A external
> pull-up is used. So if no interrupt is pending the voltage is high on the line.
> The interrupt must also be level sensitive.
>
> Whenever a interrupt occurs one card pulls down the IRQ line to ground. This
> also works if both cards pull the IRQ down the same time (IRQ happens at the
> same time).
>
> Also the return value of the IRQ is important if the IRQ is shared.  The first
> thing you have to do is check if it was your device that issued the irq (by
> accessing some registers in your device).  If it was your device do what has to
> be done (ack the interrupt in the device so that it doesnt pull down the level
> to ground any more) and return IRQ_HANDLED.  If its not your return
> IRQ_NO_HANDLED or such.
>
> So if you write a driver for one of this two cards you must use the IRQ_SHARED
> flag (this is the same with standard linux interrupt API - just call
> request_irq with irqflags=IRQF_SHARED) so that linux knows that after it calls
> your handler it must also call all other handlers of this IRQ.
>
> However shared IRQs can be used for all kind of devices. But PCI is the only
> example I am aware of where it really is used. It is also the root of alot of
> problems because one must be really careful to handle such shared IRQs
> correctly.
>
> So its more likely your device does not use shared IRQs.
>
> But perhaps in xenomai API this flag means a different thing I am not yet aware
> of.
>
> Kind regards,
> Guenter

