From: "kerhoas.vincent" <kerhoas.vincent@domain.hid>
Message-ID: <16282572.8252241211811692909.JavaMail.www@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_731422_24551385.1211811692908"
Date: Mon, 26 May 2008 16:21:32 +0200 (CEST)
Subject: [Xenomai-help] patch on cirrus logic ep93xx
Reply-To: "kerhoas.vincent" <kerhoas.vincent@domain.hid>
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

------=_Part_731422_24551385.1211811692908
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi

I don't understand how works the mailing list, but i would like to respond =
to the following message :

    * To: xenomai@xenomai.org
    * Date: Tue, 05 Jun 2007 12:58:43 +0200
    * Cancel-lock: sha1:wFJ2xCQGTR4egd5w2JgP2LY69FU=3D
    * Message-id: <m28xay4qho.fsf@domain.hid>
    * Organization: Church of Emacs - Missionary division
    * References: <200706041432.05779.ngustavson@domain.hid>
    * User-agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
I have an implementation against a 2.6.15 kernel that I never posted
because it is still "rough around the edges".  But as time passed too
quickly it is very likely the best to post it and at least give you a
base to work against.

Unfortunately I have only the whole patch including i-pipe support
based on what was in svn xenomai revision r2056 (i.e. 5th January this
year) together with the ep93xx parts in one large patch.  But the
ep93xx parts should be easy to extract.

One thing that I did not finish was a correct demuxing of the
interrupts that got introduced somewhat around that timeframe in the
other ARM ports.  The code was compile-clean but not finished in this
area.

I hope this helps
  Detlev

--=20
Life is complex. It has real and imaginary components.
--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@domain.hid

Attachment: adeos-ipipe-2.6.15-arm-ep93xx-05-dirty.patch.gz
Description: Binary data

_____________________________________________________________________

Here is my response, I haven't tried my program yet but I used a part of th=
e dirty patch.

Any comments ? Does it seem to be ok ?

Regards

Vincent
______________________________________________________________________


_________________________________________=20

* Patch xenomai kernel
* Then modifiy files above
* >make
_________________________________________
_________________________________________


In /include/asm/xenomai/hal.h :

Add :

#elif defined(CONFIG_ARCH_EP93XX)
#define RTHAL_TIMER_DEVICE=09"TIMER1"
#define RTHAL_CLOCK_DEVICE=09"TIMER1"

_________________________________________

In /include/asm-arm/arch-ep93xx/irq.h:

Add :

#ifdef CONFIG_IPIPE
#define __ipipe_mach_irq_mux_p(irq) ((irq) =3D=3D IRQ_EP93XX_GPIO(0))
#endif /* CONFIG_IPIPE */


_________________________________________

Change /arch/arm/mach-ep93xx/core.c as follows :

//*********************************************************
/*
 * arch/arm/mach-ep93xx/core.c
 * Core routines for Cirrus EP93xx chips.
 *
 * Copyright (C) 2006 Lennert Buytenhek <buytenh@domain.hid>
 *
 * Thanks go to Michael Burian and Ray Lehtiniemi for their key
 * role in the ep93xx linux community.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or (at
 * your option) any later version.
 */

#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/spinlock.h>
#include <linux/sched.h>
#include <linux/interrupt.h>
#include <linux/serial.h>
#include <linux/tty.h>
#include <linux/bitops.h>
#include <linux/serial.h>
#include <linux/serial_8250.h>
#include <linux/serial_core.h>
#include <linux/device.h>
#include <linux/mm.h>
#include <linux/time.h>
#include <linux/timex.h>
#include <linux/delay.h>
#include <linux/termios.h>
#include <linux/amba/bus.h>
#include <linux/amba/serial.h>

#include <asm/types.h>
#include <asm/setup.h>
#include <asm/memory.h>
#include <asm/hardware.h>
#include <asm/irq.h>
#include <asm/system.h>
#include <asm/tlbflush.h>
#include <asm/pgtable.h>
#include <asm/io.h>

#include <asm/mach/map.h>
#include <asm/mach/time.h>
#include <asm/mach/irq.h>
#include <asm/arch/gpio.h>

#include <asm/hardware/vic.h>

#define sic_readl=09=09__raw_readl
#define INTCP_VA_SIC_BASE=090xfca00000

=20
#ifdef CONFIG_IPIPE
int __ipipe_mach_timerint =3D IRQ_EP93XX_TIMER1;
static unsigned long long __ipipe_mach_tsc;
static DEFINE_SPINLOCK(timer_lock);

int __ipipe_mach_timerstolen =3D 0;
EXPORT_SYMBOL(__ipipe_mach_timerstolen);

unsigned int __ipipe_mach_ticks_per_jiffy =3D 508000L / HZ;
EXPORT_SYMBOL(__ipipe_mach_ticks_per_jiffy);


#endif /* CONFIG_IPIPE */


#ifdef CONFIG_NO_IDLE_HZ
#error "dynamic tick timer not yet supported with IPIPE"
#endif /* CONFIG_NO_IDLE_HZ */


#define TIMER_INTERVAL=09(508 * mSEC_10 / 1000)
#define TICKS2USECS(x)=09((x) * 1000 / 508)
=20
static unsigned long timer_reload;
static unsigned long timer_interval;
static unsigned long timer_lxlost;
static int tscok;


union tsc_reg {
#ifdef __BIG_ENDIAN
=09struct {
=09=09unsigned long high;
=09=09unsigned long low;
=09};
#else /* __LITTLE_ENDIAN */
=09struct {
=09=09unsigned long low;
=09=09unsigned long high;
=09};
#endif /* __LITTLE_ENDIAN */
=09unsigned long long full;
};

#ifdef CONFIG_SMP
static union tsc_reg tsc[NR_CPUS];

/* (...) */
#else /* !CONFIG_SMP */
static union tsc_reg *tsc;

/* (...) */
#endif


/*************************************************************************
 * Static I/O mappings that are needed for all EP93xx platforms
 *************************************************************************/
static struct map_desc ep93xx_io_desc[] __initdata =3D {
=09{
=09=09.virtual=09=3D EP93XX_AHB_VIRT_BASE,
=09=09.pfn=09=09=3D __phys_to_pfn(EP93XX_AHB_PHYS_BASE),
=09=09.length=09=09=3D EP93XX_AHB_SIZE,
=09=09.type=09=09=3D MT_DEVICE,
=09}, {
=09=09.virtual=09=3D EP93XX_APB_VIRT_BASE,
=09=09.pfn=09=09=3D __phys_to_pfn(EP93XX_APB_PHYS_BASE),
=09=09.length=09=09=3D EP93XX_APB_SIZE,
=09=09.type=09=09=3D MT_DEVICE,
=09},
};

void __init ep93xx_map_io(void)
{
=09iotable_init(ep93xx_io_desc, ARRAY_SIZE(ep93xx_io_desc));
}

static inline void set_dec(unsigned long reload)
{
=09unsigned int timer_ctrl =3D 0x80 | 0x08;=09/* non-periodic at 508 kHz */
=20
=09timer_reload =3D reload;
=09timer_interval =3D reload;

=09__raw_writel(0, EP93XX_TIMER1_CONTROL);
=09__raw_writel(timer_reload, EP93XX_TIMER1_LOAD);
=09__raw_writel(timer_ctrl, EP93XX_TIMER1_CONTROL);
 }
/*************************************************************************
 * Timer handling for EP93xx
 *************************************************************************
 * The ep93xx has four internal timers.  Timers 1, 2 (both 16 bit) and
 * 3 (32 bit) count down at 508 kHz, are self-reloading, and can generate
 * an interrupt on underflow.  Timer 4 (40 bit) counts down at 983.04 kHz,
 * is free-running, and can't generate interrupts.
 *
 * The 508 kHz timers are ideal for use for the timer interrupt, as the
 * most common values of HZ divide 508 kHz nicely.  We pick one of the 16
 * bit timers (timer 1) since we don't need more than 16 bits of reload
 * value as long as HZ >=3D 8.
 *
 * The higher clock rate of timer 4 makes it a better choice than the
 * other timers for use in gettimeoffset(), while the fact that it can't
 * generate interrupts means we don't have to worry about not being able
 * to use this timer for something else.  We also use timer 4 for keeping
 * track of lost jiffies.
 */
static unsigned int last_jiffy_time;

#define TIMER4_TICKS_PER_JIFFY=09=09((CLOCK_TICK_RATE + (HZ/2)) / HZ)

#ifdef CONFIG_IPIPE
/* (...) */
void __ipipe_mach_get_tscinfo(struct __ipipe_tscinfo *info)
{
=09info->type =3D IPIPE_TSC_TYPE_NONE;
}
#endif


