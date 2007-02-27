Message-ID: <45E40207.3020505@domain.hid>
Date: Tue, 27 Feb 2007 11:03:51 +0100
MIME-Version: 1.0
Subject: Re: [Xenomai-help] newby question, can/socket stuff
References: <bc4264770702261108l6b3f60b2w53e9e90e40d79b92@domain.hid>	
	<45E33BA0.6080903@domain.hid>	
	<bc4264770702261206v1e3d84cbhe94b923540dbaae6@domain.hid>	
	<45E34014.6080105@domain.hid>
	<bc4264770702261237v2cdd380ag128ed0cfb703b281@domain.hid>
	<45E35261.8000505@domain.hid> <45E3F83B.4070702@domain.hid>
	<45E3FDD5.4070308@domain.hid>
In-Reply-To: <45E3FDD5.4070308@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>, Xenomai-help@domain.hid

Hi,

Absolutely clear. From the metaphorical chinaman's point of view that is. :)

Thanks all.

Roland.


Jan Kiszka wrote:
> Roland Tollenaar wrote:
>> Hi
>>
>>>>> Add 1 to 1: The CAN profile describes what IOCTLs are available for CAN
>>>>> sockets. rt_dev_ioctl() (or ioctl() with the POSIX skin) is the way to
>>>>> pass these IOCTLs down to the CAN stack.
>>>> Actually this sheds quite a bit of light on matters. If you would be
>>>> so kind as to give a brief explanation of what a "stack" is exactly. I
>>>> have been confronted with the term quite a lot now but its not
>>>> becoming clearer. I used to think it was a buffer of some kind. Kind
>>>> of like the ones that one "pushes" and "pops" on but I can't see a
>>>> connection between that concept and what you say above.
>>> http://en.wikipedia.org/wiki/Protocol_stack? :->
>> Thanks.
>>
>> Would that mean that the protocol stack we are looking at is something
>> like this?:
> 
> Yep.
> 
>> CANOpen (in my application)
>> RTCAN (incorporated in Xenomai)
>> CAN Driver (e.g. the PEAK dongle dirver)
>> Parallel port driver
> 
> That driver doesn't exist here technically.
> 
>> :
>> Parallel Port Hardware
>> Dongle
>>
>> Whereby the last two would officially not make out part of the protocol
>> stack.
>>
>> and rt_dev_ioctl passes the IOCTLS to the layer RTCAN in my example above?
>>
> 
> Yes.
> 
>> And in this text
>>>>> Add 1 to 1: The CAN profile describes what IOCTLs are available for
>>>>> CAN sockets. rt_dev_ioctl() (or ioctl() with the POSIX skin) is the
>>>>> way to pass these IOCTLs down to the CAN stack.
>> the final word should technically speaking not be "stack" but rather
>> "layer". ?
> 
> Yes and no. The first layer to see the request is the CAN protocol
> layer, but it may decide to pass it down to the driver, which may decide
> to hand it to the hardware. That's why I was speaking of the whole thing
> "stack" here.
> 
>> If all the above is a roughly correct understanding of the situation I
>> should be able to make a bit more sense out of the CAN code.
>>
>> Thanks,
>>
>> Roland
>>
> 
> Jan
> 

