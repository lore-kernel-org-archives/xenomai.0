MIME-Version: 1.0
In-Reply-To: <20150519183909.GH10686@hermes.click-hack.org>
References: <CAKC9m6cqL6vFttH3QJM9Z64YqHscF1QGCeP6dq5w=XepGDXgeQ@mail.gmail.com>
 <20150513180613.GE3759@hermes.click-hack.org>
 <CAKC9m6edtqma0t4ddUpqker1Ofx5YDyV6TUXNY3EAZnxyDu2vQ@mail.gmail.com>
 <20150518173654.GC10686@hermes.click-hack.org>
 <CAKC9m6d025dA-8hZ=tRS86+RP9jomraT9MKvBBDdiBNo9DUmwQ@mail.gmail.com>
 <20150519183909.GH10686@hermes.click-hack.org>
Date: Fri, 29 May 2015 14:32:51 -0700
Message-ID: <CAKC9m6e3=O2jhAQ124Mv4+7kEHpkqFFD4THpTgTa=0zWbCJNAA@mail.gmail.com>
From: Hongfei Cheng <hongfei@mperpetuo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai]
	=?utf-8?b?SVJRIGZsb3cgaGFuZGxlcjog4oCcaGFuZGxlX2VkZ2Vf?=
	=?utf-8?b?aXJx4oCdIHZzIOKAnGhhbmRsZV9sZXZlbF9pcnHigJ0=?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Tue, May 19, 2015 at 11:39 AM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:
> On Tue, May 19, 2015 at 10:23:36AM -0700, Hongfei Cheng wrote:
>> On Mon, May 18, 2015 at 10:36 AM, Gilles Chanteperdrix
>> <gilles.chanteperdrix@xenomai.org> wrote:
>> > On Mon, May 18, 2015 at 10:32:49AM -0700, Hongfei Cheng wrote:
>> >> On Wed, May 13, 2015 at 11:06 AM, Gilles Chanteperdrix
>> >> <gilles.chanteperdrix@xenomai.org> wrote:
>> >> > On Wed, May 13, 2015 at 12:55:46AM -0700, Hongfei Cheng wrote:
>> >> >> Hi All,
>> >> >>
>> >> >> In the document of "Porting Xenomai dual kernel to a new ARM SoC",
>> >> >> section "flow handler" states: If the flow handler is
>> >> >> =E2=80=9Chandle_edge_irq=E2=80=9D, and the system locks up when th=
e first interrupt
>> >> >> happens, try replacing =E2=80=9Chandle_edge_irq=E2=80=9D with =E2=
=80=9Chandle_level_irq=E2=80=9D.
>> >> >>
>> >> >> Could anyone explain why =E2=80=9Chandle_edge_irq=E2=80=9D can cau=
se system to hang
>> >> >> while =E2=80=9Chandle_level_irq=E2=80=9D doesn't? I searched the a=
rchives but
failed
>> >> >> to find any discussion on this topic.
>> >> >
>> >> > level irqs are acked and masked at interrupt controller level on
>> >> > entry, whereas edge interrupts are only acked. The Adeos patch
>> >> > unmasks the irqs at processor level after this initial ack and mask
>> >> > or ack. So, if the interrupt controller keeps the interrupt asserte=
d
>> >> > at the processor level when the level stays the same (IOW, if the
>> >> > interrupt controller only supports the "level" behaviour), unmaskin=
g
>> >> > the interrupt line will cause the interrupt to trigger again, being
>> >> > ack again, etc... without any chance for the handler to ack the
>> >> > interrupt at device level. The fix is to use handle_level_irq so
>> >> > that the irq is masked at interrupt controller level before irqs ar=
e
>> >> > unmasked at processor level.
>> >> >
>> >> > This does not happen with an unpatched kernel, because irqs are not
>> >> > unmasked at processor level until the handler has had a chance to
>> >> > execute and ack the interrupt at device level.
>> >>
>> >> Gilles, thank you for the detailed explanation.
>> >>
>> >> For ARM Cortex-A9/A15/A57, can we make the following statements as to
>> >> which irq flow handler can be used for a specific interrupt:
>> >> 1. An interrupt input is programmed as "level-sensitive" on the
>> >> interrupt controller (GIC): only flow handler =E2=80=9Chandle_level_i=
rq=E2=80=9D
>> >> should be used at the device driver level.
>> >> 2. An interrupt input is programmed as "edge-triggered" on the
>> >> interrupt controller (GIC): either "edge" or "level" flow handler can
>> >> be used at the device driver level.
>> >
>> > I believe on cortex A9, the GIC irqs are of the "fasteoi" type.
>> > Which is a kind of level, but requires more patching of the irq
>> > controller routines. Is not that code shared between 32 and 64 bits?
>>
>> The GIC code is indeed shared between AArch32 and AArch64. However on
>> our ARMv8 platform, only parts of the SPIs, 32~447, are initialized
>> and mapped to fasteoi. The rest of the SPIs, 448~639, are for platform
>> specific peripheral drivers. These drivers use handle_level_irq and
>> handle_edge_irq as flow handlers.
>>
>> What we are seeing is that, when I-pipe is enabled, some of the
>> platform specific peripheral drivers receive numerous interrupts which
>> are nonexistent when I-pipe is disabled. At first glance, such problem
>> appears to match the pattern of using "handle_edge_irq" for
>> level-triggered interrupts at the GIC. However the number of the
>> "bogus" interrupts (per second) are only in the 100s. The handlers in
>> the device drivers still have chance to process these interrupts.
>>
>> Here is a partial call stack:
>> <peripheral-driver-irq-mask>+0xc/0x18
>> gic_hold_irq+0xb8/0x134
>> __ipipe_ack_fasteoi_irq+0x14/0x20
>> __ipipe_dispatch_irq+0x90/0x2a8
>> __ipipe_grab_irq+0x5c/0x74
>>
>> Does this call stack look correct to you? Any idea as to the cause of
>> such problem?
>
> No, this call stack does not look correct. gic_hold_irq should only
> mask the irq at interrupt controller level, not call back anything
> related to peripheral driver itself.
>
> Also, if an irq does not use handle_fasteoi_irq, gic_hold_irq should
> not be invoked.

