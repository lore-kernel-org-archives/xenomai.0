From: Jean-Pascal JULIEN <jean-pascal.julien@domain.hid>
Date: Fri, 18 May 2012 09:06:57 +0200
Message-ID: <C7408997F5B0784C970ED53C11855FAE011112339157@domain.hid>
References: <C7408997F5B0784C970ED53C11855FAE011112339155@domain.hid>,
	<C7408997F5B0784C970ED53C11855FAE01111232AFE7@domain.hid>
	<C7408997F5B0784C970ED53C11855FAE011112339156@domain.hid>,
	<30154f906372933f78eb6a9f4c632782.squirrel@domain.hid>
In-Reply-To: <30154f906372933f78eb6a9f4c632782.squirrel@domain.hid>
Content-Language: fr-FR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai-help] RE :  IRQ latency
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "gilles.chanteperdrix@xenomai.org" <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

>> Hi,
>>
>> I installed xenomai on an overo water board (cortex A8) and performed
>> latency tests.

>What version of Xenomai?

>> I tested two modules.
>> The first module is based on an internal timer. It toggles a GPIO each
>> 1ms.
>> The second module waits for an external interrupt from an input GPIO
>> (square signal at 1KHz). When that happens, the module toggles a GPIO pi=
n.
>>
>> When i load the system and do a transfer from Ethernet to the sd card th=
e
>> first module works fine with a maximum latency less than 50us.
>> But the second module, in the same context, have a maximum latency of
>> several milliseconds.
>>
>> As the first module works fine i think i have a problem with the hardwar=
e
>> configuration like the hardware irq priority.
>> In the irq.c file, the irq priority level is not set for the linux domai=
n.
>>
>> Should i configure the irq level at the initialization of the board ? Wh=
at
>> else could cause this issue ?

>The error is more likely in the code of your driver. Show us the code.

Hi Gilles,


Sorry, i forgot the essential.
My linux kernel version is the 2.6.38 from sakoman.=20
My xenomai version is xenomai-2.6.0
The adeos patch is : adeos-ipipe-2.6.38.8-arm-1.18-04.patch ( ./prepare-ker=
nel.sh --linux=3D${WORKDIR}/git --arch=3Darm --adeos=3D${WORKDIR}/xenomai-2=
.6.0/ksrc/arch/arm/patches/adeos-ipipe-2.6.38.8-arm-1.18-04.patch).
The xenomai user space is make with the next configuration :=20
 ./configure --build=3Darm-ti-linux --host=3Darm-none-linux-gnueabi --prefi=
x=3D/usr --includedir=3D/usr/include/xenomai  --enable-arm-tsc=3Domap3   --=
disable-dox-doc --disable-dbx LDFLAGS=3D"-Wl,-O1 -Wl,--hash-style=3Dgnu"


The module code is :

For the init of the module:
---------------------------------------------------------------------------=
------------------------------------------------------
if (!(((gpio_request(RX_TST_GPIO,"RX_TST_GPIO") =3D=3D 0) &&
		(gpio_direction_input(RX_TST_GPIO) =3D=3D 0)))) {
		rtdm_printk(KERN_DEBUG "Could not claim GPIO for TX_SPACE_AVAILABLE_GPIO\=
n");
		erreur_return |=3D 1;
		return -1;
	}

	if (!(((gpio_request(TX_TST_GPIO,"RX_TST_GPIO") =3D=3D 0) &&
		(gpio_direction_output(TX_TST_GPIO,0) =3D=3D 0)))) {
		rtdm_printk(KERN_DEBUG "Could not claim GPIO for TX_SPACE_AVAILABLE_GPIO\=
n");
		erreur_return |=3D 2;
		return -1;
	}=20


	ret =3D request_irq(gpio_to_irq(RX_TST_GPIO),
			space_available_irqhandler,
		IRQF_TRIGGER_FALLING|IRQF_DISABLED, "usrp_intr_aviable", NULL);
	if((ret!=3D0)){ rtdm_printk(KERN_DEBUG "Could not request irq\n"); erreur_=
return |=3D 4;}

	disable_irq(gpio_to_irq(RX_TST_GPIO));
	free_irq(gpio_to_irq(RX_TST_GPIO), NULL);

	err =3D rtdm_irq_request(&rt_irq_handle, gpio_to_irq(RX_TST_GPIO), rt_data=
_ready_irqhandler, RTDM_IRQTYPE_EDGE, "XENO_IRQ_RECEIVE",NULL);
	err =3D rtdm_irq_enable(&rt_irq_handle);

The irq code is:
---------------------------------------------------------------------------=
------------------------------------------------------
static int rt_data_ready_irqhandler(rtdm_irq_t *irq_handle)=20
{
	=09
	iomask ^=3D 1;
        gpio_set_value(TX_TST_GPIO, iomask);
=09
	return RTDM_IRQ_HANDLED;
}


Thanks for your help.

JP