#ifdef CONFIG_IPIPE
void __ipipe_mach_acktimer(void)
{
// It's up to i_pipe to acknoledge timer interrupt

=09__raw_writel(1, EP93XX_TIMER1_CLEAR);
}

/*
 * Called with IRQ disabled from do_gettimeofday().
 */
static inline unsigned long ep93xx_getticksoffset(void)
{
=09unsigned long ticks;

=09if (!tscok)
=09=09return 0;

=09ticks =3D __raw_readl(EP93XX_TIMER1_VALUE) & 0xffff;

=09if (ticks > timer_reload)
=09=09ticks =3D 0xffff + timer_reload - ticks;
=09else
=09=09ticks =3D timer_reload - ticks;

=09return ticks;
}

unsigned long long __ipipe_mach_get_tsc(void)
{
=09unsigned long long result;
=09unsigned long flags;

=09local_irq_save_hw_notrace(flags);
=09spin_lock(&timer_lock);
=09result =3D __ipipe_mach_tsc + ep93xx_getticksoffset();
=09spin_unlock(&timer_lock);
=09local_irq_restore_hw_notrace(flags);
=09return result;
}


EXPORT_SYMBOL(__ipipe_mach_get_tsc);


void __ipipe_mach_set_dec(unsigned long reload)
{
=09unsigned long ticks;
=09unsigned long flags;

=09spin_lock_irqsave(&timer_lock, flags);
=09ticks =3D ep93xx_getticksoffset();
=09__ipipe_mach_tsc +=3D ticks;
=09timer_lxlost +=3D ticks;

=09set_dec(reload);
=09spin_unlock_irqrestore(&timer_lock, flags);
}

EXPORT_SYMBOL(__ipipe_mach_set_dec);

unsigned long __ipipe_mach_get_dec(void)
{
=09return =09__raw_readl(EP93XX_TIMER1_VALUE) & 0xffff;
}
#endif /* CONFIG_IPIPE */


 /*
  * Returns number of ms since last clock interrupt.  Note that interrupts
  * will have been disabled by do_gettimeoffset()
  */

unsigned long ep93xx_gettimeoffset(void)
 {

//=09 * Convert the ticks to usecs

=09return TICKS2USECS(timer_lxlost + ep93xx_getticksoffset());
}


=20

 /*
  * IRQ handler for the timer
  */
static int ep93xx_timer_interrupt(int irq, void *dev_id)
{

=09write_seqlock(&xtime_lock);

=09timer_lxlost =3D 0;

#ifdef CONFIG_IPIPE
=09/*
=09 * If Linux is the only domain, ack the timer and reprogram it
=09 */
=09if (!__ipipe_mach_timerstolen) {
=09=09__ipipe_mach_tsc +=3D ep93xx_getticksoffset();
#else
=09=09/* ...clear the interrupt */
=09=09__raw_writel(1, EP93XX_TIMER1_CLEAR);  /* Clear match on timer 1 */
#endif
=09=09set_dec(timer_reload);

#ifdef CONFIG_IPIPE
=09}
#endif=09
=20
 =09timer_tick();
=09write_sequnlock(&xtime_lock);
=20
 =09return IRQ_HANDLED;
}


static struct irqaction ep93xx_timer_irq =3D {
=09.name=09=09=3D "ep93xx timer",
=09.flags=09=09=3D IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
=09.handler=09=3D ep93xx_timer_interrupt,
};



static void __init ep93xx_timer_init(unsigned long reload)
{



=09tsc =3D (union tsc_reg *) __ipipe_tsc_area;
=09barrier();


=09/* Enable periodic HZ timer.  */
=09__raw_writel(0x48, EP93XX_TIMER1_CONTROL);
=09__raw_writel((508469 / HZ) - 1, EP93XX_TIMER1_LOAD);
=09__raw_writel(0xc8, EP93XX_TIMER1_CONTROL);

=09/* Enable lost jiffy timer.  */
=09__raw_writel(0x100, EP93XX_TIMER4_VALUE_HIGH);

 =09set_dec(reload);
=20
=09
=09setup_irq(IRQ_EP93XX_TIMER1, &ep93xx_timer_irq);

=09tscok =3D 1;
}


struct sys_timer ep93xx_timer =3D {
=09.init=09=09=3D ep93xx_timer_init,
=09.offset=09=09=3D ep93xx_gettimeoffset,
};


/*************************************************************************
 * GPIO handling for EP93xx
 *************************************************************************/
static unsigned char gpio_int_unmasked[3];
static unsigned char gpio_int_enabled[3];
static unsigned char gpio_int_type1[3];
static unsigned char gpio_int_type2[3];

static void update_gpio_int_params(int abf)
{
=09if (abf =3D=3D 0) {
=09=09__raw_writeb(0, EP93XX_GPIO_A_INT_ENABLE);
=09=09__raw_writeb(gpio_int_type2[0], EP93XX_GPIO_A_INT_TYPE2);
=09=09__raw_writeb(gpio_int_type1[0], EP93XX_GPIO_A_INT_TYPE1);
=09=09__raw_writeb(gpio_int_unmasked[0] & gpio_int_enabled[0], EP93XX_GPIO_=
A_INT_ENABLE);
=09} else if (abf =3D=3D 1) {
=09=09__raw_writeb(0, EP93XX_GPIO_B_INT_ENABLE);
=09=09__raw_writeb(gpio_int_type2[1], EP93XX_GPIO_B_INT_TYPE2);
=09=09__raw_writeb(gpio_int_type1[1], EP93XX_GPIO_B_INT_TYPE1);
=09=09__raw_writeb(gpio_int_unmasked[1] & gpio_int_enabled[1], EP93XX_GPIO_=
B_INT_ENABLE);
=09} else if (abf =3D=3D 2) {
=09=09__raw_writeb(0, EP93XX_GPIO_F_INT_ENABLE);
=09=09__raw_writeb(gpio_int_type2[2], EP93XX_GPIO_F_INT_TYPE2);
=09=09__raw_writeb(gpio_int_type1[2], EP93XX_GPIO_F_INT_TYPE1);
=09=09__raw_writeb(gpio_int_unmasked[2] & gpio_int_enabled[2], EP93XX_GPIO_=
F_INT_ENABLE);
=09} else {
=09=09BUG();
=09}
}


static unsigned char data_register_offset[8] =3D {
=090x00, 0x04, 0x08, 0x0c, 0x20, 0x30, 0x38, 0x40,
};

static unsigned char data_direction_register_offset[8] =3D {
=090x10, 0x14, 0x18, 0x1c, 0x24, 0x34, 0x3c, 0x44,
};

void gpio_line_config(int line, int direction)
{
=09unsigned int data_direction_register;
=09unsigned long flags;
=09unsigned char v;

=09data_direction_register =3D
=09=09EP93XX_GPIO_REG(data_direction_register_offset[line >> 3]);

=09local_irq_save(flags);
=09if (direction =3D=3D GPIO_OUT) {
=09=09if (line >=3D 0 && line < 16) {
=09=09=09/* Port A/B.  */
=09=09=09gpio_int_unmasked[line >> 3] &=3D ~(1 << (line & 7));
=09=09=09update_gpio_int_params(line >> 3);
=09=09} else if (line >=3D 40 && line < 48) {
=09=09=09/* Port F.  */
=09=09=09gpio_int_unmasked[2] &=3D ~(1 << (line & 7));
=09=09=09update_gpio_int_params(2);
=09=09}

=09=09v =3D __raw_readb(data_direction_register);
=09=09v |=3D 1 << (line & 7);
=09=09__raw_writeb(v, data_direction_register);
=09} else if (direction =3D=3D GPIO_IN) {
=09=09v =3D __raw_readb(data_direction_register);
=09=09v &=3D ~(1 << (line & 7));
=09=09__raw_writeb(v, data_direction_register);
=09}
=09local_irq_restore(flags);
}
EXPORT_SYMBOL(gpio_line_config);

int gpio_line_get(int line)
{
=09unsigned int data_register;

=09data_register =3D EP93XX_GPIO_REG(data_register_offset[line >> 3]);

=09return !!(__raw_readb(data_register) & (1 << (line & 7)));
}
EXPORT_SYMBOL(gpio_line_get);

void gpio_line_set(int line, int value)
{
=09unsigned int data_register;
=09unsigned long flags;
=09unsigned char v;

=09data_register =3D EP93XX_GPIO_REG(data_register_offset[line >> 3]);

=09local_irq_save(flags);
=09if (value =3D=3D EP93XX_GPIO_HIGH) {
=09=09v =3D __raw_readb(data_register);
=09=09v |=3D 1 << (line & 7);
=09=09__raw_writeb(v, data_register);
=09} else if (value =3D=3D EP93XX_GPIO_LOW) {
=09=09v =3D __raw_readb(data_register);
=09=09v &=3D ~(1 << (line & 7));
=09=09__raw_writeb(v, data_register);
=09}
=09local_irq_restore(flags);
}
EXPORT_SYMBOL(gpio_line_set);


