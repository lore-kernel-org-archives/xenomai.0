Message-ID: <491C5844.2060306@domain.hid>
Date: Thu, 13 Nov 2008 17:39:32 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <c024fefc0811120041l71143d5dic1980a06d89a1317@domain.hid>	
	<491B367A.1050207@domain.hid>
	<c024fefc0811130016u526a45a9q4f587679e75c381c@domain.hid>
In-Reply-To: <c024fefc0811130016u526a45a9q4f587679e75c381c@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai Kernel Module & Watchdogs
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Adrian Boeing <aboeing@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Adrian Boeing wrote:
> Hi Gilles,
> 
> Thank you for your reply.
> 
> Not necessarily, the same priority scale is available in kernel-space
>> and user-space. However, are you aware that Xenomai already has a
>> watchdog? It is selectable in Linux configuration once linux sources
>> have been prepared.
> 
> 
> Yes, I saw it mentioned in an older version of the documentation, however I
> was unable to find the option. (The documentation mentions 'expert mode' in
> the 'general' menu - I was not able to find it.)

You need to enable xenomai debugging.

> 
> I would like to create a watchdog that watches my other real & non-realtime
> threads to make sure they are not starved/stuck/error etc. and reset them if
> necessary.
> 
> The documentation on 'alarm' mentions "Create an alarm object from kernel
> space". So I assumed they must be created in a kernel module.

No, as can be seen in the documentation, there are two rt_alarm_create
functions, one for user-space, one for kernel-space

> 
> 
>> 2. How do I create a kernel module? (what is the compiler command?)
>>
>> This question is off-topic on Xenomai mailing list, it is not related to
>> xenomai at all. But you have to get the module compiled by Linux kernel
>> makefiles. See Documentation/kbuild/modules.txt in the kernel sources.
> 
> 
> Thanks for the hints. One of the examples in the Xenomai documentation is
> "kernel_task.c"
> How should I compile and run this example? I assumed it was a kernel module.
> 
> This is how I compile it at the moment:
> gcc -I/usr/include/xenomai -D_GNU_SOURCE -D_REENTRANT -D__XENO__
> -L/usr/lib -lpthread  -lnative -Xlinker -rpath -Xlinker /usr/lib  -c kmod.c
> 
> Try to run it:
> sudo insmod ./kmod.o
> 
> I get this error:
> insmod: error inserting './kmod.o': -1 Invalid module format

I repeat myself: "you have to get the module compiled by Linux kernel
makefiles. See Documentation/kbuild/modules.txt in the kernel sources."

Please do not drop the mailing list from the CC.

-- 
                                                 Gilles.

