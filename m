From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Subject: RE: gdb  test failure debug status update
Date: Thu, 6 May 2021 02:00:23 +0000
Message-ID: <DM5PR11MB18521837E79C031B621080A8F2589@DM5PR11MB1852.namprd11.prod.outlook.com>
References: <DM5PR11MB18525F69E34389DE7A8EE49BF2409@DM5PR11MB1852.namprd11.prod.outlook.com>
 <87mtti3325.fsf@xenomai.org> <87k0om32jb.fsf@xenomai.org>
 <DM5PR11MB1852E0C420E68BFB8CAFEE21F25F9@DM5PR11MB1852.namprd11.prod.outlook.com>
 <DM5PR11MB1852D3221BDFC752C9CC1946F25E9@DM5PR11MB1852.namprd11.prod.outlook.com>
 <87bl9w2pkm.fsf@xenomai.org> <875z042odb.fsf@xenomai.org>
 <DM5PR11MB18527EA509FB99BF50D1ACFFF25E9@DM5PR11MB1852.namprd11.prod.outlook.com>
 <DM5PR11MB18529649C47BF241930A2217F25E9@DM5PR11MB1852.namprd11.prod.outlook.com>
 <8735v82jmd.fsf@xenomai.org>
In-Reply-To: <8735v82jmd.fsf@xenomai.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>



>-----Original Message-----
>From: Philippe Gerum <rpm@xenomai.org>=20
>Sent: Friday, April 30, 2021 5:43 PM
>To: Chen, Hongzhan <hongzhan.chen@intel.com>
>Subject: Re: gdb test failure debug status update
>
>
>Chen, Hongzhan <hongzhan.chen@intel.com> writes:
>
>>>-----Original Message-----
>>>From: Xenomai <xenomai-bounces@xenomai.org> On Behalf Of Chen, Hongzhan =
via Xenomai
>>>Sent: Friday, April 30, 2021 4:07 PM
>>>To: Philippe Gerum <rpm@xenomai.org>
>>>Cc: xenomai@xenomai.org
>>>Subject: RE: gdb test failure debug status update
>>>
>>>
>>>
>>>>-----Original Message-----
>>>>From: Philippe Gerum <rpm@xenomai.org>=20
>>>>Sent: Friday, April 30, 2021 4:01 PM
>>>>To: Chen, Hongzhan <hongzhan.chen@intel.com>
>>>>Cc: xenomai@xenomai.org
>>>>Subject: Re: gdb test failure debug status update
>>>>
>>>>
>>>>Philippe Gerum <rpm@xenomai.org> writes:
>>>>
>>>>> Chen, Hongzhan <hongzhan.chen@intel.com> writes:
>>>>>
>>>>>> The final xnthread_relaxed call path is like this asm_sysv_apic_time=
r_interrupt ->handle_irq_pipelined_finish=20
>>>>>> ->dovetail_call_mayday ->handle_oob_mayday>xnthread_relax.=20
>>>>>> That means that handle_irq_pipelined_finish is called under OOB cond=
ition of arch_pipeline_entry in
>>>>>>  arch/x86/kernel/irq_pipeline.c.  Does that means that kernel entry/=
exit code is never called after return from=20
>>>>>> xnthread_relax to handle_irq_pipelined_finish then to asm_sysv_apic_=
timer_interrupt?  Even I enforce to=20
>>>>>> call  dovetail_request_ucall before calling final xnthread_relax sys=
tem would not try to switch back to primary mode
>>>>>> because kernel exit code is never called in this case?
>>>>>>
>>>>>
>>>>> The IRQ frame is indeed kept from unwinding until the preempted task
>>>>> context returns from irq_exit_pipeline(), which branches to the Cobal=
t
>>>>> rescheduling procedure. From the Dovetail interface POV,
>>>>> irq_exit_pipeline() is called by handle_irq_pipelined_finish() to all=
ow
>>>>> the companion core to perform post-IRQ chores, such as running its ow=
n
>>>>> rescheduling procedure.
>>>>>
>>>>> IOW, if task @foo is preempted by an IRQ, then suspended in oob conte=
xt
>>>>> as a result of what the interrupt handler just did for it (e.g. raisi=
ng
>>>>> XNDBGSTOP, XNRELAX, XNPEND, XNSUSP in its state), then
>>>>> handle_irq_pipelined_finish()->irq_exit_pipeline()->xnsched_run() wil=
l
>>>>> cause the @foo context to switch away, effectively preventing
>>>>> handle_irq_pipelined_finish() to return, until @foo resumes execution
>>>> eventually.
>>
>> ln handle_irq_pipelined_finish, irq_exit_pipeline would at first  be exe=
cuted and it=20
>> handle dovetail_call_mayday in the end. But issue happen after run dovet=
ail_call_mayday=20
>> because it call final xnthread_relax before gdb test failue.
>>
>
>Can you add WARN_ON(1) to dovetail_call_mayday() and report about the
>output? TIA,
>
>--=20
>Philippe.
>

