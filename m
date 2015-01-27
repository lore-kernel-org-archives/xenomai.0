Date: Tue, 27 Jan 2015 14:09:25 +0100
From: Arnaud Degroote <arnaud.degroote@isae.fr>
Message-ID: <20150127130925.GA22089@dmia-degroote.isae.fr>
References: <20150126190241.GA10160@bugfree>
 <20150126190911.GN12812@hermes.click-hack.org>
 <20150126195219.GA10959@bugfree>
 <20150126195409.GA1491@hermes.click-hack.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150126195409.GA1491@hermes.click-hack.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Porting Xenomai on Odroid-U3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 26/Jan - 20:54, Gilles Chanteperdrix wrote:
> On Mon, Jan 26, 2015 at 08:52:19PM +0100, Arnaud Degroote wrote:
> > On 26/Jan - 20:09, Gilles Chanteperdrix wrote:
> > > On Mon, Jan 26, 2015 at 08:02:41PM +0100, Arnaud Degroote wrote:
> > > > Hi list,
> > > > 
> > > > I'm trying to port Xenomai on Odroid-U3. I read on the list that there
> > > > is a first try by GP Orcullo, so I start from its work.
> > > > 
> > > > I'm working on a 3.17.8 kernel on which I ported the Ipipe / Xenomai
> > > > patch. I validated it on two omaps platform where I don't see regression
> > > > against previous version of the patch, so I'm fairly confident that the
> > > > core part is correct. In a second time, I ported the previous effort of
> > > > GP Orcullo. The current state of the effort is available on 
> > > > 
> > > > https://github.com/adegroote/linux/tree/linux-stable-xenomai-odroid-3.17.y
> > > > 
> > > > I tested without IPIPE, and with IPIPE. Troubles start with the XENOMAI
> > > > option. Basically, the kernel seems to hangs when I load any "skin" (I
> > > > compiled them in modules to be sure). For example, 
> > > > 
> > > > modprobe xeno-native
> > > > 
> > > > prints
> > > > 
> > > > Xenomai: starting native API services.	
> > > > 
> > > > but I cannot get back the shell prompt.
> > > > 
> > > > From the Troubleshooting part, I suppose something is wrong with the
> > > > ipipe_timer, but I don't have much idea where to look for. 
> > > > 
> > > > Can someone give me some inputs about how to trace / debug this issue
> > > > or/and quickly check if I miss something obvious in my patch.
> > > > 
> > > > https://github.com/adegroote/linux/commit/81c6ebeb3127efdceb3e31f9d3f1f400ecbb579f.patch
> > > 
> > > Well, you should put some printks in the timer code to see what is
> > > the last action done. Is the ->ack function called, does it really
> > > acknowledge the timer interrupt at timer level (because if it does
> > > not, the interrupt will trigger again at the end of the current
> > > interrupt).
> > 
> > Thanks Gilles,
> > I will try tomorrow morning, when I will be back to work.
> > > 
> > > Could you post a link to the patched file handling the timer ?
> > 
> > The timer used is exynos-mct, available here
> > 
> > https://github.com/adegroote/linux/blob/linux-stable-xenomai-odroid-3.17.y/drivers/clocksource/exynos_mct.c
> 
> The ISR is wrong. The acknowledge should be skipped when the timer is
> stolen, not the event handler.

After fixing this issue and a few other one, the situation has improved.
However, I notice that I hit the warning !!hard_irqs_disabled from
__ipipe_set_irq_pending.

As suggested in a previous thread about U3, I replace the IPIPE_WARN_ONCE by

if (!hard_irqs_disabled())
{
	ipipe_trace_panic_freeze();
	ipipe_trace_panic_dump();
	BUG();
}

and get the following trace

