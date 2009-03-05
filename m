Message-ID: <49B0132F.5020000@domain.hid>
Date: Thu, 05 Mar 2009 19:00:15 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <67b6b3430903041631p107682bdyf5d5fb9c0e70d86d@domain.hid>
	<49AFA197.9090704@domain.hid>
	<27BF0F57-FF6F-458D-9974-0A8FA991D02E@comcast.net>
In-Reply-To: <27BF0F57-FF6F-458D-9974-0A8FA991D02E@comcast.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] ipipe error
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <steven.seeger@domain.hid>
Cc: xenomai@xenomai.org

Steven Seeger wrote:
> Mark has CONFIG_FRAME_POINTER enabled. We removed the calls to 
> rt_task_set_mode() and the problems went away. Again, I have no idea why 
> they are even there. I will blame Mark because it is convenient.
>

There must be an issue in rt_task_set_mode() when clearing T_PRIMARY anyway. 
Will reproduce and fix.

> Steven
> 
> On Mar 5, 2009, at 4:55 AM, Philippe Gerum wrote:
> 
>> Mark Saiia wrote:
>>> When running 2.6.27.19 w/ Xenomai 2.4.7 on a geode board, I get the
>>> following in the log. I haven't done any debugging yet, but wanted to
>>> see if anyone else has this issue.  It results in some of the
>>> application threads not being responsive, while others are still
>>> running.
>>>
>>
>> Is CONFIG_FRAME_POINTER enabled for your kernel, i.e. can we trust the 
>> backtrace
>> below?
>>
>> Additionally, what happens if you stop asking rt_task_set_mode() to clear
>> primary mode via toggling the T_PRIMARY flag? (which you should very 
>> likely NOT
>> do, btw. Forcing the current mode is counter-productive most of the 
>> time; this
>> is an internal feature for very, very specific needs of some Xenomai 
>> library code).
>>
>>>     ar  5 15:08:22 (none) user.err kernel: I-pipe: Detected illicit call
>>> from domain 'Xenomai'
>>> Mar  5 15:08:22 (none) user.err kernel:         into a service
>>> reserved for domain 'Linux' and below.
>>> Mar  5 15:08:22 (none) user.warn kernel: Pid: 990, comm: main thread
>>> Not tainted 2.6.27.19-standard-xenomai #1
>>> Mar  5 15:08:22 (none) user.warn kernel:  [<c0146d3d>]
>>> ipipe_check_context+0x8d/0xb0
>>> Mar  5 15:08:22 (none) user.warn kernel:  [<c0115535>]
>>> sub_preempt_count+0x15/0x80
>>> Mar  5 15:08:22 (none) user.warn kernel:  [<c0115e1e>]
>>> finish_task_switch+0x2e/0x80
>>> Mar  5 15:08:22 (none) user.warn kernel:  [<c01172ba>]
>>> ipipe_reenter_root+0x1a/0x60
>>> Mar  5 15:08:22 (none) user.warn kernel:  [<c0155a2d>] 
>>> xnshadow_relax+0x9d/0x100
>>> Mar  5 15:08:22 (none) user.warn kernel:  [<c015e9b7>]
>>> __rt_task_set_mode+0x67/0x90
>>> Mar  5 15:08:22 (none) user.warn kernel:  [<c0155dd7>]
>>> losyscall_event+0xb7/0x170
>>> Mar  5 15:08:22 (none) user.warn kernel:  [<c0155d20>] ?
>>> losyscall_event+0x0/0x170
>>> Mar  5 15:08:22 (none) user.warn kernel:  [<c0148150>]
>>> __ipipe_dispatch_event+0xd0/0x220
>>> Mar  5 15:08:22 (none) user.warn kernel:  [<c010d54a>]
>>> __ipipe_syscall_root+0x3a/0xe0
>>> Mar  5 15:08:22 (none) user.warn kernel:  [<c010320b>] 
>>> system_call+0x2b/0x4c
>>> Mar  5 15:08:22 (none) user.warn kernel:  =======================
>>> Mar  5 15:08:22 (none) user.warn kernel: ------------[ cut here 
>>> ]------------
>>> Mar  5 15:08:22 (none) user.warn kernel: WARNING: at
>>> kernel/sched.c:4322 sub_preempt_count+0x7d/0x80()
>>> Mar  5 15:08:22 (none) user.warn kernel: Modules linked in: ipv6
>>> eepro100 mii genrtc usb_storage nls_iso8859_1 nls_cp437
>>> Mar  5 15:08:22 (none) user.warn kernel: Pid: 990, comm: main thread
>>> Not tainted 2.6.27.19-standard-xenomai #1
>>> Mar  5 15:08:22 (none) user.warn kernel:  [<c011b746>]
>>> warn_on_slowpath+0x46/0x60
>>> Mar  5 15:08:22 (none) user.warn kernel:  [<c010320b>] ? 
>>> system_call+0x2b/0x4c
>>> Mar  5 15:08:22 (none) user.warn kernel:  [<c011cc71>] ? 
>>> printk+0x41/0x180
>>> Mar  5 15:08:22 (none) user.warn kernel:  [<c0103c85>] ?
>>> show_trace_log_lvl+0x25/0x30
>>> Mar  5 15:08:22 (none) user.warn kernel:  [<c0101e5a>] ? 
>>> __switch_to+0xa/0x150
>>> Mar  5 15:08:22 (none) user.warn kernel:  [<c0146d42>] ?
>>> ipipe_check_context+0x92/0xb0
>>> Mar  5 15:08:22 (none) user.warn kernel:  [<c0115535>] ?
>>> sub_preempt_count+0x15/0x80
>>> Mar  5 15:08:22 (none) user.warn kernel:  [<c011559d>]
>>> sub_preempt_count+0x7d/0x80
>>> Mar  5 15:08:22 (none) user.warn kernel:  [<c0115e1e>]
>>> finish_task_switch+0x2e/0x80
>>> Mar  5 15:08:22 (none) user.warn kernel:  [<c01172ba>]
>>> ipipe_reenter_root+0x1a/0x60
>>> Mar  5 15:08:22 (none) user.warn kernel:  [<c0155a2d>] 
>>> xnshadow_relax+0x9d/0x100
>>> Mar  5 15:08:22 (none) user.warn kernel:  [<c0155e08>]
>>> losyscall_event+0xe8/0x170
>>> Mar  5 15:08:22 (none) user.warn kernel:  [<c0155d20>] ?
>>> losyscall_event+0x0/0x170
>>> Mar  5 15:08:22 (none) user.warn kernel:  [<c0148150>]
>>> __ipipe_dispatch_event+0xd0/0x220
>>> Mar  5 15:08:22 (none) user.warn kernel:  [<c010d54a>]
>>> __ipipe_syscall_root+0x3a/0xe0
>>> Mar  5 15:08:22 (none) user.warn kernel:  [<c010320b>] 
>>> system_call+0x2b/0x4c
>>> Mar  5 15:08:22 (none) user.warn kernel:  =======================
>>> Mar  5 15:08:22 (none) user.warn kernel: ---[ end trace 
>>> 37b08dd71b141ea9 ]---
>>> Mar  5 15:08:22 (none) user.emerg rtlogd: : StopScan()
>>>
>>> Thanks,
>>>
>>> Mark
>>>
>>> _______________________________________________
>>> Xenomai-help mailing list
>>> Xenomai-help@domain.hid
>>> https://mail.gna.org/listinfo/xenomai-help
>>>
>>
>>
>> -- 
>> Philippe.
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
> 
> 