Please check following output.

[   27.260261] ------------[ cut here ]------------
[   27.260262] WARNING: CPU: 0 PID: 400 at kernel/dovetail.c:93 dovetail_ca=
ll_mayday+0x6/0x20
[   27.260263] Modules linked in:
[   27.260265] CPU: 0 PID: 400 Comm: smokey Tainted: G        W         5.1=
0.25+ #588
[   27.260266] Hardware name: AAEON UP-WHL01/UP-WHL01, BIOS UPW1AM18D 06/23=
/2020
[   27.260266] IRQ stage: Xenomai
[   27.260267] RIP: 0010:dovetail_call_mayday+0x6/0x20
[   27.260269] Code: 00 00 00 00 0f 1f 44 00 00 31 c0 c3 0f 1f 84 00 00 00 =
00 00 0f 1f 44 00 00 f3 c3 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 53 <0f=
> 0b 9c 5b fa f0 80 67 03 fb 48 89 f7 e8 48 04 02 00 53 9d 5b c3
[   27.260270] RSP: 0000:ffffc900014c3f30 EFLAGS: 00010006
[   27.260271] RAX: 0000000014000004 RBX: ffffc900014c3f58 RCX: ffff888264e=
1cf40
[   27.260272] RDX: ffff888264e1cf40 RSI: ffffc900014c3f58 RDI: ffff8881037=
6e300
[   27.260273] RBP: ffff888264e1cf40 R08: 0000000000003904 R09: ffff88810b4=
08000
[   27.260274] R10: ffffc900014c3d48 R11: ffffffff8274a5e8 R12: ffffffff81c=
00c3a
[   27.260274] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000000=
00000
[   27.260275] FS:  00007ffff758f740(0000) GS:ffff888264e00000(0000) knlGS:=
0000000000000000
[   27.260276] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   27.260277] CR2: 00007ff55f9909d8 CR3: 00000001156ea006 CR4: 00000000001=
706f0
[   27.260278] Call Trace:
[   27.260279]  handle_irq_pipelined_finish+0x154/0x190
[   27.260279]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[   27.260280] RIP: 0033:0x55555540b4d5
[   27.260281] Code: Unable to access opcode bytes at RIP 0x55555540b4ab.
[   27.260282] RSP: 002b:00007fffffffe940 EFLAGS: 00000206
[   27.260283] RAX: 0000000000043028 RBX: 000055555562a140 RCX: 00000000000=
00000
[   27.260284] RDX: 000055555541fa4f RSI: 000000000000009f RDI: 00005555554=
1fc68
[   27.260285] RBP: 00007fffffffe950 R08: 0000000000000000 R09: 00000000fff=
fffff
[   27.260285] R10: 0000000000000000 R11: 00007ffff799c820 R12: 00000000000=
00002
[   27.260287] R13: 000055555562c9f0 R14: 00007fffffffeb04 R15: 00007ffff75=
8f740
[   27.260287] irq event stamp: 2000
[   27.260288] hardirqs last  enabled at (1999): [<ffffffff8105face>] flush=
_tlb_mm_range+0x10e/0x140
[   27.260289] hardirqs last disabled at (2000): [<ffffffff81bd2264>] exc_i=
nt3+0x44/0x1a0
[   27.260290] softirqs last  enabled at (784): [<ffffffff81e0030a>] __do_s=
oftirq+0x30a/0x42d
[   27.260291] softirqs last disabled at (777): [<ffffffff81c00faf>] asm_ca=
ll_irq_on_stack+0xf/0x20
[   27.260292] ---[ end trace ea56d34072e888ed ]---

Regards

Hongzhan Chen

