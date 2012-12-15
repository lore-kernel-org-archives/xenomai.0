From: GUGLIELMO NAVARRA <guglielmo.navarra@studenti.uniparthenope.it>
Date: Sat, 15 Dec 2012 15:47:05 +0000
Message-ID: <7385E066AECB78449EEDFA7EE2A2B2B60A052E16@DB3PRD0410MB355.eurprd04.prod.outlook.com>
Content-Language: it-IT
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] [Xenomai-help] Latency calculation on da850 (Omap
 L138)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Da: Gilles Chanteperdrix [gilles.chanteperdrix@xenomai.org]
Inviato: sabato 15 dicembre 2012 15.54
> Anyway, I also asked you to run the "tsc" test, what does this test tell
> you?

In the structure tsc_info must assign addresses (phy and virt) of timer ass=
igned to clocksource or clockevent?
I have assigned the offset of timer assigned to clockevent (base address is=
 the same because the timer is 64-bit)


static void l138_xenomai_tsc_init(void)
{
struct davinci_soc_info *soc_info =3D &davinci_soc_info;
struct davinci_timer_instance *dtip =3D soc_info->timer_info->timers;
void __iomem *base;
base =3D ioremap(dtip[0].base, SZ_4K);
tsc_info.type =3D IPIPE_TSC_TYPE_FREERUNNING;
tsc_info.freq =3D l138_clock_tick_rate;
tsc_info.counter_vaddr =3D (unsigned long)(base + TIM12);
tsc_info.u.counter_paddr =3D dtip[0].base + TIM12;
tsc_info.u.fr.mask =3D 0xffffffff;
__ipipe_tsc_register(&tsc_info);
}



and in the board declaration:



static struct davinci_timer_instance da850_timer_instance[4] =3D {
{
.base =3D DA8XX_TIMER64P0_BASE,
.bottom_irq =3D IRQ_DA8XX_TINT12_0,
.top_irq =3D IRQ_DA8XX_TINT34_0,
},
{
.base =3D DA8XX_TIMER64P1_BASE,
.bottom_irq =3D IRQ_DA8XX_TINT12_1,
.top_irq =3D IRQ_DA8XX_TINT34_1,
},
{
.base =3D DA850_TIMER64P2_BASE,
.bottom_irq =3D IRQ_DA850_TINT12_2,
.top_irq =3D IRQ_DA850_TINT34_2,
},
{
.base =3D DA850_TIMER64P3_BASE,
.bottom_irq =3D IRQ_DA850_TINT12_3,
.top_irq =3D IRQ_DA850_TINT34_3,
},
};





Result not change