/*************************************************************************
 * EP93xx IRQ handling
 *************************************************************************/
static void ep93xx_gpio_ab_irq_handler(unsigned int irq, struct irq_desc *d=
esc)
{
=09unsigned char status;
=09int i;

=09status =3D __raw_readb(EP93XX_GPIO_A_INT_STATUS);
=09for (i =3D 0; i < 8; i++) {
=09=09if (status & (1 << i)) {
=09=09=09desc =3D irq_desc + IRQ_EP93XX_GPIO(0) + i;
=09=09=09desc_handle_irq(IRQ_EP93XX_GPIO(0) + i, desc);
=09=09}
=09}

=09status =3D __raw_readb(EP93XX_GPIO_B_INT_STATUS);
=09for (i =3D 0; i < 8; i++) {
=09=09if (status & (1 << i)) {
=09=09=09desc =3D irq_desc + IRQ_EP93XX_GPIO(8) + i;
=09=09=09desc_handle_irq(IRQ_EP93XX_GPIO(8) + i, desc);
=09=09}
=09}
}

static void ep93xx_gpio_f_irq_handler(unsigned int irq, struct irq_desc *de=
sc)
{
=09int gpio_irq =3D IRQ_EP93XX_GPIO(16) + (((irq + 1) & 7) ^ 4);

=09desc_handle_irq(gpio_irq, irq_desc + gpio_irq);
}

static void ep93xx_gpio_irq_mask_ack(unsigned int irq)
{
=09int line =3D irq - IRQ_EP93XX_GPIO(0);
=09int port =3D line >> 3;

=09gpio_int_unmasked[port] &=3D ~(1 << (line & 7));
=09update_gpio_int_params(port);

=09if (port =3D=3D 0) {
=09=09__raw_writel(1 << (line & 7), EP93XX_GPIO_A_INT_ACK);
=09} else if (port =3D=3D 1) {
=09=09__raw_writel(1 << (line & 7), EP93XX_GPIO_B_INT_ACK);
=09} else if (port =3D=3D 2) {
=09=09__raw_writel(1 << (line & 7), EP93XX_GPIO_F_INT_ACK);
=09}
}

static void ep93xx_gpio_irq_mask(unsigned int irq)
{
=09int line =3D irq - IRQ_EP93XX_GPIO(0);
=09int port =3D line >> 3;

=09gpio_int_unmasked[port] &=3D ~(1 << (line & 7));
=09update_gpio_int_params(port);
}

static void ep93xx_gpio_irq_unmask(unsigned int irq)
{
=09int line =3D irq - IRQ_EP93XX_GPIO(0);
=09int port =3D line >> 3;

=09gpio_int_unmasked[port] |=3D 1 << (line & 7);
=09update_gpio_int_params(port);
}


/*
 * gpio_int_type1 controls whether the interrupt is level (0) or
 * edge (1) triggered, while gpio_int_type2 controls whether it
 * triggers on low/falling (0) or high/rising (1).
 */
static int ep93xx_gpio_irq_type(unsigned int irq, unsigned int type)
{
=09int port;
=09int line;

=09line =3D irq - IRQ_EP93XX_GPIO(0);
=09if (line >=3D 0 && line < 16) {
=09=09gpio_line_config(line, GPIO_IN);
=09} else {
=09=09gpio_line_config(EP93XX_GPIO_LINE_F(line-16), GPIO_IN);
=09}

=09port =3D line >> 3;
=09line &=3D 7;

=09if (type & IRQT_RISING) {
=09=09gpio_int_enabled[port] |=3D 1 << line;
=09=09gpio_int_type1[port] |=3D 1 << line;
=09=09gpio_int_type2[port] |=3D 1 << line;
=09} else if (type & IRQT_FALLING) {
=09=09gpio_int_enabled[port] |=3D 1 << line;
=09=09gpio_int_type1[port] |=3D 1 << line;
=09=09gpio_int_type2[port] &=3D ~(1 << line);
=09} else if (type & IRQT_HIGH) {
=09=09gpio_int_enabled[port] |=3D 1 << line;
=09=09gpio_int_type1[port] &=3D ~(1 << line);
=09=09gpio_int_type2[port] |=3D 1 << line;
=09} else if (type & IRQT_LOW) {
=09=09gpio_int_enabled[port] |=3D 1 << line;
=09=09gpio_int_type1[port] &=3D ~(1 << line);
=09=09gpio_int_type2[port] &=3D ~(1 << line);
=09} else {
=09=09gpio_int_enabled[port] &=3D ~(1 << line);
=09}
=09update_gpio_int_params(port);

=09return 0;
}

static struct irq_chip ep93xx_gpio_irq_chip =3D {
=09.name=09=09=3D "GPIO",
=09.ack=09=09=3D ep93xx_gpio_irq_mask_ack,
=09.mask=09=09=3D ep93xx_gpio_irq_mask,
=09.unmask=09=09=3D ep93xx_gpio_irq_unmask,
=09.set_type=09=3D ep93xx_gpio_irq_type,
};


void __init ep93xx_init_irq(void)
{
=09int irq;

=09vic_init((void *)EP93XX_VIC1_BASE, 0, EP93XX_VIC1_VALID_IRQ_MASK);
=09vic_init((void *)EP93XX_VIC2_BASE, 32, EP93XX_VIC2_VALID_IRQ_MASK);

=09for (irq =3D IRQ_EP93XX_GPIO(0); irq <=3D IRQ_EP93XX_GPIO(23); irq++) {
=09=09set_irq_chip(irq, &ep93xx_gpio_irq_chip);
=09=09set_irq_handler(irq, handle_level_irq);
=09=09set_irq_flags(irq, IRQF_VALID);
=09}

=09set_irq_chained_handler(IRQ_EP93XX_GPIO_AB, ep93xx_gpio_ab_irq_handler);
=09set_irq_chained_handler(IRQ_EP93XX_GPIO0MUX, ep93xx_gpio_f_irq_handler);
=09set_irq_chained_handler(IRQ_EP93XX_GPIO1MUX, ep93xx_gpio_f_irq_handler);
=09set_irq_chained_handler(IRQ_EP93XX_GPIO2MUX, ep93xx_gpio_f_irq_handler);
=09set_irq_chained_handler(IRQ_EP93XX_GPIO3MUX, ep93xx_gpio_f_irq_handler);
=09set_irq_chained_handler(IRQ_EP93XX_GPIO4MUX, ep93xx_gpio_f_irq_handler);
=09set_irq_chained_handler(IRQ_EP93XX_GPIO5MUX, ep93xx_gpio_f_irq_handler);
=09set_irq_chained_handler(IRQ_EP93XX_GPIO6MUX, ep93xx_gpio_f_irq_handler);
=09set_irq_chained_handler(IRQ_EP93XX_GPIO7MUX, ep93xx_gpio_f_irq_handler);
}

#ifdef CONFIG_ARCH_EP93XX_GPIO_IRQ
 =09set_irq_chained_handler(IRQ_GPIO, ep93xx_gpio_demux_handler);
#endif



#ifdef CONFIG_IPIPE
void __ipipe_mach_demux_irq(unsigned irq, struct pt_regs *regs)
{
=09unsigned char status;
=09int i;
=09struct irq_desc *desc_unused =3D irq_desc + IRQ_EP93XX_GPIO(0);
=09unsigned irq_unused =3D irq;

=09status =3D __raw_readb(EP93XX_GPIO_A_INT_STATUS);

=09//*desc_unused=3D irq_desc + IRQ_EP93XX_GPIO(0);

=09for (i =3D 0; i < 8; i++) {
=09=09if (status & (1 << i)) {
=09=09=09
=09=09=09__ipipe_handle_irq(IRQ_EP93XX_GPIO(0) + i, regs);
=09=09}
=09}

=09status =3D __raw_readb(EP93XX_GPIO_B_INT_STATUS);

=09desc_unused=3D irq_desc + IRQ_EP93XX_GPIO(8);

=09for (i =3D 0; i < 8; i++) {
=09=09if (status & (1 << i)) {
=09=09=09
=09=09=09__ipipe_handle_irq(IRQ_EP93XX_GPIO(8) + i, regs);
=09=09}

=09desc_unused->chip->unmask(irq_unused);

=09}
}
#endif /* CONFIG_IPIPE */


/*************************************************************************
 * EP93xx peripheral handling
 *************************************************************************/
#define EP93XX_UART_MCR_OFFSET=09=09(0x0100)

