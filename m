Date: Fri, 11 May 2007 12:33:37 +0000
Message-ID: <m18U4w9o.1178886817.1476260.dchabal@domain.hid>
In-Reply-To: <4644529D.2000305@domain.hid>
From: "CHABAL David" <david.chabal@domain.hid>
Errors-To: "CHABAL David" <david.chabal@domain.hid>
MIME-Version: 1.0 
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] 16550A driver and Moxa card / solved
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Le 11/5/2007, "Jan Kiszka" <jan.kiszka@domain.hid> a =E9crit:

>Jan Kiszka wrote:
>> CHABAL David wrote:
>>> Le 11/5/2007, "Jan Kiszka" <jan.kiszka@domain.hid> a =C3=A9crit:
>>>
>>>> Maksym Veremeyenko wrote:
>>>>> CHABAL David =C3=90=C2=BF=C3=90=C2=B8=C3=91=CB=86=C3=90=C2=B5=C3=91=E2=
=80=9A:
>>>>>
>>>>>> I met some trouble with the 16550A driver provided in Xenomai 2.3.1
>>>>>> and my Moxa cards (PCI / 8 * RS232 / 168U ).
>>>>>>
>>>>>> It was a problem of baudrate computation before setting the LCR_DLAB
>>>>>> register.
>>>>>>
>>>>>> The formula implemented by the Xenomai driver is different from the on=
e
>>>>>> provided by Moxa. So I copy/paste the formula from the mxser.c file
>>>>>> (present in the
>>>>>> kernel distro), and it seems to work fine.
>>>>>>
>>>>>> I think it's Moxa card dependant, may be caused by the high default ba=
ud
>>>>>> rate of this card.
>>>>> I have two Moxa boards with no problem, possible you need to specify=20
>>>>> 'baud_base' param.
>>>>>
>>>>> I my case :
>>>>>
>>>>> # 8 ports board:
>>>>> /sbin/modprobe xeno_16550A \
>>>>> ioaddr=3D0x1000,0x1008,0x1010,0x1018,0x1020,0x1028,0x1030,0x1038 \
>>>>> irq=3D9,9,9,9,9,9,9,9 \
>>>>> baud_base=3D921600,921600,921600,921600,921600,921600,921600,921600
>>>>>
>>>>> # 2 ports board + onboards:
>>>>> /sbin/modprobe xeno_16550A ioaddr=3D0x3f8,0x2f8,0xdf00,0xdf08=20
>>>>> irq=3D4,3,11,11 baud_base=3D115200,115200,921600,921600
>>>>>
>>>> Interesting. That would leave us just with the generic fix to catch
>>>> baud_rate=3D=3D0. Far more attractive. :)
>>>>
>>>> David, can you confirm this? Weren't you just aware of the baud_base
>>>> parameter?
>>> I'm not totally convinced because if I compute by hand the DLAB register
>>> with the 19200 value (my config):
>>>
>>> With the moxa driver:
>>>   baud_div =3D 912.600 / 19.200 =3D 47
>>>
>>> With the Xeno driver:
>>>   baud_div =3D (912.600 - 9600) / 19.200 =3D 47
>>>
>>> Grrr, it's ok here because the rounded values are the same because the
>>> baud base is biggest than the speed requested, but I think a problem can
>>> occur with 115200 or more, example:
>>>
>>> moxa: 912.600/115.200 =3D 8
>>> xeno: =3D 7
>>=20
>> Yeah, hard arguments. This really cries for a moxa tweak. (The
>> alternative would be to pass an artificially increased baud_base - but
>> that would be _really_ ugly and we could also ask the user for the
>> divider directly...)
>
>Here we go. This patch should add the most essential changes of your
>patch to SVN trunk (backport not officially planned, but it should not
>be tricky). The idea is to pass "variant=3D1" to xeno_16550A on load.
>That will kick out rounding on divider calculation and even switches
>the default baud base.
>
>Comments/test reports welcome.
>
>Jan
>
>
>Index: ksrc/drivers/serial/16550A.c
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>--- ksrc/drivers/serial/16550A.c=09(Revision 2433)
>+++ ksrc/drivers/serial/16550A.c=09(Arbeitskopie)
>@@ -28,10 +28,14 @@
>=20
> #define MAX_DEVICES=09=098
>=20
>+#define VARIANT_STANDARD=090
>+#define VARIANT_MOXA=09=091
>+
> #define IN_BUFFER_SIZE=09=094096
> #define OUT_BUFFER_SIZE=09=094096
>=20
> #define DEFAULT_BAUD_BASE=09115200
>+#define DEFAULT_BAUD_BASE_MOXA=09921600
> #define DEFAULT_TX_FIFO=09=0916
>=20
> #define PARITY_MASK=09=090x03
>@@ -121,11 +125,13 @@ static struct rtdm_device *device[MAX_DE
> static unsigned int irq[MAX_DEVICES];
> static unsigned int baud_base[MAX_DEVICES];
> static int tx_fifo[MAX_DEVICES];
>+static int variant[MAX_DEVICES];
> static unsigned int start_index;
>=20
> compat_module_param_array(irq, uint, MAX_DEVICES, 0400);
> compat_module_param_array(baud_base, uint, MAX_DEVICES, 0400);
> compat_module_param_array(tx_fifo, int, MAX_DEVICES, 0400);
>+compat_module_param_array(variant, int, MAX_DEVICES, 0400);
>=20
> MODULE_PARM_DESC(irq, "IRQ numbers of the serial devices");
> MODULE_PARM_DESC(baud_base, "Maximum baud rate of the serial device "
>@@ -302,20 +308,24 @@ static int rt_16550_set_config(struct rt
> =09rtdm_lockctx_t lock_ctx;
> =09unsigned long base =3D ctx->base_addr;
> =09int mode =3D rt_16550_io_mode_from_ctx(ctx);
>-=09int dev_id;
> =09int err =3D 0;
>-=09int baud_div =3D 0;
>=20
> =09/* make line configuration atomic and IRQ-safe */
> =09rtdm_lock_get_irqsave(&ctx->lock, lock_ctx);
>=20
> =09if (testbits(config->config_mask, RTSER_SET_BAUD)) {
>-=09=09dev_id =3D container_of(((void *)ctx), struct rtdm_dev_context,
>-=09=09=09=09      dev_private)->device->device_id;
>+=09=09int dev_id =3D container_of(((void *)ctx),
>+=09=09=09=09=09  struct rtdm_dev_context,
>+=09=09=09=09=09  dev_private)->device->device_id;
>+=09=09int rounding =3D ctx->config.baud_rate >> 1;
>+=09=09int baud_div =3D 0;
>+
>+=09=09if (variant[dev_id] =3D=3D VARIANT_MOXA)
>+=09=09=09rounding =3D 0;
>=20
> =09=09ctx->config.baud_rate =3D config->baud_rate;
>-=09=09baud_div =3D (baud_base[dev_id] + (ctx->config.baud_rate >> 1)) /
>-=09=09    ctx->config.baud_rate;
>+=09=09baud_div =3D (baud_base[dev_id] + rounding) /
>+=09=09=09ctx->config.baud_rate;
> =09=09rt_16550_reg_out(mode, base, LCR, LCR_DLAB);
> =09=09rt_16550_reg_out(mode, base, DLL, baud_div & 0xff);
> =09=09rt_16550_reg_out(mode, base, DLM, baud_div >> 8);
>@@ -595,10 +605,10 @@ int rt_16550_ioctl(struct rtdm_dev_conte
>=20
> =09=09if (testbits(config->config_mask, RTSER_SET_BAUD) &&
> =09=09    (config->baud_rate >
>-=09=09     baud_base[context->device->device_id])) {
>-=09=09=09/* the baudrate is to high for this port */
>+=09=09     baud_base[context->device->device_id] ||
>+=09=09     config->baud_rate <=3D 0))
>+=09=09=09/* invalid baudrate for this port */
> =09=09=09return -EINVAL;
>-=09=09}
>=20
> =09=09if (testbits(config->config_mask,
> =09=09=09     RTSER_SET_TIMESTAMP_HISTORY)) {
>@@ -1164,7 +1174,8 @@ int __init rt_16550_init(void)
> =09=09=09goto kfree_out;
>=20
> =09=09if (baud_base[i] =3D=3D 0)
>-=09=09=09baud_base[i] =3D DEFAULT_BAUD_BASE;
>+=09=09=09baud_base[i] =3D (variant[i] =3D=3D VARIANT_MOXA) ?
>+=09=09=09=09DEFAULT_BAUD_BASE_MOXA : DEFAULT_BAUD_BASE;
>=20
> =09=09if (tx_fifo[i] =3D=3D 0)
> =09=09=09tx_fifo[i] =3D DEFAULT_TX_FIFO;
>

I think the DEFAULT_BAUD_BASE_MOXA constant shouldn't be added. May be
other Moxa cards work slowly (or will be faster) and include this
computation, I would keep this parameter free and ever modifiable by the
boot line.

David

