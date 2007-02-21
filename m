Message-ID: <45DC42D5.9020605@domain.hid>
Date: Wed, 21 Feb 2007 14:02:13 +0100
MIME-Version: 1.0
Subject: Re: [Xenomai-help] pcspeaker tsc
References: <45DB5A29.9080506@domain.hid> <45DB5FC0.6060004@domain.hid>
In-Reply-To: <45DB5FC0.6060004@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai-help@domain.hid

Hi,

my kernel was compiled for processor family 486. If I change this I 
discover that I have to recompile all the modules as well. For normal 
kernel recompiles this is normal practice, for my live distribution it 
is a house load of really crappy work.

So I am considering to leave my kernel in 486 state until later.

My final application will only have a fastest cycle-time of 1ms and 
according to Philippes interpretation of my latency test read-out I 
should be able to achieve that easily without TSC support in the kernel.

My question is, can I do this? What problems may I experience later on 
as a result of this choice now.

I want to get some feel for the application space programming with 
xenomai and it does not seem worth spending forever getting this right 
now. Or am I wrong?


Are there any settings in the kernel that will improve behaviour without 
the TSC support that I could or should apply?

Kind regards,

Roland Tollenaar.

Jan Kiszka wrote:
> Roland Tollenaar wrote:
>> Hi
>>
>> I have some form of kernel recompiled in which I have the power
>> management turned off. The PCspeaker is also unselected but it comes
>> alive anyway. This is the result -or so it seems- of the soundcard
>> driver. I would like to rmmod the sound card driver after booting if
>> this interferes with xenomai but there are so many dependencies snd-this
>> and snd-that, that its not trivial.
>>
>> -Is this sound-card driver a problem for xenomai?
> 
> Nope.
> 
>> -how can I be sure that the pc speaker is harmless for xenomai
> 
> Yes, as long as you are not targeting a very low-end x86 platform (any
> pre-Pentium system without TSC support). But Xenomai will warn you then
> during kernel configuration.
> 
> Jan
> 

