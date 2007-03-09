Message-ID: <45F1425E.90604@domain.hid>
Date: Fri, 09 Mar 2007 12:17:50 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RTCAN and tsc
References: <bc4264770703060706x5dafb942weec4d4c2c5756427@domain.hid>
	<E1HPc72-0002bA-Ko@domain.hid> <45F1340C.20402@domain.hid>
	<E1HPclZ-0004Yo-QD@mailer.emlix.com>
In-Reply-To: <E1HPclZ-0004Yo-QD@mailer.emlix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sebastian Smolorz <ssm@domain.hid>
Cc: xenomai@xenomai.org, Bernard Dautrevaux <bernard.dautrevaux@domain.hid>

Sebastian Smolorz wrote:
> Gilles Chanteperdrix wrote:
> 
>>Sebastian Smolorz wrote:
>>
>>>Gilles Chanteperdrix wrote:
>>>
>>>>Sebastian Smolorz wrote:
>>>>
>>>>>If an RX interrupt appears it it necessary to read out up to 14 SJA1000
>>>>>regs and write one register before a CAN message can be distributed to
>>>>>the sockets. Do you really suggest that the reading of the SJA1000
>>>>>registers should be interruptible? One step towards chaos, I would say.
>>>>
>>>>Maybe it would make sense to handle the message reception in a thread (a
>>>>kind of bottom half), and to only disable the CAN irq when doing the
>>>>reception work. This way, the system would still be able to handle other
>>>>events while the can reception takes place.
>>>
>>>The SJA1000 interrupt handler consists of several parts:
>>>1. Read out the interrupt register to determine which kind of CAN
>>>interrupt raised
>>>2. Check for the different kind of interrupts (error, TX, RX)
>>>3. If RX:
>>>3a. read out HW registers
>>>3b. Distribute to sockets
>>>
>>>It seems that an extended amount of time is spent for 3a. If we do this
>>>in a bottom-half we have to deal with things like priority inversion and
>>>under certain circumstances with lost CAN messages due to a full HW RX
>>>buffer of the CAN controller.
>>
>>So, maybe it is possible to simply enable interrupts in the interrupt
>>handler with only the CAN interrupt disabled ?
> 
> 
> This requires a detailed review of the driver code because every access to the 
> CAN HW registers are protected by a rtdm_lock_get_irqsave and the SJA1000 IRQ 
> handler relies on all IRQs being off.

RTnet documentation recommends to use
      rtdm_irq_disable(&priv->irq_handle);
      rtdm_lock_get(&priv->lock);

instead of rtdm_lock_get_irqsave(&priv->lock);
when the critical section is about to be long. The point is that the can
irq would still be off, it is unlikely that you have to protect from irq
handlers of other drivers.

> 
> But as far as I see, the PI and the HW buffer overflow problems would still 
> exist.
> 

I do not see what you mean.

-- 
                                                 Gilles Chanteperdrix