What we've found is that one of the vendor-specific platform drivers
defines arch specific GIC irq extension, gic_arch_extn. The GIC callbacks
added by the I-pipe core, gic_hold_irq() and gic_release_irq(), "extend"
some of the GIC irqs to the platform driver's irq_mask and irq_unmask
callbacks. None of these GIC irqs are registered by the platform driver.
The following code changes are needed to successfully probe the platform
driver.

In addition, the spinlock used in the irq callbacks of the platform driver
has to be converted to I-pipe spinlock. Below is a sequence of the
spinlocks used for gic_mask_irq(), for instance:
<drivers/irqchip/irq-gic.c> gic_mask_irq():
raw_spin_lock_irqsave_cond(&irq_controller_lock, flags); /*
IPIPE_DEFINE_RAW_SPINLOCK(irq_controller_lock) */
<platform driver> msm_mpm_disable_irq(): spin_lock_irqsave(&msm_mpm_lock,
flags); /* IPIPE_DEFINE_SPINLOCK(msm_mpm_lock) */
<kernel/sched/core.c> complete(struct completion *x):
spin_lock_irqsave(&x->wait.lock, flags); /* x->wait.lock is defined as
spinlock_t */
......
<kernel/sched/core.c> complete(struct completion *x):
spin_unlock_irqrestore(&x->wait.lock, flags);
<platform driver> msm_mpm_disable_irq():
spin_unlock_irqrestore(&msm_mpm_lock, flags);
<drivers/irqchip/irq-gic.c>:
raw_spin_unlock_irqrestore_cond(&irq_controller_lock, flags);

Two questions:
1). Is the linux spinlock used in its scheduler's complete() function safe
in this chain of spinlocks?
2). Is there any risk if gic_arch_extn.irq_hold() and
gic_arch_extn.irq_release() are set as NULL (in the platform driver)?

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index debcd50..fdb0a5b 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -363,11 +363,16 @@ static void gic_hold_irq(struct irq_data *d)

        raw_spin_lock_irqsave_cond(&irq_controller_lock, flags);
        writel_relaxed_no_log(mask, gic_dist_base(d) +
GIC_DIST_ENABLE_CLEAR + (gic_irq(d) / 32) * 4);
+#ifdef CONFIG_ARCH_MSM
+       if (gic_arch_extn.irq_hold)
+               gic_arch_extn.irq_hold(d);
+#else /* !CONFIG_ARCH_MSM */
        if (gic_arch_extn.irq_mask)
                gic_arch_extn.irq_mask(d);
        if (gic_arch_extn.irq_eoi) {
                gic_arch_extn.irq_eoi(d);
        }
+#endif /* CONFIG_ARCH_MSM */
        writel_relaxed(gic_irq(d), gic_cpu_base(d) + GIC_CPU_EOI);
        raw_spin_unlock_irqrestore_cond(&irq_controller_lock, flags);
 }
@@ -378,8 +383,13 @@ static void gic_release_irq(struct irq_data *d)
        unsigned long flags;

        raw_spin_lock_irqsave_cond(&irq_controller_lock, flags);
+#ifdef CONFIG_ARCH_MSM
+       if (gic_arch_extn.irq_release)
+               gic_arch_extn.irq_release(d);
+#else /* !CONFIG_ARCH_MSM */
        if (gic_arch_extn.irq_unmask)
                gic_arch_extn.irq_unmask(d);
+#endif /* CONFIG_ARCH_MSM */
        writel_relaxed(mask, gic_dist_base(d) + GIC_DIST_ENABLE_SET +
(gic_irq(d) / 32) * 4);
        raw_spin_unlock_irqrestore_cond(&irq_controller_lock, flags);
 }