[    2.889126] device-mapper: ioctl: 4.27.0-ioctl (2013-10-30) initialised: dm-devel@redhat.com
[    2.892469] sdhci: Secure Digital Host Controller Interface driver
[    2.898260] sdhci: Copyright(c) Pierre Ossman
[    2.905232] s3c-sdhci 12530000.sdhci: clock source 2: mmc_busclk.2 (50000000 Hz)
[    2.910396] s3c-sdhci 12530000.sdhci: Got CD GPIO #99.
[    2.927454] s3c-sdhci 12530000.sdhci: No vqmmc regulator found
[    2.962112] I-pipe tracer log (100 points):
[    2.962178]      #func               0 ipipe_trace_panic_freeze+0x10 (__ipipe_set_irq_pending+0xc8)
[    2.969511]      #func               0 __ipipe_set_irq_pending+0x10 (__ipipe_dispatch_irq+0x150)
[    2.978103]      #func              -1 exynos_irq_ack+0x10 (__ipipe_ack_level_irq+0x30)
[    2.985915]  |   #end     0x80000001     -1 __ipipe_spin_unlock_irqrestore+0x4c (exynos_irq_mask+0x90)
[    2.995202]  |   #func              -2 __ipipe_spin_unlock_irqrestore+0x10 (exynos_irq_mask+0x90)
[    3.003882]  |   #begin   0x80000001     -3 __ipipe_spin_lock_irqsave+0x60 (exynos_irq_mask+0x3c)
[    3.012736]      #func              -3 __ipipe_spin_lock_irqsave+0x10 (exynos_irq_mask+0x3c)
[    3.020982]      #func              -4 exynos_irq_mask+0x10 (__ipipe_ack_level_irq+0x4c)
[    3.028881]      #func              -5 __ipipe_ack_level_irq+0x10 (__ipipe_dispatch_irq+0x260)
[    3.037300]      #func              -5 irq_to_desc+0x10 (__ipipe_dispatch_irq+0x1bc)
[    3.044852]      #func              -6 irq_to_desc+0x10 (__ipipe_dispatch_irq+0x1ac)
[    3.052404]      #func              -6 __ipipe_dispatch_irq+0x10 (exynos_eint_gpio_irq+0x70)
[    3.060649]      #begin   0x000000ab     -7 exynos_eint_gpio_irq+0x64 (handle_irq_event_percpu+0x78)
[    3.069763]      #func              -8 exynos_eint_gpio_irq+0x10 (handle_irq_event_percpu+0x78)
[    3.078270]      #func              -9 handle_irq_event_percpu+0x14 (handle_irq_event+0x4c)
[    3.086429]      #func              -9 do_raw_spin_unlock+0x10 (_raw_spin_unlock+0x18)
[    3.094154]      #func             -10 _raw_spin_unlock+0x10 (handle_irq_event+0x40)
[    3.101706]      #func             -10 handle_irq_event+0x10 (handle_fasteoi_irq+0x84)
[    3.109431]      #func             -11 do_raw_spin_lock+0x10 (_raw_spin_lock+0x18)
[    3.116809]      #func             -12 _raw_spin_lock+0x10 (handle_fasteoi_irq+0x28)
[    3.124361]      #func             -12 handle_fasteoi_irq+0x10 (generic_handle_irq+0x3c)
[    3.132260]      #func             -13 generic_handle_irq+0x10 (handle_IRQ+0x48)
[    3.139464]      #func             -14 ipipe_root_only+0x10 (irq_enter+0x54)
[    3.146321]  |   #end     0x80000001    -15 rcu_irq_enter+0xcc (irq_enter+0x20)
[    3.153613]  |   #begin   0x80000001    -15 rcu_irq_enter+0xb0 (irq_enter+0x20)
[    3.160904]      #func             -16 rcu_irq_enter+0x10 (irq_enter+0x20)
[    3.167587]      #func             -16 irq_enter+0x10 (handle_IRQ+0x2c)
[    3.174011]      #func             -17 handle_IRQ+0x10 (__ipipe_do_IRQ+0x1c)
[    3.180868]      #func             -18 __ipipe_do_IRQ+0x10 (__ipipe_do_sync_stage+0x218)
[    3.188766]  |   #end     0x80000000    -18 __ipipe_do_sync_stage+0x23c (ipipe_unstall_root+0x74)
[    3.197620]  |   +func             -19 __ipipe_do_sync_stage+0x14 (ipipe_unstall_root+0x74)
[    3.205779]  |   #func             -20 ipipe_root_only+0x10 (ipipe_unstall_root+0x24)
[    3.213417]  |   #begin   0x80000000    -20 ipipe_unstall_root+0x6c (_raw_spin_unlock_irqrestore+0x28)
[    3.222705]      #func             -21 ipipe_unstall_root+0x10 (_raw_spin_unlock_irqrestore+0x28)
[    3.231385]      #func             -21 do_raw_spin_unlock+0x10 (_raw_spin_unlock_irqrestore+0x1c)
[    3.240065]      #func             -22 _raw_spin_unlock_irqrestore+0x10 (__setup_irq+0x3b4)
[    3.248224]      #func             -23 check_irq_resend+0x14 (irq_startup+0x90)
[    3.255342]  |   #end     0x80000001    -23 irq_enable+0x68 (irq_startup+0xd0)
[    3.262547]  |   #func             -24 __ipipe_spin_unlock_irqrestore+0x10 (exynos_irq_unmask+0x9c)
[    3.271400]  |   #func             -25 __ipipe_spin_lock_irqsave+0x10 (exynos_irq_unmask+0x48)
[    3.279819]  |   #func             -25 exynos_irq_unmask+0x10 (irq_enable+0x4c)
[    3.286937]  |   #begin   0x80000001    -25 irq_enable+0x78 (irq_startup+0xd0)
[    3.294141]      #func             -26 irq_enable+0x10 (irq_startup+0xd0)
[    3.300738]      #func             -27 irq_startup+0x10 (__setup_irq+0x49c)
[    3.307509]      #func             -28 __fixup_irq_handler+0x10 (exynos_irq_set_type+0x84)
[    3.315581]      #func             -29 irq_to_desc+0x10 (exynos_irq_set_type+0x70)
[    3.322959]      #func             -30 exynos_irq_set_type+0x10 (__irq_set_trigger+0x64)
[    3.330858]      #func             -31 __irq_set_trigger+0x10 (__setup_irq+0x46c)
[    3.338149]      #func             -32 __raw_spin_lock_init+0x10 (__init_waitqueue_head+0x2c)
[    3.346482]      #func             -32 __init_waitqueue_head+0x10 (__setup_irq+0x250)
[    3.354120]  |   #end     0x90000000    -33 __ipipe_fast_svc_irq_exit+0x18 (__ipipe_spin_unlock_irqrestore+0x50)
[    3.364276]  |   #func             -33 __ipipe_bugon_irqs_enabled+0x10 (__ipipe_fast_svc_irq_exit+0x4)
[    3.373390]  |   #func             -34 __ipipe_check_root_interruptible+0x10 (__irq_svc+0x5c)
[    3.381723]  |   #func             -34 __ipipe_exit_irq+0x10 (__ipipe_grab_irq+0x5c)
[    3.389274]  |   #end     0x0000004e    -35 __ipipe_grab_irq+0x54 (gic_handle_irq+0x48)
[    3.397260]  |   #func             -36 __ipipe_do_sync_pipeline+0x10 (__ipipe_dispatch_irq+0x1a4)
[    3.405940]  |   #func             -36 __ipipe_set_irq_pending+0x10 (__ipipe_dispatch_irq+0x150)
[    3.414533]  |   #func             -37 __ipipe_spin_unlock_irqrestore+0x10 (gic_hold_irq+0xa8)
[    3.422953]  |   #func             -38 gic_get_percpu_base+0x10 (gic_hold_irq+0x98)
[    3.430418]  |   #func             -39 gic_get_percpu_base+0x10 (gic_hold_irq+0x40)
[    3.437882]  |   #func             -39 __ipipe_spin_lock_irqsave+0x10 (gic_hold_irq+0x30)
[    3.445868]  |   #func             -40 gic_hold_irq+0x10 (__ipipe_ack_fasteoi_irq+0x24)
[    3.453680]  |   #func             -41 __ipipe_ack_fasteoi_irq+0x10 (__ipipe_dispatch_irq+0x260)
[    3.462273]  |   #func             -42 irq_to_desc+0x10 (__ipipe_dispatch_irq+0x1bc)
[    3.469825]  |   #func             -43 irq_to_desc+0x10 (__ipipe_dispatch_irq+0x1ac)
[    3.477376]  |   #func             -44 __ipipe_dispatch_irq+0x10 (__ipipe_grab_irq+0x4c)
[    3.485275]  |   #begin   0x0000004e    -45 __ipipe_grab_irq+0x28 (gic_handle_irq+0x48)
[    3.493261]  |   #func             -45 __ipipe_grab_irq+0x10 (gic_handle_irq+0x48)
[    3.500639]  |   #func             -46 irq_find_mapping+0x14 (gic_handle_irq+0x40)
[    3.508017]  |   #func             -47 gic_get_percpu_base+0x10 (gic_handle_irq+0x2c)
[    3.515655]  |   #func             -48 gic_handle_irq+0x10 (__irq_svc+0x58)
[    3.522426]  |   #begin   0x90000000    -49 __irq_svc+0x44 (__ipipe_spin_unlock_irqrestore+0x50)
[    3.531193]  |   #end     0x80000001    -50 __ipipe_spin_unlock_irqrestore+0x4c (exynos_irq_unmask+0x9c)
[    3.540654]  |   #func             -50 __ipipe_spin_unlock_irqrestore+0x10 (exynos_irq_unmask+0x9c)
[    3.549507]  |   #begin   0x80000001    -51 __ipipe_spin_lock_irqsave+0x60 (exynos_irq_unmask+0x48)
[    3.558534]      #func             -51 __ipipe_spin_lock_irqsave+0x10 (exynos_irq_unmask+0x48)
[    3.566954]      #func             -52 exynos_irq_unmask+0x10 (exynos_irq_request_resources+0xc0)
[    3.575634]  |   #end     0x80000001    -52 __ipipe_spin_unlock_irqrestore+0x4c (exynos_irq_request_resources+0xb8)
[    3.586050]  |   #func             -53 __ipipe_spin_unlock_irqrestore+0x10 (exynos_irq_request_resources+0xb8)
[    3.595859]  |   #begin   0x80000001    -54 __ipipe_spin_lock_irqsave+0x60 (exynos_irq_request_resources+0x5c)
[    3.605840]      #func             -55 __ipipe_spin_lock_irqsave+0x10 (exynos_irq_request_resources+0x5c)
[    3.615215]  |   #end     0x80000001    -55 gpio_lock_as_irq+0x80 (exynos_irq_request_resources+0x30)
[    3.624416]  |   #begin   0x80000001    -56 gpio_lock_as_irq+0x6c (exynos_irq_request_resources+0x30)
[    3.633616]      #func             -57 gpio_lock_as_irq+0x10 (exynos_irq_request_resources+0x30)
[    3.642209]      #func             -57 exynos_irq_request_resources+0x10 (__setup_irq+0x230)
[    3.650456]      #func             -59 do_raw_spin_lock+0x10 (_raw_spin_lock_irqsave+0x4c)
[    3.658528]  |   #end     0x80000001    -59 _raw_spin_lock_irqsave+0x78 (__setup_irq+0x94)
[    3.666774]  |   +begin   0x80000001    -59 _raw_spin_lock_irqsave+0x5c (__setup_irq+0x94)
[    3.675020]      +func             -60 _raw_spin_lock_irqsave+0x10 (__setup_irq+0x94)
[    3.682659]  |   +end     0x80000001    -61 __setup_irq+0x454 (request_threaded_irq+0xbc)
[    3.690818]  |   +begin   0x80000001    -61 __setup_irq+0x440 (request_threaded_irq+0xbc)
[    3.698977]  |   +end     0x80000000    -62 ipipe_unstall_root+0x58 (_raw_spin_unlock_irqrestore+0x28)
[    3.708264]  |   #func             -62 ipipe_root_only+0x10 (ipipe_unstall_root+0x24)
[    3.715903]  |   #begin   0x80000000    -63 ipipe_unstall_root+0x6c (_raw_spin_unlock_irqrestore+0x28)
[    3.725191]      #func             -63 ipipe_unstall_root+0x10 (_raw_spin_unlock_irqrestore+0x28)
[    3.733871]      #func             -64 do_raw_spin_unlock+0x10 (_raw_spin_unlock_irqrestore+0x1c)
[    3.742550]      #func             -64 _raw_spin_unlock_irqrestore+0x10 (rt_mutex_adjust_pi+0xa4)
[    3.751230]      #func             -64 do_raw_spin_lock+0x10 (_raw_spin_lock_irqsave+0x4c)
[    3.759303]  |   #end     0x80000001    -65 _raw_spin_lock_irqsave+0x78 (rt_mutex_adjust_pi+0x28)
[    3.768157]  |   +begin   0x80000001    -65 _raw_spin_lock_irqsave+0x5c (rt_mutex_adjust_pi+0x28)
[    3.777027] ------------[ cut here ]------------
[    3.781613] kernel BUG at kernel/ipipe/core.c:587!
[    3.786387] Internal error: Oops - BUG: 0 [#1] ARM
[    3.791159] Modules linked in:
[    3.794203] CPU: 0 PID: 1 Comm: swapper Not tainted 3.17.8-00007-gef5da60-dirty #80
[    3.801840] task: ea084000 ti: ea086000 task.ti: ea086000
[    3.807223] PC is at __ipipe_set_irq_pending+0xcc/0x10c
[    3.812429] LR is at console_unlock+0x228/0x4bc
[    3.816943] pc : [<c0087b54>]    lr : [<c0051b78>]    psr: 60000153
[    3.816943] sp : ea087a90  ip : c00518b4  fp : ea087abc
[    3.828398] r10: c0743b40  r9 : c0743b40  r8 : 00000002
[    3.833606] r7 : 000000ac  r6 : c0745ef0  r5 : 000000ab  r4 : c0743b40
[    3.840116] r3 : 00000000  r2 : c0741ddc  r1 : 00000080  r0 : 00000001
[    3.846628] Flags: nZCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
[    3.854005] Control: 10c53c7d  Table: 40004059  DAC: 00000015
[    3.859734] Process swapper (pid: 1, stack limit = 0xea086238)
[    3.865549] Stack: (0xea087a90 to 0xea088000)
[    3.869892] 7a80:                                     00002340 c0743b40 000000ab c0745ef0
[    3.878053] 7aa0: 000000ac 00000002 c0743b40 c0743b40 ea087ae4 ea087ac0 c008926c c0087a94
[    3.886211] 7ac0: 000000ab ea007ba4 0000004e 00000000 00000000 00000000 ea087afc ea087ae8
[    3.894370] 7ae0: c0294e00 c0089128 c0294d90 ea17be00 ea087b4c ea087b00 c005410c c0294d9c
[    3.902529] 7b00: ea087b3c ea087b10 c000f230 c008c1cc c0901341 ea007b40 c0901540 c090152c
[    3.910688] 7b20: c004d0c0 ea007b40 ea007ba4 ea17be00 00000000 c0743b44 c0743b40 c0990040
[    3.918847] 7b40: ea087b6c ea087b50 c0054358 c00540a0 00000000 ea007b40 ea007ba4 c08d2910
[    3.927007] 7b60: ea087b8c ea087b70 c0056ec4 c0054318 c0056e40 0000004e 0000004e 00000000
[    3.935166] 7b80: ea087ba4 ea087b90 c00538cc c0056e4c 000000ac c08d25cc ea087bc4 ea087ba8
[    3.943325] 7ba0: c000fb60 c005389c c09913c0 0000004e c0990040 0000004f ea087bd4 ea087bc8
[    3.951484] 7bc0: c0015bf4 c000fb24 ea087c1c ea087bd8 c0088af4 c0015be4 c0990040 c0990000
[    3.959644] 7be0: c0745ef0 c0743b40 c0743b44 c0743b48 ffffffff 00000000 e9951ec0 ea21f364
[    3.967802] 7c00: 000000ab 00000000 ea21f33c 00000000 ea087c2c ea087c20 c0088c14 c00888e8
[    3.975962] 7c20: ea087c44 ea087c30 c04d7998 c0088bac 00000000 ea21f300 ea087c7c ea087c48
[    3.984121] 7c40: c005571c c04d797c 000000ab e98895a0 ea087c6c e9951ec0 ea21f300 c0054378
[    3.992280] 7c60: 00002003 000000ab ea3b2800 c03dd278 ea087cac ea087c80 c0055a18 c0055374
[    4.000439] 7c80: 00002003 e9951990 ea3b2800 000000ab 00000000 c03dd278 ea3b2808 e988ec50
[    4.008598] 7ca0: ea087cdc ea087cb0 c0057e60 c0055968 e98895a0 ea3b2800 ea3b2800 e98895a0
[    4.016758] 7cc0: 000000ab ea3b2800 00000000 00000200 ea087d0c ea087ce0 c03dd260 c0057e04
[    4.024917] 7ce0: 00002003 e98895a0 ea3b2800 00000000 ea3b2b80 ea3b2800 00000000 ea3b2b80
[    4.033076] 7d00: ea087d24 ea087d10 c03d25c4 c03dd1cc 00000000 ea3b2800 ea087d3c ea087d28
[    4.041236] 7d20: c03d3884 c03d2578 ea3b2c28 00000000 ea087d6c ea087d40 c03e6acc c03d383c
[    4.049395] 7d40: e988ec00 ea3b2b80 ea3b2b80 00000004 ea133610 ea133600 ea3b2cec 00000001
[    4.057553] 7d60: ea087dbc ea087d70 c03e7d6c c03e6364 02faf080 00000000 c08f5478 0000006b
[    4.065713] 7d80: 5f636d6d 63737562 332e6b6c ea087d00 c008c1f8 ea133610 c08f53b0 00000000
[    4.073872] 7da0: c08f53b0 00000000 e988e1c0 00000000 ea087dd4 ea087dc0 c02f7ac4 c03e79bc
[    4.082032] 7dc0: c09da1ec ea133610 ea087dfc ea087dd8 c02f5d4c c02f7a94 00000000 ea133610
[    4.090191] 7de0: c08f53b0 ea133644 00000000 c06db568 ea087e1c ea087e00 c02f5f70 c02f5c40
[    4.098349] 7e00: ea12e5cc 00000000 c08f53b0 c02f5ed4 ea087e44 ea087e20 c02f4030 c02f5ee0
[    4.106509] 7e20: ea003c78 ea12e5c0 c000f230 c08f53b0 e9889500 c08ebcc0 ea087e54 ea087e48
[    4.114668] 7e40: c02f57f0 c02f3fcc ea087e7c ea087e58 c02f5468 c02f57d0 c062e7d0 ea087e68
[    4.122827] 7e60: c08f53b0 c073cae0 c0709748 ea086038 ea087e94 ea087e80 c02f6798 c02f5318
[    4.130987] 7e80: c073cae0 c073cae0 ea087ea4 ea087e98 c02f7a80 c02f671c ea087eb4 ea087ea8
[    4.139146] 7ea0: c0709764 c02f7a28 ea087f4c ea087eb8 c0008ac4 c0709754 c008c1f8 c008b250
[    4.147305] 7ec0: ea087efc 00000000 c000f230 c008c1cc ea087efc ea087ee0 c06db584 c02739f4
[    4.155465] 7ee0: c06db500 eb7ff876 c04fe920 00000092 ea087f4c ea087f00 c003b340 c06db574
[    4.163623] 7f00: ea087f34 ea087f10 00000006 00000006 eb7ff89a c066fe74 00000000 c06257ec
[    4.171783] 7f20: c004b524 c07317d0 00000006 c0903600 c0903600 c06db568 c0714edc c0714ee8
[    4.179942] 7f40: ea087f94 ea087f50 c06dbe18 c0008a34 00000006 00000006 c06db568 ea087f68
[    4.188101] 7f60: c04d79b8 00000092 ea087f94 00003600 c04ce4f8 00000000 00000000 00000000
[    4.196260] 7f80: 00000000 00000000 ea087fac ea087f98 c04ce514 c06dbcf4 00000000 00000000
[    4.204419] 7fa0: 00000000 ea087fb0 c000f150 c04ce504 00000000 00000000 00000000 00000000
[    4.212578] 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    4.220737] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[    4.228913] [<c0087b54>] (__ipipe_set_irq_pending) from [<c008926c>] (__ipipe_dispatch_irq+0x150/0x2f8)
[    4.238280] [<c008926c>] (__ipipe_dispatch_irq) from [<c0294e00>] (exynos_eint_gpio_irq+0x70/0x94)
[    4.247220] [<c0294e00>] (exynos_eint_gpio_irq) from [<c005410c>] (handle_irq_event_percpu+0x78/0x278)
[    4.256503] [<c005410c>] (handle_irq_event_percpu) from [<c0054358>] (handle_irq_event+0x4c/0x6c)
[    4.265357] [<c0054358>] (handle_irq_event) from [<c0056ec4>] (handle_fasteoi_irq+0x84/0x120)
[    4.273863] [<c0056ec4>] (handle_fasteoi_irq) from [<c00538cc>] (generic_handle_irq+0x3c/0x4c)
[    4.282462] [<c00538cc>] (generic_handle_irq) from [<c000fb60>] (handle_IRQ+0x48/0x94)
[    4.290358] [<c000fb60>] (handle_IRQ) from [<c0015bf4>] (__ipipe_do_IRQ+0x1c/0x24)
[    4.297910] [<c0015bf4>] (__ipipe_do_IRQ) from [<c0088af4>] (__ipipe_do_sync_stage+0x218/0x2c4)
[    4.306587] [<c0088af4>] (__ipipe_do_sync_stage) from [<c0088c14>] (ipipe_unstall_root+0x74/0x78)
[    4.315440] [<c0088c14>] (ipipe_unstall_root) from [<c04d7998>] (_raw_spin_unlock_irqrestore+0x28/0x2c)
[    4.324816] [<c04d7998>] (_raw_spin_unlock_irqrestore) from [<c005571c>] (__setup_irq+0x3b4/0x55c)
[    4.333755] [<c005571c>] (__setup_irq) from [<c0055a18>] (request_threaded_irq+0xbc/0x13c)
[    4.342002] [<c0055a18>] (request_threaded_irq) from [<c0057e60>] (devm_request_threaded_irq+0x68/0xac)
[    4.351382] [<c0057e60>] (devm_request_threaded_irq) from [<c03dd260>] (mmc_gpiod_request_cd_irq+0xa0/0xb8)
[    4.361106] [<c03dd260>] (mmc_gpiod_request_cd_irq) from [<c03d25c4>] (mmc_start_host+0x58/0x80)
[    4.369865] [<c03d25c4>] (mmc_start_host) from [<c03d3884>] (mmc_add_host+0x54/0x78)
[    4.377590] [<c03d3884>] (mmc_add_host) from [<c03e6acc>] (sdhci_add_host+0x774/0xa64)
[    4.385489] [<c03e6acc>] (sdhci_add_host) from [<c03e7d6c>] (sdhci_s3c_probe+0x3bc/0x548)
[    4.393649] [<c03e7d6c>] (sdhci_s3c_probe) from [<c02f7ac4>] (platform_drv_probe+0x3c/0x6c)
[    4.401987] [<c02f7ac4>] (platform_drv_probe) from [<c02f5d4c>] (driver_probe_device+0x118/0x24c)
[    4.410836] [<c02f5d4c>] (driver_probe_device) from [<c02f5f70>] (__driver_attach+0x9c/0xa0)
[    4.419255] [<c02f5f70>] (__driver_attach) from [<c02f4030>] (bus_for_each_dev+0x70/0xa4)
[    4.427413] [<c02f4030>] (bus_for_each_dev) from [<c02f57f0>] (driver_attach+0x2c/0x30)
[    4.435398] [<c02f57f0>] (driver_attach) from [<c02f5468>] (bus_add_driver+0x15c/0x204)
[    4.443383] [<c02f5468>] (bus_add_driver) from [<c02f6798>] (driver_register+0x88/0x108)
[    4.451456] [<c02f6798>] (driver_register) from [<c02f7a80>] (__platform_driver_register+0x64/0x6c)
[    4.460492] [<c02f7a80>] (__platform_driver_register) from [<c0709764>] (sdhci_s3c_driver_init+0x1c/0x20)
[    4.470035] [<c0709764>] (sdhci_s3c_driver_init) from [<c0008ac4>] (do_one_initcall+0x9c/0x1ec)
[    4.478718] [<c0008ac4>] (do_one_initcall) from [<c06dbe18>] (kernel_init_freeable+0x130/0x1d0)
[    4.487396] [<c06dbe18>] (kernel_init_freeable) from [<c04ce514>] (kernel_init+0x1c/0x100)
[    4.495642] [<c04ce514>] (kernel_init) from [<c000f150>] (ret_from_fork+0x18/0x24)
[    4.503187] Code: e5813118 e89daff8 eb000f17 eb000bf7 (e7f001f2) 
[    4.509287] Kernel panic - not syncing: Fatal exception in interrupt
[    4.515680] ---[ end trace dcdf11b24ffcd499 ]---

through I'm not sure how to really interpret the trace.

I suppose the offender is related to exynos_eint_gpio_irq available here

https://github.com/adegroote/linux/blob/linux-stable-xenomai-odroid-3.17.y/drivers/pinctrl/samsung/pinctrl-exynos.c#L278

but from documentation and other code sample, I don't see the cause of the trouble.
Any idea / guidance is welcome. Thanks in advance,
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150127/1eaaaf2e/attachment.sig>
