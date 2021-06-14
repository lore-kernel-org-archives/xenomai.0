From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: dovetail on x86: TSC switching and the fallout
Message-ID: <ad8fbcff-8e4c-723a-380b-d5acfe6ea530@siemens.com>
Date: Mon, 14 Jun 2021 18:46:42 +0200
MIME-Version: 1.0
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
To: Xenomai <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>

Hi Philippe,

we are still looking for the reasons, but some systems here consider the 
TSC already unstable during early boot (can be reproduced with
"tsc=unstable"):

2021-06-11T17:12:17 [    2.059118] TSC synchronization [CPU#0 -> CPU#2]:
2021-06-11T17:12:17 [    2.059124] Measured 63 cycles TSC warp between CPUs, turning off TSC clock.
2021-06-11T17:12:17 [    2.059128] tsc: Marking TSC unstable due to check_tsc_sync_source failed

As we know, this will cause troubles later on. An immediate result is

[    1.858649] IRQ pipeline: high-priority Xenomai stage added.
[    1.859341] IRQ pipeline: oob stage found stalled while modifying in-band
[    1.859342]               interrupt state and/or running sleeping code
[    1.859343] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.10.42+ #153
[    1.859343] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[    1.859344] IRQ stage: Linux
[    1.859345] Call Trace:
[    1.859345]  dump_stack+0x84/0x9c
[    1.859346]  inband_irq_save+0xa/0x30
[    1.859346]  read_hpet+0x66/0x110
[    1.859347]  ktime_get_mono_fast_ns+0x53/0xb0
[    1.859347]  ? rdinit_setup+0x2b/0x2b
[    1.859348]  xnlock_dbg_prepare_acquire+0xe/0x20
[    1.859348]  ____xnlock_get.constprop.25+0x3b/0xa0
[    1.859349]  xnclock_init+0x95/0xe6
[    1.859349]  pipeline_init+0x23/0x49
[    1.859350]  xenomai_init+0x10c/0x264
[    1.859350]  ? xnclock_init+0xe6/0xe6
[    1.859351]  do_one_initcall+0x64/0x320
[    1.859352]  ? rdinit_setup+0x2b/0x2b
[    1.859352]  ? rcu_read_lock_sched_held+0x52/0x90
[    1.859353]  kernel_init_freeable+0x228/0x266
[    1.859353]  ? rest_init+0x250/0x250
[    1.859354]  kernel_init+0xa/0x120
[    1.859354]  ret_from_fork+0x22/0x30

because read_hpet is not oob-ready. Are clocksources on x86 supposed to 
be usable with Dovetail, or is this expected because nothing by tsc 
should be active?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