static void ep93xx_uart_set_mctrl(struct amba_device *dev,
=09=09=09=09  void __iomem *base, unsigned int mctrl)
{
=09unsigned int mcr;

=09mcr =3D 0;
=09if (!(mctrl & TIOCM_RTS))
=09=09mcr |=3D 2;
=09if (!(mctrl & TIOCM_DTR))
=09=09mcr |=3D 1;

=09__raw_writel(mcr, base + EP93XX_UART_MCR_OFFSET);
}

static struct amba_pl010_data ep93xx_uart_data =3D {
=09.set_mctrl=09=3D ep93xx_uart_set_mctrl,
};

static struct amba_device uart1_device =3D {
=09.dev=09=09=3D {
=09=09.bus_id=09=09=3D "apb:uart1",
=09=09.platform_data=09=3D &ep93xx_uart_data,
=09},
=09.res=09=09=3D {
=09=09.start=09=3D EP93XX_UART1_PHYS_BASE,
=09=09.end=09=3D EP93XX_UART1_PHYS_BASE + 0x0fff,
=09=09.flags=09=3D IORESOURCE_MEM,
=09},
=09.irq=09=09=3D { IRQ_EP93XX_UART1, NO_IRQ },
=09.periphid=09=3D 0x00041010,
};

static struct amba_device uart2_device =3D {
=09.dev=09=09=3D {
=09=09.bus_id=09=09=3D "apb:uart2",
=09=09.platform_data=09=3D &ep93xx_uart_data,
=09},
=09.res=09=09=3D {
=09=09.start=09=3D EP93XX_UART2_PHYS_BASE,
=09=09.end=09=3D EP93XX_UART2_PHYS_BASE + 0x0fff,
=09=09.flags=09=3D IORESOURCE_MEM,
=09},
=09.irq=09=09=3D { IRQ_EP93XX_UART2, NO_IRQ },
=09.periphid=09=3D 0x00041010,
};

static struct amba_device uart3_device =3D {
=09.dev=09=09=3D {
=09=09.bus_id=09=09=3D "apb:uart3",
=09=09.platform_data=09=3D &ep93xx_uart_data,
=09},
=09.res=09=09=3D {
=09=09.start=09=3D EP93XX_UART3_PHYS_BASE,
=09=09.end=09=3D EP93XX_UART3_PHYS_BASE + 0x0fff,
=09=09.flags=09=3D IORESOURCE_MEM,
=09},
=09.irq=09=09=3D { IRQ_EP93XX_UART3, NO_IRQ },
=09.periphid=09=3D 0x00041010,
};


static struct platform_device ep93xx_rtc_device =3D {
       .name           =3D "ep93xx-rtc",
       .id             =3D -1,
       .num_resources  =3D 0,
};


static struct resource ep93xx_ohci_resources[] =3D {
=09[0] =3D {
=09=09.start=09=3D EP93XX_USB_PHYS_BASE,
=09=09.end=09=3D EP93XX_USB_PHYS_BASE + 0x0fff,
=09=09.flags=09=3D IORESOURCE_MEM,
=09},
=09[1] =3D {
=09=09.start=09=3D IRQ_EP93XX_USB,
=09=09.end=09=3D IRQ_EP93XX_USB,
=09=09.flags=09=3D IORESOURCE_IRQ,
=09},
};

static struct platform_device ep93xx_ohci_device =3D {
=09.name=09=09=3D "ep93xx-ohci",
=09.id=09=09=3D -1,
=09.dev=09=09=3D {
=09=09.dma_mask=09=09=3D (void *)0xffffffff,
=09=09.coherent_dma_mask=09=3D 0xffffffff,
=09},
=09.num_resources=09=3D ARRAY_SIZE(ep93xx_ohci_resources),
=09.resource=09=3D ep93xx_ohci_resources,
};


void __init ep93xx_init_devices(void)
{
=09unsigned int v;

=09/*
=09 * Disallow access to MaverickCrunch initially.
=09 */
=09v =3D __raw_readl(EP93XX_SYSCON_DEVICE_CONFIG);
=09v &=3D ~EP93XX_SYSCON_DEVICE_CONFIG_CRUNCH_ENABLE;
=09__raw_writel(0xaa, EP93XX_SYSCON_SWLOCK);
=09__raw_writel(v, EP93XX_SYSCON_DEVICE_CONFIG);

=09amba_device_register(&uart1_device, &iomem_resource);
=09amba_device_register(&uart2_device, &iomem_resource);
=09amba_device_register(&uart3_device, &iomem_resource);

=09platform_device_register(&ep93xx_rtc_device);
=09platform_device_register(&ep93xx_ohci_device);
}








=20


 Cr=C3=A9ez votre adresse =C3=A9lectronique pr=C3=A9nom.nom@domain.hid
 1 Go d'espace de stockage, anti-spam et anti-virus int=C3=A9gr=C3=A9s.

------=_Part_731422_24551385.1211811692908
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi<BR><BR>I don't understand how works the mailing list, but i would like t=
o respond to the following message :<BR><BR>    * To: xenomai@xenomai.org<=
BR>    * Date: Tue, 05 Jun 2007 12:58:43 +0200<BR>    * Cancel-lock: sha1:w=
FJ2xCQGTR4egd5w2JgP2LY69FU=3D<BR>    * Message-id: <m28xay4qho.fsf@domain.hid=
enx.de><BR>    * Organization: Church of Emacs - Missionary division<BR>   =
 * References: <200706041432.05779.ngustavson@domain.hid><BR>    * User-ag=
ent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)<BR>I have an implemen=
tation against a 2.6.15 kernel that I never posted<BR>because it is still "=
rough around the edges".  But as time passed too<BR>quickly it is very like=
ly the best to post it and at least give you a<BR>base to work against.<BR>=
<BR>Unfortunately I have only the whole patch including i-pipe support<BR>b=
ased on what was in svn xenomai revision r2056 (i.e. 5th January this<BR>ye=
ar) together with the ep93xx parts in one large patch.  But the<BR>ep93xx p=
arts should be easy to extract.<BR><BR>One thing that I did not finish was =
a correct demuxing of the<BR>interrupts that got introduced somewhat around=
 that timeframe in the<BR>other ARM ports.  The code was compile-clean but =
not finished in this<BR>area.<BR><BR>I hope this helps<BR>  Detlev<BR><BR>-=
- <BR>Life is complex. It has real and imaginary components.<BR>--<BR>DENX =
Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel<BR>HRB 16=
5235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany<BR>Phone: =
(+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@domain.hid<BR><BR>Atta=
chment: adeos-ipipe-2.6.15-arm-ep93xx-05-dirty.patch.gz<BR>Description: Bin=
ary data<BR><BR>___________________________________________________________=
__________<BR><BR>Here is my response, I haven't tried my program yet but I=
 used a part of the dirty patch.<BR><BR>Any comments ? Does it seem to be o=
k ?<BR><BR>Regards<BR><BR>Vincent<BR>______________________________________=
________________________________<BR><BR><BR>_______________________________=
__________ <BR><BR>* Patch xenomai kernel<BR>* Then modifiy files above<BR>=
* >make<BR>_________________________________________<BR>___________________=
______________________<BR><BR><BR>In /include/asm/xenomai/hal.h :<BR><BR>Ad=
d :<BR><BR>#elif defined(CONFIG_ARCH_EP93XX)<BR>#define RTHAL_TIMER_DEVICE=
=09"TIMER1"<BR>#define RTHAL_CLOCK_DEVICE=09"TIMER1"<BR><BR>_______________=
__________________________<BR><BR>In /include/asm-arm/arch-ep93xx/irq.h:<BR=
><BR>Add :<BR><BR>#ifdef CONFIG_IPIPE<BR>#define __ipipe_mach_irq_mux_p(irq=
) ((irq) =3D=3D IRQ_EP93XX_GPIO(0))<BR>#endif /* CONFIG_IPIPE */<BR><BR><BR=
>_________________________________________<BR><BR>Change /arch/arm/mach-ep9=
3xx/core.c as follows :<BR><BR>//******************************************=
***************<BR>/*<BR> * arch/arm/mach-ep93xx/core.c<BR> * Core routines=
 for Cirrus EP93xx chips.<BR> *<BR> * Copyright (C) 2006 Lennert Buytenhek =
<buytenh@domain.hid><BR> *<BR> * Thanks go to Michael Burian and Ray Le=
htiniemi for their key<BR> * role in the ep93xx linux community.<BR> *<BR> =
* This program is free software; you can redistribute it and/or modify<BR> =
* it under the terms of the GNU General Public License as published by<BR> =
* the Free Software Foundation; either version 2 of the License, or (at<BR>=
 * your option) any later version.<BR> */<BR><BR>#include <linux/kernel.h><=
