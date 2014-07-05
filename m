Message-ID: <53B7B3BF.3090807@xenomai.org>
Date: Sat, 05 Jul 2014 10:13:51 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1404210421-17081-1-git-send-email-maxime.ripard@free-electrons.com>
 <53B294A7.5010803@xenomai.org> <20140701141536.GN28647@lukather>
 <53B30D96.60500@xenomai.org> <20140704092736.GC13487@lukather>
In-Reply-To: <20140704092736.GC13487@lukather>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] AT91: SAMA5D3: Adapt Ipipe for AIC5
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Thomas Petazzoni <thomas@free-electrons.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Boris Brezillon <boris@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, xenomai@xenomai.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 07/04/2014 11:27 AM, Maxime Ripard wrote:
> On Tue, Jul 01, 2014 at 09:35:50PM +0200, Gilles Chanteperdrix wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> On 07/01/2014 04:15 PM, Maxime Ripard wrote:
>>> Hi Gilles,
>>>
>>> On Tue, Jul 01, 2014 at 12:59:51PM +0200, Gilles Chanteperdrix
>>> wrote:
>>>> On 07/01/2014 12:27 PM, Maxime Ripard wrote:
>>>>> - -	at91_pic_muter_register(); }
>>>>
>>>> Obviously, some if (soc_is_foo()) missing here.
>>>
>>> Right.
>>>
>>>>> +static void __maybe_unused at91_aic5_eoi(struct irq_data *d) 
>>>>> +{ +	at91_aic_write(AT91_AIC5_EOICR, 0); +}
>>>>
>>>> You want to make that inline, so that the hold callback ends-up
>>>> doing just two register writes without any function calls,
>>>> improving interrupt latency.
>>>>
>>>>> + #ifdef CONFIG_IPIPE static void at91_aic_hold_irq(struct
>>>>> irq_data *d) { @@ -258,13 +283,20 @@ static void
>>>>> at91_aic_release_irq(struct irq_data *d) { 
>>>>> at91_aic_hard_unmask_irq(d); } -#endif /* CONFIG_IPIPE */
>>>>>
>>>>> -static void __maybe_unused at91_aic5_eoi(struct irq_data *d) 
>>>>> +static void at91_aic5_hold_irq(struct irq_data *d) { -
>>>>> at91_aic_write(AT91_AIC5_EOICR, 0); +
>>>>> at91_aic5_hard_mask_irq(d); +	at91_aic5_eoi(d); }
>>>>>
>>>>> +static void at91_aic5_release_irq(struct irq_data *d) +{ +
>>>>> at91_aic5_hard_unmask_irq(d); +}
>>>>
>>>> The ->release callback is called with irqs on, so you may want to
>>>> call hard_local_irq_save / hard_local_irq_restore to make it
>>>> atomic (note that the old at91s are also broken by the addition
>>>> of the call to set_backup). Alternatively, you may move the
>>>> clear_backup/set_bakcup calls to the linux mask/unmask routines,
>>>> so that the register writes remain atomic, and you can avoid the
>>>> save/restore and function calls and improve the interrupt
>>>> latency.
>>>
>>> Ok, so, with the changes you mentionned, I can't make the system
>>> crash anymore (or at least, not as easily as it used to be).
>>>
>>> But: - whenever the program mentionned above calls exit(), it 
>>> stalls. However, ctrl+c makes the program exit properly, and 
>>> everything seems fine otherwise - whenever we don't link it against
>>> xenomai, it just hangs. I've not figured out why yet
>>>
>>> With CONFIG_XENOMAI and CONFIG_IPIPE disabled, it works fine.
>>
>> My answer was wrong, you probably need to keep the
>> set_backup/clear_backup calls in he ->hold and ->release callbacks, as
>> the linux interrupt may expect the backup areas to be in sync. Did you
>> do this, or did you go for the alternative?
> 
> I went for the alternative. I'm sending you a v2 with what I have so
> far, that shows the behaviour I was describing.

Could you try the following patch?

diff --git a/arch/arm/mach-at91/gpio.c b/arch/arm/mach-at91/gpio.c
index 8ef9c3e..ec539bc 100644
- --- a/arch/arm/mach-at91/gpio.c
+++ b/arch/arm/mach-at91/gpio.c
@@ -994,6 +994,10 @@ void __init at91_gpio_init(struct at91_gpio_bank *data, int nr_banks)
 }
 
 #if defined(CONFIG_IPIPE)
+extern unsigned long at91_aic_caps;
+#define AT91_AIC_CAP_AIC5	(1 << 0)
+#define has_aic5()		(at91_aic_caps & AT91_AIC_CAP_AIC5)
+
 static void at91_enable_irqdesc(struct ipipe_domain *ipd, unsigned irq)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
@@ -1089,6 +1093,9 @@ void at91_pic_muter_register(void)
 		.unmute = at91_unmute_pic,
 	};
 
+	if (has_aic5())
+		return;
+
 	ipipe_pic_muter_register(&at91_pic_muter);
 }
 #endif /* CONFIG_IPIPE */
diff --git a/arch/arm/mach-at91/irq.c b/arch/arm/mach-at91/irq.c
index a18f229..be13b65 100644
- --- a/arch/arm/mach-at91/irq.c
+++ b/arch/arm/mach-at91/irq.c
@@ -48,7 +48,7 @@ void __iomem *at91_aic_base;
 static struct irq_domain *at91_aic_domain;
 static struct device_node *at91_aic_np;
 static unsigned int n_irqs = NR_AIC_IRQS;
