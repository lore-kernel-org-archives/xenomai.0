Message-ID: <47332C26.8000008@domain.hid>
Date: Thu, 08 Nov 2007 16:32:54 +0100
MIME-Version: 1.0
References: <200711061807.26236.lepalom@domain.hid>
	<200711071859.33094.lepalom@domain.hid> <4732991C.1080008@domain.hid>
	<200711081041.57506.lepalom@domain.hid>
In-Reply-To: <200711081041.57506.lepalom@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
Subject: Re: [Xenomai-help] IRQ issues in xenomai and rtnet
Reply-To: rolandtollenaar@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Leopold Palomo-Avellaneda <lepalom@domain.hid>
Cc: mathias_koehrer@domain.hid, xenomai@xenomai.org

> no,  I can test it again but I think that I have been not able to have a 
> combination without share at least irq of one of the network cards.
> 
>> Although my experience was then always that 
>> the freezing just occurs when rtnet is started 
> 
> me too.

In this case what you should do is look for non-rt devices that are not 
used. Preferably disable them in the BIOS and ensure that the irq's that 
are share with non-rt devices are shared only with devices that are not 
used.

I.g. with the SATA controller if you don't have a SATA Hd connected, or 
with a USB controller that you will not be using.


Roland

> 
>> so your system hanging on 
>> boot strikes me as a bit odd. Unless of course you start rtnet in one of
>> the rc bootscrips of course?
> 
> no, the hanging at boot time is when I don't put the noapic option in the 
> 2.6.22 kernels (it's known bug) with 2.6.23 depends of irqpoll, or the manual 
> assignment in the bios.
> 
> Thanks.
> 
> Leo
> 
>>> A Dimecres 07 Novembre 2007, Jan Kiszka va escriure:
>>>> Leopold Palomo-Avellaneda wrote:
>>>>> A Dimecres 07 Novembre 2007, Karl Reichert va escriure:
>>>>> [...]
>>>>>
>>>>>>> the _same_ card was working with rtnet (not xenomai but rtai) in a
>>>>>>> configuration that I had in another box.
>>>>>> That's what I mean, the card is not the problem. The problem is the
>>>>>> current setup, so as a result it is not working. But of course not the
>>>>>> card is the one to blame. ...
>>>>> are you working for intel? ;-)
>>>>>
>>>>> no, I'm joking.
>>>>>
>>>>> Sadly, I have tested the same configuration with a rtai kernel and I
>>>>> got the same hang :-( Also, the network card got the same irq in rtai
>>>>> ...
>>>> IRQ issues are generally I-pipe issues. And RTAI uses (almost) the same
>>>> I-pipe patch as Xenomai, thus shares the same bugs until they are fixed
>>>> upstream. Generally.
>>>>
>>>> There are currently a few fixes floating around on Adeos-main, and we
>>>> (Xenomai) have some new report probably regarding MSI. As I think I have
>>>> seen something about MSI in your config as well, could you try to
>>>> disable CONFIG_PCI_MSI to check if at least the hangs disappears (given,
>>>> of course, IRQs line will then not be in conflict again)? Also can you
>>>> try (unless you already do so) with the latest I-pipe patch for, say,
>>>> 2.6.23.x?
>>>>
>>>> Another hint regard IRQ conflict avoidance: If RTnet (or RT hardware in
>>>> general) shares some line with a Linux device you may not depend upon
>>>> (Firewire? USB?), just unload the related Linux drivers. Of course, this
>>>> doesn't fly if it is your main IDE/SATA device...
>>>>
>>>> Note that this IRQ stuff is most likely not RTnet business, so it would
>>>> be good to move the thread over to Xenomai.
>>>>
>>>> Jan
>>> _______________________________________________
>>> Xenomai-help mailing list
>>> Xenomai-help@domain.hid
>>> https://mail.gna.org/listinfo/xenomai-help
> 
> 
> 

