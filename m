Message-ID: <48620CDC.7010909@domain.hid>
Date: Wed, 25 Jun 2008 11:16:12 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <E1KBFpL-0002d2-CR@www3.emo.freenet-rz.de>	<4861E6B4.2000909@domain.hid>
	<op.udapcpq7t06gyn@domain.hid>
In-Reply-To: <op.udapcpq7t06gyn@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] compiling probs
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Axel Beierlein <belatronix@domain.hid>
Cc: "Xenomai-help@domain.hid" <Xenomai-help@domain.hid>

Axel Beierlein wrote:
> Am 25.06.2008, 08:33 Uhr, schrieb Wolfgang Grandegger <wg@domain.hid>:
> 
>> belatronix@domain.hid wrote:
>>> ----- original Nachricht --------
>>>  Betreff: Re: [Xenomai-help] compiling probs
>>> Gesendet: Di 24 Jun 2008 13:12:26 CEST
>>> Von: "Wolfgang Grandegger"<wg@domain.hid>
>>>
>>>> Axel Beierlein wrote:
>>>>> Hello,
>>>>>
>>>>> when i try to compile the module examples from the xenomai source   
>>>>> directory i get many <in file included> like this
>>>>>
>>>>> In file included from   
>>>>> /home/xx/linuxppc_2_4_25/include/asm/xenomai/hal.h:50,
>>>>>                   from   
>>>>> /home/xx/linuxppc_2_4_25/include/asm-generic/xenomai/system.h:39,
>>>>>                   from   
>>>>> /home/xx/linuxppc_2_4_25/include/asm/xenomai/system.h:29,
>>>>>                   from   
>>>>> /home/xx/linuxppc_2_4_25/include/xenomai/nucleus/types.h:39,
>>>>>                   from   
>>>>> /home/xx/linuxppc_2_4_25/include/xenomai/nucleus/queue.h:24,
>>>>>                   from   
>>>>> /home/xx/linuxppc_2_4_25/include/xenomai/nucleus/timer.h:23,
>>>>>                   from   
>>>>> /home/xx/linuxppc_2_4_25/include/xenomai/nucleus/thread.h:23,
>>>>>                   from   
>>>>> /home/xx/linuxppc_2_4_25/include/xenomai/nucleus/pod.h:34,
>>>>>                   from   
>>>>> /home/xx/linuxppc_2_4_25/include/xenomai/nucleus/xenomai.h:23,
>>>>>                   from   
>>>>> /home/xx/linuxppc_2_4_25/include/xenomai/rtdm/rtdm_driver.h:36,
>>>>>                   from heartbeat-x86.c:21:
>>>>>
>>>>> also a type qualifier warning.
>>>>>
>>>>> /home/xx/linuxppc_2_4_25/include/asm/time.h:60: warning: type  
>>>>> qualifiers ignored on function return type
>>>>>
>>>>> Did anyone know what i make wrong?
>>>>>
>>>>> I use xenomai 2.3.5 and the Kernelsource 2.4.25 from the Denx  
>>>>> repository with the ELDK4.1.
>>>>>
>>>>> my make to build the modules is like <make  
>>>>> XENO=$DESTDIR/root/xenomai  CC=ppc_6xx-gcc> where DESTDIR is set to  
>>>>> the Path where the rootfs is.
>>>> Is your kernel configured and built?
>>> Yes, the kernel is configured and built
>>>> Does adding ARCH=ppc help?
>>> No, ARCH=ppc is already set by the eldk_init script
>>>> Is module support enabled in the kernel?
>>> Yes, it is enabled
>>>> What ELDK version do you use?
>>>>
>>> As i said before, i use the ELDK4.1
>> For Linux 2.4 you should use ELDK 3.1.1 because the GLIBC uses 2.4  
>> includes.
>>
>>>> It works fine here.
>>>>
>>> Here not
>>>
>>>> Wolfgang.
>>>>
>>> Any other Ideas?
>> See above. I will try if I get the error with ELDK 4.1.
>>
>> Wolfgang.
> 
> Thats it! With ELDK 3.1.1 it works already fine by me.

OK, with 4.1 I was also not able to compile it properly.

Wolfgang.

