Message-ID: <4CC44C02.4050003@domain.hid>
Date: Sun, 24 Oct 2010 17:08:50 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTinN+KBK2B77opSCwDvb9bneObxL1+FTmmwpQGup@domain.hid>	<4CC20AD2.4060501@domain.hid>
	<AANLkTimyj5TRgan5nE5ey6h8-WO_-na=U66si-e9Xx9F@mail.gmail.com>
In-Reply-To: <AANLkTimyj5TRgan5nE5ey6h8-WO_-na=U66si-e9Xx9F@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Slow hard drive access in xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Pastor Sampedro <pastorsa@domain.hid>
Cc: xenomai@xenomai.org, Peter Pastor <peter.pastor@domain.hid>

Peter Pastor Sampedro wrote:
> Hey Gilles,
> 
> Thanks for you prompt response !
> 
> I noticed that the problem of slow hard disc access does happen after
> a certain event. Right after booting xenomai "hdparam -t" gives me
> 120MB/s which is what I get when running the non-real-time kernel.
> Even when I run my real-time tasks everything seems to be fine.
> However, I just had the case that I tried to play a sound (just for
> testing) which triggered some output in the dmesg (see attached
> xenomai_problem.txt). The output of dmesg up to this point is
> contained in xenomai_fine.txt and the dmesg log of the non-real-time
> linux kernel is in dmesg_linux.txt.
> 
> I disabled the audio card again and as of now, I haven't seen that
> problem. I can't really make sense out of what dmesg spit out. Would
> be great if someone could shine some light on this. It would be great
> if someone could let me know whether disabling the sound card solved
> the problem.

Does the same behaviour occur without Xenomai in the mix?

> 
>>> Do you really need things like NUMA, SPARSEMEM, SECCOMP, AUDITSYSCALL,
>>> KPROBES, FTRACE, SELINUX?
> I am actually not sure what all these options mean, I also haven't
> spend time to figure things out. What impact could disabling these
> options have ? Do they decrease latency? address the problem above?
> other things?

These are kernel options, as such, they are documented in the Linux
kernel configuration. Some of them induce overhead, yes, but most of
all, enabling all options at random makes you risk finding an option
combination which nobody else every tried.

> 
> THANKS so much,
>  peter
> 
> 
> [  424.921914] irq 16: nobody cared (try booting with the "irqpoll" option)
> [  424.921920] Pid: 0, comm: swapper Tainted: P
> 2.6.31.4-ipipe-2.5.4 #2
> [  424.921923] Call Trace:
> [  424.921925]  <IRQ>  [<ffffffff8109b966>] __report_bad_irq+0x26/0xa0
> [  424.921938]  [<ffffffff8109bb6c>] note_interrupt+0x18c/0x1d0
> [  424.921943]  [<ffffffff8109c2fd>] handle_fasteoi_irq+0xcd/0xf0
> [  424.921948]  [<ffffffff8100ef6d>] handle_irq+0x1d/0x30
> [  424.921951]  [<ffffffff8100e467>] do_IRQ+0x67/0xd0
> [  424.921956]  [<ffffffff810a1880>] __ipipe_sync_stage+0x270/0x276
> [  424.921960]  [<ffffffff8100e400>] ? do_IRQ+0x0/0xd0
> [  424.921964]  [<ffffffff810a1886>] ? __xirq_end+0x0/0x100
> [  424.921967]  [<ffffffff8100e400>] ? do_IRQ+0x0/0xd0
> [  424.921972]  [<ffffffff810a1dca>] __ipipe_walk_pipeline+0x11a/0x130
> [  424.921978]  [<ffffffff810283b5>] __ipipe_handle_irq+0x125/0x2f0
> [  424.921985]  [<ffffffff8100ca53>] common_interrupt+0x13/0x2c
> [  424.922013]  <EOI>  [<ffffffff810287d6>] ? __ipipe_halt_root+0x26/0x40
> [  424.922017]  [<ffffffff810146f5>] ? default_idle+0x75/0x170
> [  424.922020]  [<ffffffff81538db1>] ? atomic_notifier_call_chain+0x11/0x20
> [  424.922023]  [<ffffffff8100aa39>] ? cpu_idle+0x79/0xe0
> [  424.922026]  [<ffffffff81521554>] ? rest_init+0x84/0x90
> [  424.922030]  [<ffffffff818295ac>] ? start_kernel+0x3ee/0x3fa
> [  424.922032]  [<ffffffff81828af5>] ? x86_64_start_reservations+0x125/0x129
> [  424.922034]  [<ffffffff81828c0b>] ? x86_64_start_kernel+0x112/0x119
> [  424.922035] handlers:
> [  424.922036] [<ffffffff813bb180>] (usb_hcd_irq+0x0/0xb0)
> [  424.922039] [<ffffffffa0061c30>] (mpt_interrupt+0x0/0xa00 [mptbase])
> [  424.922052] [<ffffffffa0c403b0>] (azx_interrupt+0x0/0x180 [snd_hda_intel])
> [  424.922057] Disabling IRQ #16
> [  425.215050] hda-intel: IRQ timing workaround is activated for card
> #0. Suggest a bigger bdl_pos_adj.
> 
> 
> 
> 
> to recreate the problem. After booting into xenomai the hdparam -t
> gives me 120MB/s which is the same as when doing so in the
> non-real-time
> 
> On Fri, Oct 22, 2010 at 3:06 PM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>> Peter Pastor wrote:
>>> Hey there,
>>>
>>> I am running xenomai 2.5.4 on linux 2.6.31.4-ipipe. (.config is attached)
>>>
>>> The system is running fairly stable, however, the hard drive access is
>>> very slow.
>>>
>>> When running
>>> $ hdparam -tT /dev/sdh
>>>
>>> I get a access rate of around 3mb/s under xenomai. However, when I boot
>>> the regular ubuntu (non-rt) kernel I get an access rate of about 120mb/s
>>>
>>> I do not really know where to start looking for the cause of this
>>> problem. I disabled CONFIG_PCI_MSI (see config). Also, i can see that
>>> IRQ16 is shared between ioc0 (I assume that is my hard drive)
>> Nope, your hard disk controller is "ahci". The question now is to know
>> if the configuration with which you have this issue is exactly the same
>> as the non-RT one, only with Xenomai enabled. If you are in this case,
>> then please send the two boot logs.
>>
>> Also, does this happen while running any Xenomai program?
>> Do you really need things like NUMA, SPARSEMEM, SECCOMP, AUDITSYSCALL,
>> KPROBES, FTRACE, SELINUX?
>>
>>
>> --
>>                                                                Gilles.
>>


-- 
                                                                Gilles.

