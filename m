Message-ID: <451C0171.3020508@domain.hid>
Date: Thu, 28 Sep 2006 13:08:01 -0400
From: "J.D. Yamokoski" <yamokosk@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] Problems booting after Adeos patch
References: <451AEEED.1050708@domain.hid> <451B0978.5020108@domain.hid>	
	<451BD6FC.9080205@domain.hid> <451BDADC.30101@domain.hid>
	<1159454661.4982.20.camel@domain.hid>
In-Reply-To: <1159454661.4982.20.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: rpm@xenomai.org
Cc: adeos-main@gna.org

Philippe Gerum wrote:
> On Thu, 2006-09-28 at 16:23 +0200, Jan Kiszka wrote:
>   
>> J.D. Yamokoski wrote:
>>     
>>> Jan Kiszka wrote:
>>>       
>>>> J.D. Yamokoski wrote:
>>>>  
>>>>         
>>>>> Greetings,
>>>>>
>>>>> I have recently run into some trouble trying to boot a custom configed
>>>>> linux kernel with Adeos. During boot the system seems to have problems
>>>>> with the SATA hard drives with messages like,
>>>>>
>>>>> ata1: slow completion (cmd ef)
>>>>> ATA: abnormal status 0x0FF
>>>>> ata1: command 0x25 timeout, stat 0x50 host-stat 0x24
>>>>>
>>>>> And then finally towards the end of the boot sequence, I get "ALERT!
>>>>> /dev/sda3 does not exist. Dropping to a shell!"
>>>>>
>>>>> I am using a highly modified config customized for this machine
>>>>> (Highlights of the config: It excludes a lot of drivers, SMP build, and
>>>>> both SATA-as-SCSI-driver and the regular PCI IDE driver are enabled.)
>>>>> Unpatched this customized kernel works fine. And as expected, if I use a
>>>>> more general config file (one that came with my distro) the Adeos
>>>>> patched kernel boots normally. Its just the combination of Adeos and
>>>>> customized config that seems to be the problem. Does anything jump out
>>>>> at anyone? I have include my config file with this email.
>>>>>
>>>>>     
>>>>>           
>>>> What I-pipe patch version are you using?
>>>>
>>>> Could you try with CONFIG_PCI_MSI disabled? There has been other reports
>>>> on MSI issues recently, maybe yours belong to the same group.
>>>>
>>>> Thanks,
>>>> Jan
>>>>
>>>>
>>>> PS: Unrelated to the problem but maybe still interesting: If you plan to
>>>> use Adeos/I-pipe as a real-time enabler (e.g. with Xenomai), you should
>>>> switch off CONFIG_ACPI_PROCESSOR, CONFIG_CPU_FREQ, and CONFIG_APM.
>>>> Recent Xenomai versions should warn you about this fact as well.
>>>>
>>>>   
>>>>         
>>> That seems to have fixed the problem! The new kernel with this disabled
>>> boots just fine. Thanks!
>>>       
>> Well, I wouldn't say "fixed", it works around the bug.
>>
>>     
>>> By the way, I was using I-pipe patch 2.6.15-i386-1.3-07.
>>>       
>> Philippe, any news on the MSI issue?
>>
>>     
>
> Nope. Unfortunately, now hw at hand that exhibits the issue, and no time
> to dig it anyway.
>
>   
>> Jan
>>
>> _______________________________________________
>> Adeos-main mailing list
>> Adeos-main@domain.hid
>> https://mail.gna.org/listinfo/adeos-main
>>     
I can't lend out hardware, but if there are specific tests or patches 
you want me to try, by all means send them my way.

J.D.