BR>#include <linux/init.h><BR>#include <linux/spinlock.h><BR>#include <linu=
x/sched.h><BR>#include <linux/interrupt.h><BR>#include <linux/serial.h><BR>=
#include <linux/tty.h><BR>#include <linux/bitops.h><BR>#include <linux/seri=
al.h><BR>#include <linux/serial_8250.h><BR>#include <linux/serial_core.h><B=
R>#include <linux/device.h><BR>#include <linux/mm.h><BR>#include <linux/tim=
e.h><BR>#include <linux/timex.h><BR>#include <linux/delay.h><BR>#include <l=
inux/termios.h><BR>#include <linux/amba/bus.h><BR>#include <linux/amba/seri=
al.h><BR><BR>#include <asm/types.h><BR>#include <asm/setup.h><BR>#include <=
asm/memory.h><BR>#include <asm/hardware.h><BR>#include <asm/irq.h><BR>#incl=
ude <asm/system.h><BR>#include <asm/tlbflush.h><BR>#include <asm/pgtable.h>=
<BR>#include <asm/io.h><BR><BR>#include <asm/mach/map.h><BR>#include <asm/m=
ach/time.h><BR>#include <asm/mach/irq.h><BR>#include <asm/arch/gpio.h><BR><=
BR>#include <asm/hardware/vic.h><BR><BR>#define sic_readl=09=09__raw_readl<=
BR>#define INTCP_VA_SIC_BASE=090xfca00000<BR><BR> <BR>#ifdef CONFIG_IPIPE<B=
R>int __ipipe_mach_timerint =3D IRQ_EP93XX_TIMER1;<BR>static unsigned long =
long __ipipe_mach_tsc;<BR>static DEFINE_SPINLOCK(timer_lock);<BR><BR>int __=
ipipe_mach_timerstolen =3D 0;<BR>EXPORT_SYMBOL(__ipipe_mach_timerstolen);<B=
R><BR>unsigned int __ipipe_mach_ticks_per_jiffy =3D 508000L / HZ;<BR>EXPORT=
_SYMBOL(__ipipe_mach_ticks_per_jiffy);<BR><BR><BR>#endif /* CONFIG_IPIPE */=
<BR><BR><BR>#ifdef CONFIG_NO_IDLE_HZ<BR>#error "dynamic tick timer not yet =
supported with IPIPE"<BR>#endif /* CONFIG_NO_IDLE_HZ */<BR><BR><BR>#define =
TIMER_INTERVAL=09(508 * mSEC_10 / 1000)<BR>#define TICKS2USECS(x)=09((x) * =
1000 / 508)<BR> <BR>static unsigned long timer_reload;<BR>static unsigned l=
ong timer_interval;<BR>static unsigned long timer_lxlost;<BR>static int tsc=
ok;<BR><BR><BR>union tsc_reg {<BR>#ifdef __BIG_ENDIAN<BR>=09struct {<BR>=09=
=09unsigned long high;<BR>=09=09unsigned long low;<BR>=09};<BR>#else /* __L=
ITTLE_ENDIAN */<BR>=09struct {<BR>=09=09unsigned long low;<BR>=09=09unsigne=
d long high;<BR>=09};<BR>#endif /* __LITTLE_ENDIAN */<BR>=09unsigned long l=
ong full;<BR>};<BR><BR>#ifdef CONFIG_SMP<BR>static union tsc_reg tsc[NR_CPU=
S];<BR><BR>/* (...) */<BR>#else /* !CONFIG_SMP */<BR>static union tsc_reg *=
tsc;<BR><BR>/* (...) */<BR>#endif<BR><BR><BR>/*****************************=
********************************************<BR> * Static I/O mappings that=
 are needed for all EP93xx platforms<BR> **********************************=
***************************************/<BR>static struct map_desc ep93xx_i=
o_desc[] __initdata =3D {<BR>=09{<BR>=09=09.virtual=09=3D EP93XX_AHB_VIRT_B=
ASE,<BR>=09=09.pfn=09=09=3D __phys_to_pfn(EP93XX_AHB_PHYS_BASE),<BR>=09=09.=
length=09=09=3D EP93XX_AHB_SIZE,<BR>=09=09.type=09=09=3D MT_DEVICE,<BR>=09}=
, {<BR>=09=09.virtual=09=3D EP93XX_APB_VIRT_BASE,<BR>=09=09.pfn=09=09=3D __=
phys_to_pfn(EP93XX_APB_PHYS_BASE),<BR>=09=09.length=09=09=3D EP93XX_APB_SIZ=
E,<BR>=09=09.type=09=09=3D MT_DEVICE,<BR>=09},<BR>};<BR><BR>void __init ep9=
3xx_map_io(void)<BR>{<BR>=09iotable_init(ep93xx_io_desc, ARRAY_SIZE(ep93xx_=
io_desc));<BR>}<BR><BR>static inline void set_dec(unsigned long reload)<BR>=
{<BR>=09unsigned int timer_ctrl =3D 0x80 | 0x08;=09/* non-periodic at 508 k=
Hz */<BR> <BR>=09timer_reload =3D reload;<BR>=09timer_interval =3D reload;<=
BR><BR>=09__raw_writel(0, EP93XX_TIMER1_CONTROL);<BR>=09__raw_writel(timer_=
reload, EP93XX_TIMER1_LOAD);<BR>=09__raw_writel(timer_ctrl, EP93XX_TIMER1_C=
ONTROL);<BR> }<BR>/********************************************************=
*****************<BR> * Timer handling for EP93xx<BR> *********************=
****************************************************<BR> * The ep93xx has f=
our internal timers.  Timers 1, 2 (both 16 bit) and<BR> * 3 (32 bit) count =
down at 508 kHz, are self-reloading, and can generate<BR> * an interrupt on=
 underflow.  Timer 4 (40 bit) counts down at 983.04 kHz,<BR> * is free-runn=
ing, and can't generate interrupts.<BR> *<BR> * The 508 kHz timers are idea=
l for use for the timer interrupt, as the<BR> * most common values of HZ di=
vide 508 kHz nicely.  We pick one of the 16<BR> * bit timers (timer 1) sinc=
e we don't need more than 16 bits of reload<BR> * value as long as HZ >=3D =
8.<BR> *<BR> * The higher clock rate of timer 4 makes it a better choice th=
an the<BR> * other timers for use in gettimeoffset(), while the fact that i=
t can't<BR> * generate interrupts means we don't have to worry about not be=
ing able<BR> * to use this timer for something else.  We also use timer 4 f=
or keeping<BR> * track of lost jiffies.<BR> */<BR>static unsigned int last_=
jiffy_time;<BR><BR>#define TIMER4_TICKS_PER_JIFFY=09=09((CLOCK_TICK_RATE + =
(HZ/2)) / HZ)<BR><BR>#ifdef CONFIG_IPIPE<BR>/* (...) */<BR>void __ipipe_mac=
h_get_tscinfo(struct __ipipe_tscinfo *info)<BR>{<BR>=09info->type =3D IPIPE=
_TSC_TYPE_NONE;<BR>}<BR>#endif<BR><BR><BR>#ifdef CONFIG_IPIPE<BR>void __ipi=
pe_mach_acktimer(void)<BR>{<BR>// It's up to i_pipe to acknoledge timer int=
errupt<BR><BR>=09__raw_writel(1, EP93XX_TIMER1_CLEAR);<BR>}<BR><BR>/*<BR> *=
 Called with IRQ disabled from do_gettimeofday().<BR> */<BR>static inline u=
