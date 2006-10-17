Message-ID: <4534A4B4.5070100@domain.hid>
Date: Tue, 17 Oct 2006 10:39:00 +0100
From: Marcelo Coelho <mjcoelho@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] which way to obtain irq#
References: <4533C841.3040108@domain.hid> <4533D031.4040306@domain.hid>
	<4534A243.7070303@domain.hid>
In-Reply-To: <4534A243.7070303@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
Cc: Xenomai help <xenomai@xenomai.org>


>> [I think you swapped the terms "real" and "virtual" here, no?]

At a first look I don't think so. The first option gives a number
between 1 and 255 and the second gives between 1 and 15.







> 
> Jan Kiszka wrote:
>  > Marcelo Coelho wrote:
>  >> Hi!
>  >>
>  >>
>  >> I'm developing a driver based on RTDM, and i'm having some problems
>  >> related to IRQ discovery (related to the fact that the driver is
>  >> starting to do something).
>  >>
>  >> So, there is 2 ways to obtain the IRQ number:
>  >>     pci_device -> irq
>  >> or
>  >>     pci_read_config_byte( pci_device, PCI_INTERRUPT_LINE, (unsigned
>  >> char*) &irq )
>  >>
>  >>
>  >> The difference between these is that the 1st presents the "real" irq
>  >> number (between 1 and 15) and the other presents the "virtual" irq
>  >> (between 1 and 255).
>  >
>  > [I think you swapped the terms "real" and "virtual" here, no?]
>> You have to use the first one like any Linux driver (RTDM is no
>> different in this regard).
>>
>>>
>>> From your experience, is there any problem using the virtual irq number
>>> (the 1st option)?
>>>
>>>
>>>
>>> Thanks for your answers!!
>>>
>>>
>>
>> Jan
>>
> 
> DISCLAIMER: This message may contain confidential information or 
> privileged material and is intended only for the individual(s) named. If 
> you are not a named addressee and mistakenly received this message you 
> should not copy or otherwise disseminate it: please delete this e-mail 
> from your system and notify the sender immediately. E-mail transmissions 
> are not guaranteed to be secure or error-free as information could be 
> intercepted, corrupted, lost, destroyed, arrive late or incomplete or 
> contain viruses. Therefore, the sender does not accept liability for any 
> errors or omissions in the contents of this message that arise as a 
> result of e-mail transmissions. Please request a hard copy version if 
> verification is required. Critical Software, SA.
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 

DISCLAIMER: This message may contain confidential information or privileged material and is intended only for the individual(s) named. If you are not a named addressee and mistakenly received this message you should not copy or otherwise disseminate it: please delete this e-mail from your system and notify the sender immediately. E-mail transmissions are not guaranteed to be secure or error-free as information could be intercepted, corrupted, lost, destroyed, arrive late or incomplete or contain viruses. Therefore, the sender does not accept liability for any errors or omissions in the contents of this message that arise as a result of e-mail transmissions. Please request a hard copy version if verification is required. Critical Software, SA.

