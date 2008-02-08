Date: Fri, 08 Feb 2008 16:27:40 +0100
From: "Petr Cervenka" <grugh@domain.hid>
MIME-Version: 1.0
Message-ID: <200802081627.15934@domain.hid>
References: 00710081503.15198@domain.hid> <200802061509.13010@domain.hid>
	<200802081341.13030@domain.hid> <47AC56A1.8090706@domain.hid>
In-Reply-To: <47AC56A1.8090706@domain.hid>
Content-Type: text/plain; charset=windows-1250
Content-Transfer-Encoding: QUOTED-PRINTABLE
Subject: Re: [Xenomai-help] FPU not available
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: jan.kiszka@domain.hid, xenomai@xenomai.org


______________________________________________________________
> Od: rpm@xenomai.org
> Komu: Petr Cervenka <grugh@domain.hid>
> CC: jan.kiszka@domain.hid, xenomai@xenomai.org
> Datum: 08.02.2008 14:25
> P=F8edm=ECt: Re: [Xenomai-help] FPU not available
>
>Petr Cervenka wrote:
>>> Philippe Gerum wrote:
>>>> Jan Kiszka wrote:
>>>>> Jan Kiszka wrote:
>>>>>> Gilles Chanteperdrix wrote:
>>>>>>> On Wed, Feb 6, 2008 at 3:09 PM, Petr Cervenka <grugh@domain.hid=
>
wrote:
>>>>>>>> Hello.
>>>>>>>>  Recently, we switched to newer distribution of linux (Kubuntu
7.10). During this switch we changed many things (Xenomai 2.4.1, linux
kernel 2.6.24, x86_64 architecture, ...).
>>>>>>>>  No we have problem, that in one of our tasks we are sometimes=
 not able to use floating point operations (under very specific circums=
tances) . In such case, that task crashes immediately, but rest of the =
application runs "normaly". Output from dmesg is attached to this messa=
ge. Task was created with T_FPU flag.
>>>>>>>>  Is there anything we can check or change?
>>>>>>>>  Petr Cervenka
>>>>>>> I do not know if this is related to the issue you are facing, b=
ut the
>>>>>>> first FPU fault of a thread running in primary mode may be hand=
led by
>>>>>>> Xenomai without switching to secondary mode. So, maybe the faul=
t
>>>>>>> epilogue implicitely expects Xenomai to have switched the fault=
 to
>>>>>>> secondary mode and use some secondary mode services such as
>>>>>>> ipipe_restore_root, whereas the thread never leaved primary mod=
e.
>>>>>>>
>>>>>> Good point! That is probably this path (and not the one I starre=
d on):
>>>>>>
>>>>>> __ipipe_handle_exception()
>>>>>> 	...
>>>>>> 	if (unlikely(ipipe_trap_notify(vector, regs))) {
>>>>>> 		local_irq_restore(flags);
>>>>>> 		return 1;
>>>>>> 	}
>>>>>>
>>>>>> That needs some more thoughts...
>>>>> Looking at the whole __ipipe_handle_exception, the problem is rel=
ated to
>>>>>  the early, context-independent __ipipe_stall_root(). Can we post=
pone
>>>>> this safely after having called any potential high-stage hooks fo=
r this
>>>>> exception, and then only if the callee migrated the thread to the=
 root
>>>>> domain? Or is there a need to have the root domain stalled across=
 the
