Message-ID: <4DBAFFBE.7040900@domain.hid>
Date: Fri, 29 Apr 2011 20:13:18 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <BANLkTi=UuSsFMmin_vGQFp3-vn=7JVT8Cg@domain.hid>	<1303941212.1932.38.camel@domain.hid>	<BANLkTimc7+mvdqosEw+1YGonxKYUQnrcsA@mail.gmail.com>	<BANLkTikG9UFeR0C69oh+=umQLJN2Zva3dQ@mail.gmail.com>	<1304066654.2845.12.camel@domain.hid>
	<BANLkTim+cY=KkurCjqUTTNt-Ocv7ZUQd6A@mail.gmail.com>
In-Reply-To: <BANLkTim+cY=KkurCjqUTTNt-Ocv7ZUQd6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PowerPC]Badness at mmu_context_nohash
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jean-Michel Hautbois <jhautbois@domain.hid>
Cc: xenomai@xenomai.org

On 2011-04-29 18:08, Jean-Michel Hautbois wrote:
> 2011/4/29 Philippe Gerum <rpm@xenomai.org>:
>> On Thu, 2011-04-28 at 10:33 +0200, Jean-Michel Hautbois wrote:
>>> 2011/4/27 Philippe Gerum <rpm@xenomai.org>:
>>>> On Wed, 2011-04-27 at 20:42 +0200, Jean-Michel Hautbois wrote:
>>>>> Hi list,
>>>>>
>>>>> I am currently using a Xenomai port on a linux 2.6.35.11 linux kernel
>>>>> and the adeos-ipipe-2.6.35.7-powerpc-2.12-01.patch.
>>>>> I am facing a scheduling issue on a P2020 (dual core PowerPC), and I
>>>>> get the following message :
>>>>>
>>>>> Badness at arch/powerpc/mm/mmu_context_nohash.c:209
>>>>> NIP: c0018d20 LR: c039b94c CTR: c00343e4
>>>>> REGS: ecfadce0 TRAP: 0700   Tainted: G        W    (2.6.35.11)
>>>>> MSR: 00021000 <ME,CE>  CR: 24000488  XER: 00000000
>>>>> TASK = ec5220d0[496] 'sipaq' THREAD: ecfac000 CPU: 1
>>>>> GPR00: 00000001 ecfadd90 ec5220d0 ec5df340 ec58a700 00000000 ffffffff 00000003
>>>>> GPR08: c04a2d98 00000007 c04a2d98 0067e000 0002f385 1007f1f8 c04a5b40 ecfac040
>>>>> GPR16: c04a5b40 c04deb80 c04a2120 c04a2d98 c04a5b40 c04d008c ecfac000 00029000
>>>>> GPR24: c04d0000 c04d1e6c 00000001 ec58a700 eceaf390 c04d1e78 c0b23b40 ec5df340
>>>>> NIP [c0018d20] switch_mmu_context+0x80/0x438
>>>>> LR [c039b94c] schedule+0x774/0x7dc
>>>>> Call Trace:
>>>>> [ecfadd90] [44000484] 0x44000484 (unreliable)
>>>>> [ecfadde0] [c039b94c] schedule+0x774/0x7dc
>>>>> [ecfade50] [c039cb98] do_nanosleep+0xc8/0x114
>>>>> [ecfade80] [c0059bf8] hrtimer_nanosleep+0xd8/0x158
>>>>> [ecfadf10] [c0059d48] sys_nanosleep+0xd0/0xd4
>>>>> [ecfadf40] [c0013c0c] ret_from_syscall+0x0/0x3c
>>>>> --- Exception: c01 at 0xffa6cc4
>>>>>    LR = 0xffa6cb0
>>>>> Instruction dump:
>>>>> 40a2fff0 4c00012c 2f800000 409e0128 813b018c 2f830000 39290001 913b018c
>>>>> 419e0020 8003018c 7c000034 5400d97e <0f000000> 8123018c 3929ffff 9123018c
>>>>>
>>>>> Do you have a clue on how to start debugging it ?
>>>>
>>>> Yes, but that can't be easily summarized here. In short, we have a
>>>> serious problem with the sharing of the MMU context between the Linux
>>>> and Xenomai schedulers in the SMP case on powerpc.
>>>
>>> OK, good to know that it is a known issue. If there is a thread with
>>> some thoughts about it, I am interested ;).
>>>
>>>>> It is happening quite randomly... :).
>>>>
>>>> Does disabling CONFIG_XENO_HW_UNLOCKED_SWITCH clear this issue?
>>>>
>>>
>>> Well, yes and no. It starts well, but when booting the kernel I get :
>>
>>
>> The mm switch issue was specifically addressed by this patch, which is
>> part of 2.12-01:
>> http://git.denx.de/?p=ipipe-2.6.git;a=commit;h=c14a47630d62d0328de1957636dceb1d498f7048
>>
>> However, it the last 2.6.35 patch issued was based on 2.6.35.7, not
>> 2.6.35.11, so there is still the possibility that something went wrong
>> while you forward ported this code.
>>
>> - Please check that mmu_context_nohash.c does contain the fix above as
>> it should
> 
> It is ok, I have the fix.
> 
>> - Please try Richard's suggestion, i.e. moving to 2.6.36, which may give
>> us more hints.
> 
> It is better. I don't have the badness on mmu context anymore.
> This gives some hints ;).
> 
>>> Badness at kernel/lockdep.c:2327
>>> NIP: c006e554 LR: c006e53c CTR: 000186a0
>>
>> Adeos sometimes conflicts with the vanilla IRQ state tracer. I'll have a
>> look at this. Disable CONFIG_TRACE_IRQFLAGS.
> 
> Yes, but I *want* to have the CONFIG_TRACE_IRQFLAGS on. I just wanted
> to tell that I had the problem, in order to be sure it is known ;).
> 

Just found and fixed a generic TRACE_IRQFLAGS related bug, see [1].
Kernel (x86) is still unhappy about some inconsistent lock state, but
debugging this needs to wait.

Jan

[1] http://thread.gmane.org/gmane.linux.kernel.adeos.general/1807

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

