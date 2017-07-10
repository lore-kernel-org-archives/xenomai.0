From: Nitin Kulkarni <nitink@kth.se>
Date: Mon, 10 Jul 2017 08:32:32 +0000
Message-ID: <1499675553334.21481@kth.se>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Kernel Warning : I-pipe: Detected illicit call from head
 domain 'Xenomai'
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I am getting this message from I-Pipe trace when I enabled the I-pipe debug=
 option.

Does this affect the performance of my driver in terms of execution time ? =
and does this mean it switches mode from primary to

secondary mode ?

Background:

I am trying to port the linux spi-driver to rtdm driver and instead of goin=
g all the way from scratch

I thought of just trying to remove all the linux related scheduling and try=
 to initiate the transfer directly in

real-time domain. I think I have done that partially (dma completion interr=
upt is still in non-real time domain) but I get this message the first time=
 when I send some data over spi. I know that it is because of some memory a=
llocation for setting the dma buffers

but the transmission is successful and quite quick now because I removed th=
e mechanism used by linux which used tasklets

and work queues to schedule the transfer.  I just want the transfer to star=
t as soon as possible triggered by an interrupt.


Trace is as below:

~# [ 7544.181965] I-pipe: Detected illicit call from head domain 'Xenomai'
[ 7544.181965]         into a regular Linux service
[ 7544.194343] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G           O    4.4.=
43-yocto-standard #34
[ 7544.203952] Hardware name: Intel Corp. Broxton M/SDS, BIOS GTPP161A.X64.=
0143.B30.1611152208 11/15/2016
[ 7544.214440]  ffffffffa263a634 a63536d03e2ff61c ffffffffa2deba80 ffffffff=
a263a634
[ 7544.222815]  000000000000e0e0 ffffffffa3376600 ffffffffa2debab0 ffffffff=
a2303f3c
[ 7544.231186]  00000000024000c0 00000000024000c0 0000000000000020 ffff8801=
7a001c00
[ 7544.239558] Call Trace:
[ 7544.242318]  [<ffffffffa263a634>] ? dump_stack+0x96/0xc2
[ 7544.248305]  [<ffffffffa263a634>] dump_stack+0x96/0xc2
[ 7544.254095]  [<ffffffffa2303f3c>] ipipe_root_only+0x15c/0x1b0
[ 7544.260572]  [<ffffffffa23d8efd>] __kmalloc+0x1cd/0x270
[ 7544.266459]  [<ffffffffa264b279>] ? sg_kmalloc+0x19/0x30
[ 7544.272445]  [<ffffffffa264b279>] sg_kmalloc+0x19/0x30
[ 7544.279878]  [<ffffffffa264b18d>] __sg_alloc_table+0xfd/0x160
[ 7544.287982]  [<ffffffffa264b260>] ? sg_free_table+0x70/0x70
[ 7544.295875]  [<ffffffffa264b862>] sg_alloc_table+0x22/0x90
[ 7544.303668]  [<ffffffffc045d1c9>] spi_map_buf.isra.8+0xa9/0x2f0 [spi_tes=
t_rtdm]
[ 7544.313511]  [<ffffffffc045d125>] ? spi_map_buf.isra.8+0x5/0x2f0 [spi_te=
st_rtdm]
[ 7544.323465]  [<ffffffffc045d666>] pump_messages+0x256/0x54c [spi_test_rt=
dm]
[ 7544.332942]  [<ffffffffc045d0f7>] intr_handler+0x57/0x80 [spi_test_rtdm]
[ 7544.342148]  [<ffffffffa2347d14>] xnintr_irq_handler+0xf4/0x410
[ 7544.350481]  [<ffffffffa2304b6c>] __ipipe_do_sync_stage+0x10c/0x270
[ 7544.359178]  [<ffffffffa2304e2b>] __ipipe_do_sync_pipeline+0x8b/0x1e0
[ 7544.368025]  [<ffffffffa2305791>] __ipipe_dispatch_irq+0xc1/0x350
[ 7544.376484]  [<ffffffffa223819c>] __ipipe_handle_irq+0xbc/0x2c0
[ 7544.384752]  [<ffffffffa2b193f5>] common_interrupt+0x75/0x95
[ 7544.392721]  [<ffffffffa2308c34>] ? ipipe_trace_end+0x14/0x20
[ 7544.400816]  [<ffffffffa2237cca>] ? __ipipe_halt_root+0x5a/0xc0
[ 7544.409125]  [<ffffffffa220eb9f>] mwait_idle+0x7f/0x1b0
[ 7544.416670]  [<ffffffffa220f15f>] arch_cpu_idle+0xf/0x20
[ 7544.424297]  [<ffffffffa22b4ada>] default_idle_call+0x2a/0x40
[ 7544.432397]  [<ffffffffa22b4d6e>] cpu_startup_entry+0x27e/0x320
[ 7544.440682]  [<ffffffffa2b122b4>] rest_init+0x84/0x90
[ 7544.447991]  [<ffffffffa31b4ff7>] start_kernel+0x4bc/0x4dd
[ 7544.455788]  [<ffffffffa31b42fe>] x86_64_start_reservations+0x2a/0x2c
[ 7544.464639]  [<ffffffffa31b4468>] x86_64_start_kernel+0x168/0x176
[ 7544.473069] I-pipe tracer log (100 points):
[ 7544.479354]  |# func                    0 ipipe_trace_panic_freeze+0x0 (=
ipipe_root_only+0x13a)
[ 7544.490758]  |# func                    0 ipipe_root_only+0x0 (__kmalloc=
+0x1cd)
[ 7544.500692]  |# func                   -1 kmalloc_slab+0x0 (__kmalloc+0x=
2e)
[ 7544.510227]  |# func                   -1 __kmalloc+0x0 (sg_kmalloc+0x19=
)
[ 7544.519584]  |# func                   -2 __virt_addr_valid+0x0 (spi_map=
_buf.isra.8+0x27f [spi_test_rtdm])
[ 7544.532217]  |# func                   -3 spi_map_buf.isra.8+0x0 [spi_te=
st_rtdm] (pump_messages+0x256 [spi_test_rtdm])
[ 7544.546079]  |# func                   -4 pxa2xx_spi_can_dma+0x0 [spi_px=
a2xx_platform] (pump_messages+0x231 [spi_test_rtdm])
[ 7544.560575]  |# func                   -5 __ipipe_spin_unlock_irqrestore=
+0x0 (pump_messages+0xf2 [spi_test_rtdm])
[ 7544.574023]  |# func                   -6 __ipipe_spin_lock_irqsave+0x0 =
(pump_messages+0x2c [spi_test_rtdm])
[ 7544.586992]  |# func                   -6 pump_messages+0x0 [spi_test_rt=
dm] (intr_handler+0x57 [spi_test_rtdm])
[ 7544.600279]  |# func                   -7 intr_handler+0x0 [spi_test_rtd=
m] (xnintr_irq_handler+0xf4)
[ 7544.612501]  |# func                   -9 xnintr_irq_handler+0x0 (__ipip=
e_do_sync_stage+0x10c)
[ 7544.624115]  |+ func                   -9 __ipipe_do_sync_stage+0x0 (__i=
pipe_do_sync_pipeline+0x8b)
[ 7544.636193]  | +func                  -10 __ipipe_do_sync_pipeline+0x0 (=
__ipipe_dispatch_irq+0xc1)
[ 7544.648144]  | +end     0x0000012c    -16 ipipe_trace_end+0x14 (ipipe_ir=
q_cascade+0xf1 [pinctrl_intel])
[ 7544.660615]  | +func                  -16 __ipipe_set_irq_pending+0x0 (_=
_ipipe_dispatch_irq+0x2a0)
[ 7544.672610]  | +func                  -17 intel_get_community+0x0 [pinct=
rl_intel] (intel_gpio_irq_ack+0x3e [pinctrl_intel])
[ 7544.687068]  | +func                  -17 intel_gpio_irq_ack+0x0 [pinctr=
l_intel] (__ipipe_ack_level_irq+0x4d)
[ 7544.700173]  | #func                  -18 __ipipe_spin_unlock_irqrestore=
+0x0 (intel_gpio_irq_mask+0x73 [pinctrl_intel])
[ 7544.714302]  | #func                  -23 intel_get_community+0x0 [pinct=
rl_intel] (__intel_gpio_irq_mask_unmask+0x22 [pinctrl_intel])
[ 7544.731792]  | #func                  -23 __intel_gpio_irq_mask_unmask+0=
x0 [pinctrl_intel] (intel_gpio_irq_mask+0x68 [pinctrl_intel])
[ 7544.749477]  | #func                  -24 __ipipe_lock_irq+0x0 (intel_gp=
io_irq_mask+0x86 [pinctrl_intel])
[ 7544.762447]  | +func                  -25 __ipipe_spin_lock_irqsave+0x0 =
(intel_gpio_irq_mask+0x30 [pinctrl_intel])
[ 7544.776329]  | +func                  -25 intel_gpio_irq_mask+0x0 [pinct=
rl_intel] (__ipipe_ack_level_irq+0x3b)
[ 7544.789840]  | +func                  -26 __ipipe_ack_level_irq+0x0 (__i=
pipe_dispatch_irq+0x72)
[ 7544.801874]  | +func                  -27 irq_to_desc+0x0 (__ipipe_dispa=
tch_irq+0xe1)
[ 7544.812944]  | +func                  -27 irq_to_desc+0x0 (__ipipe_dispa=
tch_irq+0xd1)
[ 7544.823973]  | +func                  -28 __ipipe_dispatch_irq+0x0 (ipip=
e_irq_cascade+0xe9 [pinctrl_intel])
[ 7544.837201]  | +begin   0x0000012c    -28 ipipe_irq_cascade+0xdc [pinctr=
l_intel] (__ipipe_dispatch_irq+0x72)
[ 7544.850529]  | +func                  -28 irq_find_mapping+0x0 (ipipe_ir=
q_cascade+0xd1 [pinctrl_intel])
[ 7544.863407]  | +func                  -36 apic_ack_edge+0x0 (irq_chip_ac=
k_parent+0x14)
[ 7544.874611]  | +func                  -37 irq_chip_ack_parent+0x0 (ipipe=
_irq_cascade+0x3a [pinctrl_intel])
[ 7544.887821]  | +func                  -37 ipipe_irq_cascade+0x0 [pinctrl=
_intel] (__ipipe_dispatch_irq+0x72)
[ 7544.901159]  | +func                  -38 irq_to_desc+0x0 (__ipipe_dispa=
tch_irq+0xe1)
[ 7544.912349]  | +func                  -39 irq_to_desc+0x0 (__ipipe_dispa=
tch_irq+0xd1)
[ 7544.923510]  | +func                  -39 __ipipe_dispatch_irq+0x0 (__ip=
ipe_handle_irq+0xbc)
[ 7544.935378]  | +begin   0x0000000e    -39 __ipipe_halt_root+0x5a (common=
_interrupt+0x75)
[ 7544.946862]  | +func                  -40 __ipipe_handle_irq+0x0 (common=
_interrupt+0x75)
[ 7544.958357]  | +end     0x8000000e   -413 ipipe_trace_end+0x14 (__ipipe_=
halt_root+0x46)
[ 7544.969777]  | #begin   0x80000000   -414 __ipipe_halt_root+0x71 (mwait_=
idle+0x7f)
[ 7544.980726]    #func                 -414 __ipipe_halt_root+0x0 (mwait_i=
dle+0x7f)
[ 7544.991565]    #func                 -415 mwait_idle+0x0 (arch_cpu_idle+=
0xf)
[ 7545.001925]    #func                 -415 arch_cpu_idle+0x0 (default_idl=
e_call+0x2a)
[ 7545.013067]    #func                 -415 default_idle_call+0x0 (cpu_sta=
rtup_entry+0x27e)
[ 7545.024719]  | #end     0x80000001   -416 ipipe_trace_end+0x14 (ipipe_ro=
ot_only+0x83)
[ 7545.035993]  | #begin   0x80000001   -416 ipipe_root_only+0xa0 (ipipe_re=
store_root+0x12)
[ 7545.047531]    #func                 -417 ipipe_root_only+0x0 (ipipe_res=
tore_root+0x12)
[ 7545.058977]    #func                 -417 ipipe_restore_root+0x0 (rcu_id=
le_enter+0xd2)
[ 7545.070310]    #func                 -417 rcu_idle_enter+0x0 (cpu_startu=
p_entry+0x279)
[ 7545.081647]    #func                 -418 tick_check_broadcast_expired+0=
x0 (cpu_startup_entry+0xf8)
[ 7545.094252]    #func                 -418 __rcu_read_unlock+0x0 (atomic_=
notifier_call_chain+0x3a)
[ 7545.106654]    #func                 -418 notifier_call_chain+0x0 (atomi=
c_notifier_call_chain+0x33)
[ 7545.119247]    #func                 -419 __rcu_read_lock+0x0 (atomic_no=
tifier_call_chain+0x1c)
[ 7545.131427]    #func                 -419 atomic_notifier_call_chain+0x0=
 (arch_cpu_idle_enter+0x29)
