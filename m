MIME-Version: 1.0
In-Reply-To: <4B47B0FE.8060000@domain.hid>
References: <725957.56219.qm@domain.hid>
	<4303dd241001080943v2d279019s1164a5b2aa34790a@domain.hid>
	<4303dd241001081002y8d7ef2fmcb7654d84dfd462f@domain.hid>
	<4B477495.6010009@domain.hid>
	<4303dd241001081127u217e916ax9c20352b7d7efe49@domain.hid>
	<4B478825.9000006@domain.hid>
	<4303dd241001081142q37797dcjb25fd9103f7e497e@domain.hid>
	<4B478B6E.1050400@domain.hid>
	<4303dd241001081354tc22e226j761564dea565ac89@domain.hid>
	<4B47B0FE.8060000@domain.hid>
Date: Wed, 13 Jan 2010 08:50:27 +0000
Message-ID: <4303dd241001130050r1f5dad13xe12d4f9cb92d0e2c@domain.hid>
From: Flavio de Castro Alves Filho <flavio.alves@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Porting I-Pipe for new ARM board
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello Gilles,

First of all, really thank you for you revision. It was really helpful.

And ... about the changes. I implemented the corrections as you
suggested and it is still not working. It is blocking allways at the
same place.

I'm still working to find out a solution.

Thank you very much.

Flavio

Flavio de Castro Alves Filho
Phi Innovations - Embedded Software Services
www.phiinnovations.com
Phone: +55 11 84 94 56 76
Skype: flavio.de.castro.alves.filho



