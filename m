Message-ID: <48F73FCD.10304@domain.hid>
Date: Thu, 16 Oct 2008 15:21:17 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48F5E050.4090106@domain.hid> <48F6035C.1040103@domain.hid>
	<48F64626.7040304@domain.hid>
In-Reply-To: <48F64626.7040304@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] implementing a new rtdm driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: belatronix@domain.hid
Cc: Xenomai-help@domain.hid

[ Save the CCs! ]

Axel Beierlein wrote:
> Jan Kiszka schrieb:
>> Axel Beierlein wrote:
>>  
>>> Hello,
>>>
>>> i will implement my Serial ppc-PSC driver into the rtdm and
>>> there are some hardwarespecific things that differ from the
>>> implementation of the 16550A.
>>>
>>> Is it right that i have to add these things to the existing Serial
>>> Profile in rtserial.h?
>>>     
>>
>> Well, unless that UART comes with some very special features or someone
>> made a mistake when defining the serial profile, you should be able to
>> provide a compatible driver.
>>
>>  
>>> What for is the device sub class Makro and how can i use it for a new
>>> profile? Perhaps #ifdef compiling?
>>>     
>>
>>   
> My first Idea was anything like
> #if RTDM_SUB_CLASS  = = RT_SERIAL_PSC
> ioctl functions for the new Hardware
> ...
>> Please discuss with us what you want to #ifdef so that we can tell you
>> why you shouldn't. ;)
>>
>>   
> Ok, I also think that this was not a good idea :-(
>> Regarding the subclass: It might only be for informational purposes, but
>> it would definitely make sense when you add new services to the profile
>> (or leave out existing ones).
>>
>>   
> Why does this make sense?
> In the testdriver profile there you have defined three subclasses and
> special ioctl functions for different uses of the driver. But the
> defined subclass Makros are not used apart from writing to the device
> structure.
> For what kind of Information are the different subclasses?

It pops up under /proc/xenomai/rtdm, and the user application can query
the subclass via RTIOC_DEVICE_INFO.

> Sorry, when i am a little bit slow on the uptake!
> 
>>> Summarize:
>>> What is the preferred way to implement an new serial Hardware into
>>> the existing RTDM Serial Device Profile?
>>>
>>>     
>>
>> Unless you find significant shared code in your to-be-written driver and
>> the 16550A, I would say go for a separate implementation of the same API
>> (== RTDM profile). If you find common code, than let us discuss some
>> generic UART framework for RTDM.
>>   
> The most of your 16550 code i can use for the psc one but the ioctl
> routine will differ slightly. Also the init and
> configuration sequences.
> 
> Ok, i will post the drivercode the next time, perhaps we can find a way
> to fit it to xenomai. But first i will make a working beta
> and do some tests on our hardware.

Looking forward!

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

