MIME-Version: 1.0
References: <CABJm_X0vbaGg-vdNf87EB_Qck4ftzkixEtC5oBW5ZJONN4jeKw@mail.gmail.com>
In-Reply-To: <CABJm_X0vbaGg-vdNf87EB_Qck4ftzkixEtC5oBW5ZJONN4jeKw@mail.gmail.com>
From: "Ramappa. Hugar." <rainbow2ramu@gmail.com>
Date: Thu, 18 Oct 2018 12:53:53 +0530
Message-ID: <CABJm_X3S7r=dRxpLGb+2Xwai3oqGfXtDxx58rhMMGVXrT9K4Rg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] [ipipe-arm64] Xenomai porting on msm-4.9 kernel for
 DB410C SOC
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Before modifying the PDC.c driver. and with some debugging enabled. I have
seen the following

[    4.787872] task: ffffffe470b68080 task.stack: ffffffe470b54000
[    4.793855] PC is at 0x0
[    4.796438] LR is at __ipipe_ack_fasteoi_irq+0x28/0x38
[    4.801631] pc : [<0000000000000000>] lr : [<ffffff857c7318c8>] pstate:
804001c5
(snip)
[    8.442478] Exception stack(0xffffffc5f0b73030 to 0xffffffc5f0b73160)
[    5.058522] 6f00: 6967736d20313d6e 3031303178303d64 303d726464612038
6420383039303478
[    5.066420] [<          (null)>]           (null)
[    5.071180] [<ffffff857c786b88>] __ipipe_dispatch_irq+0x88/0x1e8
[    5.077244] [<ffffff857c68157c>] __ipipe_grab_irq+0x8c/0xa0
[    5.082874] Exception stack(0xffffffe470b57050 to 0xffffffe470b57180)
(snip)
[    5.259404] [<ffffff857c6837c4>] el1_irq+0xc4/0x104
[    5.264334] [<ffffff857c696edc>] ftrace_graph_caller+0x1c/0x30
[    5.270223] [<ffffff857c69d068>] ipipe_test_root+0x10/0x38
[    5.275766] [<ffffff857c68b7d8>] unwind_frame+0x1a8/0x1b8
[    5.281224] [<ffffff857c68b81c>] walk_stackframe+0x34/0x58
[    5.286764] [<ffffff857c6901a4>] return_address+0x64/0xa0
[    5.292228] [<ffffff857c7a0738>] trace_hardirqs_off+0x100/0x310
[    5.298216] [<ffffff857d1fa978>] _raw_spin_lock_irq+0x20/0x68
[    5.304025] [<ffffff857d1f6ff0>] wait_for_common+0x50/0x178
[    5.309656] [<ffffff857d1f717c>] wait_for_completion_timeout+0x2c/0x38
[    5.316253] [<ffffff857cba18e8>] rpmh_write+0x150/0x1d8
[    5.321531] [<ffffff857cbf0624>]
rpmh_regulator_send_aggregate_requests+0x26c/0x550
[    5.329257] [<ffffff857cbf21c4>]
rpmh_regulator_vrm_set_mode_index+0x5c/0xc0
[    5.336371] [<ffffff857cbf229c>] rpmh_regulator_vrm_set_load+0x74/0x80
[    5.342968] [<ffffff857cbe0b38>] drms_uA_update+0xf0/0x348
[    5.348507] [<ffffff857cbe0dcc>] regulator_set_load+0x3c/0x60
[    5.354314] [<ffffff857cbe61b0>]
regulator_proxy_consumer_register+0x228/0x340
[    5.361601] [<ffffff857cbe2350>] regulator_register+0x990/0x1158
[    5.367662] [<ffffff857cbe49d4>] devm_regulator_register+0x54/0xb0
[    5.373905] [<ffffff857cbf0f40>] rpmh_regulator_probe+0x638/0x1648
[    5.380153] [<ffffff857cc390e8>] platform_drv_probe+0x60/0xc8
[    5.385959] [<ffffff857cc36a14>] driver_probe_device+0x22c/0x418

