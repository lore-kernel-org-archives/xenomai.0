References: <6caeb963-97fc-c858-8c89-6cafda765d9a@siemens.com>
 <87wnr25gqw.fsf@xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Dovetail: Possible boot issue on BeagleBone Black
In-reply-to: <87wnr25gqw.fsf@xenomai.org>
Date: Thu, 10 Jun 2021 09:23:36 +0200
Message-ID: <87tum65gjr.fsf@xenomai.org>
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>


Philippe Gerum <rpm@xenomai.org> writes:

> Jan Kiszka <jan.kiszka@siemens.com> writes:
>
>> Hi Philippe,
>>
>> seems we have some early boot problem with Dovetail on the BBB (while
>> qemu-arm is fine), see [1] vs. [2] (disabled Xenomai for [2], see [3]).
>> Do you happen to have such a target around? Or a reference config that
>> is supposed to work?
>>
>> Jan
>>
>> [1] https://source.denx.de/Xenomai/xenomai-images/-/jobs/277392#L444
>> [2] https://source.denx.de/Xenomai/xenomai-images/-/jobs/277821#L444
>> [3]
>> https://source.denx.de/Xenomai/xenomai-images/-/commit/d48c28a82f16b5141948f23cc5bce244217eda15
>
> Yes, I have that one at hand, my Kconfig attached. No issue with booting
> EVL on the latest Dovetail/5.10-LTS. I'll give a try to Dovetail+Cobalt
> later today. (dtb issue in the CI?)
>
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 5.10.42-00590-gcd7b61ff545b (rpm@pyro) (arm-linux-gnueabihf-gcc (Linaro GCC 7.5-2019.12) 7.5.0, GNU ld (Linaro_Binutils-2019.12) 2.28.2.20170706) #1 PREEMPT IRQPIPE Thu Jun 10 09:08:56 CEST 2021
> [    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c5387d
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> [    0.000000] OF: fdt: Machine model: TI AM335x BeagleBone Black
> [    0.000000] Memory policy: Data cache writeback
> [    0.000000] efi: UEFI not found.
> [    0.000000] cma: Reserved 64 MiB at 0x9b800000
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000080000000-0x000000009fdfffff]
> [    0.000000]   Normal   empty
> [    0.000000]   HighMem  empty
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000080000000-0x000000009fdfffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x000000009fdfffff]
> [    0.000000] CPU: All CPU(s) started in SVC mode.
> [    0.000000] AM335X ES2.1 (sgx neon)
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 129540
> [    0.000000] Kernel command line: root=/dev/nfs rw nfsroot=192.168.3.1:/var/lab/nfsroot/generic/armv7,v3,tcp panic=1 console=ttyS0,115200n8 ip=dhcp
> [    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes, linear)
> [    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes, linear)
> [    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
> [    0.000000] Memory: 428160K/522240K available (13312K kernel code, 1712K rwdata, 5228K rodata, 2048K init, 411K bss, 28544K reserved, 65536K cma-reserved, 0K highmem)
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> [    0.000000] rcu: Preemptible hierarchical RCU implementation.
> [    0.000000] rcu: 	RCU event tracing is enabled.
> [    0.000000] 	Trampoline variant of Tasks RCU enabled.
> [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
> [    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
> [    0.000000] IRQ: Found an INTC at 0x(ptrval) (revision 5.0) with 128 interrupts
> [    0.000000] random: get_random_bytes called from start_kernel+0x330/0x4c4 with crng_init=0
> [    0.004513] IRQ pipeline enabled

Just tried with PROVE_LOCKING, and DEBUG_DOVETAIL enabled. Still ok (evl
test suite passes as well).

-- 
Philippe.

