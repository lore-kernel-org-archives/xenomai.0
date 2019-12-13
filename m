Subject: Re: stalled head domain with 3.1rc4
References: <VI1PR05MB5917452476FF30146D701888F6540@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <VI1PR05MB591740A31653FE8542171311F6540@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <VI1PR05MB5917FB6355396C28F99B79EDF6540@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <978c3a94-ae94-3982-3fdc-22e6f28d4aa4@siemens.com>
 <VI1PR05MB5917084161925CAB5627714DF6540@VI1PR05MB5917.eurprd05.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <6ef04e88-b7aa-2025-3ec8-ec11e8ff8ec5@siemens.com>
Date: Fri, 13 Dec 2019 14:44:13 +0100
MIME-Version: 1.0
In-Reply-To: <VI1PR05MB5917084161925CAB5627714DF6540@VI1PR05MB5917.eurprd05.prod.outlook.com>
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
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 13.12.19 14:35, Lange Norbert wrote:
> 
> 
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: Freitag, 13. Dezember 2019 14:13
>> To: Lange Norbert <norbert.lange@andritz.com>; Xenomai
>> (xenomai@xenomai.org) <xenomai@xenomai.org>
>> Subject: Re: stalled head domain with 3.1rc4
>>
>> NON-ANDRITZ SOURCE: BE CAUTIOUS WITH CONTENT, LINKS OR
>> ATTACHMENTS.
>>
>>
>> On 13.12.19 13:25, Lange Norbert via Xenomai wrote:
>>> Same thing with panic trace enabled (another, longer trace with 4000
>>> samples attached)
>>>
>>> [  292.743618] I-pipe: Detected stalled head domain, probably caused by a
>> bug.
>>> [  292.743618]         A critical section may have been left unterminated.
>>> [  292.757195] CPU: 0 PID: 1159 Comm: trace-cmd Tainted: G        W
>> 4.19.84-xeno8-static #1
>>> [  292.765986] Hardware name: TQ-Group TQMxE39M/Type2 - Board
>> Product
>>> Name, BIOS 5.12.30.21.20 08/05/2019 [  292.775304] I-pipe domain:
>>> Linux [  292.778546] Call Trace:
>>> [  292.781005]  <IRQ>
>>> [  292.783034]  dump_stack+0x8c/0xc0
>>> [  292.786363]  ipipe_root_only.cold+0x11/0x32 [  292.790560]
>>> ipipe_stall_root+0xe/0x60 [  292.794322]
>>> __ipipe_trap_prologue+0x11d/0x2f0 [  292.798782]  int3+0x45/0x70 [
>>> 292.801592] RIP: 0010:xntimer_start+0x3a/0x330 [  292.806050] Code: 55
>>> 49 89 d5 41 54 55 48 89 fd 53 48 83 ec 10 48 8b 47 70 4c 8b 37 48 63
>>> 40 18 4d 8b a6 90 00 00 00 4c 03 24 c5 00 e3f [  292.824832] RSP:
>>> 0018:ffff97d43ac03e78 EFLAGS: 00000082 [  292.830075] RAX:
>>> 0000000000000000 RBX: 0000000000025090 RCX: 0000000000000000 [
>>> 292.837219] RDX: 0000000000000000 RSI: 00000000000c6130 RDI:
>>> ffff97d43aeb0708 [  292.844367] RBP: ffff97d43aeb0708 R08:
>>> 0000000000000000 R09: 000000000027e6d0 [  292.851514] R10:
>>> 00000043f5344961 R11: 00000043f5344961 R12: ffff97d43aebb020 [
>>> 292.858658] R13: 0000000000000000 R14: ffffffff9e03bca0 R15:
>>> 00000000000c6130 [  292.865804]  ? xntimer_start+0x3a/0x330 [
>>> 292.869653]  program_htick_shot+0x8d/0x130 [  292.873761]
>>> clockevents_program_event+0x88/0xe0
>>> [  292.878392]  hrtimer_interrupt+0x140/0x230 [  292.882502]
>>> smp_apic_timer_interrupt+0x46/0x110
>>> [  292.887132]  __ipipe_do_sync_stage+0x15d/0x1c0 [  292.891592]
>>> __ipipe_handle_irq+0xa0/0x220 [  292.895699]
>>> ipipe_reschedule_interrupt+0x12/0x40
>>> [  292.900412]  </IRQ>
>>> [  292.902525] RIP: 0010:smp_call_function_many+0x1b6/0x250
>>> [  292.907848] Code: e8 4f 23 6c 00 3b 05 5d 5f 01 01 89 c7 0f 83 c4
>>> fe ff ff 48 63 c7 48 8b 0b 48 03 0c c5 00 e3 f1 9d 8b 41 18 a8 01 745
>>> [  292.926626] RSP: 0018:ffffab24c0c9bb40 EFLAGS: 00000202 ORIG_RAX:
>>> ffffffffffffff15 [  292.934210] RAX: 0000000000000003 RBX:
>>> ffff97d43aeb4c00 RCX: ffff97d43b2b7ac0 [  292.941357] RDX:
>>> 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000001 [
>>> 292.948500] RBP: ffffffff9d017b70 R08: ffff97d43aeb4c08 R09:
>>> 000000000002e248 [  292.955644] R10: ffff97d43aeb7780 R11:
>>> ffff97d43a003800 R12: 0000000000000000 [  292.962789] R13:
>>> ffff97d43aeb4c08 R14: 0000000000000004 R15: 0000000000000001 [
>>> 292.969936]  ? optimize_nops.isra.0+0x90/0x90 [  292.974306]  ?
>>> optimize_nops.isra.0+0x90/0x90 [  292.978673]  ?
>>> xntimer_start+0x39/0x330 [  292.982519]  ? xntimer_start+0x3a/0x330 [
>>> 292.986368]  on_each_cpu+0x28/0x50 [  292.989782]  ?
>>> xntimer_start+0x39/0x330 [  292.993630]  text_poke_bp+0x68/0xde [
>>> 292.997128]  ?
>> trace_event_raw_event_cobalt_thread_suspend+0xe0/0xe0
>>> [  293.003495]  __jump_label_transform.isra.0+0x102/0x150
>>> [  293.008645]  arch_jump_label_transform+0x2e/0x40
>>> [  293.013276]  __jump_label_update+0x67/0xa0 [  293.017382]
>>> static_key_slow_inc_cpuslocked+0x75/0x80
>>> [  293.022445]  static_key_slow_inc+0x16/0x20 [  293.026555]
>>> tracepoint_probe_register_prio+0x1f3/0x2a0
>>> [  293.031790]  ?
>>> trace_event_raw_event_cobalt_thread_suspend+0xe0/0xe0
>>> [  293.038155]  __ftrace_event_enable_disable+0x6f/0x230
>>> [  293.043217]  __ftrace_set_clr_event_nolock+0xe6/0x130
>>> [  293.048280]  system_enable_write+0xaa/0xe0 [  293.052392]
>>> do_iter_write+0x140/0x180 [  293.056151]  vfs_writev+0xa6/0xf0 [
>>> 293.059484]  do_writev+0x5f/0x100 [  293.062813]
>>> do_syscall_64+0x82/0x4e0 [  293.066489]
>>> entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>> [  293.071554] RIP: 0033:0x45874c
>>> [  293.074619] Code: ed 01 48 29 d0 49 83 c5 10 49 8b 55 08 48 63 dd
>>> 48 29 c2 49 01 45 00 49 89 55 08 49 63 7f 78 4c 89 e0 4c 89 ee 48 898
>>> [  293.093397] RSP: 002b:00007ffc91a57a00 EFLAGS: 00000202 ORIG_RAX:
>>> 0000000000000014 [  293.100983] RAX: ffffffffffffffda RBX:
>>> 0000000000000002 RCX: 000000000045874c [  293.108129] RDX:
>>> 0000000000000002 RSI: 00007ffc91a57a10 RDI: 0000000000000005 [
>>> 293.115275] RBP: 0000000000000002 R08: 0000000000b7d4e0 R09:
>>> 8080808080808080 [  293.122422] R10: 0000000000000005 R11:
>> 0000000000000202 R12: 0000000000000014 [  293.129569] R13:
>> 00007ffc91a57a10 R14: 0000000000000001 R15: 0000000000b7d4e0 [
>> 293.136722] I-pipe tracer log (100 points):
>>> [  293.140917]  |*#func                    0 ipipe_trace_panic_freeze+0x0
>> (ipipe_root_only+0xcf)
>>> [  293.149511]  |*#func                    0 ipipe_root_only+0x0
>> (ipipe_stall_root+0xe)
>>> [  293.157323]  |*#func                   -1 ipipe_stall_root+0x0
>> (__ipipe_trap_prologue+0x11d)
>>> [  293.165833]  |*#func                   -1 ipipe_test_root+0x0
>> (__ipipe_trap_prologue+0xbf)
>>> [  293.174165]  |*#func                   -2 __ipipe_trap_prologue+0x0 (int3+0x45)
>>> [  293.181541]  |*#func                   -2 xntimer_start+0x0
>> (program_htick_shot+0x8d)
>>
>> I suspect we see the hot-enabling of a tracepoint in xntimer_start here.
>> That's done on x86 by injecting an int3 at the call-out while patching in the full
>> instruction. If we are unlucky, that int3 is hit before the patching is done. Let
>> me check if we handled that better in the past.
> 
> What is the fallout if this happens, Does it affect the system negatively (apart from hickups in RT)?
> From my test it never happened after hitting the stalled head domain once (is this a BUG_ONCE message?).

After a warning, you should not assume the system to be still in a good
state, specifically with I-pipe/Xenomai enabled. If you can still
collect some debugging information, then it's good day.

> 
> This int3 necessary to invalidate I-caches?
> There are tricks to atomically patch the stubs even on warty x86 stuff like LLVM's XRay [1]

The code in the kernel as evolved over a long time and is very likely
there in the current form for good reasons. I need to dig them out, they
will be in git or in comments.

> 
>> BTW, I usually only enable tracing before starting the workload. OTH, there
>> are paths like this remaining even then, so this is just reducing likelyhood.
>> What it avoids is that the application sees the latency that tracing activation
>> brings.
> 
> You are lucky if you can easily test workloads like that. I have to take several steps and did not want
> to create huge traces before the span of the workload.

We are usually running tracer in flight recorder, also for huge workloads.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

