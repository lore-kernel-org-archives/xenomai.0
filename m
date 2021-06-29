From: wayhoo <wayhoo@sina.com>
Subject: linux-evl-5.10.46-evl1: INTC/gpmc is not pipeline-safe warning
Message-ID: <239ad2a2-c093-86ee-3d1f-f38abd2df673@sina.com>
Date: Tue, 29 Jun 2021 15:12:58 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

     Ported linux-evl-5.10.46-evl1 to an am335x board, two warnings 
occurred at kernel startup, but evl test passed.

     1. when CONFIG_SMP was not enabled, INTC warning information occurred:

[    0.002179] IRQ pipeline enabled
[    0.002190] TI gptimer clocksource: always-on 
/ocp/interconnect@44c00000/segment@200000/target-module@31000
[    0.002196] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps 
every 89478484971ns
[    0.002202] clocksource: dmtimer: freq: 24000000 Hz, mask: 0xffffffff 
max_cycles: 0xffffffff, max_idle_ns: 79635851949 ns
[    0.002206] ------------[ cut here ]------------
[    0.002211] WARNING: CPU: 0 PID: 0 at kernel/irq/chip.c:53 
irq_set_chip+0xc0/0xe0
[    0.002215] irqchip INTC is not pipeline-safe!Modules linked in:
[    0.002228] CPU: 0 PID: 0 Comm: swapper Not tainted 5.10.46 #1
[    0.002233] Hardware name: Generic AM33XX (Flattened Device Tree)
[    0.002235] IRQ stage: Linux
[    0.002240] [<c010c348>] (unwind_backtrace) from [<c010a0f0>] 
(show_stack+0x10/0x14)
[    0.002245] [<c010a0f0>] (show_stack) from [<c07c9ac0>] 
(__warn+0xc4/0x120)
[    0.002250] [<c07c9ac0>] (__warn) from [<c07c9b94>] 
(warn_slowpath_fmt+0x78/0xac)
[    0.002255] [<c07c9b94>] (warn_slowpath_fmt) from [<c016b82c>] 
(irq_set_chip+0xc0/0xe0)
[    0.002260] [<c016b82c>] (irq_set_chip) from [<c016cecc>] 
(irq_set_chip_and_handler_name+0x28/0x8c)
[    0.002265] [<c016cecc>] (irq_set_chip_and_handler_name) from 
[<c0170494>] (irq_domain_set_info+0x24/0x40)
[    0.002271] [<c0170494>] (irq_domain_set_info) from [<c016e1bc>] 
(irq_map_generic_chip+0x104/0x188)
[    0.002277] [<c016e1bc>] (irq_map_generic_chip) from [<c016f4e8>] 
(irq_domain_associate+0x7c/0x1fc)
[    0.002282] [<c016f4e8>] (irq_domain_associate) from [<c016fdfc>] 
(irq_create_mapping_affinity+0x64/0xd0)
[    0.002288] [<c016fdfc>] (irq_create_mapping_affinity) from 
[<c017027c>] (irq_create_fwspec_mapping+0x1e0/0x308)
[    0.002293] [<c017027c>] (irq_create_fwspec_mapping) from 
[<c01703f4>] (irq_create_of_mapping+0x50/0x78)
[    0.002299] [<c01703f4>] (irq_create_of_mapping) from [<c05f1688>] 
(irq_of_parse_and_map+0x34/0x5c)
[    0.002304] [<c05f1688>] (irq_of_parse_and_map) from [<c0b261ec>] 
(dmtimer_clkevt_init_common+0x64/0x168)
[    0.002310] [<c0b261ec>] (dmtimer_clkevt_init_common) from 
[<c0b26790>] (dmtimer_systimer_init+0x4a0/0x654)
[    0.002315] [<c0b26790>] (dmtimer_systimer_init) from [<c0b255f4>] 
(timer_probe+0x70/0xec)
[    0.002320] [<c0b255f4>] (timer_probe) from [<c0b00cb4>] 
(start_kernel+0x368/0x4f0)
[    0.002324] [<c0b00cb4>] (start_kernel) from [<00000000>] (0x0)
[    0.002328] ---[ end trace 531e75c85aa4fd9f ]---
[    0.002334] TI gptimer clockevent: 24000000 Hz at 
/ocp/interconnect@48000000/segment@0/target-module@40000
[    0.002536] Calibrating delay loop... 586.13 BogoMIPS (lpj=2930688)
[    0.060890] pid_max: default: 32768 minimum: 301
[    0.061128] Mount-cache hash table entries: 1024 (order: 0, 4096 
bytes, linear)
[    0.061151] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 
bytes, linear)
[    0.062283] CPU: Testing write buffer coherency: ok
[    0.062373] CPU0: Spectre v2: using BPIALL workaround
[    0.063491] Setting up static identity map for 0x80100000 - 0x80100060
[    0.063688] rcu: Hierarchical SRCU implementation.

     2. when CONFIG_SMP was enabled,  there was no INTC warning, but 