[ 7545.143996]    #func                 -419 local_touch_nmi+0x0 (arch_cpu_=
idle_enter+0xe)
[ 7545.155390]    #func                 -420 arch_cpu_idle_enter+0x0 (cpu_s=
tartup_entry+0xe9)
[ 7545.167056]  | +end     0x80000000   -420 ipipe_trace_end+0x14 (ipipe_un=
stall_root+0x4d)
[ 7545.178537]  | #func                 -421 ipipe_root_only+0x0 (ipipe_uns=
tall_root+0x16)
[ 7545.189904]  | #begin   0x80000000   -421 ipipe_unstall_root+0x5c (tick_=
nohz_idle_enter+0x6e)
[ 7545.201870]    #func                 -421 ipipe_unstall_root+0x0 (tick_n=
ohz_idle_enter+0x6e)
[ 7545.213726]  | #end     0x80000001   -422 ipipe_trace_end+0x14 (ipipe_ro=
ot_only+0x83)
[ 7545.224897]  | #begin   0x80000001   -422 ipipe_root_only+0xa0 (ipipe_re=
store_root+0x12)
[ 7545.236326]    #func                 -422 ipipe_root_only+0x0 (ipipe_res=
tore_root+0x12)
[ 7545.247634]    #func                 -423 ipipe_restore_root+0x0 (_raw_s=
pin_unlock_irqrestore+0x1f)
[ 7545.260088]    #func                 -423 _raw_spin_unlock_irqrestore+0x=
0 (hrtimer_start_range_ns+0x1bb)
[ 7545.273031]    #func                 -423 __ipipe_spin_unlock_debug+0x0 =
(hrtimer_start_range_ns+0x1ab)
[ 7545.285743]  | #end     0x80000000   -424 ipipe_trace_end+0x14 (__ipipe_=
restore_head+0x50)
[ 7545.297275]  |*#func                 -424 __ipipe_restore_head+0x0 (prog=
ram_htick_shot+0xfa)
[ 7545.308977]  |*#func                 -425 lapic_next_deadline+0x0 (ipipe=
_timer_set+0x72)
[ 7545.320270]  |*#func                 -425 ipipe_timer_set+0x0 (xnclock_c=
ore_local_shot+0x6f)
[ 7545.331942]  |*#event   tick@7560182109  -425 xnclock_core_local_shot+0x=
67 (xntimer_enqueue_and_program+0x56)
[ 7545.345294]  |*#func                 -426 xnclock_core_local_shot+0x0 (x=
ntimer_enqueue_and_program+0x56)
[ 7545.358167]  |*#func                 -426 xntimer_heading_p+0x0 (xntimer=
_enqueue_and_program+0x2d)
[ 7545.370454]  |*#func                 -426 xntimerq_insert+0x0 (xntimer_e=
nqueue_and_program+0x18)
[ 7545.382578]  |*#func                 -427 xntimer_enqueue_and_program+0x=
0 (xntimer_start+0x107)
[ 7545.394587]  |*#func                 -427 xnclock_core_ns_to_ticks+0x0 (=
xntimer_start+0x1d5)
[ 7545.406286]  |*#func                 -427 xntimer_start+0x0 (program_hti=
ck_shot+0xaa)
[ 7545.417279]  | #begin   0x80000000   -428 program_htick_shot+0x25 (clock=
events_program_event+0x82)
[ 7545.429555]    #func                 -428 program_htick_shot+0x0 (clocke=
vents_program_event+0x82)
[ 7545.441732]    #func                 -428 ktime_get+0x0 (clockevents_pro=
gram_event+0x47)
[ 7545.453011]    #func                 -429 clockevents_program_event+0x0 =
(tick_program_event+0x44)
[ 7545.465172]    #func                 -429 tick_program_event+0x0 (hrtime=
r_start_range_ns+0x328)
[ 7545.477172]    #func                 -429 enqueue_hrtimer+0x0 (hrtimer_s=
tart_range_ns+0x180)
[ 7545.488872]  | #end     0x80000000   -430 ipipe_trace_end+0x14 (__ipipe_=
restore_head+0x50)
[ 7545.500392]  |*#func                 -430 __ipipe_restore_head+0x0 (prog=
ram_htick_shot+0xfa)
[ 7545.512125]  |*#func                 -431 lapic_next_deadline+0x0 (ipipe=
_timer_set+0x72)
[ 7545.523458]  |*#func                 -431 ipipe_timer_set+0x0 (xnclock_c=
ore_local_shot+0x6f)
[ 7545.535165]  |*#event   tick@7561823740  -431 xnclock_core_local_shot+0x=
67 (xntimer_enqueue_and_program+0x56)
[ 7545.548571]  |*#func                 -432 xnclock_core_local_shot+0x0 (x=
ntimer_enqueue_and_program+0x56)
[ 7545.561527]  |*#func                 -432 xntimer_heading_p+0x0 (xntimer=
_enqueue_and_program+0x2d)
[ 7545.573904]  |*#func                 -432 xntimerq_insert+0x0 (xntimer_e=
nqueue_and_program+0x18)
[ 7545.586073]  |*#func                 -433 xntimer_enqueue_and_program+0x=
0 (xntimer_start+0x107)
[ 7545.598152]  |*#func                 -433 xnclock_core_ns_to_ticks+0x0 (=
xntimer_start+0x1d5)
[ 7545.609950]  |*#func                 -433 xntimer_start+0x0 (program_hti=
ck_shot+0xaa)
[ 7545.621057]  | #begin   0x80000000   -434 program_htick_shot+0x25 (clock=
events_program_event+0x82)
[ 7545.633462]    #func                 -434 program_htick_shot+0x0 (clocke=
vents_program_event+0x82)
[ 7545.645777]    #func                 -435 ktime_get+0x0 (clockevents_pro=
gram_event+0x47)
[ 7545.657207]    #func                 -435 clockevents_program_event+0x0 =
(tick_program_event+0x44)
[ 7545.669510]    #func                 -436 tick_program_event+0x0 (__remo=
ve_hrtimer+0x78)
[ 7545.680941]    #func                 -436 __hrtimer_get_next_event+0x0 (=
__remove_hrtimer+0x5a)

Regards,
Nitin