nsigned long ep93xx_getticksoffset(void)<BR>{<BR>=09unsigned long ticks;<BR=
><BR>=09if (!tscok)<BR>=09=09return 0;<BR><BR>=09ticks =3D __raw_readl(EP93=
XX_TIMER1_VALUE) & 0xffff;<BR><BR>=09if (ticks > timer_reload)<BR>=09=09tic=
ks =3D 0xffff + timer_reload - ticks;<BR>=09else<BR>=09=09ticks =3D timer_r=
eload - ticks;<BR><BR>=09return ticks;<BR>}<BR><BR>unsigned long long __ipi=
pe_mach_get_tsc(void)<BR>{<BR>=09unsigned long long result;<BR>=09unsigned =
long flags;<BR><BR>=09local_irq_save_hw_notrace(flags);<BR>=09spin_lock(&ti=
mer_lock);<BR>=09result =3D __ipipe_mach_tsc + ep93xx_getticksoffset();<BR>=
=09spin_unlock(&timer_lock);<BR>=09local_irq_restore_hw_notrace(flags);<BR>=
=09return result;<BR>}<BR><BR><BR>EXPORT_SYMBOL(__ipipe_mach_get_tsc);<BR><=
BR><BR>void __ipipe_mach_set_dec(unsigned long reload)<BR>{<BR>=09unsigned =
long ticks;<BR>=09unsigned long flags;<BR><BR>=09spin_lock_irqsave(&timer_l=
ock, flags);<BR>=09ticks =3D ep93xx_getticksoffset();<BR>=09__ipipe_mach_ts=
c +=3D ticks;<BR>=09timer_lxlost +=3D ticks;<BR><BR>=09set_dec(reload);<BR>=
=09spin_unlock_irqrestore(&timer_lock, flags);<BR>}<BR><BR>EXPORT_SYMBOL(__=
ipipe_mach_set_dec);<BR><BR>unsigned long __ipipe_mach_get_dec(void)<BR>{<B=
R>=09return =09__raw_readl(EP93XX_TIMER1_VALUE) & 0xffff;<BR>}<BR>#endif /*=
 CONFIG_IPIPE */<BR><BR><BR> /*<BR>  * Returns number of ms since last cloc=
k interrupt.  Note that interrupts<BR>  * will have been disabled by do_get=
timeoffset()<BR>  */<BR><BR>unsigned long ep93xx_gettimeoffset(void)<BR> {<=
BR><BR>//=09 * Convert the ticks to usecs<BR><BR>=09return TICKS2USECS(time=
r_lxlost + ep93xx_getticksoffset());<BR>}<BR><BR><BR> <BR><BR> /*<BR>  * IR=
Q handler for the timer<BR>  */<BR>static int ep93xx_timer_interrupt(int ir=
q, void *dev_id)<BR>{<BR><BR>=09write_seqlock(&xtime_lock);<BR><BR>=09timer=
_lxlost =3D 0;<BR><BR>#ifdef CONFIG_IPIPE<BR>=09/*<BR>=09 * If Linux is the=
 only domain, ack the timer and reprogram it<BR>=09 */<BR>=09if (!__ipipe_m=
ach_timerstolen) {<BR>=09=09__ipipe_mach_tsc +=3D ep93xx_getticksoffset();<=
BR>#else<BR>=09=09/* ...clear the interrupt */<BR>=09=09__raw_writel(1, EP9=
3XX_TIMER1_CLEAR);  /* Clear match on timer 1 */<BR>#endif<BR>=09=09set_dec=
(timer_reload);<BR><BR>#ifdef CONFIG_IPIPE<BR>=09}<BR>#endif=09<BR> <BR> =
=09timer_tick();<BR>=09write_sequnlock(&xtime_lock);<BR> <BR> =09return IRQ=
_HANDLED;<BR>}<BR><BR><BR>static struct irqaction ep93xx_timer_irq =3D {<BR=
>=09.name=09=09=3D "ep93xx timer",<BR>=09.flags=09=09=3D IRQF_DISABLED | IR=
QF_TIMER | IRQF_IRQPOLL,<BR>=09.handler=09=3D ep93xx_timer_interrupt,<BR>};=
<BR><BR><BR><BR>static void __init ep93xx_timer_init(unsigned long reload)<=
BR>{<BR><BR><BR><BR>=09tsc =3D (union tsc_reg *) __ipipe_tsc_area;<BR>=09ba=
rrier();<BR><BR><BR>=09/* Enable periodic HZ timer.  */<BR>=09__raw_writel(=
0x48, EP93XX_TIMER1_CONTROL);<BR>=09__raw_writel((508469 / HZ) - 1, EP93XX_=
TIMER1_LOAD);<BR>=09__raw_writel(0xc8, EP93XX_TIMER1_CONTROL);<BR><BR>=09/*=
 Enable lost jiffy timer.  */<BR>=09__raw_writel(0x100, EP93XX_TIMER4_VALUE=
_HIGH);<BR><BR> =09set_dec(reload);<BR> <BR>=09<BR>=09setup_irq(IRQ_EP93XX_=
TIMER1, &ep93xx_timer_irq);<BR><BR>=09tscok =3D 1;<BR>}<BR><BR><BR>struct s=
ys_timer ep93xx_timer =3D {<BR>=09.init=09=09=3D ep93xx_timer_init,<BR>=09.=
offset=09=09=3D ep93xx_gettimeoffset,<BR>};<BR><BR><BR>/*******************=
******************************************************<BR> * GPIO handling =
for EP93xx<BR> ************************************************************=
*************/<BR>static unsigned char gpio_int_unmasked[3];<BR>static unsi=
gned char gpio_int_enabled[3];<BR>static unsigned char gpio_int_type1[3];<B=
R>static unsigned char gpio_int_type2[3];<BR><BR>static void update_gpio_in=
t_params(int abf)<BR>{<BR>=09if (abf =3D=3D 0) {<BR>=09=09__raw_writeb(0, E=
P93XX_GPIO_A_INT_ENABLE);<BR>=09=09__raw_writeb(gpio_int_type2[0], EP93XX_G=
PIO_A_INT_TYPE2);<BR>=09=09__raw_writeb(gpio_int_type1[0], EP93XX_GPIO_A_IN=
T_TYPE1);<BR>=09=09__raw_writeb(gpio_int_unmasked[0] & gpio_int_enabled[0],=
 EP93XX_GPIO_A_INT_ENABLE);<BR>=09} else if (abf =3D=3D 1) {<BR>=09=09__raw=
_writeb(0, EP93XX_GPIO_B_INT_ENABLE);<BR>=09=09__raw_writeb(gpio_int_type2[=
1], EP93XX_GPIO_B_INT_TYPE2);<BR>=09=09__raw_writeb(gpio_int_type1[1], EP93=
XX_GPIO_B_INT_TYPE1);<BR>=09=09__raw_writeb(gpio_int_unmasked[1] & gpio_int=
_enabled[1], EP93XX_GPIO_B_INT_ENABLE);<BR>=09} else if (abf =3D=3D 2) {<BR=
>=09=09__raw_writeb(0, EP93XX_GPIO_F_INT_ENABLE);<BR>=09=09__raw_writeb(gpi=
o_int_type2[2], EP93XX_GPIO_F_INT_TYPE2);<BR>=09=09__raw_writeb(gpio_int_ty=
pe1[2], EP93XX_GPIO_F_INT_TYPE1);<BR>=09=09__raw_writeb(gpio_int_unmasked[2=
] & gpio_int_enabled[2], EP93XX_GPIO_F_INT_ENABLE);<BR>=09} else {<BR>=09=
=09BUG();<BR>=09}<BR>}<BR><BR><BR>static unsigned char data_register_offset=
[8] =3D {<BR>=090x00, 0x04, 0x08, 0x0c, 0x20, 0x30, 0x38, 0x40,<BR>};<BR><B=
R>static unsigned char data_direction_register_offset[8] =3D {<BR>=090x10, =
0x14, 0x18, 0x1c, 0x24, 0x34, 0x3c, 0x44,<BR>};<BR><BR>void gpio_line_confi=
g(int line, int direction)<BR>{<BR>=09unsigned int data_direction_register;=
<BR>=09unsigned long flags;<BR>=09unsigned char v;<BR><BR>=09data_direction=
_register =3D<BR>=09=09EP93XX_GPIO_REG(data_direction_register_offset[line =
>> 3]);<BR><BR>=09local_irq_save(flags);<BR>=09if (direction =3D=3D GPIO_OU=
T) {<BR>=09=09if (line >=3D 0 && line < 16) {<BR>=09=09=09/* Port A/B.  */<=
BR>=09=09=09gpio_int_unmasked[line >> 3] &=3D ~(1 << (line & 7));<BR>=09=09=
=09update_gpio_int_params(line >> 3);<BR>=09=09} else if (line >=3D 40 && l=
ine < 48) {<BR>=09=09=09/* Port F.  */<BR>=09=09=09gpio_int_unmasked[2] &=
=3D ~(1 << (line & 7));<BR>=09=09=09update_gpio_int_params(2);<BR>=09=09}<B=
R><BR>=09=09v =3D __raw_readb(data_direction_register);<BR>=09=09v |=3D 1 <=
< (line & 7);<BR>=09=09__raw_writeb(v, data_direction_register);<BR>=09} el=
se if (direction =3D=3D GPIO_IN) {<BR>=09=09v =3D __raw_readb(data_directio=
n_register);<BR>=09=09v &=3D ~(1 << (line & 7));<BR>=09=09__raw_writeb(v, d=
ata_direction_register);<BR>=09}<BR>=09local_irq_restore(flags);<BR>}<BR>EX=
PORT_SYMBOL(gpio_line_config);<BR><BR>int gpio_line_get(int line)<BR>{<BR>=
=09unsigned int data_register;<BR><BR>=09data_register =3D EP93XX_GPIO_REG(=
data_register_offset[line >> 3]);<BR><BR>=09return !!(__raw_readb(data_regi=
ster) & (1 << (line & 7)));<BR>}<BR>EXPORT_SYMBOL(gpio_line_get);<BR><BR>vo=
id gpio_line_set(int line, int value)<BR>{<BR>=09unsigned int data_register=
;<BR>=09unsigned long flags;<BR>=09unsigned char v;<BR><BR>=09data_register=
 =3D EP93XX_GPIO_REG(data_register_offset[line >> 3]);<BR><BR>=09local_irq_=
save(flags);<BR>=09if (value =3D=3D EP93XX_GPIO_HIGH) {<BR>=09=09v =3D __ra=
w_readb(data_register);<BR>=09=09v |=3D 1 << (line & 7);<BR>=09=09__raw_wri=
teb(v, data_register);<BR>=09} else if (value =3D=3D EP93XX_GPIO_LOW) {<BR>=
=09=09v =3D __raw_readb(data_register);<BR>=09=09v &=3D ~(1 << (line & 7));=
<BR>=09=09__raw_writeb(v, data_register);<BR>=09}<BR>=09local_irq_restore(f=
lags);<BR>}<BR>EXPORT_SYMBOL(gpio_line_set);<BR><BR><BR>/******************=
*******************************************************<BR> * EP93xx IRQ ha=
ndling<BR> ****************************************************************=
*********/<BR>static void ep93xx_gpio_ab_irq_handler(unsigned int irq, stru=
ct irq_desc *desc)<BR>{<BR>=09unsigned char status;<BR>=09int i;<BR><BR>=09=
status =3D __raw_readb(EP93XX_GPIO_A_INT_STATUS);<BR>=09for (i =3D 0; i < 8=
; i++) {<BR>=09=09if (status & (1 << i)) {<BR>=09=09=09desc =3D irq_desc + =
IRQ_EP93XX_GPIO(0) + i;<BR>=09=09=09desc_handle_irq(IRQ_EP93XX_GPIO(0) + i,=
 desc);<BR>=09=09}<BR>=09}<BR><BR>=09status =3D __raw_readb(EP93XX_GPIO_B_I=
NT_STATUS);<BR>=09for (i =3D 0; i < 8; i++) {<BR>=09=09if (status & (1 << i=
)) {<BR>=09=09=09desc =3D irq_desc + IRQ_EP93XX_GPIO(8) + i;<BR>=09=09=09de=
sc_handle_irq(IRQ_EP93XX_GPIO(8) + i, desc);<BR>=09=09}<BR>=09}<BR>}<BR><BR=
>static void ep93xx_gpio_f_irq_handler(unsigned int irq, struct irq_desc *d=
esc)<BR>{<BR>=09int gpio_irq =3D IRQ_EP93XX_GPIO(16) + (((irq + 1) & 7) ^ 4=
);<BR><BR>=09desc_handle_irq(gpio_irq, irq_desc + gpio_irq);<BR>}<BR><BR>st=
atic void ep93xx_gpio_irq_mask_ack(unsigned int irq)<BR>{<BR>=09int line =
=3D irq - IRQ_EP93XX_GPIO(0);<BR>=09int port =3D line >> 3;<BR><BR>=09gpio_=
int_unmasked[port] &=3D ~(1 << (line & 7));<BR>=09update_gpio_int_params(po=
rt);<BR><BR>=09if (port =3D=3D 0) {<BR>=09=09__raw_writel(1 << (line & 7), =
EP93XX_GPIO_A_INT_ACK);<BR>=09} else if (port =3D=3D 1) {<BR>=09=09__raw_wr=
itel(1 << (line & 7), EP93XX_GPIO_B_INT_ACK);<BR>=09} else if (port =3D=3D =
2) {<BR>=09=09__raw_writel(1 << (line & 7), EP93XX_GPIO_F_INT_ACK);<BR>=09}=
<BR>}<BR><BR>static void ep93xx_gpio_irq_mask(unsigned int irq)<BR>{<BR>=09=
int line =3D irq - IRQ_EP93XX_GPIO(0);<BR>=09int port =3D line >> 3;<BR><BR=
>=09gpio_int_unmasked[port] &=3D ~(1 << (line & 7));<BR>=09update_gpio_int_=
params(port);<BR>}<BR><BR>static void ep93xx_gpio_irq_unmask(unsigned int i=
rq)<BR>{<BR>=09int line =3D irq - IRQ_EP93XX_GPIO(0);<BR>=09int port =3D li=
ne >> 3;<BR><BR>=09gpio_int_unmasked[port] |=3D 1 << (line & 7);<BR>=09upda=
te_gpio_int_params(port);<BR>}<BR><BR><BR>/*<BR> * gpio_int_type1 controls =
whether the interrupt is level (0) or<BR> * edge (1) triggered, while gpio_=
int_type2 controls whether it<BR> * triggers on low/falling (0) or high/ris=
ing (1).<BR> */<BR>static int ep93xx_gpio_irq_type(unsigned int irq, unsign=
ed int type)<BR>{<BR>=09int port;<BR>=09int line;<BR><BR>=09line =3D irq - =
IRQ_EP93XX_GPIO(0);<BR>=09if (line >=3D 0 && line < 16) {<BR>=09=09gpio_lin=
e_config(line, GPIO_IN);<BR>=09} else {<BR>=09=09gpio_line_config(EP93XX_GP=
IO_LINE_F(line-16), GPIO_IN);<BR>=09}<BR><BR>=09port =3D line >> 3;<BR>=09l=
ine &=3D 7;<BR><BR>=09if (type & IRQT_RISING) {<BR>=09=09gpio_int_enabled[p=
ort] |=3D 1 << line;<BR>=09=09gpio_int_type1[port] |=3D 1 << line;<BR>=09=
=09gpio_int_type2[port] |=3D 1 << line;<BR>=09} else if (type & IRQT_FALLIN=
G) {<BR>=09=09gpio_int_enabled[port] |=3D 1 << line;<BR>=09=09gpio_int_type=
1[port] |=3D 1 << line;<BR>=09=09gpio_int_type2[port] &=3D ~(1 << line);<BR=
>=09} else if (type & IRQT_HIGH) {<BR>=09=09gpio_int_enabled[port] |=3D 1 <=
< line;<BR>=09=09gpio_int_type1[port] &=3D ~(1 << line);<BR>=09=09gpio_int_=
type2[port] |=3D 1 << line;<BR>=09} else if (type & IRQT_LOW) {<BR>=09=09gp=
io_int_enabled[port] |=3D 1 << line;<BR>=09=09gpio_int_type1[port] &=3D ~(1=
 << line);<BR>=09=09gpio_int_type2[port] &=3D ~(1 << line);<BR>=09} else {<=
BR>=09=09gpio_int_enabled[port] &=3D ~(1 << line);<BR>=09}<BR>=09update_gpi=
o_int_params(port);<BR><BR>=09return 0;<BR>}<BR><BR>static struct irq_chip =
ep93xx_gpio_irq_chip =3D {<BR>=09.name=09=09=3D "GPIO",<BR>=09.ack=09=09=3D=
 ep93xx_gpio_irq_mask_ack,<BR>=09.mask=09=09=3D ep93xx_gpio_irq_mask,<BR>=
=09.unmask=09=09=3D ep93xx_gpio_irq_unmask,<BR>=09.set_type=09=3D ep93xx_gp=
io_irq_type,<BR>};<BR><BR><BR>void __init ep93xx_init_irq(void)<BR>{<BR>=09=
int irq;<BR><BR>=09vic_init((void *)EP93XX_VIC1_BASE, 0, EP93XX_VIC1_VALID_=
IRQ_MASK);<BR>=09vic_init((void *)EP93XX_VIC2_BASE, 32, EP93XX_VIC2_VALID_I=
RQ_MASK);<BR><BR>=09for (irq =3D IRQ_EP93XX_GPIO(0); irq <=3D IRQ_EP93XX_GP=
IO(23); irq++) {<BR>=09=09set_irq_chip(irq, &ep93xx_gpio_irq_chip);<BR>=09=
=09set_irq_handler(irq, handle_level_irq);<BR>=09=09set_irq_flags(irq, IRQF=
_VALID);<BR>=09}<BR><BR>=09set_irq_chained_handler(IRQ_EP93XX_GPIO_AB, ep93=
xx_gpio_ab_irq_handler);<BR>=09set_irq_chained_handler(IRQ_EP93XX_GPIO0MUX,=
 ep93xx_gpio_f_irq_handler);<BR>=09set_irq_chained_handler(IRQ_EP93XX_GPIO1=
MUX, ep93xx_gpio_f_irq_handler);<BR>=09set_irq_chained_handler(IRQ_EP93XX_G=
PIO2MUX, ep93xx_gpio_f_irq_handler);<BR>=09set_irq_chained_handler(IRQ_EP93=
XX_GPIO3MUX, ep93xx_gpio_f_irq_handler);<BR>=09set_irq_chained_handler(IRQ_=
EP93XX_GPIO4MUX, ep93xx_gpio_f_irq_handler);<BR>=09set_irq_chained_handler(=
IRQ_EP93XX_GPIO5MUX, ep93xx_gpio_f_irq_handler);<BR>=09set_irq_chained_hand=
ler(IRQ_EP93XX_GPIO6MUX, ep93xx_gpio_f_irq_handler);<BR>=09set_irq_chained_=
handler(IRQ_EP93XX_GPIO7MUX, ep93xx_gpio_f_irq_handler);<BR>}<BR><BR>#ifdef=
 CONFIG_ARCH_EP93XX_GPIO_IRQ<BR> =09set_irq_chained_handler(IRQ_GPIO, ep93x=
x_gpio_demux_handler);<BR>#endif<BR><BR><BR><BR>#ifdef CONFIG_IPIPE<BR>void=
 __ipipe_mach_demux_irq(unsigned irq, struct pt_regs *regs)<BR>{<BR>=09unsi=
gned char status;<BR>=09int i;<BR>=09struct irq_desc *desc_unused =3D irq_d=
esc + IRQ_EP93XX_GPIO(0);<BR>=09unsigned irq_unused =3D irq;<BR><BR>=09stat=
us =3D __raw_readb(EP93XX_GPIO_A_INT_STATUS);<BR><BR>=09//*desc_unused=3D i=
rq_desc + IRQ_EP93XX_GPIO(0);<BR><BR>=09for (i =3D 0; i < 8; i++) {<BR>=09=
=09if (status & (1 << i)) {<BR>=09=09=09<BR>=09=09=09__ipipe_handle_irq(IRQ=
_EP93XX_GPIO(0) + i, regs);<BR>=09=09}<BR>=09}<BR><BR>=09status =3D __raw_r=
eadb(EP93XX_GPIO_B_INT_STATUS);<BR><BR>=09desc_unused=3D irq_desc + IRQ_EP9=
3XX_GPIO(8);<BR><BR>=09for (i =3D 0; i < 8; i++) {<BR>=09=09if (status & (1=
 << i)) {<BR>=09=09=09<BR>=09=09=09__ipipe_handle_irq(IRQ_EP93XX_GPIO(8) + =
i, regs);<BR>=09=09}<BR><BR>=09desc_unused->chip->unmask(irq_unused);<BR><B=
R>=09}<BR>}<BR>#endif /* CONFIG_IPIPE */<BR><BR><BR>/**********************=
***************************************************<BR> * EP93xx peripheral=
 handling<BR> *************************************************************=
