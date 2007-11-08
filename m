Message-ID: <4732991C.1080008@domain.hid>
Date: Thu, 08 Nov 2007 06:05:32 +0100
MIME-Version: 1.0
References: <200711061807.26236.lepalom@domain.hid>	<200711071500.23914.lepalom@domain.hid>
	<4731CAE5.5080401@domain.hid> <200711071859.33094.lepalom@domain.hid>
In-Reply-To: <200711071859.33094.lepalom@domain.hid>
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

Hi
> I have selected in the bios that each pci slot htat has a ethernet has a 
> specific irq, but when I load a rtnet driver, it assigns another irq. Making 
> more test, now with 2.6.23 the irq assigned in bios more or less i maintained 
> but still _again_ when load the rtnet driver, the box hangs ...

Is there any possibility of posting the irq assignemts as you set them 
in the BIOS when it hangs and.....


> I must put a irq specific for each card if not the kernel doesn't boot or I 
> put irq auto and irqpoll in the kenel options. With this configuration I can 
> configure the cards:
> 
> and the system doesn't hang ...
the irq output of lspci -v when the system does not hang?

Also the output of /proc/xenomai/irq IIRC.

For what its worth, I understand that there may be no sharing of the IRQ 
of a real-time device with a non-rt device. In particular not a non-rt 
device that is being used. Although my experience was then always that 
the freezing just occurs when rtnet is started so your system hanging on 
boot strikes me as a bit odd. Unless of course you start rtnet in one of 
the rc bootscrips of course?

Roland.

> 
> 
> So, any ideas about it?
> 
> Best regards,
> 
> and very thanks for all your effort,
> 
> Leo
> 
> A Dimecres 07 Novembre 2007, Jan Kiszka va escriure:
> 
>> Leopold Palomo-Avellaneda wrote:
>>> A Dimecres 07 Novembre 2007, Karl Reichert va escriure:
>>> [...]
>>>
>>>>> the _same_ card was working with rtnet (not xenomai but rtai) in a
>>>>> configuration that I had in another box.
>>>> That's what I mean, the card is not the problem. The problem is the
>>>> current setup, so as a result it is not working. But of course not the
>>>> card is the one to blame. ...
>>> are you working for intel? ;-)
>>>
>>> no, I'm joking.
>>>
>>> Sadly, I have tested the same configuration with a rtai kernel and I got
>>> the same hang :-( Also, the network card got the same irq in rtai ...
>> IRQ issues are generally I-pipe issues. And RTAI uses (almost) the same
>> I-pipe patch as Xenomai, thus shares the same bugs until they are fixed
>> upstream. Generally.
>>
>> There are currently a few fixes floating around on Adeos-main, and we
>> (Xenomai) have some new report probably regarding MSI. As I think I have
>> seen something about MSI in your config as well, could you try to
>> disable CONFIG_PCI_MSI to check if at least the hangs disappears (given,
>> of course, IRQs line will then not be in conflict again)? Also can you
>> try (unless you already do so) with the latest I-pipe patch for, say,
>> 2.6.23.x?
>>
>> Another hint regard IRQ conflict avoidance: If RTnet (or RT hardware in
>> general) shares some line with a Linux device you may not depend upon
>> (Firewire? USB?), just unload the related Linux drivers. Of course, this
>> doesn't fly if it is your main IDE/SATA device...
>>
>> Note that this IRQ stuff is most likely not RTnet business, so it would
>> be good to move the thread over to Xenomai.
>>
>> Jan
> 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 

