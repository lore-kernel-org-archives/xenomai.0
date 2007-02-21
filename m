Message-ID: <45DC3887.5090003@domain.hid>
Date: Wed, 21 Feb 2007 13:18:15 +0100
MIME-Version: 1.0
Subject: Re: [Xenomai-help] tsc enable or disable
References: <bc4264770702201537x2bd55cc1l713471dafc23f301@domain.hid>	
	<1172017415.5044.65.camel@domain.hid> <45DC1DA9.5030405@domain.hid>
	<1172054504.3551.9.camel@domain.hid>
In-Reply-To: <1172054504.3551.9.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
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
To: rpm@xenomai.org, Xenomai-help@domain.hid

Hi

> Processor type and features -> Processor family
Thanks found it. I did try to set it to the 586/5x86 etc series but I am 
having serious conflicts now with the squashfs and unionfs file system 
drivers. I cannot get it booted like this.

I will try the pentium classic family to see whether that works.

Anyone know why I might be seeing this. Those file systems are inherent 
to the liveUSB liveCD distributions.


How serious is it if I cannot get TSC support into the kernel?
Will I have problems with sound cards and such like?

RR



> 
>> Regards,
>>
>> Roland
>>
>>
>>
>>
>>
>>
>>
>>> Search for Time stamp counter / x86. Activating it gives a better timing
>>> precision -and a much lower overhead- than using the poor man's
>>> emulation of a TSC based on the 8254 programmable interval timer you
>>> also have in your PC (which is the fallback choice Xenomai picks when no
>>> TSC is available on x86). (This said, TSCs also have their problems, but
>>> that's off-topic).
>>>
>>>> Ehh and while I think about it, what is displayed by the latency test. I get
>>>>
>>>> lat min  lat ave latmax overrun lat best
>>>> 20.11   29.33   52.79  0            19.276
>>>>
>>>> typical.
>>>>
>>> Decent, especially in emulated TSC mode over a low-end system. Not that
>>> brilliant and almost suspect on a multi-Ghz box, it depends on you hw.
>>>
>>>> The period seems to be 100micro seconds so what do the figures above
>>>> mean? 20 microseconds is typically the shortest period I could run at?
>>>> Or >52.79? Some light on this would be great.
>>>>
>>> 20 us is the closest latency _spot_ (i.e. for one sample) to the ideal
>>> tick time observed in your current configuration, for running a
>>> user-space task sampling at 10Khz (if you did not specify any option to
>>> the latency test, that is). 52.79 would tell us that the sustainable
>>> rate without any overrun should in theory be close to 20Khz according to
>>> those figures, but you also need to account for some RT sleep time to
>>> let the regular Linux kernel breathe and other perturbations, so I would
>>> rather bet on a period around 80-90 us (to check this, try running the
>>> latency test as either: ./run -- -p 80, or sudo ./latency -p 80, and
>>> adjust /proc/xenomai/latency to get the minimal latency closer to the
>>> ideal tick time while the test runs, i.e. zero).
>>>
>>> In any case, those figures would only make sense as significant
>>> worst-case values for a properly loaded box (i.e. w/ cache
>>> perturbations, bus traffic, all sorts of runtime tortures).
>>>
>>> Search the mail archive for the keyword "/proc/xenomai/latency", and
>>> make sure to have read the TROUBLESHOOTING guide, you will get more
>>> information about these issues.
>>>
>>>> Kind regards,
>>>>
>>>> And thanks for all the help.
>>>>
>>>> Roland.
>>>>
>>>> _______________________________________________
>>>> Xenomai-help mailing list
>>>> Xenomai-help@domain.hid
>>>> https://mail.gna.org/listinfo/xenomai-help