- -static unsigned long at91_aic_caps = 0;
+unsigned long at91_aic_caps = 0;
 
 /* AIC5 introduces a Source Select Register */
 #define AT91_AIC_CAP_AIC5	(1 << 0)
@@ -202,7 +202,7 @@ static void at91_aic_mask_irq(struct irq_data *d)
 	hard_cond_local_irq_restore(flags);
 }
 
- -static void __maybe_unused at91_aic5_mask_irq(struct irq_data *d)
+static inline void at91_aic5_hard_mask_irq(struct irq_data *d)
 {
 	/* Disable interrupt on AIC5 */
 	at91_aic_write(AT91_AIC5_SSR, d->hwirq & AT91_AIC5_INTSEL_MSK);
@@ -211,6 +211,16 @@ static void __maybe_unused at91_aic5_mask_irq(struct irq_data *d)
 	clear_backup(d->hwirq);
 }
 
+static void __maybe_unused at91_aic5_mask_irq(struct irq_data *d)
+{
+	unsigned long flags;
+
+	flags = hard_cond_local_irq_save();
+	at91_aic5_hard_mask_irq(d);
+	ipipe_lock_irq(d->irq);
+	hard_cond_local_irq_restore(flags);
+}
+
 static inline void at91_aic_hard_unmask_irq(struct irq_data *d)
 {
 	/* Enable interrupt on AIC */
@@ -229,7 +239,7 @@ static void at91_aic_unmask_irq(struct irq_data *d)
 	hard_cond_local_irq_restore(flags);
 }
 
- -static void __maybe_unused at91_aic5_unmask_irq(struct irq_data *d)
+static inline void at91_aic5_hard_unmask_irq(struct irq_data *d)
 {
 	/* Enable interrupt on AIC5 */
 	at91_aic_write(AT91_AIC5_SSR, d->hwirq & AT91_AIC5_INTSEL_MSK);
@@ -238,6 +248,16 @@ static void __maybe_unused at91_aic5_unmask_irq(struct irq_data *d)
 	set_backup(d->hwirq);
 }
 
+static void __maybe_unused at91_aic5_unmask_irq(struct irq_data *d)
+{
+	unsigned long flags;
+
+	flags = hard_cond_local_irq_save();
+	at91_aic5_hard_unmask_irq(d);
+	ipipe_unlock_irq(d->irq);
+	hard_cond_local_irq_restore(flags);
+}
+
 static void at91_aic_eoi(struct irq_data *d)
 {
 	/*
@@ -247,6 +267,11 @@ static void at91_aic_eoi(struct irq_data *d)
 	at91_aic_write(AT91_AIC_EOICR, 0);
 }
 
+static void __maybe_unused at91_aic5_eoi(struct irq_data *d)
+{
+	at91_aic_write(AT91_AIC5_EOICR, 0);
+}
+
 #ifdef CONFIG_IPIPE
 static void at91_aic_hold_irq(struct irq_data *d)
 {
@@ -256,14 +281,24 @@ static void at91_aic_hold_irq(struct irq_data *d)
 
 static void at91_aic_release_irq(struct irq_data *d)
 {
+	unsigned long flags = hard_local_irq_save();
 	at91_aic_hard_unmask_irq(d);
+	hard_local_irq_restore(flags);
 }
- -#endif /* CONFIG_IPIPE */
 
- -static void __maybe_unused at91_aic5_eoi(struct irq_data *d)
+static void __maybe_unused at91_aic5_hold_irq(struct irq_data *d)
 {
- -	at91_aic_write(AT91_AIC5_EOICR, 0);
+	at91_aic5_hard_mask_irq(d);
+	at91_aic5_eoi(d);
+}
+
+static void __maybe_unused at91_aic5_release_irq(struct irq_data *d)
+{
+	unsigned long flags = hard_local_irq_save();
+	at91_aic5_hard_unmask_irq(d);
+	hard_local_irq_restore(flags);
 }
+#endif /* CONFIG_IPIPE */
 
 static unsigned long *at91_extern_irq;
 
@@ -527,6 +562,10 @@ int __init at91_aic5_of_init(struct device_node *node,
 	at91_aic_chip.irq_mask		= at91_aic5_mask_irq;
 	at91_aic_chip.irq_unmask	= at91_aic5_unmask_irq;
 	at91_aic_chip.irq_eoi		= at91_aic5_eoi;
+#ifdef CONFIG_IPIPE
+	at91_aic_chip.irq_hold		= at91_aic5_hold_irq;
+	at91_aic_chip.irq_release	= at91_aic5_release_irq;
+#endif
 	at91_aic_irq_ops.map		= at91_aic5_irq_map;
 
 	err = at91_aic_of_common_init(node, parent);


> 
> Maxime
> 


- -- 
                                                                Gilles.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iD8DBQFTt7O/GpcgE6m/fboRAvANAJ0YX0XXpvWaDGHx5ieWGJ56pPr94wCfaQV4
0BNkzC1CovZ0CwAIQzw1uXk=
=dHKp
-----END PGP SIGNATURE-----

