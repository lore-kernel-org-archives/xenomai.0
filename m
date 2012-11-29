From: Stephan Kappertz <stephan.kappertz@kabelmail.de>
Mime-Version: 1.0 (Apple Message framework v1283)
Date: Thu, 29 Nov 2012 13:16:31 +0100
In-Reply-To: <mailman.0.1354186801.18650.xenomai@xenomai.org>
References: <mailman.0.1354186801.18650.xenomai@xenomai.org>
Message-Id: <6F62EBB3-71FC-47B6-B6A4-9A2A7EFE793B@kabelmail.de>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Compiling I-pipe patched kernel on beaglebone from
	Angstrom branch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

>=20
> Von: WONG Sheng Chao <wong@isir.upmc.fr>
> Betreff: Re: [Xenomai] Compiling I-pipe patched kernel on beaglebone =
from Angstrom branch
> Datum: 28. November 2012 21:22:41 MEZ
> An: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> Kopie: xenomai@xenomai.org
>=20
>=20
> On Wed, 28 Nov 2012 20:55:24 +0100, Gilles Chanteperdrix wrote:
>> On 11/28/2012 08:34 PM, WONG Sheng Chao wrote:
>>=20
>>> On Wed, 28 Nov 2012 19:57:50 +0100, Gilles Chanteperdrix wrote:
>>>> On 11/28/2012 07:49 PM, WONG Sheng Chao wrote:
>>>>=20
>>>>> On Wed, 28 Nov 2012 19:14:41 +0100, Gilles Chanteperdrix wrote:
>>>>>> On 11/28/2012 06:40 PM, WONG Sheng Chao wrote:
>>>>>>> On Wed, 28 Nov 2012 16:12:58 +0100, WONG Sheng Chao wrote:
>>>>>>>> On Tue, 27 Nov 2012 19:00:30 +0100, Gilles Chanteperdrix wrote:
>>>>>>>>> On 11/27/2012 05:40 PM, WONG Sheng Chao wrote:
>>>>>>>>>> Hi Gilles
>>>>>>>>>>=20
>>>>>>>>>> Following your advice i tracked down the include files which
>>>>>>>>>> need
>>>>>>>>>> to be
>>>>>>>>>> included to remove the error. The kernel now compiles without
>>>>>>>>>> errors. I
>>>>>>>>>> followed the instructions in
>>>>>>>>>>=20
>>>>>>>>>> =
http://www.xenomai.org/pipermail/xenomai/2012-July/000481.html
>>>>>>>>>>=20
>>>>>>>>>> to change the timer.c and also changing the .handle_irq with
>>>>>>>>>> ipipe_handle_multi_irq
>>>>>>>>>>=20
>>>>>>>>>> =46rom the serial terminal i noticed that with CONFIG_IPIPE =3D=
 ON
>>>>>>>>>> the
>>>>>>>>>> timer is used correctly as in the above post but it hangs at
>>>>>>>>>=20
>>>>>>>>> Are you sure the timer is running correctly
>>>>>>>>>=20
>>>>>>>>>=20
>>>>>>>>>> Any advice on how to proceed to debug this problem? I attach
>>>>>>>>>> the
>>>>>>>>>> config files of two cases for your reference.
>>>>>>>>>=20
>>>>>>>>> I would put a printk in linux timer irq handler.
>>>>>>>>=20
>>>>>>>> How should i come about debugging the timer irq handler?
>>>>>>>=20
>>>>>>> Refering to this,
>>>>>>>=20
>>>>>>> http://www.xenomai.org/pipermail/xenomai/2012-May/025838.html
>>>>>>>=20
>>>>>>> I believe that i should be put a printk in the function
>>>>>>> ipipe_mach_acktimer, as it is called when the linux timer
>>>>>>> interrupt,
>>>>>>> but
>>>>>>> I after checking in these files, i still couldn't find it.
>>>>>>=20
>>>>>> ipipe_mach_acktimer disappeared, it is in the pre I-pipe core
>>>>>> patches.
>>>>>> The documentation for the I-pipe core patches on the ARM
>>>>>> architecture
>>>>>> is
>>>>>> here:
>>>>>> http://www.xenomai.org/index.php/I-pipe-core:ArmPorting
>>>>>>=20
>>>>>> The linux timer interrupt handler given as example in this
>>>>>> documentation
>>>>>> is "omap2_gp_timer_interrupt" function, and is probably the same
>>>>>> for
>>>>>> your omap3 derivative.
>>>>>=20
>>>>> Thanks for the information. So to proceed i looked at the function
>>>>>=20
>>>>> static irqreturn_t omap2_gp_timer_interrupt(int irq, void *dev_id)
>>>>> {
>>>>> 	struct clock_event_device *evt =3D &clockevent_gpt;
>>>>>=20
>>>>> 	if (!clockevent_ipipe_stolen(evt))
>>>>> 		omap2_gp_timer_ack();
>>>>>=20
>>>>> 	if (num_online_cpus() =3D=3D 1)
>>>>> 		__ipipe_tsc_update();
>>>>>=20
>>>>> 	evt->event_handler(evt);
>>>>> 	return IRQ_HANDLED;
>>>>> }
>>>>>=20
>>>>> when clockevent_ipipe_stolen =3D=3D 0
>>>>> the omap2_gp_timer_ack is called to acknowledge the linux timer
>>>>> interrupt (with CONFIG_XENOMAI =3D no)
>>>>>=20
>>>>> I put a printk in omap2_gp_timer_ack and i notice that in both =
cases
>>>>> of
>>>>> CONFIG_IPIPE =3D yes and CONFIG_IPIPE =3D no
>>>>>=20
>>>>> the omap2_gp_timer_ack function get called.
>>>>>=20
>>>>> But i am not sure how to interrupt this. I guess this means that =
the
>>>>> timer interrupt is being handled. But it still does not tell me =
why
>>>>> the
>>>>> kernel does not boot properly when CONFIG_IPIPE =3D yes.
>>>>=20
>>>>=20
>>>> Put a static counter in the timer_ack function to only emit a =
printk
>>>> every HZ ticks, and check whether the timer is ticking when you get
>>>> the
>>>> freeze in the at24c driver initialization.
>>>=20
>>> Yes the timer is still ticking after the freeze in the at24c driver
>>> initialization. Does this means that  the ipipe_handle_multi_irq in
>>> omap_intc_handle_irq is not handling the multiple irq properly?
>>=20
>>=20
>> No. It simply means the problem is not the timer. Next usual suspect =
is
>> the clocksource. Did you get the message about clocksource switching =
to
>> ipipe_tsc and does ipipe_tsc_get return increasing values?
>=20
> Yes the clock source did change to tsc in the boot message, I will =
take a look at the return value of I pipe_tsc_get.
>=20
>=20

