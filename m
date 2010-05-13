Message-ID: <4BEBB838.2080407@domain.hid>
Date: Thu, 13 May 2010 10:28:40 +0200
From: Ramon <ramoncostacastello@domain.hid>
MIME-Version: 1.0
References: <4BEB0A05.5020006@domain.hid> <4BEB0EF2.7020604@domain.hid>
	<4BEB1C06.7030907@domain.hid>
In-Reply-To: <4BEB1C06.7030907@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] native kernel task example
Reply-To: ramoncostacastello@domain.hid
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
Cc: xenomai@xenomai.org

Hi,

I have a system developed (teaching and research purposes) developed in 
RTLinuxfree and currently I'm trying to migrate
this system to Xenomai (several task periodical task with period of 
100us (one at 50us)).
As a first step I would like to run them at kernel level to preserve 
performance (hard realtime), latter I will try to migrate
user space.

This task contains low level  commands (out, in commands to access AD/DA 
card registers)

Any suggestion ?

Best wishes
Ramon

On 12/05/2010 23:22, Jan Kiszka wrote:
> Wolfgang Grandegger wrote:
>    
>> On 05/12/2010 10:05 PM, Ramon wrote:
>>      
>>> Hi,
>>>
>>> I'm looking for a very simple kernel task using native api.
>>> A very simple one would be nice, a periodical task for example.
>>>
>>> I'm interested in the .c file and its Makefile.
>>>        
>> You can find examples in the "examples" directory of the Xenomai tree
>> as documented here:
>>
>> http://xenomai.org/index.php/Examples
>>
>> http://www.rts.uni-hannover.de/xenomai/lxr/source/examples/native/trivial-periodic.c
>>
>> might be what you are looking for.
>>
>> Wolfgang.
>>      
> Just be warned that the in-kernel skin usage is considered deprecated
> (with exception of RTDM). It may not be the best choice when starting
> something new.
>
> Jan
>
>    


