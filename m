Received: from huan8.mail.rambler.ru (carlos104.mail.rambler.ru [81.19.78.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A677C
	for <xenomai@lists.linux.dev>; Wed,  6 Jul 2022 19:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rambler.ru;
	 s=mail; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:To:From:
	References:Subject:MIME-Version:Date:Message-ID;
	bh=vdd9m51ZTNIn0gjJ1KzEfd12Bgw8yvI5U/9rK9z+yoA=; b=G3+x/x4ItmZmIqoDWLAs0+ydqx
	IVZ4W8nLvFJV+YwtK2KduYMPQecon/B0e7qtkD803nSXOeeo6fHi8a8YGiuodEFTdNdim7sYf/iJt
	yymF15M/slb+OAT8ZAiWb3J81xyYjaHTS61xDWzRV2oQ5PFO7haxG4biU+0L31ekPJgI=;
Received: from [UNAVAILABLE] ([85.140.3.156]:53144 helo=[192.168.100.100])
	by huan8.mail.rambler.ru with esmtpa (Exim 4.86_2)
	(envelope-from <feedcom@rambler.ru>)
	id 1o9AL7-0006bo-Dl
	for xenomai@lists.linux.dev; Wed, 06 Jul 2022 22:05:33 +0300
Message-ID: <849a6328-3fec-bcec-fd1b-c518c291d337@rambler.ru>
Date: Wed, 6 Jul 2022 22:05:32 +0300
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: More details on health monitoring notifications
Content-Language: ru-RU
References: <PH1P110MB105061FEB2694B16A3879348E2BD9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB10506DDF3B33330889D67BE6E2819@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87o7y2s1p9.fsf@xenomai.org>
From: Leonid Gasheev via Xenomai <feedcom@rambler.ru>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
In-Reply-To: <87o7y2s1p9.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rambler-User: feedcom@rambler.ru/85.140.3.156

06.07.2022 17:57, Philippe Gerum пишет:
> 
> Russell Johnson <russell.johnson@kratosdefense.com> writes:
> 
>> [[S/MIME Signed Part:Undecided]]
>> I also notice these lines in “dmesg” output from the EVL core. Can I use the excpt or user_pc to get any more information about what is causing these in-band switches?
>>
> 
> Yes. Exception #14 on x86 is 'page fault' event, which seems to be the
> architecture this code is running on. User_pc is the PC value in the
> virtual address space of the process when it causes the trap in this
> case. This is a - possibly legit - memory access which requires a
> so-called 'major fault' to be taken.
> 
> GDB may help figuring out the location of this code, in two ways:
> 
> - switching the HM notifier to 'signal' mode for your threads, using
>    T_HMSIG, you only need to run the app over GDB: the core will send it
>    a SIGDEBUG event, which GDB will trap. Using the GDB 'backtrace/bt'
>    command once the app is in break state after receipt should display a
>    backtrace to the offending code (IOW the EVL core makes sure that your
>    app receives SIGDEBUG immediately on top of the code causing the
>    trap).
> 
> - using the GDB 'list' command to list the code at the PC value reported
>    by the kernel should work. You just need to start the application
>    first: unless you have a complex dlopen-based scheme for running code
>    plugins, running until a breakpoint is taken in main() should be
>    enough before you can issue 'list *<PC_value>'.
> 
>>   
>>
>> [ 7301.352255] EVL: thread_1 switching in-band [pid=6319, excpt=14, user_pc=0x7f54a7877fa6]
>>
>> [ 7301.352689] EVL: thread_2 switching in-band [pid=6285, excpt=14, user_pc=0x7f54a7877fa6]
>>
>>   
>>
>> From: Russell Johnson
>> Sent: Friday, July 1, 2022 11:19 AM
>> To: xenomai@lists.linux.dev
>> Subject: More details on health monitoring notifications
>>
>>   
>>
>> Hello,
>>
>>   
>>
>> I have gotten a health monitoring thread going that tracks all the EVL threads running in my app. The goal was to try and figure out what is causing occasional in-band switches in some of my EVL threads. I am seeing the notifications now that give me a little more insight, and the two diagnostic codes I am seeing are 2 (switched inband due to syscall) and 3 (switched inband due to fault). I am finding these to be quite hard to pinpoint
>> specifically throughout my code. Is there any way to get more information into what exactly is causing these notifications from the EVL core? It would be great to have a callstack of some kind, but I am not sure if that is possible. Any insight would be helpful.
>>
>>   
>>
>> Thanks,
>>
>>   
>>
>> Russell
>>
>> [[End of S/MIME Signed Part]]
> 
> 

Hello, Philippe, could you make a small comment on the following?

The OS made a start and I executed the following commands:
leo@orangepipc2:~$ uname -a
Linux orangepipc2 5.15.52-evl.2-sunxi64 #22.07.sl SMP IRQPIPE Mon Jul 4 
09:36:12 UTC 2022 aarch64 aarch64 aarch64 GNU/Linux

leo@orangepipc2:~$ dmesg | grep EVL
[    1.200014] IRQ pipeline: high-priority EVL stage added.
[    1.203250] EVL: core started [DEBUG]

leo@orangepipc2:~$ sudo evl test
basic-xbuf: OK
....
All test exit: OK

leo@orangepipc2:~$ dmesg | grep EVL
[    1.200014] IRQ pipeline: high-priority EVL stage added.
[    1.203250] EVL: core started [DEBUG]
[  413.466523] EVL: fault:1540 switching in-band [pid=1540, excpt=0, 
__arch_copy_to_user+0x84/0x218]
[  413.466757] EVL: fault:1540 resuming out-of-band [pid=1540, excpt=0, 
__entry_tramp_text_end+0x13e8/0x11000]
[  413.466793] EVL: fault:1540 switching in-band [pid=1540, excpt=0, 
__entry_tramp_text_end+0x13f4/0x11000]
[  413.466847] EVL: fault:1540 resuming out-of-band [pid=1540, excpt=0, 
__entry_tramp_text_end+0x13fc/0x11000]
[  413.466874] EVL: fault:1540 switching in-band [pid=1540, excpt=0, 
user_pc=0xaaaacc4f0cb8]

-- 
Leonid Gasheev