The problem is that you are using the wrong timer.

You should have=20

OMAP clockevent source: GPTIMER2 at 24000000 Hz
OMAP clocksource: GPTIMER1 at 24000000 Hz

in the startup console output for both the kernel with IPIPE disabled =
and with IPIPE enabled.

Thus in arch/arm/mach-omap2/timer.c you need to change the timer =
definitions accordingly.

What I did was:

#define OMAP2_MPU_SOURCE	"sys_ck"
#define OMAP3_MPU_SOURCE	OMAP2_MPU_SOURCE
#define OMAP4_MPU_SOURCE	"sys_clkin_ck"
#define OMAP2_32K_SOURCE	"func_32k_ck"
#define OMAP3_32K_SOURCE	"omap_32k_fck"
#define OMAP4_32K_SOURCE	"sys_32k_ck"
#define AM33XX_CLKEV_SOURCE OMAP4_MPU_SOURCE
#define AM33XX_RTC32K_SOURCE	"clk_32768_ck"

#ifdef CONFIG_OMAP_32K_TIMER
#define OMAP2_CLKEV_SOURCE	OMAP2_32K_SOURCE
#define OMAP3_CLKEV_SOURCE	OMAP3_32K_SOURCE
#define OMAP4_CLKEV_SOURCE	OMAP4_32K_SOURCE
#define AM33XX_MPU_SOURCE	AM33XX_RTC32K_SOURCE
#define OMAP3_SECURE_TIMER	12
#else
#define OMAP2_CLKEV_SOURCE	OMAP2_MPU_SOURCE
#define OMAP3_CLKEV_SOURCE	OMAP3_MPU_SOURCE
#define OMAP4_CLKEV_SOURCE	OMAP4_MPU_SOURCE
#define AM33XX_MPU_SOURCE	OMAP4_MPU_SOURCE
#define OMAP3_SECURE_TIMER	1
#endif
...
...
...
#ifdef CONFIG_ARCH_OMAP3

#ifndef CONFIG_SOC_OMAPAM33XX

#ifndef CONFIG_IPIPE
OMAP_SYS_TIMER_INIT(3, 1, OMAP3_CLKEV_SOURCE, 2, OMAP3_MPU_SOURCE)
#else
OMAP_SYS_TIMER_INIT(3, 2, OMAP3_CLKEV_SOURCE, 3, OMAP3_MPU_SOURCE)
#endif
OMAP_SYS_TIMER(3)
OMAP_SYS_TIMER_INIT(3_secure, OMAP3_SECURE_TIMER, OMAP3_CLKEV_SOURCE,
			2, OMAP3_MPU_SOURCE)
OMAP_SYS_TIMER(3_secure)

#else // #ifdef CONFIG_SOC_OMAPAM33XX

OMAP_SYS_TIMER_INIT(3, 2, AM33XX_CLKEV_SOURCE, 1, AM33XX_MPU_SOURCE)
OMAP_SYS_TIMER(3)

#endif

#endif

- Stephan

