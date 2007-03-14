Message-ID: <45F7F0BE.50402@domain.hid>
Date: Wed, 14 Mar 2007 13:55:26 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rtcansend.c problem if using
	together	with-lpthread_rt
References: <DD39B5C3F4963040ADC9768BE7E430CB01BB4107@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB01C21D24@domain.hid>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB01C21D24@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai@xenomai.org

Daniel Schnell wrote:
> Hi,
> 
> Sorry to repost this issue, which I posted some days ago, but there was
> no reaction so far.
> It should be easy to reproduce. I need just a short answer from somebody
> with a RT-CAN driver.

Hm, Gilles already answered 
https://mail.gna.org/public/xenomai-help/2007-03/msg00198.html.

> 
> Thanks in advance,
> 
> Best regards,
> 
> Daniel Schnell.
> 
> 
> Daniel Schnell wrote:
>> Hi,
>>
>> Hunting down a RTCAN related bug in my application I ended up
>> compiling the rtcansend.c function with our make environment. 
>>
>> Basicly the compilation is done like this:
>>
>> ppc_6xx-gcc -W -Wall -O2 -D_GNU_SOURCE -D_REENTRANT -D__XENO__
>> -I/usr/xenomai/include -c -o rtcansend.o rtcansend.c 
>>
>> Linking:
>>
>> ppc_6xx-gcc  -o rtcansend rtcansend.o -L/usr/xenomai/lib -lpthread_rt
>> -lnative -lrtdm -lpthread -lrt 
>>
>> If run, the following happens:
>> bash-2.05b# ./rtcansend rtcan0 -v -i0 01 interface rtcan0 s=0,
>> ifr_name=rtcan0 
>> rt_task_shadow: Device or resource busy
>> Cleaning up...
>>
>> If I leave away -lpthread_rt in the linking step, output is normal:
>>
>> bash-2.05b# test/rtcansend rtcan0 -v -i0 01 interface rtcan0 s=0,
>> ifr_name=rtcan0 <0x000> [1] 01 Cleaning up... 
>>
>> I am using svn version 2256.
>> Am I doing here something fundamentally wrong in providing
>> -lpthread_rt as an additional library ? Shouldn't the native skin and
>> the POSIX skin just work together ?  
>>
>>
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 
> 


