Message-ID: <54C772AB.7010909@colgp.it>
Date: Tue, 27 Jan 2015 12:12:43 +0100
From: Luca Galvagno <luca.galvagno@colgp.it>
MIME-Version: 1.0
References: <54C760BC.7040301@colgp.it> <54C76713.2010904@xenomai.org>
 <54C76931.9080905@colgp.it> <54C76BB0.8060304@xenomai.org>
In-Reply-To: <54C76BB0.8060304@xenomai.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Linux scheduling is hijacked from xenomai scheduling
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

Hi Philippe,
we checked the kernel options you suggested and they are in line with 
what you said.
When the system hangs we have the following log on console :

[  391.382182] Unable to handle kernel paging request for instruction fetch
[  391.462985] Faulting instruction address: 0x00000000
[  391.522787] Oops: Kernel access of bad area, sig: 11 [#1]
[  391.587824] PREEMPT mpx5200
[  391.621391] last sysfs file:
[  391.657063] Modules linked in: rt_tmrint rtspic rt_rtc_mpc5200 
rt_mpc52xx_uart rt_gpio rt_extint rt_drdy e1000 rtc_pcf8563
[  391.790298] NIP: 00000000 LR: c005a6f8 CTR: 00000000
[  391.850099] REGS: c3381be0 TRAP: 0400   Not tainted  (2.6.34)
[  391.919336] MSR: 20001032 <ME,IR,DR>  CR: 28042222  XER: 00000000
[  391.992778] TASK = c3261580[942] 'IEC8_1' THREAD: c3380000
[  392.056779] GPR00: 00000000 c3381c90 c3261580 00000202 00000000 
c0356d30 00000010 00000002
[  392.157477] GPR08: c0356d70 00000000 c0356d34 c0357648 88042222 
101e70f0 00000001 c0350000
[  392.258176] GPR16: c0380000 c3381f50 c03874c0 c0370000 00000040 
fffffff0 00000001 c036ef64
[  392.358880] GPR24: 00300180 00004080 c03874c0 c0360000 c0356d20 
c03874c0 00000202 00004040
[  392.461675] Call Trace:
[  392.491051] [c3381c90] [c005a6f8] 0xc005a6f8 (unreliable)
[  392.556096] [c3381cb0] [c000ab8c] 0xc000ab8c
[  392.607501] [c3381ce0] [c000ac34] 0xc000ac34
[  392.658905] [c3381cf0] [c0012bec] 0xc0012bec
[  392.710310] --- Exception: 901 at 0xc005ab58
[  392.710319]     LR = 0xc005ab3c
[  392.799476] [c3381dd0] [c0060840] 0xc0060840
[  392.850881] [c3381e00] [c006921c] 0xc006921c
[  392.902285] [c3381ea0] [c00697a8] 0xc00697a8
[  392.953689] [c3381ed0] [c005b9a0] 0xc005b9a0
[  393.005094] [c3381f20] [c000ae68] 0xc000ae68
[  393.056499] [c3381f40] [c001224c] 0xc001224c
[  393.107904] --- Exception: c01 at 0xfdc8618
[  393.107913]     LR = 0xfdc8604
[  393.194968] Instruction dump:
[  393.230635] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 
XXXXXXXX XXXXXXXX
[  393.323993] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 
XXXXXXXX XXXXXXXX
[  393.417358] ---[ end trace 37b9aa07d9779bd0 ]---
[  393.484646] note: IEC8_1[942] exited with preempt_count 2

Thanks
Regards

Luca Galvagno

On 27/01/2015 11:42, Philippe Gerum wrote:
> On 01/27/2015 11:32 AM, Luca Galvagno wrote:
>> Hi Philippe,
>> we are trying  2.6.4 and 2.5.6 xenomai versions.
>> Moreover in the past we did not have the problem with kernel 2.6.23.14,
>> Adeos adeos-ipipe-2.6.23-powerpc-DENX-2.0-09.patch , xenomai 2.4.6.1
> That's the story of a hacker's life: bugs come and go unexpectedly, and
> much time is spent understanding the reason for such frustrating
> transitions.
>
> Anyway, do you have OPT_PRIOCPL off in your Xenomai configuration? If
> set, you should disable it.
>
> In addition, you should check whether OPT_WATCHDOG is turned on. Your
> pipeline patch is way too old to support the lockup recovery feature
> available with 2.6.4, but at least you would have some feedback on your
> console if a rt task is spinning continuously.
>
>> thanks
>> Regards
>>
>> Luca Galvagno
>>
>> On 27/01/2015 11:23, Philippe Gerum wrote:
>>> On 01/27/2015 10:56 AM, Luca Galvagno wrote:
>>>> Hi to all,
>>>> we are using kernel 2.6.34 with the corresponding ADEOS patch
>>> Which Xenomai release?
>>>
>>>> (2.6.34-powerpc-2.10-03.patch ) and Xenomai on a PowerPC MPC5200b.
>>> 4 years old kernel and pipeline patch, don't expect much feedback on
>>> this configuration.
>>>
>>>> We are facing on a strange behavior when mixing Linux SysCalls with
>>>> Xenomai tasks . The effect of the above mix is that the "pure" (without
>>>> linux syscall) xenomai task continues to run , the remaining "mixed"
>>>> task (for example we have one with a posix socket server) and moreover
>>>> the linux os itself are not scheduled anymore. Specifically, to test
>>>> this behavior, we connected an oscilloscope to a cpu pin , the result is
>>>> that the xenomai task is moving the pin up and down (as it was
>>>> programmed) but the linux machine is neither accessible via ping or via
>>>> SSH.
>>>>
>>>> Do you have some suggestions, or some tests we can do ?
>>> Xenomai starving the regular kernel from CPU cycles until all the
>>> pending real-time duties have been carried out is the basic idea behind
>>> the dual kernel design, this is nothing strange.
>>>
>>> Now the question is: why does your real-time code seem to never complete
>>> its work loop, and there never leaves some CPU time to linux?
>>>
>>
>