gpmc warning occurred:

[    7.596903] omap-gpmc 50000000.gpmc: GPMC revision 6.0
[    7.602570] gpmc_mem_init: disabling cs 0 mapped at 0x0-0x1000000
[    7.613268] ------------[ cut here ]------------
[    7.613283] WARNING: CPU: 0 PID: 50 at kernel/irq/chip.c:53 
irq_set_chip+0xc0/0xe0
[    7.613291] irqchip gpmc is not pipeline-safe!Modules linked in:
[    7.613311] CPU: 0 PID: 50 Comm: kworker/0:2 Not tainted 5.10.46 #8
[    7.613319] Hardware name: Generic AM33XX (Flattened Device Tree)
[    7.613326] IRQ stage: Linux
[    7.613333] Workqueue: events deferred_probe_work_func
[    7.613347] [<c010de0c>] (unwind_backtrace) from [<c010a5f4>] 
(show_stack+0x10/0x14)
[    7.613355] [<c010a5f4>] (show_stack) from [<c081daac>] 
(dump_stack+0xbc/0xd4)
[    7.613364] [<c081daac>] (dump_stack) from [<c08194e4>] 
(__warn+0xc0/0x11c)
[    7.613372] [<c08194e4>] (__warn) from [<c08195b8>] 
(warn_slowpath_fmt+0x78/0xac)
[    7.613381] [<c08195b8>] (warn_slowpath_fmt) from [<c018d968>] 
(irq_set_chip+0xc0/0xe0)
[    7.613390] [<c018d968>] (irq_set_chip) from [<c018f170>] 
(irq_set_chip_and_handler_name+0x28/0x8c)
[    7.613399] [<c018f170>] (irq_set_chip_and_handler_name) from 
[<c062ce84>] (gpmc_irq_map+0x6c/0x74)
[    7.613408] [<c062ce84>] (gpmc_irq_map) from [<c01921d4>] 
(irq_domain_associate+0x7c/0x200)
[    7.613417] [<c01921d4>] (irq_domain_associate) from [<c0192bc4>] 
(irq_create_mapping_affinity+0x64/0xd0)
[    7.613426] [<c0192bc4>] (irq_create_mapping_affinity) from 
[<c0193794>] (irq_create_fwspec_mapping+0x214/0x370)
[    7.613436] [<c0193794>] (irq_create_fwspec_mapping) from 
[<c0193940>] (irq_create_of_mapping+0x50/0x78)
[    7.613444] [<c0193940>] (irq_create_of_mapping) from [<c0623e6c>] 
(of_irq_get+0x84/0xc0)
[    7.613453] [<c0623e6c>] (of_irq_get) from [<c0623ed0>] 
(of_irq_to_resource+0x28/0xf8)
[    7.613462] [<c0623ed0>] (of_irq_to_resource) from [<c0623fdc>] 
(of_irq_to_resource_table+0x3c/0x54)
[    7.613471] [<c0623fdc>] (of_irq_to_resource_table) from [<c061d2a4>] 
(of_device_alloc+0xfc/0x2a4)
[    7.613480] [<c061d2a4>] (of_device_alloc) from [<c061d494>] 
(of_platform_device_create_pdata+0x48/0xc4)
[    7.613490] [<c061d494>] (of_platform_device_create_pdata) from 
[<c0820d98>] (gpmc_probe_generic_child+0x810/0x8b4)
[    7.613499] [<c0820d98>] (gpmc_probe_generic_child) from [<c062f788>] 
(gpmc_probe+0x4b8/0x560)
[    7.613507] [<c062f788>] (gpmc_probe) from [<c0545cac>] 
(platform_drv_probe+0x48/0x98)
[    7.613516] [<c0545cac>] (platform_drv_probe) from [<c0543b44>] 
(really_probe+0xf0/0x4bc)
[    7.613525] [<c0543b44>] (really_probe) from [<c0544218>] 
(driver_probe_device+0x5c/0xb4)
[    7.613533] [<c0544218>] (driver_probe_device) from [<c0541cc0>] 
(bus_for_each_drv+0x80/0xd0)
[    7.613542] [<c0541cc0>] (bus_for_each_drv) from [<c0543fe4>] 
(__device_attach+0xd4/0x194)
[    7.613551] [<c0543fe4>] (__device_attach) from [<c0542d60>] 
(bus_probe_device+0x88/0x90)
[    7.613560] [<c0542d60>] (bus_probe_device) from [<c0543198>] 
(deferred_probe_work_func+0x7c/0xac)
[    7.613569] [<c0543198>] (deferred_probe_work_func) from [<c0143d68>] 
(process_one_work+0x258/0x538)
[    7.613578] [<c0143d68>] (process_one_work) from [<c01440a8>] 
(worker_thread+0x60/0x568)
[    7.613586] [<c01440a8>] (worker_thread) from [<c0149cb8>] 
(kthread+0x178/0x180)
[    7.613595] [<c0149cb8>] (kthread) from [<c0100158>] 
(ret_from_fork+0x14/0x3c)
[    7.613602] Exception stack(0xc1ef9fb0 to 0xc1ef9ff8)
[    7.613611] 9fa0:                                     00000000 
00000000 00000000 00000000
[    7.613619] 9fc0: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[    7.613627] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    7.613635] ---[ end trace bb76a02053b474e6 ]---
[    7.950583] nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xdc
[    7.957484] nand: Micron MT29F4G08ABADAWP
[    7.961744] nand: 512 MiB, SLC, erase size: 128 KiB, page size: 2048, 
OOB size: 64
[    7.970350] nand: using OMAP_ECC_BCH8_CODE_HW ECC scheme
[    7.976654] 11 fixed-partitions partitions found on MTD device 
omap2-nand.0

     3. below is the patch for gpmc warning, it just simply masks the 
warning.

diff -uNr a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
--- a/drivers/memory/omap-gpmc.c    2021-06-27 23:33:13.000000000 +0800
+++ b/drivers/memory/omap-gpmc.c    2021-06-29 13:09:45.151032676 +0800
@@ -1405,6 +1405,7 @@
      gpmc->irq_chip.irq_mask = gpmc_irq_mask;
      gpmc->irq_chip.irq_unmask = gpmc_irq_unmask;
      gpmc->irq_chip.irq_set_type = gpmc_irq_set_type;
+    gpmc->irq_chip.flags = IRQCHIP_PIPELINE_SAFE;

      gpmc_irq_domain = irq_domain_add_linear(gpmc->dev->of_node,
                          gpmc->nirqs,

     4. What more needs to be done to timer-ti-dm-timer.c and/or 
omap-gpmc.c? any advice, please.


wayhoo