2010/1/8 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
> aFlavio de Castro Alves Filho wrote:
>> In fact,
>>
>> Much easier.
>>
>> *** linux-03.20.00.05/arch/arm/mach-davinci/gpio.c =A0 =A02009-07-29
>> 02:53:15.000000000 -0300
>> --- linux-03.20.00.05_xenomai/arch/arm/mach-davinci/gpio.c =A0 =A02010-0=
1-08
>> 16:08:35.000000000 -0200
>> ***************
>> *** 27,32 ****
>> --- 27,33 ----
>>
>> =A0 #include <asm/mach/irq.h>
>>
>> + #include <asm/ipipe.h>
>>
>> =A0 static DEFINE_SPINLOCK(gpio_lock);
>>
>> ***************
>> *** 261,266 ****
>> --- 262,315 ----
>> =A0 =A0 =A0 /* now it may re-trigger */
>> =A0 }
>>
>> + #ifdef CONFIG_IPIPE
>> +
>> + /* Flavio Alves: for debugging */
>> + extern void printascii(const char *);
>> +
>> + void __ipipe_mach_demux_irq(unsigned irq, struct pt_regs *regs)
>> + {
>> + =A0 =A0 struct gpio_controller *__iomem g =3D get_irq_chip_data(irq);
>> + =A0 =A0 struct irq_desc *desc;
>> + =A0 =A0 u32 mask =3D 0xffff;
>> +
>> + =A0 =A0 //printascii("1__ipipe_mach_demux_irq\n");
>> +
>> + =A0 =A0 /* we only care about one bank */
>> + =A0 =A0 if (irq & 1)
>> + =A0 =A0 =A0 =A0 mask <<=3D 16;
>> +
>> + =A0 =A0 desc =3D &irq_desc[irq];
>> +
>> + =A0 =A0 /* temporarily mask (level sensitive) parent IRQ */
>> + =A0 =A0 desc->chip->ack(irq);
>
> Wrong comment. ->ack does not mask the parent irq, it just acks it.
> masking it would be wrong by the way, since demux should not be done
> with parent irq masked, as you will find out in the linux-arm-kernel
> mailing list archives
>
>> + =A0 =A0 while (1) {
>> + =A0 =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0status;
>> + =A0 =A0 =A0 =A0 int =A0 =A0 =A0 =A0n;
>> + =A0 =A0 =A0 =A0 int =A0 =A0 =A0 =A0res;
>> +
>> + =A0 =A0 =A0 =A0 /* ack any irqs */
>> + =A0 =A0 =A0 =A0 status =3D __raw_readl(&g->intstat) & mask;
>> + =A0 =A0 =A0 =A0 if (!status)
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 __raw_writel(status, &g->intstat);
>> + =A0 =A0 =A0 =A0 if (irq & 1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 status >>=3D 16;
>> +
>> + =A0 =A0 =A0 =A0 /* now demux them to the right lowlevel handler */
>> + =A0 =A0 =A0 =A0 n =3D (int)get_irq_data(irq);
>> + =A0 =A0 =A0 =A0 while (status) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 res =3D ffs(status);
>> + =A0 =A0 =A0 =A0 =A0 =A0 n +=3D res;
>> + =A0 =A0 =A0 =A0 =A0 =A0 __ipipe_handle_irq((n-1),regs);
>> + =A0 =A0 =A0 =A0 =A0 =A0 status >>=3D res;
>> + =A0 =A0 =A0 =A0 }
>
> This while loop should reread the hardware status at each iteration, to
> take into account new interrupts which would have showed up while
> handling the last interrupt.
>
>> + =A0 =A0 }
>> + =A0 =A0 desc->chip->unmask(irq);
>
> Not needed since you did not mask the parent irq.
>
>> + =A0 =A0 /* now it may re-trigger */
>> + }
>> + #endif /* CONFIG_IPIPE */
>> +
>> =A0 /*
>> =A0 =A0* NOTE: =A0for suspend/resume, probably best to make a platform_d=
evice with
>> =A0 =A0* suspend_late/resume_resume calls hooking into results of the se=
t_wake()
>> diff -crB linux-03.20.00.05/arch/arm/mach-davinci/include/mach/irqs.h
>> linux-03.20.00.05_xenomai/arch/arm/mach-davinci/include/mach/irqs.h
>> *** linux-03.20.00.05/arch/arm/mach-davinci/include/mach/irqs.h
>> 2009-07-29 02:53:15.000000000 -0300
>> --- linux-03.20.00.05_xenomai/arch/arm/mach-davinci/include/mach/irqs.h
>> 2010-01-06 16:45:56.000000000 -0200
>> ***************
>> *** 359,362 ****
>> --- 359,381 ----
>> =A0 #define IRQ_DA850_MCBSP1RINT =A0 =A0 =A0 =A099
>> =A0 #define IRQ_DA850_MCBSP1XINT =A0 =A0 =A0 =A0100
>>
>> + #ifdef CONFIG_IPIPE
>> + #if 0
>> + #define __ipipe_mach_irq_mux_p(irq) \
>> + =A0 =A0 =A0 =A0 ((unsigned) (irq - IRQ_DA8XX_GPIO0) \
>> + =A0 =A0 =A0 =A0 =A0<=3D (IRQ_DA8XX_GPIO7 - IRQ_DA8XX_GPIO0))
>> + #endif
>> + #define __ipipe_mach_irq_mux_p(irq) \
>> + =A0 =A0 ((irq) =3D=3D IRQ_DA8XX_GPIO0 \
>> + =A0 =A0 =A0|| (irq) =3D=3D IRQ_DA8XX_GPIO1 \
>> + =A0 =A0 =A0|| (irq) =3D=3D IRQ_DA8XX_GPIO2 \
>> + =A0 =A0 =A0|| (irq) =3D=3D IRQ_DA8XX_GPIO3 \
>> + =A0 =A0 =A0|| (irq) =3D=3D IRQ_DA8XX_GPIO4 \
>> + =A0 =A0 =A0|| (irq) =3D=3D IRQ_DA8XX_GPIO5 \
>> + =A0 =A0 =A0|| (irq) =3D=3D IRQ_DA8XX_GPIO6 \
>> + =A0 =A0 =A0|| (irq) =3D=3D IRQ_DA8XX_GPIO7)
>
> Yuck. The "#if 0"ed one solution seems much better. You have to realize
> that this macro is called for every interrupt so, it has to be pretty
> fast. If the interrupts are not consecutive, then use a bit field
> (s3cxxxx does it IIRC). But to get things working it is ok, you can fix
> this later.
>
>> +
>> +
>> + #endif /* CONFIG_IPIPE */
>> +
>> =A0 #endif /* __ASM_ARCH_IRQS_H */
>> diff -crB linux-03.20.00.05/arch/arm/mach-davinci/irq.c
>> linux-03.20.00.05_xenomai/arch/arm/mach-davinci/irq.c
>> *** linux-03.20.00.05/arch/arm/mach-davinci/irq.c =A0 =A02009-07-29
>> 02:53:15.000000000 -0300
>> --- linux-03.20.00.05_xenomai/arch/arm/mach-davinci/irq.c =A0 =A02010-01=
-08
>> 15:22:13.000000000 -0200
>> ***************
>> *** 111,119 ****
>> --- 111,228 ----
>> =A0 =A0 =A0 .name =A0 =A0=3D "AINTC",
>> =A0 =A0 =A0 .ack =A0 =A0=3D davinci_ack_irq,
>> =A0 =A0 =A0 .mask =A0 =A0=3D davinci_mask_irq,
>> + #ifdef CONFIG_IPIPE
>> + =A0 =A0 .mask_ack =3D davinci_mask_irq,
>> + #endif /* CONFIG_IPIPE */
>
> No, no, no. BIG BUG here. Your PIC has different ack and mask routines,
> so, both should be called by mask_ack.
>
> You did not get this idea from the porting howto. I made this on some
> platforms whre the ack and mask routines were the same, so that mask_ack
> ended up doing twice the same thing.
>
> Anyway, this kind of optimization is to be left aside when starting the
> port.
>
>> =A0 =A0 =A0 .unmask =3D davinci_unmask_irq,
>> =A0 };
>>
>> + #ifdef CONFIG_IPIPE
>> + static const u8 da850_default_priorities[DAVINCI_N_AINTC_IRQ] __initda=
ta =3D
>> {
>> + =A0 [IRQ_DA8XX_COMMTX] =A0 =A0 =A0 =A0 =A0 =A0 =3D 7,
>> + =A0 [IRQ_DA8XX_COMMRX] =A0 =A0 =A0 =A0 =A0 =A0 =3D 7,
>> + =A0 [IRQ_DA8XX_NINT] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 7,
>> + =A0 [IRQ_DA8XX_EVTOUT0] =A0 =A0 =A0 =A0 =A0 =A0=3D 7,
>> + =A0 [IRQ_DA8XX_EVTOUT1] =A0 =A0 =A0 =A0 =A0 =A0=3D 7,
>> + =A0 [IRQ_DA8XX_EVTOUT2] =A0 =A0 =A0 =A0 =A0 =A0=3D 7,
>> + =A0 [IRQ_DA8XX_EVTOUT3] =A0 =A0 =A0 =A0 =A0 =A0=3D 7,
>> + =A0 [IRQ_DA8XX_EVTOUT4] =A0 =A0 =A0 =A0 =A0 =A0=3D 7,
>> + =A0 [IRQ_DA8XX_EVTOUT5] =A0 =A0 =A0 =A0 =A0 =A0=3D 7,
>> + =A0 [IRQ_DA8XX_EVTOUT6] =A0 =A0 =A0 =A0 =A0 =A0=3D 7,
>> + =A0 [IRQ_DA8XX_EVTOUT7] =A0 =A0 =A0 =A0 =A0 =A0=3D 7,
>> + =A0 [IRQ_DA8XX_CCINT0] =A0 =A0 =A0 =A0 =A0 =A0 =3D 7,
>> + =A0 [IRQ_DA8XX_CCERRINT] =A0 =A0 =A0 =A0 =A0 =3D 7,
>> + =A0 [IRQ_DA8XX_TCERRINT0] =A0 =A0 =A0 =A0 =A0=3D 7,
>> + =A0 [IRQ_DA8XX_AEMIFINT] =A0 =A0 =A0 =A0 =A0 =3D 7,
>> + =A0 [IRQ_DA8XX_I2CINT0] =A0 =A0 =A0 =A0 =A0 =A0=3D 5,
>> + =A0 [IRQ_DA8XX_MMCSDINT0] =A0 =A0 =A0 =A0 =A0=3D 5,
>> + =A0 [IRQ_DA8XX_MMCSDINT1] =A0 =A0 =A0 =A0 =A0=3D 5,
>> + =A0 [IRQ_DA8XX_ALLINT0] =A0 =A0 =A0 =A0 =A0 =A0=3D 5,
>> + =A0 [IRQ_DA8XX_RTC] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 4,
>> + =A0 [IRQ_DA8XX_SPINT0] =A0 =A0 =A0 =A0 =A0 =A0 =3D 5,
>> + =A0 [IRQ_DA8XX_TINT12_0] =A0 =A0 =A0 =A0 =A0 =3D 2,
>> + =A0 [IRQ_DA8XX_TINT34_0] =A0 =A0 =A0 =A0 =A0 =3D 5,
>> + =A0 [IRQ_DA8XX_TINT12_1] =A0 =A0 =A0 =A0 =A0 =3D 5,
>> + =A0 [IRQ_DA8XX_TINT34_1] =A0 =A0 =A0 =A0 =A0 =3D 5,
>> + =A0 [IRQ_DA8XX_UARTINT0] =A0 =A0 =A0 =A0 =A0 =3D 5,
>> + =A0 [IRQ_DA8XX_KEYMGRINT] =A0 =A0 =A0 =A0 =A0=3D 7,
>> + =A0 [IRQ_DA850_MIOPU_BOOTCFG_ERR] =A0=3D 7,
>> + =A0 [IRQ_DA8XX_CHIPINT0] =A0 =A0 =A0 =A0 =A0 =3D 7,
>> + =A0 [IRQ_DA8XX_CHIPINT1] =A0 =A0 =A0 =A0 =A0 =3D 7,
>> + =A0 [IRQ_DA8XX_CHIPINT2] =A0 =A0 =A0 =A0 =A0 =3D 7,
>> + =A0 [IRQ_DA8XX_CHIPINT3] =A0 =A0 =A0 =A0 =A0 =3D 7,
>> + =A0 [IRQ_DA8XX_TCERRINT1] =A0 =A0 =A0 =A0 =A0=3D 7,
>> + =A0 [IRQ_DA8XX_C0_RX_THRESH_PULSE] =3D 7,
>> + =A0 [IRQ_DA8XX_C0_RX_PULSE] =A0 =A0 =A0 =A0=3D 7,
>> + =A0 [IRQ_DA8XX_C0_TX_PULSE] =A0 =A0 =A0 =A0=3D 7,
>> + =A0 [IRQ_DA8XX_C0_MISC_PULSE] =A0 =A0 =A0=3D 7,
>> + =A0 [IRQ_DA8XX_C1_RX_THRESH_PULSE] =3D 7,
>> + =A0 [IRQ_DA8XX_C1_RX_PULSE] =A0 =A0 =A0 =A0=3D 7,
>> + =A0 [IRQ_DA8XX_C1_TX_PULSE] =A0 =A0 =A0 =A0=3D 7,
>> + =A0 [IRQ_DA8XX_C1_MISC_PULSE] =A0 =A0 =A0=3D 7,
>> + =A0 [IRQ_DA8XX_MEMERR] =A0 =A0 =A0 =A0 =A0 =A0 =3D 5,
>> + =A0 [IRQ_DA8XX_GPIO0] =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 6,
>> + =A0 [IRQ_DA8XX_GPIO1] =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 6,
>> + =A0 [IRQ_DA8XX_GPIO2] =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 6,
>> + =A0 [IRQ_DA8XX_GPIO3] =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 6,
>> + =A0 [IRQ_DA8XX_GPIO4] =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 6,
>> + =A0 [IRQ_DA8XX_GPIO5] =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 6,
>> + =A0 [IRQ_DA8XX_GPIO6] =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 6,
>> + =A0 [IRQ_DA8XX_GPIO7] =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 6,
>> + =A0 [IRQ_DA8XX_GPIO8] =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 6,
>> + =A0 [IRQ_DA8XX_I2CINT1] =A0 =A0 =A0 =A0 =A0 =A0=3D 5,
>> + =A0 [IRQ_DA8XX_LCDINT] =A0 =A0 =A0 =A0 =A0 =A0 =3D 5,
>> + =A0 [IRQ_DA8XX_UARTINT1] =A0 =A0 =A0 =A0 =A0 =3D 5,
>> + =A0 [IRQ_DA8XX_MCASPINT] =A0 =A0 =A0 =A0 =A0 =3D 5,
>> + =A0 [IRQ_DA8XX_ALLINT1] =A0 =A0 =A0 =A0 =A0 =A0=3D 5,
>> + =A0 [IRQ_DA8XX_SPINT1] =A0 =A0 =A0 =A0 =A0 =A0 =3D 5,
>> + =A0 [IRQ_DA8XX_UHPI_INT1] =A0 =A0 =A0 =A0 =A0=3D 5,
>> + =A0 [IRQ_DA8XX_USB_INT] =A0 =A0 =A0 =A0 =A0 =A0=3D 5,
>> + =A0 [IRQ_DA8XX_IRQN] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 5,
>> + =A0 [IRQ_DA8XX_RWAKEUP] =A0 =A0 =A0 =A0 =A0 =A0=3D 5,
>> + =A0 [IRQ_DA8XX_UARTINT2] =A0 =A0 =A0 =A0 =A0 =3D 5,
>> + =A0 [IRQ_DA8XX_DFTSSINT] =A0 =A0 =A0 =A0 =A0 =3D 5,
>> + =A0 [IRQ_DA8XX_EHRPWM0] =A0 =A0 =A0 =A0 =A0 =A0=3D 7,
>> + =A0 [IRQ_DA8XX_EHRPWM0TZ] =A0 =A0 =A0 =A0 =A0=3D 7,
>> + =A0 [IRQ_DA8XX_EHRPWM1] =A0 =A0 =A0 =A0 =A0 =A0=3D 7,
>> + =A0 [IRQ_DA8XX_EHRPWM1TZ] =A0 =A0 =A0 =A0 =A0=3D 7,
>> + =A0 [IRQ_DA850_SATAINT] =A0 =A0 =A0 =A0 =A0 =A0=3D 5,
>> + =A0 [IRQ_DA850_TINT12_2] =A0 =A0 =A0 =A0 =A0 =3D 5,
>> + =A0 [IRQ_DA8XX_ECAP0] =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 7,
>> + =A0 [IRQ_DA8XX_ECAP1] =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 7,
>> + =A0 [IRQ_DA8XX_ECAP2] =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 7,
>> + =A0 [IRQ_DA850_MMCSDINT0_1] =A0 =A0 =A0 =A0=3D 5,
>> + =A0 [IRQ_DA850_MMCSDINT1_1] =A0 =A0 =A0 =A0=3D 5,
>> + =A0 [IRQ_DA850_T12CMPINT0_2] =A0 =A0 =A0 =3D 7,
>> + =A0 [IRQ_DA850_T12CMPINT1_2] =A0 =A0 =A0 =3D 7,
>> + =A0 [IRQ_DA850_T12CMPINT2_2] =A0 =A0 =A0 =3D 7,
>> + =A0 [IRQ_DA850_T12CMPINT3_2] =A0 =A0 =A0 =3D 7,
>> + =A0 [IRQ_DA850_T12CMPINT4_2] =A0 =A0 =A0 =3D 7,
>> + =A0 [IRQ_DA850_T12CMPINT5_2] =A0 =A0 =A0 =3D 7,
>> + =A0 [IRQ_DA850_T12CMPINT6_2] =A0 =A0 =A0 =3D 7,
>> + =A0 [IRQ_DA850_T12CMPINT7_2] =A0 =A0 =A0 =3D 7,
>> + =A0 [IRQ_DA850_T12CMPINT0_3] =A0 =A0 =A0 =3D 7,
>> + =A0 [IRQ_DA850_T12CMPINT1_3] =A0 =A0 =A0 =3D 7,
>> + =A0 [IRQ_DA850_T12CMPINT2_3] =A0 =A0 =A0 =3D 7,
>> + =A0 [IRQ_DA850_T12CMPINT3_3] =A0 =A0 =A0 =3D 7,
>> + =A0 [IRQ_DA850_T12CMPINT4_3] =A0 =A0 =A0 =3D 7,
>> + =A0 [IRQ_DA850_T12CMPINT5_3] =A0 =A0 =A0 =3D 7,
>> + =A0 [IRQ_DA850_T12CMPINT6_3] =A0 =A0 =A0 =3D 7,
>> + =A0 [IRQ_DA850_T12CMPINT7_3] =A0 =A0 =A0 =3D 7,
>> + =A0 [IRQ_DA8XX_ARMCLKSTOPREQ] =A0 =A0 =A0=3D 7,
>> + =A0 [IRQ_DA850_RPIINT] =A0 =A0 =A0 =A0 =A0 =A0 =3D 7,
>> + =A0 [IRQ_DA850_VPIFINT] =A0 =A0 =A0 =A0 =A0 =A0=3D 7,
>> + =A0 [IRQ_DA850_CCINT1] =A0 =A0 =A0 =A0 =A0 =A0 =3D 7,
>> + =A0 [IRQ_DA850_CCERRINT1] =A0 =A0 =A0 =A0 =A0=3D 7,
>> + =A0 [IRQ_DA850_TCERRINT2] =A0 =A0 =A0 =A0 =A0=3D 7,
>> + =A0 [IRQ_DA850_TINT12_3] =A0 =A0 =A0 =A0 =A0 =3D 5,
>> + =A0 [IRQ_DA850_MCBSP0RINT] =A0 =A0 =A0 =A0 =3D 5,
>> + =A0 [IRQ_DA850_MCBSP0XINT] =A0 =A0 =A0 =A0 =3D 5,
>> + =A0 [IRQ_DA850_MCBSP1RINT] =A0 =A0 =A0 =A0 =3D 5,
>> + =A0 [IRQ_DA850_MCBSP1XINT] =A0 =A0 =A0 =A0 =3D 5
>> + };
>> + #endif /* CONFIG_IPIPE */
>
> Fiddling with IRQ priorities is mostly useless if you send the EOI to
> the interrupt controller at the beginning of the interrupt handling as
> davinci_ack_irq seems to do it.
>
> Besides, we have the (undocumented) PIC mute functionality wich is even
> better than interrupt priorities. I need to document it sometimes.
>
>> +
>> =A0 /* FIQ are pri 0-1; otherwise 2-7, with 7 lowest priority */
>> =A0 static const u8 dm644x_default_priorities[DAVINCI_N_AINTC_IRQ] __ini=
tdata
>> =3D {
>> =A0 =A0 =A0 [IRQ_VDINT0] =A0 =A0 =A0 =A0=3D 2,
>> ***************
>> *** 325,330 ****
>> --- 434,443 ----
>> =A0 =A0 =A0 =A0 =A0 davinci_def_priorities =3D dm646x_default_priorities=
;
>> =A0 =A0 =A0 else if (cpu_is_davinci_dm355())
>> =A0 =A0 =A0 =A0 =A0 davinci_def_priorities =3D dm355_default_priorities;
>> + #ifdef CONFIG_IPIPE
>> + =A0 =A0 else if (cpu_is_da850())
>> + =A0 =A0 =A0 davinci_def_priorities =3D da850_default_priorities;
>> + #endif /* CONFIG_IPIPE */
>>
>> =A0 =A0 =A0 /* Clear all interrupt requests */
>> =A0 =A0 =A0 davinci_irq_writel(~0x0, FIQ_REG0_OFFSET);
>> ***************
>> *** 361,369 ****
>> --- 474,484 ----
>> =A0 =A0 =A0 for (i =3D 0; i < DAVINCI_N_AINTC_IRQ; i++) {
>> =A0 =A0 =A0 =A0 =A0 set_irq_chip(i, &davinci_irq_chip_0);
>> =A0 =A0 =A0 =A0 =A0 set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
>> + #ifndef CONFIG_IPIPE
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (i !=3D IRQ_TINT1_TINT34)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_irq_handler(i, h=
andle_edge_irq);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> + #endif /* CONFIG IPIPE */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_irq_handler(i, h=
andle_level_irq);
>> =A0 =A0 =A0 }
>> =A0 }
>> diff -crB linux-03.20.00.05/arch/arm/mach-davinci/time.c
>> linux-03.20.00.05_xenomai/arch/arm/mach-davinci/time.c
>> *** linux-03.20.00.05/arch/arm/mach-davinci/time.c =A0 =A02009-07-29
>> 02:53:15.000000000 -0300
>> --- linux-03.20.00.05_xenomai/arch/arm/mach-davinci/time.c =A0 =A02010-0=
1-08
>> 17:07:36.000000000 -0200
>> ***************
>> *** 30,35 ****
>> --- 30,41 ----
>> =A0 #include <mach/cpu.h>
>> =A0 #include "clock.h"
>>
>> + #ifdef CONFIG_IPIPE
>> + #ifdef CONFIG_NO_IDLE_HZ
>> + #error "dynamic tick timer not yet supported with IPIPE"
>> + #endif /* CONFIG_NO_IDLE_HZ */
>> + #endif /* CONFIG_IPIPE */
>> +
>> =A0 static struct clock_event_device clockevent_davinci;
>> =A0 static unsigned int davinci_clock_tick_rate;
>>
>> ***************
>> *** 70,75 ****
>> --- 76,102 ----
>> =A0 static int tid_system;
>> =A0 static int tid_freerun;
>>
>> + #ifdef CONFIG_IPIPE
>> + int =A0 =A0 =A0 =A0 =A0__ipipe_mach_timerint =A0 =A0 =A0 =A0=3D IRQ_DA=
8XX_TINT12_0;
>> + int =A0 =A0 =A0 =A0 =A0__ipipe_mach_timerstolen =A0 =A0 =3D 0;
>> + unsigned int __ipipe_mach_ticks_per_jiffy =3D LATCH;
>> + static int =A0 davinci_timer_initialized;
>> + union tsc_reg {
>> + #ifdef __BIG_ENDIAN
>> + =A0 =A0 struct {
>> + =A0 =A0 =A0 =A0 unsigned long high;
>> + =A0 =A0 =A0 =A0 unsigned long low;
>> + =A0 =A0 };
>> + #else =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* __LITTLE_ENDIAN */
>> + =A0 =A0 struct {
>> + =A0 =A0 =A0 =A0 unsigned long low;
>> + =A0 =A0 =A0 =A0 unsigned long high;
>> + =A0 =A0 };
>> + #endif =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* __LITTLE_ENDIAN */
>> + =A0 =A0 unsigned long long full;
>> + };
>> + #endif /* CONFIG_IPIPE */
>> +
>> =A0 /*
>> =A0 =A0* This driver configures the 2 64-bit count-up timers as 4 indepe=
ndent
>> =A0 =A0* 32-bit count-up timers used as follows:
>> ***************
>> *** 92,97 ****
>> --- 119,125 ----
>> =A0 #define TGCR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x24
>> =A0 #define WDTCR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x28
>> =A0 #define CMP12(n) =A0 =A0 =A0 =A0 =A0 =A0 (0x60 + ((n) << 2))
>> + #define INTCTLSTAT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x44
>>
>> =A0 /* Timer register bitfields */
>> =A0 #define TCR_ENAMODE_DISABLE =A0 =A0 =A0 =A0 =A00x0
>> ***************
>> *** 137,142 ****
>> --- 165,283 ----
>> =A0 #define TIMER_OPTS_ONESHOT =A0 =A00x01
>> =A0 #define TIMER_OPTS_PERIODIC =A0 0x02
>>
>> + /* Flags to be set when it is necessary to clear the */
>> + /* status register for timer interrupts =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + #define TIMER12_CLEAR_PRDINT =A00x02
>> + #define TIMER12_CLEAR_EVTINT =A00x04
>> +
>> + #ifdef CONFIG_IPIPE
>> + #ifdef CONFIG_SMP
>> + static union tsc_reg tsc[NR_CPUS];
>> +
>> + void __ipipe_mach_get_tscinfo(struct __ipipe_tscinfo *info)
>> + {
>> + =A0 =A0 info->type =3D IPIPE_TSC_TYPE_NONE;
>> + }
>> + #else =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* !CONFIG_SMP */
>> + static union tsc_reg *tsc;
>> +
>> + void __ipipe_mach_get_tscinfo(struct __ipipe_tscinfo *info)
>> + {
>> + =A0 =A0 info->type =3D IPIPE_TSC_TYPE_FREERUNNING;
>> + =A0 =A0 info->u.fr.counter =3D (unsigned *)(DAVINCI_TIMER0_BASE + TIM1=
2);
>> + =A0 =A0 info->u.fr.mask =3D 0xffffffff;
>> + =A0 =A0 info->u.fr.tsc =3D &tsc->full;
>> + }
>> + #endif =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* !CONFIG_SMP */
>> +
>> + void __ipipe_mach_acktimer(void)
>> + {
>> + =A0 void __iomem *base =3D IO_ADDRESS(DAVINCI_TIMER0_BASE);
>> + =A0 unsigned long status;
>> +
>> + =A0 status =3D __raw_readl(base + INTCTLSTAT);
>> + =A0 status |=3D (TIMER12_CLEAR_PRDINT | TIMER12_CLEAR_EVTINT);
>> +
>> + =A0 __raw_writel(status,base+INTCTLSTAT);
>> + }
>> +
>> + static void ipipe_mach_update_tsc(void)
>> + {
>> + =A0 union tsc_reg *local_tsc;
>> + =A0 unsigned long stamp, flags;
>> + =A0 void __iomem *base =3D IO_ADDRESS(DAVINCI_TIMER0_BASE);
>> +
>> + =A0 local_irq_save_hw(flags);
>> + =A0 local_tsc =3D &tsc[ipipe_processor_id()];
>> + =A0 stamp =3D __raw_readl(base + TIM12);
>> + =A0 if (unlikely(stamp < local_tsc->low))
>> + =A0 =A0 /* 32 bit counter wrapped, increment high word. */
>> + =A0 =A0 local_tsc->high++;
>> + =A0 local_tsc->low =3D stamp;
>> + =A0 local_irq_restore_hw(flags);
>> + }
>> +
>> + notrace unsigned long long __ipipe_mach_get_tsc(void)
>> + {
>> + =A0 if (likely(davinci_timer_initialized)) {
>> + =A0 =A0 union tsc_reg *local_tsc, result;
>> + =A0 =A0 unsigned long stamp;
>> + =A0 =A0 void __iomem *base =3D IO_ADDRESS(DAVINCI_TIMER0_BASE);
>> +
>> + =A0 =A0 local_tsc =3D &tsc[ipipe_processor_id()];
>> +
>> + =A0 =A0 __asm__("ldmia %1, %M0\n":
>> + =A0 =A0 =A0 =A0 "=3Dr"(result.full): "r"(local_tsc), "m"(*local_tsc));
>> + =A0 =A0 barrier();
>> + =A0 =A0 stamp =3D __raw_readl(base + TIM12);
>> + =A0 =A0 if (unlikely(stamp < result.low))
>> + =A0 =A0 =A0 result.high++;
>> + =A0 =A0 result.low =3D stamp;
>> + =A0 =A0 return result.full;
>> + =A0 }
>> + =A0 return 0;
>> + }
>> + EXPORT_SYMBOL(__ipipe_mach_get_tsc);
>> +
>> + /*
>> + =A0* Reprogram the timer
>> + =A0*/
>> + void __ipipe_mach_set_dec(unsigned long delay)
>> + {
>> + =A0 unsigned long flags;
>> + =A0 unsigned int =A0value;
>> + =A0 void __iomem *base =3D IO_ADDRESS(DAVINCI_TIMER0_BASE);
>> +
>> + =A0 if (delay > 20) {
>> + =A0 =A0 local_irq_save_hw(flags);
>> +
>> + =A0 =A0 value =3D __raw_readl(base + TIM12) + delay;
>> + =A0 =A0 __raw_writel(value,base + CMP12(0));
>> + =A0 =A0 local_irq_restore_hw(flags);
>> + =A0 } else {
>> + =A0 =A0 ipipe_trigger_irq(IRQ_DA8XX_TINT12_0);
>> + =A0 }
>> + }
>
> I can not really comment on that, since I do not really know the
> hardware details, though the code seems to indicate that the minimum is
> 1, not 20. 20 should be Ok for a first run though:
>
> =A0 =A0 =A0 =A0clockevent_davinci.min_delta_ns =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clockevent_delta2ns(1, &clockevent_davinci=
);
>
>> + EXPORT_SYMBOL(__ipipe_mach_set_dec);
>> +
>> + unsigned long __ipipe_mach_get_dec(void)
>> + {
>> + =A0 unsigned long value;
>> + =A0 void __iomem *base =3D IO_ADDRESS(DAVINCI_TIMER0_BASE);
>> +
>> + =A0 value =A0=3D __raw_readl(base + CMP12(0));
>> + =A0 value -=3D __raw_readl(base + TIM12);
>> +
>> + =A0 return value;
>> + }
>> +
>> + int __ipipe_check_tickdev(const char *devname)
>> + {
>> + =A0 return !strcmp(devname, clockevent_davinci.name);
>> + }
>> +
>> + #endif /* CONFIG_IPIPE */
>> +
>> =A0 static int timer32_config(struct timer_s *t)
>> =A0 {
>> =A0 =A0 =A0 u32 tcr =3D __raw_readl(t->base + TCR);
>> ***************
>> *** 167,176 ****
>> --- 308,324 ----
>> =A0 =A0 =A0 return __raw_readl(t->base + t->tim_off);
>> =A0 }
>>
>> + /* Flavio Alves: for debugging */
>> + extern void printascii(const char *);
>> +
>> =A0 static irqreturn_t timer_interrupt(int irq, void *dev_id)
>> =A0 {
>> =A0 =A0 =A0 struct clock_event_device *evt =3D &clockevent_davinci;
>>
>> + =A0 =A0 // =A0 =A0printascii("entrei\n");
>> + #ifdef CONFIG_IPIPE
>> + =A0 =A0 ipipe_mach_update_tsc();
>> + #endif =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* CONFIG_IP=
IPE */
>> =A0 =A0 =A0 evt->event_handler(evt);
>> =A0 =A0 =A0 return IRQ_HANDLED;
>> =A0 }
>
> Ah. You have to realize that if the clockevent framework chooses an
> other clockevent than this one, timer_interrupt will no longer be
> called, so the tsc will wrap instead of incrementing correctly. So, as
> explained in a previous mail, you have to:
> - either increment clockevent_davinci.rating (currently uninitialized if
> I read the code correctly, so 0)
> - or base Xenomai timer on the other clockevent,
> - or call ipipe_mach_update_tsc() in __ipipe_mach_acktimer (not a good
> long term solution, but good for a quick test)
>
>
>
>> ***************
>> *** 302,307 ****
>> --- 449,463 ----
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer32_config(timers[i]);
>> =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 }
>> +
>> + #ifdef CONFIG_IPIPE
>> + #ifndef CONFIG_SMP
>> + =A0 =A0 tsc =3D (union tsc_reg *)__ipipe_tsc_area;
>> + =A0 =A0 barrier();
>> + #endif =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* CONFIG_SMP */
>> + =A0 =A0 davinci_timer_initialized =3D 1;
>> + #endif =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* CONFIG_IP=
IPE */
>> +
>> =A0 }
>>
>> =A0 /*
>> ***************
>> *** 311,321 ****
>> =A0 {
>> =A0 =A0 =A0 struct timer_s *t;
>>
>> ! =A0 =A0 if (tid_freerun =3D=3D -1)
>> =A0 =A0 =A0 =A0 =A0 t =3D timers[tid_system];
>> ! =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 t =3D timers[tid_freerun];
>> !
>> =A0 =A0 =A0 return (cycles_t)timer32_read(t);
>> =A0 }
>>
>> --- 467,478 ----
>> =A0 {
>> =A0 =A0 =A0 struct timer_s *t;
>>
>> ! =A0 if (tid_freerun =3D=3D -1) {
>> =A0 =A0 =A0 =A0 =A0 t =3D timers[tid_system];
>> ! =A0 }
>> ! =A0 else {
>> =A0 =A0 =A0 =A0 =A0 t =3D timers[tid_freerun];
>> ! =A0 }
>> =A0 =A0 =A0 return (cycles_t)timer32_read(t);
>> =A0 }
>>
>> ***************
>> *** 549,551 ****
>> --- 706,718 ----
>> =A0 =A0 =A0 wdtcr =3D 0x00004000;
>> =A0 =A0 =A0 __raw_writel(wdtcr, base + WDTCR);
>> =A0 }
>> +
>> + #ifdef CONFIG_IPIPE
>> + void __ipipe_mach_release_timer(void)
>> + {
>> + =A0 davinci_set_mode(clockevent_davinci.mode, &clockevent_davinci);
>> + =A0 if (clockevent_davinci.mode =3D=3D CLOCK_EVT_MODE_ONESHOT)
>> + =A0 =A0 davinci_set_next_event(LATCH, &clockevent_davinci);
>> + }
>> + EXPORT_SYMBOL(__ipipe_mach_release_timer);
>> + #endif /* CONFIG_IPIPE */
>>
>> Best regards,
>
> Ok. I think the bug really comes from the ack_mask thing. Other than
> that, great work, the patch looks fine. Good luck.
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0Gilles.
>