The senario is something like this
1. The RPMH driver is providing the regulators to some consumers during the
probe.
2. rpmh_write() is being called during the probe. Which has a
"might_sleep()" annotation.

After digging a bit deeper. The wait_for_common() API has an
"might_sleep()" annotation as well.

Is there any specific ipipe related implementaion for the '
wait_for_completion_timeout ' ?

Thanks,
Ramappa




On Thu, Oct 18, 2018 at 12:02 PM Ramappa. Hugar. <rainbow2ramu@gmail.com>
wrote:

>
> Ramappa. Hugar. <rainbow2ramu@gmail.com>
> 10:34 AM (1 hour ago)
> to xenomai
>
> Dear all,
>
>
>
> Trying to port the xenomai on DB410c soc with kernel
> https://source.codeaurora.org/kernel/msm-4.9.git
>
>
>
> Ported the arm64 ipipe and xenomai patches. Trying to make soc related
> changes
>
> .
>
> Following '
> https://gitlab.denx.de/Xenomai/xenomai/wikis/Porting_Xenomai_To_A_New_Arm_SOC#flow-handler'
> link to port xenomai on new SOC.
>
> Here we could find three interrupt controller drivers in which we need to
> add .mask and .unmask callbacks.
>
>    - drivers/gpio/gpio-msm-smp2p.c
>
>    - drivers/pinctrl/qcom/pinctrl-msm.c
>
>    - drivers/irqchip/qcom/pdc.c
>
>
>
> 1.  'drivers/irqchip/qcom/pdc.c' made following changes to support xenomai.
>
> *----------------------  *
>
> *diff --git a/drivers/irqchip/qcom/pdc.c b/drivers/irqchip/qcom/pdc.c*
>
> *index ba7b6da..5772760 100644*
>
> *--- a/drivers/irqchip/qcom/pdc.c*
>
> *+++ b/drivers/irqchip/qcom/pdc.c*
>
> *@@ -40,7 +40,8 @@ enum pdc_register_offsets {*
>
> *        IRQ_i_CFG = 0x110,*
>
> * };*
>
>
>
> *-static DEFINE_SPINLOCK(pdc_lock);*
>
> *+//static DEFINE_SPINLOCK(pdc_lock);*
>
> *+static IPIPE_DEFINE_SPINLOCK(pdc_lock);*
>
> * static void __iomem *pdc_base;*
>
>
>
> * static int get_pdc_pin(irq_hw_number_t hwirq, void *data)*
>
> *@@ -228,8 +229,14 @@ static struct irq_chip qcom_pdc_gic_chip = {*
>
> *        .irq_disable            = qcom_pdc_gic_disable,*
>
> *        .irq_retrigger          = irq_chip_retrigger_hierarchy,*
>
> *        .irq_set_type           = qcom_pdc_gic_set_type,*
>
> *+#ifdef CONFIG_IPIPE*
>
> *+       .irq_hold               = qcom_pdc_gic_mask,*
>
> *+       .irq_release            = qcom_pdc_gic_unmask,*
>
> *+#endif*
>
> *+*
>
> *        .flags                  = IRQCHIP_MASK_ON_SUSPEND |*
>
> *                                        IRQCHIP_SET_TYPE_MASKED |*
>
> *+                                       IRQCHIP_PIPELINE_SAFE |*
>
> *                                        IRQCHIP_SKIP_SET_WAKE,*
>
> *----------------------*
>
> Not  finding equivalent API for 'irq_domain_add_hierarchy'.
>
> *---------------------- *
>
> *       pdc_domain = irq_domain_add_hierarchy(parent_domain, 0, MAX_IRQS,*
>
> *                        node, &qcom_pdc_ops, data);*
>
> *---------------------- *
>
>
>
> After this changes target is getting hang while booting.
>
>
>
> Could you please help me to port this driver ?
>
>
>
> Thanks,
>
> Ramappa
>
