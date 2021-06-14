References: <ad8fbcff-8e4c-723a-380b-d5acfe6ea530@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: dovetail on x86: TSC switching and the fallout
In-reply-to: <ad8fbcff-8e4c-723a-380b-d5acfe6ea530@siemens.com>
Date: Mon, 14 Jun 2021 19:28:19 +0200
Message-ID: <87wnqw5pak.fsf@xenomai.org>
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


Jan Kiszka <jan.kiszka@siemens.com> writes:

> Hi Philippe,
>
> we are still looking for the reasons, but some systems here consider the 
> TSC already unstable during early boot (can be reproduced with
> "tsc=unstable"):
>
> 2021-06-11T17:12:17 [    2.059118] TSC synchronization [CPU#0 -> CPU#2]:
> 2021-06-11T17:12:17 [    2.059124] Measured 63 cycles TSC warp between CPUs, turning off TSC clock.
> 2021-06-11T17:12:17 [    2.059128] tsc: Marking TSC unstable due to check_tsc_sync_source failed
>
> As we know, this will cause troubles later on. An immediate result is
>
> [    1.858649] IRQ pipeline: high-priority Xenomai stage added.
> [    1.859341] IRQ pipeline: oob stage found stalled while modifying in-band
> [    1.859342]               interrupt state and/or running sleeping code
> [    1.859343] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.10.42+ #153
> [    1.859343] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [    1.859344] IRQ stage: Linux
> [    1.859345] Call Trace:
> [    1.859345]  dump_stack+0x84/0x9c
> [    1.859346]  inband_irq_save+0xa/0x30
> [    1.859346]  read_hpet+0x66/0x110
> [    1.859347]  ktime_get_mono_fast_ns+0x53/0xb0
> [    1.859347]  ? rdinit_setup+0x2b/0x2b
> [    1.859348]  xnlock_dbg_prepare_acquire+0xe/0x20
> [    1.859348]  ____xnlock_get.constprop.25+0x3b/0xa0
> [    1.859349]  xnclock_init+0x95/0xe6
> [    1.859349]  pipeline_init+0x23/0x49
> [    1.859350]  xenomai_init+0x10c/0x264
> [    1.859350]  ? xnclock_init+0xe6/0xe6
> [    1.859351]  do_one_initcall+0x64/0x320
> [    1.859352]  ? rdinit_setup+0x2b/0x2b
> [    1.859352]  ? rcu_read_lock_sched_held+0x52/0x90
> [    1.859353]  kernel_init_freeable+0x228/0x266
> [    1.859353]  ? rest_init+0x250/0x250
> [    1.859354]  kernel_init+0xa/0x120
> [    1.859354]  ret_from_fork+0x22/0x30
>
> because read_hpet is not oob-ready. Are clocksources on x86 supposed to 
> be usable with Dovetail, or is this expected because nothing by tsc 
> should be active?

The common requirement applies to x86 clocksources: they need to be made
oob-capable. HPET was not fixed up that way, I may have postponed doing
this sine die because that particular hardware is a mess in and of
itself: it requires CPUs to either serialize on access or use a cached
value.

I see no obvious problem in fixing read_hpet() to make it oob-capable as
follows (I don't think it would be safe to take the NMI path
unconditionally if oob. EVL is SMP scalable, so having a truckload of
concurrent CPUs running real-time stuff may be an option here, and we
don't want to take any chance allowing those CPUs to read the HPET
counter simultaneously un-serialized.

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 67a9f248270ca7f..ce8e15aa8a97b8f 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -811,7 +811,7 @@ static u64 read_hpet(struct clocksource *cs)
 	if (arch_spin_is_locked(&old.lock))
 		goto contended;
 
-	local_irq_save(flags);
+	flags = hard_local_irq_save();
 	if (arch_spin_trylock(&hpet.lock)) {
 		new.value = hpet_readl(HPET_COUNTER);
 		/*
@@ -819,10 +819,10 @@ static u64 read_hpet(struct clocksource *cs)
 		 */
 		WRITE_ONCE(hpet.value, new.value);
 		arch_spin_unlock(&hpet.lock);
-		local_irq_restore(flags);
+		hard_local_irq_restore(flags);
 		return (u64)new.value;
 	}
-	local_irq_restore(flags);
+	hard_local_irq_restore(flags);
 
 contended:
 	/*

There is another aspect, which is accessing the clocksource via the vDSO
via Dovetail's generic MMIO interface. We cannot do that with acpi_pm
(this one is accessed via I/O ports), hpet would also be a problem
unless we read that counter unconditionally since we would not be able
to serialize CPUs on the kernel spinlock - back to square #1
performance-wise.

With HPET, some simple fixup like the one above would be required, and
Cobalt would also need a way to respond to clock_gettime* requests that
did not go through the vDSO directly from the oob stage, as illustrated
by this EVL code [2].

[1] https://evlproject.org/dovetail/porting/clocksource/
[2] https://source.denx.de/Xenomai/xenomai4/linux-evl/-/blob/3451245cdc9846835f8a2786767b17037ee13dda/kernel/evl/syscall.c#L205

-- 
Philippe.

