Message-ID: <4A3FD089.6000808@domain.hid>
Date: Mon, 22 Jun 2009 20:42:17 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <4A3E9E09.7060109@domain.hid> <1245660331.4087.46.camel@domain.hid>
In-Reply-To: <1245660331.4087.46.camel@domain.hid>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-help] kernel build fails with
	CONFIG_X86_MCE_P4THERMAL=y
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Philippe Gerum schrieb:
> On Sun, 2009-06-21 at 22:54 +0200, Stefan Kisdaroczi wrote:
>   
>> hi,
>>
>> if 'check for P4 thermal throttling interrupt.' ( 
>> CONFIG_X86_MCE_P4THERMAL ) is enabled, kernel builds ok with 2.6.28, but 
>> fails with adeos-ipipe-2.6.29.5-x86-2.4-02.patch:
>>
>> arch/x86/kernel/ipipe.c: In function ‘__ipipe_enable_pipeline’:
>> arch/x86/kernel/ipipe.c:210: error: ‘smp_thermal_interrupt’ undeclared 
>> (first use in this function)
>> arch/x86/kernel/ipipe.c:210: error: (Each undeclared identifier is 
>> reported only once
>> arch/x86/kernel/ipipe.c:210: error: for each function it appears in.)
>> make[3]: *** [arch/x86/kernel/ipipe.o] Fehler 1
>> make[2]: *** [arch/x86/kernel] Fehler 2
>>
>>     
>
> Thanks. I will push 2.4-03 out after I have received confirmation that
> everything is fine on your side. TIA,
>   
the kernel compiled fine now with P4THERMAL enabled. thanks.
hint: did you notice the CONFIG_X86_64 ? same problem ?

+#if defined(CONFIG_X86_MCE_P4THERMAL) || defined(CONFIG_X86_64)
+    ipipe_virtualize_irq(ipipe_root_domain,
+                 ipipe_apic_vector_irq(THERMAL_APIC_VECTOR),
+                 (ipipe_irq_handler_t)&smp_thermal_interrupt,
+                 NULL,
+                 &__ipipe_ack_apic,
+                 IPIPE_STDROOT_MASK);
+#endif /* CONFIG_X86_MCE_P4THERMAL || CONFIG_X86_64 */

> diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
> index 28cc903..d186a4c 100644
> --- a/arch/x86/kernel/ipipe.c
> +++ b/arch/x86/kernel/ipipe.c
> @@ -116,6 +116,9 @@ void smp_invalidate_interrupt(struct pt_regs *regs);
>  void smp_call_function_interrupt(struct pt_regs *regs);
>  void smp_call_function_single_interrupt(struct pt_regs *regs);
>  void uv_bau_message_interrupt(struct pt_regs *regs);
> +#ifdef CONFIG_X86_32
> +void smp_thermal_interrupt(struct pt_regs *regs);
> +#endif
>  
>  static void __ipipe_ack_irq(unsigned irq, struct irq_desc *desc)
>  {
>
>   
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
>>     