>>>>> post-fault migration?
>>>>>
>>>> Someone from the root domain may want to get notified of the excep=
tions
>>>> occurring in that domain too, in which case we may not postpone th=
e
>>>> virtual mask fixup after the notifier invocation, otherwise we wou=
ld
>>>> call the handler with a broken interrupt state.
>>>>
>>>>> In the latter case, we would have to fiddle with the stall bits d=
irectly
>>>>> instead of calling local_irq_restore - not just to work around th=
e
>>>>> BUG_ON, but also to avoid sync'ing root over potentially stalled
>>>>> non-root domains...
>>>>>
>>>> This used to be done by ipipe_restore_pipeline_nosync() in older
>>>> patches, but this one has disappeared after the flat log refactori=
ng. We
>>>> indeed need to resurrect something alike in order to reset the sta=
ll bit
>>>> without calling the syncer, when taking the fast exit path after
>>>> ipipe_trap_notify().
>>> Hmm, so it could be fairly simple in fact:
>>>
>>> --- a/arch/x86/kernel/ipipe.c
>>> +++ b/arch/x86/kernel/ipipe.c
>>> @@ -755,7 +755,9 @@ int __ipipe_handle_exception(struct pt_r
>>> #endif /* CONFIG_KGDB */
>>>
>>> 	if (unlikely(ipipe_trap_notify(vector, regs))) {
>>> -		local_irq_restore(flags);
>>> +		if (!flags)
>>> +			__clear_bit(IPIPE_STALL_FLAG,
>>> +				    &ipipe_root_cpudom_var(status));
>>> 		return 1;
>>> 	}
>>>
>>> Petr, ready to try?
>>>
>> I tried this patch and the problem (or the race condition) disappear=
ed. ;-)
>> Is there any (easy) method to recognise if the problem was solved?
>>=20
>
>This one won't break the whole thing...
>
>diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
>index ce24db7..af9d4c4 100644
>--- a/arch/x86/kernel/ipipe.c
>+++ b/arch/x86/kernel/ipipe.c
>@@ -758,6 +758,7 @@ int __ipipe_handle_exception(struct pt_regs *regs,=
 long error_code, int vector)
