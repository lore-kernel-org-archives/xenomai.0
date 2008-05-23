Message-ID: <4836C147.8020300@domain.hid>
Date: Fri, 23 May 2008 15:06:15 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <60078.189.4.74.190.1209348044.squirrel@domain.hid>	<481580F2.9090707@domain.hid>
	<4815BFDA.1040904@domain.hid>	<4815C3A5.1020606@domain.hid>
	<4815C937.6000700@domain.hid>	<4815D4B1.8040207@domain.hid>
	<481682B8.4050104@domain.hid>	<4816BF96.6010400@domain.hid>	<57472.150.162.12.153.1209499591.squirrel@domain.hid>	<48180F67.4080809@domain.hid>
	<482B8494.7050009@domain.hid>	<482BD2D4.5070408@domain.hid>
	<482C922E.1080002@domain.hid>	<482C9719.1080803@domain.hid>
	<482CA5B9.3030203@domain.hid>	<482CA862.9070105@domain.hid>
	<482D988A.8040503@domain.hid>	<48328F76.4090603@domain.hid>
	<4833A8F5.5070109@domain.hid>	<4834344E.4090706@domain.hid>	<48344261.2060102@domain.hid>
	<4834501C.30709@domain.hid>	<48345105.1060008@domain.hid>
	<48353FC2.3060708@domain.hid>	<49280.189.58.74.62.1211542371.squirrel@domain.hid>
	<4836AFD3.1090402@domain.hid>
In-Reply-To: <4836AFD3.1090402@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [Socketcan-users] RT - Socketcan
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>, breno@domain.hid

Wolfgang Grandegger wrote:
> breno@domain.hid wrote:
>>> Breno wrote:
>>>> Wolfgang Grandegger wrote:
>>>>> Breno wrote:
>>>>>
>>>>>> Wolfgang Grandegger wrote:
>>>>>>
>>>>>>> Breno wrote:
>>>>>>>
>>>>>>>
>>>>>>>> Hi Wolfgang, I got the cannetdriver26 as you suggested some e-mail
>>>>>>>> ago. Sorry my ignorance but how can I get it working o my kernel. I
>>>>>>>> mentioned before that you have a script do get it build. Could you
>>>>>>>> help me again on this issue?
>>>>>>>>
>>>>>>> For what kernel?
>>>>>>>
>>>>>>> Wolfgang.
>>>>>>>
>>>>>> Hi Wolfgang, I got a DENX Linux 2.6 Kernel Tree from DENX project.
>>>>>> The last
>>>>>> commit I have is:
>>>>>>
>>>>>> commit 76e8fbcc9e3e928a6898a93e6077264f5cb8f432
>>>>>>   Author: Wolfgang Grandegger <wolf@domain.hid>
>>>>>>   Date:   Thu Mar 27 17:41:09 2008 +0100
>>>>>>
>>>>>>   Socket-CAN: merge with SVN trunk revision 690
>>>>>>
>>>>> Can you use linux-2.6.25.4 from kernel.org for your hardware?
>>>>>
>>>>> Wolfgang.
>>>>>
>>>> But it doesn't have support for Xenomai, rigth? If so, which version
>>>> should I use?
>>> You are right, an ADEOS i-Pipe patch is not yet avaliable for 2.6.25.
>>> Just to understand your requirements. You want to use the Xenomai
>>> real-time extension because you have hard real-time requirements, right?
>>> Do you want to access the CAN bus from a Xenomai real-time task? If yes,
>>> then you should use RT-Socket-CAN.
>>>
>>>> Anyway,I got the Denx-2.6.25 and I wanna configure it on my system
>>>> regardless of this
>>>> version doesn't have Xenomai support. To get an correct kernel image on
>>>> my
>>>> present tree(2.6.24-commit 76e8fbcc9e3e928a6898a93e6077264f5cb8f432 ) I
>>>> executed make lite5200_defconfig, at the kernel option and I set
>>>> lite5200.dts
>>>> and then do make zImage. That new tree seems have some differences, do
>>>> you
>>>> know what commands do I have to execute? I'm using lite5200 powerpc
>>>> board.
>>> It does not make sense to switch to 2.6.25 now if you have real-time
>>> requirements. Please stop jumping from one setup to another. If
>>> something is not working, I'm willing to help.
>>>
>>> Wolfgang.
>>>
>> Hi Wolfgang, thanks for your support. I'm intending to use CAN along with
>> rt-tasks. I had dropped the rt-socket CAN because of the error it appears
>> when I send messages as explained some e-mails ago. For example:
>>
>> ./rtcanconfig rtcan0 -b100000 start ---> works properly!
>> ./rtcanrecv rtcan1 &
>> ./rtcansend rtcan0 -i0x123 1 2 3 4 5 6 7 8
>> #0 [8] <0x123> 00 00 00 04 05 06 07 08 ---> it seems to lose the threes
>> first data.
> 
> Then let's try to fix that. Have you built and ran rtcansend and
> rtcanrecv as I suggested (the one created by "$ make" in the Xenomai top
> directory)? Did it make a difference?
> 
> Do you see errors when you use the rtcanrecv option "-e 0xffff"?
> 
>    ./rtcanrecv -e 0xffff rtcan1
> 
>> My socket-can applications works perfectly!!!
> 
> Fine, but it's not useful to call Socket-CAN from an Xenomai real-time
> application. You will loose determinism.
> 
> And we should continue this thread with CC to the Xenomai-help mailing
> list because it might be useful for others as well.

Maybe there is something wrong with your MSCAN clock settings.

What frequency have you specified for
CONFIG_XENO_DRIVERS_CAN_MSCAN_CLOCK (check your kernel .config)?

And what MPC5200 CPU do you have? Could you show use the initial output
of your bootloader?

Wolfgang.






