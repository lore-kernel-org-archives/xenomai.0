Message-ID: <4C692FC3.5040802@domain.hid>
Date: Mon, 16 Aug 2010 14:32:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1281709057.650414331@domain.hid> <4C65583D.3030800@domain.hid>
	<1281960823.030215299@domain.hid>
In-Reply-To: <1281960823.030215299@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Very high latencies under stress testing
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: edward.robbins@domain.hid
Cc: xenomai@xenomai.org

edward.robbins@domain.hid wrote:
> 
> On Friday, 13 August, 2010 3:35pm, "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org> said:
> 
>> edward.robbins@domain.hid wrote:
>>> I wonder if this is to do with graphics? I have set "NoAccel" in the
>>> driver section of Xorg.conf (I am using fbdev). I also notice that
>>> latencies go massive (e.g. 4200uS) the first time I run glxgears.
>>> "glxinfo" reports "Direct rendering: no".
>> This is bad news. It could come either from the fact that the Xorg
>> driver shuts hardware interrupts off (there is nothing xenomai can do
>> about that), or it could be an SMI issue. What about using the driver
>> for the real graphic card you have ? Probably intel card? Do you observe
>> any big latencies if you stress the system with anything else than X?
>>
>>> Power management options (ACPUI, APM): Disable ACPI (Advanced
>>> Configuration and Power Interface) Support --> Processor Disable CPU
>>> Frequency Scaling Disable CPU idle PM support Disable Power Managment
>>> Support
>> Disabling ACPI is a bad idea. As repeated many times, only
>> ACPI_PROCESSOR should be disabled, not ACPI.
>>
> 
> Thanks for your helpful responses.
> 
> I'm not working on this project again until next week, but on Friday I was able to
> 
>  o Recompile the kernel with ACPI enabled 
>  o Boot with the 'SMI handler' BIOS option set to disabled....
>    according to the help text this option should be disabled if 'an RTOS 
>    is installed' - I presume this means that SMIs are completely disabled 
>    and therefore SMIs cannot be the source of the problem 
>   (very convenient BIOS option... now I begin to appreciate the expense of this board!) 
>  o Changed xorg to use the intel video driver

Now you can try NoAccel with the intel video driver too....


-- 
					    Gilles.

