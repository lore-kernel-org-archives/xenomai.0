MIME-Version: 1.0
In-Reply-To: <CACreCVKO35Xt9qgerZnw9V3GTRwnGPn_URkL+1C4ymeHUGfK5A@mail.gmail.com>
References: <CACreCVLijm5Wup7aTrRTq=SHBmEUQY5D2pYpXThWXSrGqpcuqw@mail.gmail.com>
 <20150318142119.GF24525@hermes.click-hack.org>
 <CACreCV+WajHg9wKp3HpxZ4uVdva5ADAWtOH6DDjPfWzcyNk2YQ@mail.gmail.com>
 <20150318145611.GG24525@hermes.click-hack.org>
 <CACreCV+VoYvYQbejhJ2RzU9ZJDUBExwZyRv-DFs3TzWtQvzZkg@mail.gmail.com>
 <20150325145730.GJ15125@hermes.click-hack.org>
 <CACreCVLQk_4i7OdMdOFBG6cLKxh3-qJLZGMoz9i_q4XoZPbdoA@mail.gmail.com>
 <20150325160852.GK15125@hermes.click-hack.org>
 <CACreCV+tYp1QConFh2uKWjnqVOQ4uA=xLmbyay_XT9mui0txfw@mail.gmail.com>
 <CACreCVLG=dtjriCzUUqYtOK1Pz+NqYoPFNLJZ4KrM-AccBoHPA@mail.gmail.com>
 <CACreCVKO35Xt9qgerZnw9V3GTRwnGPn_URkL+1C4ymeHUGfK5A@mail.gmail.com>
Date: Sat, 28 Mar 2015 17:05:55 +0800
Message-ID: <CACreCVLg5ufmVAK_+6P1KpYaQ0ShkkPw9m=5+A+Ao=xtA9tEDQ@mail.gmail.com>
From: GP Orcullo <kinsamanka@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Boot failure when CONFIG_XENOMAI is enabled
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, Mar 27, 2015 at 8:12 PM, GP Orcullo <kinsamanka@gmail.com> wrote:
> On Fri, Mar 27, 2015 at 6:19 PM, GP Orcullo <kinsamanka@gmail.com> wrote:
>> What happens in between the clocksource switch and head domain registration?
>>
>> [    0.090129] DMA: preallocated 4096 KiB pool for atomic coherent
>> allocations
>> [    0.095333] Switching to clocksource ipipe_tsc
>> [    0.122397] I-pipe: head domain Xenomai registered.
>> [    0.124618] Xenomai: hal/arm started.
>>
>> I'm trying to trace the code to find out where it stops. I tried
>> adding printk to to the set and request functions and the code never
>> runs when CONFIG_SMP is enabled.
>>
>> Thanks,
>>
>> GP Orcullo
>
> It gets stuck on the call to ipipe_critical_enter:
> http://git.xenomai.org/ipipe-gch.git/tree/kernel/ipipe/timer.c?id=ipipe-core-3.10.32-arm-7#n279
>
> Which then gets stuck on ipipe_send_ipi:
> http://git.xenomai.org/ipipe-gch.git/tree/kernel/ipipe/core.c?id=ipipe-core-3.10.32-arm-7#n1533
>

I've traced the issue to the ipipe_processor_id() function. It returns
the value 512 for processor 0. This value comes from cpu node property
of the DT file.

Changing ipipe_processor_id() to return 0 instead of 512 allows the
kernel to boot but it fails the switchtest regression test.

Changing the cpu0 reg value on the DT file allows the kernel to boot
and pass all the xenomai regression tests but it generates the
following warning at boot:

[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: at arch/arm/kernel/devtree.c:149
arm_dt_init_cpu_maps+0x124/0x1e0()
[    0.000000] DT /cpu 5 nodes greater than max cores 4, capping them
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 3.10.33-mmc+ #349
[    0.000000] [<c0013f3c>] (unwind_backtrace+0x0/0xf8) from
[<c00118f4>] (show_stack+0x10/0x14)
[    0.000000] [<c00118f4>] (show_stack+0x10/0x14) from [<c0022110>]
(warn_slowpath_common+0x48/0x68)
[    0.000000] [<c0022110>] (warn_slowpath_common+0x48/0x68) from
[<c0022178>] (warn_slowpath_fmt+0x30/0x40)
[    0.000000] [<c0022178>] (warn_slowpath_fmt+0x30/0x40) from
[<c02578bc>] (arm_dt_init_cpu_maps+0x124/0x1e0)
[    0.000000] [<c02578bc>] (arm_dt_init_cpu_maps+0x124/0x1e0) from
[<c0256ff4>] (setup_arch+0x5a0/0x68c)
[    0.000000] [<c0256ff4>] (setup_arch+0x5a0/0x68c) from [<c0254798>]
(start_kernel+0x7c/0x310)
[    0.000000] [<c0254798>] (start_kernel+0x7c/0x310) from
[<0020806c>] (0x20806c)
[    0.000000] ---[ end trace 1b75b31a2719ed1c ]---
[    0.000000] DT missing boot CPU MPIDR[23:0], fall back to default
cpu_logical_map

What's the proper way of fixing this?

GP Orcullo

