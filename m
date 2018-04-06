References: <6aedc4bc-74b5-4a9f-5c38-036a3d7850b9@siemens.com>
 <ee7647d4-0bfd-0933-2f10-e9fdc5da2880@web.de>
 <54cd6098-3828-b028-3328-daf91b46d9da@xenomai.org>
 <1edf5dcb-bc63-2f53-f91b-f821b244563c@web.de>
 <fd85297e-17eb-add4-619e-234f7602dc44@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <0fb957ac-ae49-2d57-9f83-8a61201b1fb1@siemens.com>
Date: Fri, 6 Apr 2018 15:38:55 +0200
MIME-Version: 1.0
In-Reply-To: <fd85297e-17eb-add4-619e-234f7602dc44@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] 4.9 for x86 issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2018-04-06 08:54, Philippe Gerum wrote:
> On 04/05/2018 10:13 PM, Jan Kiszka wrote:
>> On 2018-03-27 15:12, Philippe Gerum wrote:
>>> On 03/10/2018 11:06 PM, Jan Kiszka wrote:
>>>> On 2018-03-09 08:51, Jan Kiszka wrote:
>>>>> 4.9 requires more work, I've pushed the beginning to wip/4.9 in the same
>>>>> repo.
>>>>
>>>> I started to patch further on this during my flight (wip/4.9 updated),
>>>> noticed that the 4.14-wip queue will need a little bit sysentry tweaking
>>>> as well (missing 64-bit syscall dispatching), and then had to find 4.9
>>>> in a rather unfortunate state /wrt x86-64: CPUs are no longer idling
>>>> properly. I went back to ipipe-core-4.9.24-x86-2, without a difference.
>>>>
>>>> If you should look into 4.9-x86 as you indicated, please check this.
>>>
>>> Both issues fixed in 4.9.90/x86 as pushed lately. The result has run
>>> overnight in 64bit mode, and for a couple of hours in ia32emu mode. So
>>> far so good.
>>
>> Just trying 4.9.90-x86-6 in KVM, and I'm still finding 100% (virtual)
>> CPU load. I also triggered this with stable-3.0.x:
>>
>> [  237.455846] WARNING: CPU: 0 PID: 1055 at ../kernel/xenomai/posix/timerfd.c:57 timerfd_read+0x2a6/0x350
>> [  237.460728] Modules linked in:
>> [  237.461490] CPU: 0 PID: 1055 Comm: sampling-1052 Not tainted 4.9.90+ #11
>> [  237.461490] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.11.1-0-g0551a4be2c-prebuilt.qemu-project.org 04/01/2014
>> [  237.461490] I-pipe domain: Xenomai
>> [  237.461490]  ffffc90001b7fdb0 ffffffff8145e395 0000000000000000 0000000000000000
>> [  237.461490]  ffffc90001b7fdf0 ffffffff810e7261 000000393d61d170 ffffc900003e6008
>> [  237.461490]  0000000000000003 0000000000000008 00007f513e8c2de8 0000000000026200
>> [  237.461490] Call Trace:
>> [  237.461490]  [<ffffffff8145e395>] dump_stack+0xb2/0xdd
>> [  237.461490]  [<ffffffff810e7261>] __warn+0xd1/0xf0
>> [  237.461490]  [<ffffffff810e734d>] warn_slowpath_null+0x1d/0x20
>> [  237.461490]  [<ffffffff812423b6>] timerfd_read+0x2a6/0x350
>> [  237.461490]  [<ffffffff812174ec>] rtdm_fd_read+0x13c/0x3b0
>> [  237.461490]  [<ffffffff81220260>] ? CoBaLt_ioctl+0x20/0x20
>> [  237.461490]  [<ffffffff8122026e>] CoBaLt_read+0xe/0x10
>> [  237.461490]  [<ffffffff81235894>] handle_head_syscall+0x184/0x4b0
>> [  237.461490]  [<ffffffff81236288>] ipipe_fastcall_hook+0x18/0x20
>> [  237.461490]  [<ffffffff811a9054>] ipipe_handle_syscall+0x64/0x110
>> [  237.461490]  [<ffffffff81002b33>] do_syscall_64+0x43/0x1c0
>> [  237.461490]  [<ffffffff81840b43>] entry_SYSCALL_64_after_swapgs+0x5d/0xdb
>> [  237.461490] ---[ end trace 9d2476a38b0c5379 ]---
>>
>> I will debug this tomorrow.
>>
> 
> I can't reproduce this, the loadavg on my qemu instance consistently
> converges to 0.0x figures while running the latency test (10Khz or 1Khz,
> same). I'm now running 4.9.92, but I don't think this should make any
> difference, since I could trace the box entering the idle state on .90.
> 
> Are you running the ia32emu mode, or x86_64? Also, could you share your
> .config for building the guest kernel?

Config is the same I sent back then. Userland is 64-bit, compat support
enabled.

The reason I see so far: xnclock_core_local_shot never sets XNIDLE. I
suspect we always have a timer registered, that for the host clock. So
we can't become idle this way. I'm not even sure that this test makes
sense because a pending RT timer does not make a non-idle system.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

