Message-ID: <4D9F0B86.30103@domain.hid>
Date: Fri, 8 Apr 2011 15:20:06 +0200
From: Jesper Christensen <jbc@domain.hid>
MIME-Version: 1.0
References: <4D9F0679.7080109@domain.hid> <1302268379.2101.35.camel@domain.hid>
In-Reply-To: <1302268379.2101.35.camel@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] kernel threads crash
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Thanks i'll give 2.5.6 a shot.

Also it has come to my attention that there is some source files
(arch/powerpc/platforms/85xx/cpci6200.c,
arch/powerpc/platforms/85xx/cpci6200.h,
arch/powerpc/platforms/85xx/cpci6200_timer.c) that are probably not
covered by the adeos patch. Am i correct in assuming these need some
work to support i-pipe?

/Jesper


On 2011-04-08 15:12, Philippe Gerum wrote:
> On Fri, 2011-04-08 at 14:58 +0200, Jesper Christensen wrote:
>   
>> Hi
>>
>> I'm trying to implement some gateway functionality in the kernel on a
>> emerson CPCI6200 board, but have run into some strange errors. The
>> kernel module is made up of two threads that run every 1 ms. I have also
>> made use of the rtpc dispatcher in rtnet to dispatch control messages
>> from a netlink socket to the RT part of my kernel module.
>>
>> The problem is that when loaded the threads get suspended due to exceptions:
>>
>> Xenomai: suspending kernel thread b929cbc0 ('tt_upgw_0') at 0xb929cbc0
>> after exception #1792
>>
>> or
>>
>> Xenomai: suspending kernel thread b929cbc0 ('tt_upgw_0') at 0x0 after
>> exception #1025
>>
>> or
>>
>> Xenomai: suspending kernel thread b911f518 ('rtnet-rtpc') at 0xb911f940
>> after exception #1792
>>
>>
>> I have ported the "gianfar" driver from linux to rtnet.
>>
>> The versions and hardware are listed below. The errors are most likely
>> due to faulty software on my part, but i would like to ask if there are
>> any known issues with the versions or hardware i'm using. I would also
>> like to ask if there are any ways of further debugging the errors as i
>> am not getting very far with the above messages.
>>     
> A severe bug at kthread init was fixed in the 2.5.5.2 - 2.5.6 timeframe,
> which would cause exactly the kind of weird behavior you are seeing
> right now. The bug triggered random code execution due to stack memory
> pollution at init on powerpc for Xenomai kthreads:
> http://git.xenomai.org/?p=xenomai-rpm.git;a=commit;h=90699565cbce41f2cec193d57857bb5817efc19a
> http://git.xenomai.org/?p=xenomai-rpm.git;a=commit;h=da20c20d4b4d892d40c657ad1d32ddb6d0ceb47c
> http://git.xenomai.org/?p=xenomai-rpm.git;a=commit;h=a5886b354dc18f054b187b58cfbacfb60bccaf47
>
> You need at the very least those three patches (from the top of my
> head), but it would be much better to upgrade to 2.5.6.
>
>   
>>
>>
>> System info:
>>
>> Linux kernel: 2.6.29.6
>> i-pipe version: 2.7-04
>> processor: powerpc mpc8572
>> xenomai version: 2.5.3
>> rtnet version: 0.9.12
>>
>>     
>   


