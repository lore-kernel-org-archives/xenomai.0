Subject: Re: ARM: switchtest fails
References: <25f3e78c-c294-1322-4206-204dfaa48b8a@rsi-elektrotechnik.de>
 <CALLqZ8SW=nD8gp52C_1--Kgvcfi6k72iXVRjgmqRve=Nj=ysPQ@mail.gmail.com>
 <be5b1549-897a-33f5-a80a-d3ae84e58cfe@rsi-elektrotechnik.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <48cd664a-7b1a-edef-d78a-5008d34ad534@siemens.com>
Date: Mon, 13 Jul 2020 19:08:41 +0200
MIME-Version: 1.0
In-Reply-To: <be5b1549-897a-33f5-a80a-d3ae84e58cfe@rsi-elektrotechnik.de>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Leupold <leupold@rsi-elektrotechnik.de>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 09.07.20 17:22, Jan Leupold via Xenomai wrote:
> Hi Greg,
> 
> Am 02.07.20 um 14:07 schrieb Greg Gallagher:
>>
>>
>> On Thu., Jul. 2, 2020, 6:16 a.m. Jan Leupold via Xenomai
>> <xenomai@xenomai.org <mailto:xenomai@xenomai.org>> wrote:
>>
>>      Hi,
>>
>>      I have a problem with switchtest, executed on sama5d2,
>>      ipipe-4.19.128-cip28, xenomai-3.1.
>>
>>      When started without arguments:
>>      == Testing FPU check routines...
>>      d0: 1 != 2
>>      ... snip ...
>>      d15: 1 != 2
>>      == FPU check routines: OK.
>>      == Threads: sleeper_ufps-0 rtk-1 rtk-2 rtk_fp-3 rtk_fp-4 rtk_fp_ufpp-5
>>      rtk_fp_ufpp-6 rtup-7 rtup-8 rtup_ufpp-9 rtup_ufpp-10 rtus-11 rtus-12
>>      rtus_ufps-13 rtus_ufps-14 rtuo-15 rtuo-16 rtuo_ufpp-17 rtuo_ufpp-18
>>      rtuo_ufps-19 rtuo_ufps-20 rtuo_ufpp_ufps-21 rtuo_ufpp_ufps-22
>>      RTT|  00:00:00
>>      RTH|ctx switches|-------total
>>      RTD|          25|          25
>>
>>      no more output, exit status = 1
>>
>>      When started as "switchtest -n":
>>
>>      == Threads: sleeper-0 rtk-1 rtk-2 rtup-3 rtup-4 rtus-5 rtus-6 rtuo-7 rtuo-8
>>      RTT|  00:00:01
>>      RTH|ctx switches|-------total
>>      RTD|        4295|        4295
>>      RTD|        4316|        8611
>>      RTD|        4279|       12890
>>      RTD|        4316|       17206
>>      RTD|        4313|       21519
>>      ^C
>>      RTD|        1215|       22734
>>
>>      deliberately terminated by CTRL-C, exit status = 0
>>
>>      Any threadspec of rtus_ufps, rtup_ufpp or rtuo_ufpp will cause the effect.
>>      When looking at the source code I would suspect "fp_regs_set()" to
>>      cause it.
>>      The kernel log reports messages like this one:
>>      [Xenomai] rtup_ufpp-1[1599] called regular ioctl() on /dev/rtdm/switchtest
>>
>>      While I have no reason to think that floating point operations are not
>>      OK on this target I would like to at least know why switchtest fails
>>      when using floating point:
>>      * VFP initialization with respect to register access?
>>      * Number of floating point registers? (although NEON should have more than
>>        the tested 16)
>>      * Any ideas?
>>
>>      Regards,
>>      Jan
>>
>>      Some more details:
>>
>>      CONFIG_VFP, CONFIG_VFPv3 and CONFIG_NEON are set.
>>
>>      trace-cmd record -e cobalt* -e sched* -e signal*
>>      switchtest
>>      trace-cmd report
>>      ---> output (at least the portion that seems to me relevant):
>>
>>      ... switchtest threads are doing their work, and then comes rtup-ufpp-9 ...
>>           rtup-8-1538  [000]   135.112086: cobalt_switch_context:
>>      prev_name=rtup-8 prev_pid=1538 prev_prio=1 prev_state=0x48042 ==>
>>      next_name=rtup_ufpp-9 next_pid=1539 next_prio=1
>>           rtup_ufpp-9-1539  [000]   135.112129: cobalt_head_sysexit:  result=0
>>           rtup_ufpp-9-1539  [000]   135.112154: cobalt_head_sysentry:
>>      syscall=ioctl
>>           rtup_ufpp-9-1539  [000]   135.112170: cobalt_fd_ioctl:
>>      device=0xc0b7a988 fd=3 arg=0x9 pid=1539 comm=rtup_ufpp-9
>>           rtup_ufpp-9-1539  [000]   135.112192: cobalt_fd_ioctl_status:
>>      device=0xc0b7a988 fd=3 pid=1539 comm=rtup_ufpp-9
>>           rtup_ufpp-9-1539  [000]   135.112207: cobalt_shadow_gorelax:
>>      reason=syscall
>>           rtup_ufpp-9-1539  [000]   135.112221: cobalt_lostage_request:
>>      request=c090b004 pid=1539 comm=rtup_ufpp-9
>>           rtup_ufpp-9-1539  [000]   135.112240: cobalt_thread_suspend: pid=1539
>>      mask=0x80 timeout=0 timeout_mode=0 wchan=(nil)
>>           rtup_ufpp-9-1539  [000]   135.112254: cobalt_schedule:
>>      status=0x10000000
>>           rtup_ufpp-9-1539  [000]   135.112262: cobalt_switch_context:
>>      prev_name=rtup_ufpp-9 prev_pid=1539 prev_prio=1 prev_state=0x480c0 ==>
>>      next_name=ROOT next_pid=0 next_prio=-1
>>            switchtest-1530  [000]   135.112308: cobalt_lostage_wakeup: pid=1539
>>      comm=rtup_ufpp-9
>>            switchtest-1530  [000]   135.112329: sched_waking:
>>      comm=rtup_ufpp-9 pid=1539 prio=98 target_cpu=000
>>            switchtest-1530  [000]   135.112380: sched_wakeup:
>>      rtup_ufpp-9:1539 [98] success=1 CPU:000
>>            switchtest-1530  [000]   135.112450: sched_stat_runtime:
>>      comm=switchtest pid=1530 runtime=3009028 [ns] vruntime=22563904956 [ns]
>>            switchtest-1530  [000]   135.112489: sched_switch:
>>      switchtest:1530 [120] R ==> rtup_ufpp-9:1539 [98]
>>           rtup_ufpp-9-1539  [000]   135.112561: cobalt_shadow_relaxed:
>>      state=0x480c0 info=0x0
>>           rtup_ufpp-9-1539  [000]   135.112581: cobalt_fd_ioctl:
>>      device=0xc0b7a988 fd=3 arg=0x9 pid=1539 comm=rtup_ufpp-9
>>           rtup_ufpp-9-1539  [000]   135.112602: cobalt_fd_ioctl_status:
>>      device=0xc0b7a988 fd=3 pid=1539 comm=rtup_ufpp-9
>>           rtup_ufpp-9-1539  [000]   135.112614: cobalt_head_sysexit:  result=-38
>>           rtup_ufpp-9-1539  [000]   135.112997: sched_waking:
>>      comm=switchtest pid=1527 prio=120 target_cpu=000
>>           rtup_ufpp-9-1539  [000]   135.113036: sched_wakeup:
>>      switchtest:1527 [120] success=1 CPU:000
>>           rtup_ufpp-9-1539  [000]   135.113055: signal_generate:      sig=15
>>      errno=0 code=-6 comm=switchtest pid=1527 grp=0 res=0
>>           rtup_ufpp-9-1539  [000]   135.113204: sched_switch:
>>      rtup_ufpp-9:1539 [98] S ==> switchtest:1527 [120]
>>            switchtest-1527  [000]   135.113621: sched_waking:
>>      comm=switchtest pid=1530 prio=120 target_cpu=000
>>            switchtest-1527  [000]   135.113656: sched_stat_runtime:
>>      comm=switchtest pid=1527 runtime=492337 [ns] vruntime=22561734482 [ns]
>>            switchtest-1527  [000]   135.113684: sched_wakeup:
>>      switchtest:1530 [120] success=1 CPU:000
>>            switchtest-1527  [000]   135.113697: signal_generate:      sig=32
>>      errno=0 code=-6 comm=switchtest pid=1530 grp=0 res=0
>>            switchtest-1527  [000]   135.113805: cobalt_thread_unblock: pid=1537
>>      state=0x48042 info=0x0
>>            switchtest-1527  [000]   135.113820: cobalt_thread_resume:
>>      name=rtup-7 pid=1537 mask=0x2
>>            switchtest-1527  [000]   135.113837: cobalt_synch_forget:
>>      synch=0xd92e00e0
>>            switchtest-1527  [000]   135.113872: cobalt_schedule_remote:
>>      status=0x10000000
>>            switchtest-1527  [000]   135.113880: cobalt_schedule:
>>      status=0x10000000
>>            switchtest-1527  [000]   135.113893: cobalt_switch_context:
>>      prev_name=ROOT prev_pid=0 prev_prio=-1 prev_state=0x18008 ==>
>>      next_name=rtup-7 next_pid=1537 next_prio=1
>>                rtup-7-1537  [000]   135.113948: cobalt_fd_ioctl_status:
>>      device=0xc0b7a988 fd=3 pid=1537 comm=rtup-7
>>                rtup-7-1537  [000]   135.113972: cobalt_shadow_gorelax:
>>      reason=signal
>>                rtup-7-1537  [000]   135.113985: cobalt_lostage_request:
>>      request=c090b004 pid=1537 comm=rtup-7
>>                rtup-7-1537  [000]   135.113999: cobalt_thread_suspend: pid=1537
>>      mask=0x80 timeout=0 timeout_mode=0 wchan=(nil)
>>                rtup-7-1537  [000]   135.114013: cobalt_schedule:
>>      status=0x10000000
>>                rtup-7-1537  [000]   135.114021: cobalt_switch_context:
>>      prev_name=rtup-7 prev_pid=1537 prev_prio=1 prev_state=0x480c0 ==>
>>      next_name=ROOT next_pid=0 next_prio=-1
>>
>>
>>      Mit freundlichen Grüßen
>>
>>      *Jan Leupold*
>>      Entwicklung
>>      Development
>>      --
>>
>> I can take a look and see if I can reproduce on another arm platform. I'm
>> not too familiar with this test but I'll run it and see if there's anything
>> unusual on the ipipe side of things.
>>
>> -Greg
>>
> 
> Thanks for trying it out on other platforms! I think I found a way now
> to get switchtest working:
> When I use DEFAULTTUNE="cortexa5thf-neon-vfpv4" (in yocto) instead of
> "cortexa5thf", it executes without any problems on my target.

I'm not an expert in the semantics of these tuning - do they make sense 
as well, or are we still facing a not fully understood issue here?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

