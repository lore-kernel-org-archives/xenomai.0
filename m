Message-ID: <49A6C448.7090906@domain.hid>
Date: Thu, 26 Feb 2009 17:33:12 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <d7143fa7afb9637a602a432e52eb35b4@domain.hid>	<49A54246.60404@domain.hid>	<1aedae1f462bc98ca512e1e6f0f18a43@domain.hid>
	<49A56043.7000009@domain.hid>
In-Reply-To: <49A56043.7000009@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Adeos-main] [PATCH] ipipe i.MXL freeze's boot
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org, =?UTF-8?B?R3dlbmhhw6ts?= <gwen@domain.hid>

Gilles Chanteperdrix wrote:
> Gwenha=C3=ABl wrote:
>> On Wed, 25 Feb 2009 14:06:14 +0100, Gilles Chanteperdrix
>> <gilles.chanteperdrix@xenomai.org> wrote:
>>> Gwenha=C3=ABl wrote:
>>>> With i.MXL processor, kernel patched with
>>>> adeos-2.6.27-ipipe-1.12-00.patch wait indefinitly for timer
>>>> calibration.
>>>> Tick event never appear. This patch modify acktimer() in
>>>> arch/arm/mach-imx/time.c.
>>>>
>>>> I need to know if this modification is good (without adding
>>>> new errors).
>>> ipipe_mach_update_tsc should be called from imx_timer_interrupt, so,
>>> there is no need to call it from acktimer (and in fact, avoiding the
>>> call to update_tsc in acktimer reduces the timer interrupt latency). =
So,
>>> maybe what is needed and is missing is simply to read
>>> IMX_TSTAT(TIMER_BASE) ?
>> I've made modifications on patch thanks to your assumption.=20
>> The new patch work fine.
>>
>> Thank you very much
>>
>> Gwenhael
>>
>> Signed-off-by: gwenhael.goavec-merou@domain.hid
>>
>>
>> diff -ru a/arch/arm/mach-imx/irq.c b/arch/arm/mach-imx/irq.c
>> --- a/arch/arm/mach-imx/irq.c    2009-02-17 11:32:52.000000000 +0100
>> +++ b/arch/arm/mach-imx/irq.c       2009-02-23 14:12:43.000000000 +010=
0
>> @@ -35,7 +35,7 @@
>>  #include <asm/io.h>
>> =20
>>  #include <asm/mach/irq.h>
>> -#include <asm/arch/imx-regs.h>
>> +#include <mach/imx-regs.h>
>> =20
>> =20
>>  /* Used for IMX INTERRUPT priority: Still Experimental */=20
>> diff -ru a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
>> --- a/arch/arm/mach-imx/time.c	2009-02-25 15:10:01.000000000 +0100
>> +++ b/arch/arm/mach-imx/time.c	2009-02-25 15:10:49.000000000 +0100
>> @@ -89,25 +89,23 @@
>>  imx_timer_interrupt(int irq, void *dev_id)
>>  {
>>  	struct clock_event_device *evt =3D &clockevent_imx;
>> -#ifndef CONFIG_IPIPE
>>  	uint32_t tstat;
>>  	irqreturn_t ret =3D IRQ_NONE;
>> =20
>>  	/* clear the interrupt */
>>  	tstat =3D IMX_TSTAT(TIMER_BASE);
>> +#ifndef CONFIG_IPIPE
>>  	IMX_TSTAT(TIMER_BASE) =3D 0;
>> +#endif
>>  	if (tstat & TSTAT_COMP) {
>> +#ifdef CONFIG_IPIPE
>>  		ipipe_mach_update_tsc();
>> +#endif
>>  		evt->event_handler(evt);
>>  		ret =3D IRQ_HANDLED;
>>  	}
>> =20
>>  	return ret;
>> -#else /* CONFIG_IPIPE */
>> -	ipipe_mach_update_tsc();
>> -	evt->event_handler(evt);
>> -	return  IRQ_HANDLED;
>> -#endif /* CONFIG_IPIPE */
>>  }
>> =20
>>  static struct irqaction imx_timer_irq =3D {
>=20
> No, that is still wrong. You should read IMX_TSTAT(TIMER_BASE) in
> acktimer not in linux timer interrupt. When running with xenomai, the
> linux timer interrupt is a virtual interrupt and should not touch hardw=
are.
>=20

Hi Gwenha=C3=ABl,

any news about this issue ?

Regards.

--=20
                                                 Gilles.


