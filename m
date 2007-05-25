Message-ID: <4656C784.9090200@domain.hid>
Date: Fri, 25 May 2007 13:24:52 +0200
From: Johan Borkhuis <j.borkhuis@domain.hid>
MIME-Version: 1.0
References: <4656C2D0.7000705@domain.hid> <4656C583.5040303@domain.hid>
In-Reply-To: <4656C583.5040303@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem with interrupt enabling
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai-help@domain.hid

Jan Kiszka wrote:
> Johan Borkhuis wrote:
>   
>> Hello,
>>
>> I am trying to create an RTDM interrupt handler for an external 
>> interrupt. I use a rtdm_irq_request, followed by a rtdm_irq_enable. This 
>>     
>
> The rtdm_irq_enable is no longer required with RTDM revision 6 and
> higher. But that's trunk, it's rev. 5 which still comes with Xenomai
> 2.3.x. And the enable will also cause no harm with rev. 6.
>   

I did see some references to the fact that it is no longer needed in the 
future. I am running 2.3.1, so for the moment I will leave it in.

>> caused one interrupt to be processed, but subsequent interrupts were not 
>> processed.
>> After adding an extra rtdm_irq_enable to the ISR the interrupts are 
>> processed. When I look at the other drivers I don't see this. Is this 
>> needed, or is there a bug/feature in the interrupt handling on my platform?
>> (I use a MVME3100 with a ppc8540 processor and openPIC interrupt 
>> controller).
>>     
>
> What do you return with your IRQ handler? RTDM_IRQ_HANDLED?
>   
Yes, I do return RTDM_IRQ_HANDLED.

> That explicit rtdm_irq_enable is not required by design, would rather be
> a bug on certain platforms (where enable != end IRQ), and indicates that
> something else is broken, maybe in Xenomai.
>   

This driver is ported from a standard Linux driver, and in this driver 
an extra call is also not needed.

Kind regards,
    Johan Borkhuis