> #endif /* CONFIG_KGDB */
>
> 	if (unlikely(ipipe_trap_notify(vector, regs))) {
>+		WARN_ON(!ipipe_root_domain_p);
> 		if (!flags)
> 			__clear_bit(IPIPE_STALL_FLAG,
> 				    &ipipe_root_cpudom_var(status));
>
I applied the "WARN_ON" patch and got the kernel bug again.
Dmesg output is attached. I hope it will help you this time a little bi=
t.
It seems that the warning started to be printed and then the error happ=
ened (if I understand it well).

>> To your previous questions:
>> We use Athlon64 X2 (2 cores, 64-bit), kubuntu 7.10 amd64.
>> We have 2 real-time userspace applications: some kind of server for =
rtnet communication with special measuring hardware, and clients (1-4 i=
nstances) for some computing,  configuration, ethernet comunication, et=
c. Comunication between server and clients is via named rt_queues.. Any=
 "failing example" is perhaps impossible.
>> Any attempt with IPIPE_DEBUG and tracer removes the race condition.
>>=20
>> Thank you VERY MUCH for you help and support (all of you).
>> Petr
>>=20
>>> Jan
>>>
>>> --=20
>>> Siemens AG, Corporate Technology, CT SE 2
>>> Corporate Competence Center Embedded Linux
>>>
>>=20
>>=20
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
>>=20
>
>
>--=20
>Philippe.
>

[   52.570242] WARNING: at arch/x86/kernel/ipipe.c:758 __ipipe_handle_e=
xception()
[   52.570249] Pid: 4758, comm: REG_TASK_2056 Not tainted 2.6.24-adeos =
#4
[   52.570251]=20
[   52.570251] Call Trace:
[   52.570283] ------------[ cut here ]------------
[   52.570318] kernel BUG at kernel/ipipe/core.c:321!
[   52.570351] invalid opcode: 0000 [1] PREEMPT SMP=20
[   52.570449] CPU 0=20
[   52.570499] Modules linked in: rt_r8169 rtpacket rtnet rfcomm l2cap =
bluetooth ppdev container ac sbs sbshc dock battery lp irtty_sir sir_de=
v irda psmouse parport_pc parport crc_ccitt serio_raw k8temp pcspkr shp=
chp pci_hotplug button i2c_nforce2 i2c_core af_packet ipv6 evdev ext3 j=
bd mbcache sg sd_mod sata_nv ata_generic forcedeth libata amd74xx scsi_=
mod ide_core ehci_hcd ohci_hcd usbcore fan fuse
[   52.571610] Pid: 4758, comm: REG_TASK_2056 Not tainted 2.6.24-adeos =
#4
[   52.571645] RIP: 0010:[<ffffffff80278e47>]  [<ffffffff80278e47>] __i=
pipe_restore_root+0x47/0x50
[   52.571714] RSP: 0000:ffff81003e16bd88  EFLAGS: 00010002
[   52.571747] RAX: ffffffff8067caa0 RBX: 00000009e4457f0f RCX: 0000000=
000000003
[   52.571782] RDX: ffff810080993000 RSI: ffffffff8022743f RDI: 0000000=
000000001
[   52.571816] RBP: ffff81003e16bd88 R08: ffff810001008420 R09: 0000000=
000000004
[   52.571851] R10: ffff81003e16bda8 R11: 0000000000000000 R12: 0000000=
000000001
[   52.571886] R13: ffff81003e16a000 R14: ffff81003e16bffd R15: 0000000=
000000000
[   52.571921] FS:  0000000040091950(0063) GS:ffffffff805f5000(0000) kn=
lGS:0000000000000000
[   52.571963] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[   52.571997] CR2: 00002b6d57fb623d CR3: 000000003a0c5000 CR4: 0000000=
0000006e0
[   52.572031] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
[   52.572066] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000=
000000400
[   52.572101] Process REG_TASK_2056 (pid: 4758, threadinfo ffff81003e1=
6a000, task ffff810035432790)
[   52.572144] Stack:  ffff81003e16bdb8 ffffffff8023af74 ffff81003e16be=
98 ffffffff806777a8
[   52.572288]  ffff810080993000 ffff81003e16a000 ffff81003e16bdc8 ffff=
ffff80273809
[   52.572411]  ffff81003e16bde8 ffffffff8027383e ffffffff8022743f ffff=
81003e16bf00
[   52.572509] Call Trace:
[   52.572569]  [<ffffffff8023af74>] cpu_clock+0x84/0xa0
[   52.572604]  [<ffffffff80273809>] get_timestamp+0x9/0x10
[   52.572638]  [<ffffffff8027383e>] touch_softlockup_watchdog+0x2e/0x4=
0
[   52.572675]  [<ffffffff8022743f>] __ipipe_handle_exception+0x25f/0x2=
70
[   52.572711]  [<ffffffff80220c5a>] touch_nmi_watchdog+0x1a/0x80
[   52.572746]  [<ffffffff8022743f>] __ipipe_handle_exception+0x25f/0x2=
70
[   52.572783]  [<ffffffff8020def1>] print_trace_address+0x11/0x20
[   52.572818]  [<ffffffff8022743f>] __ipipe_handle_exception+0x25f/0x2=
70
[   52.572853]  [<ffffffff8020d8ab>] dump_trace+0x10b/0x2c0
[   52.572890]  [<ffffffff80413d18>] exception_event+0x48/0x60
[   52.572925]  [<ffffffff8020daa3>] show_trace+0x43/0x60
[   52.572960]  [<ffffffff8020e1aa>] dump_stack+0x6a/0x80
[   52.572995]  [<ffffffff8022743f>] __ipipe_handle_exception+0x25f/0x2=
70
[   52.573033]  [<ffffffff804a2c73>] error_sti+0x1e/0x52
[   52.573071]=20
[   52.573100]=20
[   52.573100] Code: 0f 0b eb fe 0f 1f 44 00 00 55 48 89 e5 41 56 41 55=
 41 54 53=20
[   52.573595] RIP  [<ffffffff80278e47>] __ipipe_restore_root+0x47/0x50
[   52.573650]  RSP <ffff81003e16bd88>
[   52.573690] ---[ end trace c09fed11ada7a064 ]---
[   52.573723] note: REG_TASK_2056[4758] exited with preempt_count 1=20


