Message-ID: <435403C8.80400@domain.hid>
Date: Mon, 17 Oct 2005 22:04:24 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] compiling xenomai on x86_64
References: <4353F109.7000707@domain.hid>	<4353F411.4000500@domain.hid>	<4353F896.1040508@domain.hid>
	<435402B4.5060004@domain.hid>
In-Reply-To: <435402B4.5060004@domain.hid>
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
To: Heikki Lindholm <holindho@domain.hid>
Cc: xenomai@xenomai.org

Heikki Lindholm wrote:
> Jan Kiszka kirjoitti:
> 
>> Heikki Lindholm wrote:
>>
>>> Jan Kiszka kirjoitti:
>>>
>>>
>>>> Hi,
>>>>
>>>> I'm dumb x86 user who unfortunately just seem to have tumbled in the
>>>> cross-compilation trap: I'm trying to generate i586 code on a fancy new
>>>> and fast x86_64 compilation host. I got the kernel compiled with
>>>> ARCH=i386, using only the pre-installed compiler (i.e. no dedicated
>>>> cross tool chain), but I failed to compile xenomai against that kernel
>>>> in the following. Which magic switch do I have to apply and where?
>>>
>>>
>>>
>>> As dumb a guess: -m32 compiler switch?
>>>
>>
>>
>> Yes, I know, that would help. But where to feed this argument into the
>> build system?
> 
> 
> I would try makefile (and perhaps config/kconfig/Makefile*) and command 
> line 'CC="gcc -m32" CXX="gcc -m32" make menuconfig/install' to be sure.
>

You should be able to do that just by reconfiguring:

cd build && make reconfig CC="gcc -m32"

> -- Heikki Lindholm
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 

Philippe.

