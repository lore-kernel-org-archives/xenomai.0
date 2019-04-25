Subject: Re: [PATCH] cobalt/intr: fix interrupt stat iterator
References: <20190424102940.12754-1-rpm@xenomai.org>
 <e2d59fb7-93fd-579e-44a9-410c03562f5f@siemens.com>
 <90b07ec0-5c87-bf1f-8ffe-540c96092024@xenomai.org>
 <9e05d163-b0a4-bd2b-59b8-64b1a00dccfe@siemens.com>
 <233f4280-907c-2bd6-e478-41bf74fe8970@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <6f026177-d9d3-7a48-73a8-93376d80d712@siemens.com>
Date: Thu, 25 Apr 2019 17:21:17 +0200
MIME-Version: 1.0
In-Reply-To: <233f4280-907c-2bd6-e478-41bf74fe8970@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 25.04.19 17:17, Philippe Gerum wrote:
> On 4/25/19 5:12 PM, Jan Kiszka wrote:
>> On 25.04.19 17:11, Philippe Gerum wrote:
>>> On 4/25/19 4:53 PM, Jan Kiszka wrote:
>>>> On 24.04.19 12:29, Philippe Gerum via Xenomai wrote:
>>>>> The implementation does not iterate fully over all CPU slots for every
>>>>> handler, leaving some of them uncollected. In addition, if maxcpus= is
>>>>> used to restrict the number of available CPUs to a subset of the
>>>>> present ones, with the highest numbered CPU marked offline, the
>>>>> iterator rescans the first valid IRQ slot indefinitely, eventually
>>>>> leading to memory corruption due to out-of-bound writes.
>>>>
>>>> The patch looks good and works fine for the common case, so I've applied
>>>> it to next.
>>>>
>>>> But I cannot reproduce your maxcpus setup as - for to-be-debugged
>>>> reasons - we are already crashing on 4.14 and 4.4 on x86 during boot.
>>>> Did you test on ARM?
>>>
>>> Yes, i.MX6. Quad-core restricted with maxcpus=2.
>>>
>>
>> CONFIG_HOTPLUG_CPU? Does it survive manual onlining later on?
>>
> 
> HOTPLUG is off in my setup.
> 

OK, then the pattern may also be found on ARM. It seems we can only do
offline/online when the cpu was online at the time ipipe took over the
timers, or maybe even when ipipe was hijacking interrupts. If it wasn't
we see to lack some initialization when the cpu comes up later, and the
timer tick on that new core hits a NULL pointer.

[    7.629979] BUG: unable to handle kernel NULL pointer dereference at 0000000000000018
[    7.631456] IP: __ipipe_ack_hrtimer_irq+0x47/0x60
[    7.632557] PGD 0 P4D 0 
[    7.633504] Oops: 0000 [#1] PREEMPT SMP PTI
[    7.634647] Modules linked in: rt_e1000e rtnet
[    7.635668] CPU: 3 PID: 401 Comm: cpuhp/3 Not tainted 4.14.111+ #89
[    7.636878] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
[    7.638560] I-pipe domain: Linux
[    7.639513] task: ffff888039526340 task.stack: ffffc9000073c000
[    7.640847] RIP: 0010:__ipipe_ack_hrtimer_irq+0x47/0x60
[    7.641965] RSP: 0000:ffff88803e203f80 EFLAGS: 00010046
[    7.643144] RAX: 000000000002e620 RBX: 0000000000001103 RCX: ffffffff83740880
[    7.645724] RDX: ffff88803e200000 RSI: ffffffff836f6d80 RDI: 0000000000000000
[    7.647163] RBP: 0000000000000000 R08: ffff88803cc03909 R09: 0000000000000112
[    7.648479] R10: 0000000000000115 R11: 0000000000000003 R12: 0000000000000000
[    7.650493] R13: 0000000000000000 R14: 000000000002e540 R15: 0000000000000000
[    7.651922] FS:  0000000000000000(0000) GS:ffff88803e200000(0000) knlGS:0000000000000000
[    7.653493] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.654826] CR2: 0000000000000018 CR3: 000000000221e001 CR4: 00000000003606e0
[    7.656383] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    7.657859] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    7.659355] Call Trace:
[    7.660379]  <IRQ>
[    7.661261]  __ipipe_dispatch_irq+0x87/0x1d0
[    7.662310]  __ipipe_handle_irq+0x76/0x1e0
[    7.663360]  apic_timer_interrupt+0x7f/0xb0
[    7.664401]  </IRQ>

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