************/<BR>#define EP93XX_UART_MCR_OFFSET=09=09(0x0100)<BR><BR>static=
 void ep93xx_uart_set_mctrl(struct amba_device *dev,<BR>=09=09=09=09  void =
__iomem *base, unsigned int mctrl)<BR>{<BR>=09unsigned int mcr;<BR><BR>=09m=
cr =3D 0;<BR>=09if (!(mctrl & TIOCM_RTS))<BR>=09=09mcr |=3D 2;<BR>=09if (!(=
mctrl & TIOCM_DTR))<BR>=09=09mcr |=3D 1;<BR><BR>=09__raw_writel(mcr, base +=
 EP93XX_UART_MCR_OFFSET);<BR>}<BR><BR>static struct amba_pl010_data ep93xx_=
uart_data =3D {<BR>=09.set_mctrl=09=3D ep93xx_uart_set_mctrl,<BR>};<BR><BR>=
static struct amba_device uart1_device =3D {<BR>=09.dev=09=09=3D {<BR>=09=
=09.bus_id=09=09=3D "apb:uart1",<BR>=09=09.platform_data=09=3D &ep93xx_uart=
_data,<BR>=09},<BR>=09.res=09=09=3D {<BR>=09=09.start=09=3D EP93XX_UART1_PH=
YS_BASE,<BR>=09=09.end=09=3D EP93XX_UART1_PHYS_BASE + 0x0fff,<BR>=09=09.fla=
gs=09=3D IORESOURCE_MEM,<BR>=09},<BR>=09.irq=09=09=3D { IRQ_EP93XX_UART1, N=
O_IRQ },<BR>=09.periphid=09=3D 0x00041010,<BR>};<BR><BR>static struct amba_=
device uart2_device =3D {<BR>=09.dev=09=09=3D {<BR>=09=09.bus_id=09=09=3D "=
apb:uart2",<BR>=09=09.platform_data=09=3D &ep93xx_uart_data,<BR>=09},<BR>=
=09.res=09=09=3D {<BR>=09=09.start=09=3D EP93XX_UART2_PHYS_BASE,<BR>=09=09.=
end=09=3D EP93XX_UART2_PHYS_BASE + 0x0fff,<BR>=09=09.flags=09=3D IORESOURCE=
_MEM,<BR>=09},<BR>=09.irq=09=09=3D { IRQ_EP93XX_UART2, NO_IRQ },<BR>=09.per=
iphid=09=3D 0x00041010,<BR>};<BR><BR>static struct amba_device uart3_device=
 =3D {<BR>=09.dev=09=09=3D {<BR>=09=09.bus_id=09=09=3D "apb:uart3",<BR>=09=
=09.platform_data=09=3D &ep93xx_uart_data,<BR>=09},<BR>=09.res=09=09=3D {<B=
R>=09=09.start=09=3D EP93XX_UART3_PHYS_BASE,<BR>=09=09.end=09=3D EP93XX_UAR=
T3_PHYS_BASE + 0x0fff,<BR>=09=09.flags=09=3D IORESOURCE_MEM,<BR>=09},<BR>=
=09.irq=09=09=3D { IRQ_EP93XX_UART3, NO_IRQ },<BR>=09.periphid=09=3D 0x0004=
1010,<BR>};<BR><BR><BR>static struct platform_device ep93xx_rtc_device =3D =
{<BR>       .name           =3D "ep93xx-rtc",<BR>       .id             =3D=
 -1,<BR>       .num_resources  =3D 0,<BR>};<BR><BR><BR>static struct resour=
ce ep93xx_ohci_resources[] =3D {<BR>=09[0] =3D {<BR>=09=09.start=09=3D EP93=
XX_USB_PHYS_BASE,<BR>=09=09.end=09=3D EP93XX_USB_PHYS_BASE + 0x0fff,<BR>=09=
=09.flags=09=3D IORESOURCE_MEM,<BR>=09},<BR>=09[1] =3D {<BR>=09=09.start=09=
=3D IRQ_EP93XX_USB,<BR>=09=09.end=09=3D IRQ_EP93XX_USB,<BR>=09=09.flags=09=
=3D IORESOURCE_IRQ,<BR>=09},<BR>};<BR><BR>static struct platform_device ep9=
3xx_ohci_device =3D {<BR>=09.name=09=09=3D "ep93xx-ohci",<BR>=09.id=09=09=
=3D -1,<BR>=09.dev=09=09=3D {<BR>=09=09.dma_mask=09=09=3D (void *)0xfffffff=
f,<BR>=09=09.coherent_dma_mask=09=3D 0xffffffff,<BR>=09},<BR>=09.num_resour=
ces=09=3D ARRAY_SIZE(ep93xx_ohci_resources),<BR>=09.resource=09=3D ep93xx_o=
hci_resources,<BR>};<BR><BR><BR>void __init ep93xx_init_devices(void)<BR>{<=
BR>=09unsigned int v;<BR><BR>=09/*<BR>=09 * Disallow access to MaverickCrun=
ch initially.<BR>=09 */<BR>=09v =3D __raw_readl(EP93XX_SYSCON_DEVICE_CONFIG=
);<BR>=09v &=3D ~EP93XX_SYSCON_DEVICE_CONFIG_CRUNCH_ENABLE;<BR>=09__raw_wri=
tel(0xaa, EP93XX_SYSCON_SWLOCK);<BR>=09__raw_writel(v, EP93XX_SYSCON_DEVICE=
_CONFIG);<BR><BR>=09amba_device_register(&uart1_device, &iomem_resource);<B=
R>=09amba_device_register(&uart2_device, &iomem_resource);<BR>=09amba_devic=
e_register(&uart3_device, &iomem_resource);<BR><BR>=09platform_device_regis=
ter(&ep93xx_rtc_device);<BR>=09platform_device_register(&ep93xx_ohci_device=
);<BR>}<BR><BR><BR><BR><BR><BR><BR><BR><BR> <BR><BR><BR><i>Cr=C3=A9ez votre=
 adresse =C3=A9lectronique <a target=3D_blank href=3Dhttp://www.laposte.net=
>pr=C3=A9nom.nom@domain.hid</a> <BR> 1 Go d'espace de stockage, anti-spam =
et anti-virus int=C3=A9gr=C3=A9s.</i><BR>
------=_Part_731422_24551385.1211811692908--



