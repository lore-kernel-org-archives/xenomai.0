References: <6caeb963-97fc-c858-8c89-6cafda765d9a@siemens.com>
 <87wnr25gqw.fsf@xenomai.org> <87v96lbqz0.fsf@xenomai.org>
 <296ac220-8a0b-a719-d3b6-7bab2b4fc4f4@siemens.com>
 <87pmwtbqqv.fsf@xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Dovetail: Possible boot issue on BeagleBone Black
In-reply-to: <87pmwtbqqv.fsf@xenomai.org>
Date: Thu, 10 Jun 2021 19:02:18 +0200
Message-ID: <87mtrxbqlh.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org


Philippe Gerum via Xenomai <xenomai@xenomai.org> writes:

> Jan Kiszka <jan.kiszka@siemens.com> writes:
>
>> On 10.06.21 18:54, Philippe Gerum wrote:
>>> 
>>> Philippe Gerum <rpm@xenomai.org> writes:
>>> 
>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>
>>>>> Hi Philippe,
>>>>>
>>>>> seems we have some early boot problem with Dovetail on the BBB (while
>>>>> qemu-arm is fine), see [1] vs. [2] (disabled Xenomai for [2], see [3]).
>>>>> Do you happen to have such a target around? Or a reference config that
>>>>> is supposed to work?
>>>>>
>>>>> Jan
>>>>>
>>>>> [1] https://source.denx.de/Xenomai/xenomai-images/-/jobs/277392#L444
>>>>> [2] https://source.denx.de/Xenomai/xenomai-images/-/jobs/277821#L444
>>>>> [3]
>>>>> https://source.denx.de/Xenomai/xenomai-images/-/commit/d48c28a82f16b5141948f23cc5bce244217eda15
>>>>
>>>> Yes, I have that one at hand, my Kconfig attached. No issue with booting
>>>> EVL on the latest Dovetail/5.10-LTS. I'll give a try to Dovetail+Cobalt
>>>> later today. (dtb issue in the CI?)
>>>>
>>>> [    0.000000] Booting Linux on physical CPU 0x0
>>>> [    0.000000] Linux version 5.10.42-00590-gcd7b61ff545b (rpm@pyro) (arm-linux-gnueabihf-gcc (Linaro GCC 7.5-2019.12) 7.5.0, GNU ld (Linaro_Binutils-2019.12) 2.28.2.20170706) #1 PREEMPT IRQPIPE Thu Jun 10 09:08:56 CEST 2021
>>>> [    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c5387d
>>>> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
>>>> [    0.000000] OF: fdt: Machine model: TI AM335x BeagleBone Black
>>>> [    0.000000] Memory policy: Data cache writeback
>>>> [    0.000000] efi: UEFI not found.
>>>> [    0.000000] cma: Reserved 64 MiB at 0x9b800000
>>>> [    0.000000] Zone ranges:
>>>> [    0.000000]   DMA      [mem 0x0000000080000000-0x000000009fdfffff]
>>>> [    0.000000]   Normal   empty
>>>> [    0.000000]   HighMem  empty
>>>> [    0.000000] Movable zone start for each node
>>>> [    0.000000] Early memory node ranges
>>>> [    0.000000]   node   0: [mem 0x0000000080000000-0x000000009fdfffff]
>>>> [    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x000000009fdfffff]
>>>> [    0.000000] CPU: All CPU(s) started in SVC mode.
>>>> [    0.000000] AM335X ES2.1 (sgx neon)
>>>> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 129540
>>>> [    0.000000] Kernel command line: root=/dev/nfs rw nfsroot=192.168.3.1:/var/lab/nfsroot/generic/armv7,v3,tcp panic=1 console=ttyS0,115200n8 ip=dhcp
>>>> [    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes, linear)
>>>> [    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes, linear)
>>>> [    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
>>>> [    0.000000] Memory: 428160K/522240K available (13312K kernel code, 1712K rwdata, 5228K rodata, 2048K init, 411K bss, 28544K reserved, 65536K cma-reserved, 0K highmem)
>>>> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
>>>> [    0.000000] rcu: Preemptible hierarchical RCU implementation.
>>>> [    0.000000] rcu: 	RCU event tracing is enabled.
>>>> [    0.000000] 	Trampoline variant of Tasks RCU enabled.
>>>> [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
>>>> [    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
>>>> [    0.000000] IRQ: Found an INTC at 0x(ptrval) (revision 5.0) with 128 interrupts
>>>> [    0.000000] random: get_random_bytes called from start_kernel+0x330/0x4c4 with crng_init=0
>>>> [    0.004513] IRQ pipeline enabled
>>> 
>>> Using wip/dovetail over dovetail-v5.10.y (.42 so far), bbb boots fine
>>> with Dovetail fully enabled, Cobalt in stopped mode. Enabling the core
>>> once booted, then running latency crashes in a fairly trivial way. It
>>> looks like the paint is still wet there:
>>> 
>>> ~ # corectl --start
>>> [   34.405086] [Xenomai] services started
>>> ~ # 
>>> ~ # 
>>> ~ # latency
>>> == Sampling period: 1000 us
>>> == Test mode: periodic user-mode task
>>> == All results in micro[   37.067419] 8<--- cut here ---
>>> [   37.067431] Unable to handle kernel NULL pointer dereference at virtual address 000000c0
>>> [   37.067435] pgd = 49eec2f1
>>> [   37.067439] [000000c0] *pgd=83b78831, *pte=00000000, *ppte=00000000
>>> [   37.067457] Internal error: Oops: 17 [#1] PREEMPT SMP ARM
>>> [   37.067461] Modules linked in:
>>> [   37.067468] CPU: 0 PID: 123 Comm: sampling-120 Not tainted 5.10.42-00113-gbc20d0c23c02-dirty #10
>>> [   37.067473] Hardware name: Generic AM33XX (Flattened Device Tree)
>>> [   37.067476] IRQ stage: Linux
>>> [   37.067480] PC is at pipeline_set_timer_shot+0x24/0xd8
>>> [   37.067484] LR is at pipeline_set_timer_shot+0x14/0xd8
>>> [   37.067488] pc : [<c0402ce0>]    lr : [<c0402cd0>]    psr: 20070093
>>> [   37.067492] sp : c3abfe58  ip : 10e28280  fp : c3abe000
>>> [   37.067496] r10: c1a8fab8  r9 : 00000000  r8 : 000f4240
>>> [   37.067500] r7 : 00000008  r6 : a03fb0a9  r5 : 000edea5  r4 : e147f638
>>> [   37.067505] r3 : 00000000  r2 : 1e04f000  r1 : c1526704  r0 : 00000000
>>> [   37.067509] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
>>> [   37.067513] Control: 10c5387d  Table: 83b50019  DAC: 00000051
>>> [   37.067518] Process sampling-120 (pid: 123, stack limit = 0x86f5afaa)
>>> [   37.067522] Stack: (0xc3abfe58 to 0xc3ac0000)
>>> [   37.067526] fe40:                                                       e147f638 df9ab790
>>> [   37.067531] fe60: a03fb0a9 00000008 000f4240 00000000 c1a8fab8 c040eef0 c3a54100 df9a6840
>>> [   37.067536] fe80: 000f01f6 00000000 00000000 fffffffd 00000002 3574c753 c3abff04 00000000
>>> [   37.067541] fea0: 00000000 00000000 00000008 000f4240 00000001 00000001 00000000 c0425e64
>>> [   37.067546] fec0: 000f4240 00000000 00000001 00000001 e147f600 00000000 c3abff08 e147f638
>>> [   37.067550] fee0: c3abff28 c04276ec c3abe000 ffffe000 00000003 00000001 00000000 00000051
>>> [   37.067555] ff00: 00000000 c0427848 00000000 00000000 00000000 02e07ea8 00000000 00000000
>>> [   37.067560] ff20: 00000000 c042530c 00000000 00000000 000f4240 c3abffb0 00000025 00000000
>>> [   37.067565] ff40: 02e07ea8 000000f0 00000000 3574c753 c1a8bd40 c3abffb0 00000006 00000000
>>> [   37.067570] ff60: e147f808 00000000 c3abe000 c3abff78 c0427784 c0423840 00000000 c1baa36b
>>> [   37.067574] ff80: c3abff70 c3a54100 00000078 00000000 00000000 b63d8db8 100f0042 c0300370
>>> [   37.067579] ffa0: c3abe000 00000007 00000000 c0300264 1000003a 00000003 00000001 b63d8db8
>>> [   37.067584] ffc0: 00000000 00000000 b63d8db8 000f0042 b63d8e1c 00000001 bea8ba5c 00000000
>>> [   37.067589] ffe0: 00000001 b63d8d48 00000003 b6ebc488 20070030 1000003a 00000000 00000000
>>> [   37.067594] [<c0402ce0>] (pipeline_set_timer_shot) from [<c040eef0>] (xntimer_start+0x164/0x260)
>>> [   37.067599] [<c040eef0>] (xntimer_start) from [<c0425e64>] (__cobalt_timer_setval+0xd4/0x100)
>>> [   37.067604] [<c0425e64>] (__cobalt_timer_setval) from [<c04276ec>] (__cobalt_timerfd_settime+0xfc/0x194)
>>> [   37.067609] [<c04276ec>] (__cobalt_timerfd_settime) from [<c0427848>] (CoBaLt_timerfd_settime+0xc4/0x18c)
>>> [   37.067614] [<c0427848>] (CoBaLt_timerfd_settime) from [<c0423840>] (handle_head_syscall+0x13c/0x30c)
>>> [   37.067619] [<c0423840>] (handle_head_syscall) from [<c0300264>] (fastcall_try+0x10/0x24)
>>> [   37.067623] Exception stack(0xc3abffb0 to 0xc3abfff8)
>>> [   37.067627] ffa0:                                     1000003a 00000003 00000001 b63d8db8
>>> [   37.067632] ffc0: 00000000 00000000 b63d8db8 000f0042 b63d8e1c 00000001 bea8ba5c 00000000
>>> [   37.067636] ffe0: 00000001 b63d8d48 00000003 b6ebc488 20070030 1000003a
>>> [   37.067641] Code: e3053974 e34c3195 ee1d2f90 e7933002 (e59340c0) 
>>> [   37.067645] ---[ end trace 09d1faca36a5025f ]---
>>> seconds
>>> warming up...
>>> 
>>> NOTE: imx6qp is fine booting with Cobalt enabled. Go figure.
>>> 
>>> NOTE2: we cannot build the bbb kernel with SMP support off. I'll send a
>>> patch to fix this.
>>> 
>>
>> Note2 is fixed already, you were in CC. !SMP may actually be a key to
>> the stuck boot with the xenomai-images config.
>>
>
> Nope, this is another Dovetail-specific issue I'm referring to.


No it's not. This stale reference is indeed pulled by Cobalt. All fine
now.

-- 
Philippe.

