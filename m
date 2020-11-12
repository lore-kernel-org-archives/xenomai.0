From: =?utf-8?Q?Deniz_U=C4=9Fur?= <deniz343@gmail.com>
Message-Id: <C4D04183-55E9-482C-8BCB-93930CC36A53@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.17\))
Subject: Re: [xenomai-images][PATCH 1/1][REV 2] Enable RTDM SPI on BeagleBone
 Black
Date: Thu, 12 Nov 2020 11:25:20 +0300
In-Reply-To: <0403b386-7c15-b32d-f009-25c49d105dcc@siemens.com>
References: <30F08CB9-A6E9-4C78-B40F-D6454048E786@gmail.com>
 <0403b386-7c15-b32d-f009-25c49d105dcc@siemens.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

> This is not place to put some kind or "versioning" info. It's rather =
the
> place to put your commit message, explaining *why* we want this =
change.

I wish it was possible to delete the previous mail, otherwise I =
wouldn=E2=80=99t write that.

> Why do we need to *enable* overlays first...
>=20
>> +echo "disable_uboot_overlay_video=3D1" >> /boot/uEnv.txt
>=20
> ...in order to disable a specific one?

I=E2=80=99ve tried every combination but without these, BBB doesn=E2=80=99=
t seem to be booting.

> How can non-matching drivers be in conflict? Most of those below do =
not
> match on any of the DT entries on the BBB.

I took the liberty of trying every combination again but just disabling =
CONFIG_SPI_SPIDEV wasn=E2=80=99t enough. In every other case, driver =
wasn=E2=80=99t loading and dumping stack trace to kernel logs.

> Looks good otherwise. The smaller your patch becomes, the better it is
> already ;).

Thank you. I agree with you, most of my changes are cumbersome.

> On 12 Nov 2020, at 10:09, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>=20
> On 11.11.20 20:47, Deniz U=C4=9Fur via Xenomai wrote:
>> =46rom dbc3add6bb3130d40602d3144d152acc0e0e3bd9 Mon Sep 17 00:00:00 =
2001
>> From: Deniz Ugur <deniz343@gmail.com <mailto:deniz343@gmail.com>>
>> Date: Wed, 11 Nov 2020 22:23:03 +0300
>> Subject: [xenomai-images][PATCH 1/1][REV 2] Enable RTDM SPI on =
BeagleBone Black
>> To: xenomai@xenomai.org <mailto:xenomai@xenomai.org>
>> Cc: quirin.gylstorff@siemens.com =
<mailto:quirin.gylstorff@siemens.com>
>>=20
>> Indentation was messed up on previous post. This one fixes it.
>>=20
>=20
> This is not place to put some kind or "versioning" info. It's rather =
the
> place to put your commit message, explaining *why* we want this =
change.
>=20
> Also missing: signed-off-by (DCO, https://developercertificate.org/ =
<https://developercertificate.org/>).
>=20
>> ---
>> recipes-core/customizations/customizations.bb |   9 +-
>> recipes-core/customizations/files/post-bbb    |   5 +
>> ...01-BeagleBone-Black-RTDM-SPI-enabled.patch | 110 =
++++++++++++++++++
>> recipes-kernel/linux/files/bbb.cfg            |  28 +++++
>> recipes-kernel/linux/linux-xenomai.inc        |   9 +-
>> 5 files changed, 159 insertions(+), 2 deletions(-)
>> create mode 100644 recipes-core/customizations/files/post-bbb
>> create mode 100644 =
recipes-kernel/linux/files/0001-BeagleBone-Black-RTDM-SPI-enabled.patch
>> create mode 100644 recipes-kernel/linux/files/bbb.cfg
>>=20
>> diff --git a/recipes-core/customizations/customizations.bb =
b/recipes-core/customizations/customizations.bb
>> index e35c0a5..ecfd1d0 100644
>> --- a/recipes-core/customizations/customizations.bb
>> +++ b/recipes-core/customizations/customizations.bb
>> @@ -13,10 +13,17 @@ inherit dpkg-raw
>>=20
>> DESCRIPTION =3D "demo image customizations"
>>=20
>> +def is_bbb(d):
>> +    bbb =3D d.getVar('MACHINE') or ''
>> +    if bbb =3D=3D 'beagle-bone-black':
>> +        return "file://post-bbb"
>> +    return ""
>> +
>> SRC_URI =3D " \
>>     file://postinst \
>>     file://ethernet \
>> -    file://99-silent-printk.conf"
>> +    file://99-silent-printk.conf \
>> +    ${@is_bbb(d)}"
>=20
> bitbake override magic can be used here:
>=20
> SRC_URI_append_beagle-bone-black =3D ...
>=20
>>=20
>> DEBIAN_DEPENDS =3D "passwd"
>>=20
>> diff --git a/recipes-core/customizations/files/post-bbb =
b/recipes-core/customizations/files/post-bbb
>> new file mode 100644
>> index 0000000..9befbcf
>> --- /dev/null
>> +++ b/recipes-core/customizations/files/post-bbb
>> @@ -0,0 +1,5 @@
>> +#!/bin/sh
>> +
>> +# Disable HDMI in order to enable SPI1 on BeagleBone Black
>> +echo "enable_uboot_overlays=3D1" >> /boot/uEnv.txt
>=20
> Why do we need to *enable* overlays first...
>=20
>> +echo "disable_uboot_overlay_video=3D1" >> /boot/uEnv.txt
>=20
> ...in order to disable a specific one?
>=20
>> \ No newline at end of file
>> diff --git =
a/recipes-kernel/linux/files/0001-BeagleBone-Black-RTDM-SPI-enabled.patch =
b/recipes-kernel/linux/files/0001-BeagleBone-Black-RTDM-SPI-enabled.patch
>> new file mode 100644
>> index 0000000..3b8b542
>> --- /dev/null
>> +++ =
b/recipes-kernel/linux/files/0001-BeagleBone-Black-RTDM-SPI-enabled.patch
>> @@ -0,0 +1,110 @@
>> +=46rom 1badee8e16340d063f8bff04c39c9fd3d6749a8f Mon Sep 17 00:00:00 =
2001
>> +From: Deniz Ugur <deniz343@gmail.com>
>> +Date: Mon, 9 Nov 2020 20:19:49 +0300
>> +Subject: [PATCH] BeagleBone Black RTDM SPI enabled
>> +
>> +---
>> + arch/arm/boot/dts/am335x-bone-common.dtsi   |  2 +
>> + arch/arm/boot/dts/am335x-boneblack-spi.dtsi | 77 =
+++++++++++++++++++++
>> + 2 files changed, 79 insertions(+)
>> + create mode 100644 arch/arm/boot/dts/am335x-boneblack-spi.dtsi
>> +
>> +diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi =
b/arch/arm/boot/dts/am335x-bone-common.dtsi
>> +index 73b514ddd..91ccc0f4b 100644
>> +--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
>> ++++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
>> +@@ -6,6 +6,8 @@
>> +  * published by the Free Software Foundation.
>> +  */
>> +=20
>> ++#include "am335x-boneblack-spi.dtsi"
>> ++
>=20
> I think we should rather patch that into am335x-boneblack.dts.
>=20
>> + / {
>> +   cpus {
>> +       cpu@0 {
>> +diff --git a/arch/arm/boot/dts/am335x-boneblack-spi.dtsi =
b/arch/arm/boot/dts/am335x-boneblack-spi.dtsi
>> +new file mode 100644
>> +index 000000000..47485af64
>> +--- /dev/null
>> ++++ b/arch/arm/boot/dts/am335x-boneblack-spi.dtsi
>> +@@ -0,0 +1,77 @@
>> ++&am33xx_pinmux {
>> ++    spi0_pins: pinmux_spi0_pins {
>> ++        pinctrl-single,pins =3D <
>> ++            /* This output signal is also used as a re-timing =
input. */
>> ++            0x150 0x30  /* P9_22 spi0_sclk, INPUT_PULLUP | MODE0 */
>> ++            0x154 0x30  /* P9_21 spi0_d0, INPUT_PULLUP | MODE0 */
>> ++            0x158 0x10  /* P9_18 spi0_d1, OUTPUT_PULLUP | MODE0 */
>> ++            0x15c 0x10  /* P9_17 spi0_cs0, OUTPUT_PULLUP | MODE0 */
>> ++        >;
>> ++    };
>> ++
>> ++    spi1_pins: pinmux_spi1_pins {
>> ++        pinctrl-single,pins =3D <
>> ++            /* This output signal is also used as a re-timing =
input. */
>> ++            0x190 0x33  /* P9_31 spi1_sclk, INPUT_PULLUP | MODE3 */
>> ++            0x194 0x33  /* P9_29 spi1_d0, INPUT_PULLUP | MODE3 */
>> ++            0x198 0x13  /* P9_30 spi1_d1, OUTPUT_PULLUP | MODE3 */
>> ++            0x19c 0x13  /* P9_28 spi1_cs0, OUTPUT_PULLUP | MODE3 */
>> ++            0x164 0x12  /* P9_42 spi1_cs1 OUTPUT_PULLUP | MODE2 */
>> ++        >;
>> ++    };
>> ++};
>> ++
>> ++&spi0 {
>> ++    compatible =3D "ti,omap4-mcspi";
>> ++    #address-cells =3D <0x1>;
>> ++    #size-cells =3D <0x0>;
>> ++    reg =3D <0x48030000 0x400>;
>> ++    interrupts =3D <0x41>;
>> ++    ti,spi-num-cs =3D <0x2>;
>> ++    ti,hwmods =3D "spi0";
>> ++    dmas =3D <0x27 0x10 0x0 0x27 0x11 0x0 0x27 0x12 0x0 0x27 0x13 =
0x0>;
>> ++    dma-names =3D "tx0", "rx0", "tx1", "rx1";
>> ++    status =3D "okay";
>> ++    pinctrl-names =3D "default";
>> ++    pinctrl-0 =3D <&spi0_pins>;
>> ++
>> ++    channel0@0 {
>> ++        #address-cells =3D <0x1>;
>> ++        #size-cells =3D <0x0>;
>> ++        compatible =3D "rtdm-spidev";
>> ++        reg =3D <0x0>;
>> ++        spi-max-frequency =3D <0x1312d00>;
>> ++    };
>> ++};
>> ++
>> ++&spi1 {
>> ++    compatible =3D "ti,omap4-mcspi";
>> ++    #address-cells =3D <0x1>;
>> ++    #size-cells =3D <0x0>;
>> ++    reg =3D <0x481a0000 0x400>;
>> ++    interrupts =3D <0x7d>;
>> ++    ti,spi-num-cs =3D <0x2>;
>> ++    ti,hwmods =3D "spi1";
>> ++    dmas =3D <0x27 0x2a 0x0 0x27 0x2b 0x0 0x27 0x2c 0x0 0x27 0x2d =
0x0>;
>> ++    dma-names =3D "tx0", "rx0", "tx1", "rx1";
>> ++    status =3D "okay";
>> ++    pinctrl-names =3D "default";
>> ++    pinctrl-0 =3D <&spi1_pins>;
>> ++
>> ++    channel1@0 {
>> ++        #address-cells =3D <0x1>;
>> ++        #size-cells =3D <0x0>;
>> ++        compatible =3D "rtdm-spidev";
>> ++        reg =3D <0x0>;
>> ++        spi-max-frequency =3D <0x1312d00>;
>> ++    };
>> ++
>> ++    channel1@1 {
>> ++        #address-cells =3D <0x1>;
>> ++        #size-cells =3D <0x0>;
>> ++        compatible =3D "rtdm-spidev";
>> ++        reg =3D <0x1>;
>> ++        spi-max-frequency =3D <0x1312d00>;
>> ++    };
>> ++
>> ++};
>> +\ No newline at end of file
>> +--=20
>> +2.17.1
>> \ No newline at end of file
>> diff --git a/recipes-kernel/linux/files/bbb.cfg =
b/recipes-kernel/linux/files/bbb.cfg
>> new file mode 100644
>> index 0000000..5e2a112
>> --- /dev/null
>> +++ b/recipes-kernel/linux/files/bbb.cfg
>> @@ -0,0 +1,28 @@
>> +# Disable conflicting drivers
>=20
> How can non-matching drivers be in conflict? Most of those below do =
not
> match on any of the DT entries on the BBB.
>=20
>> +CONFIG_XENO_DRIVERS_SPI_BCM2835=3Dn
>> +CONFIG_XENO_DRIVERS_SPI_SUN6I=3Dn
>> +CONFIG_SPI_ATMEL=3Dn
>> +CONFIG_SPI_BCM2835=3Dn
>> +CONFIG_SPI_BCM2835AUX=3Dn
>> +CONFIG_SPI_BCM_QSPI=3Dn
>> +CONFIG_SPI_BITBANG=3Dn
>> +CONFIG_SPI_CADENCE=3Dn
>> +CONFIG_SPI_DAVINCI=3Dn
>> +CONFIG_SPI_GPIO=3Dn
>> +CONFIG_SPI_FSL_DSPI=3Dn
>> +CONFIG_SPI_OMAP24XX=3Dn
>> +CONFIG_SPI_ORION=3Dn
>> +CONFIG_SPI_PL022=3Dn
>> +CONFIG_SPI_ROCKCHIP=3Dn
>> +CONFIG_SPI_RSPI=3Dn
>> +CONFIG_SPI_S3C64XX=3Dn
>> +CONFIG_SPI_SH_MSIOF=3Dn
>> +CONFIG_SPI_SH_HSPI=3Dn
>> +CONFIG_SPI_SIRF=3Dn
>> +CONFIG_SPI_SUN4I=3Dn
>> +CONFIG_SPI_SUN6I=3Dn
>> +CONFIG_SPI_TEGRA114=3Dn
>> +CONFIG_SPI_TEGRA20_SFLASH=3Dn
>> +CONFIG_SPI_TEGRA20_SLINK=3Dn
>> +CONFIG_SPI_XILINX=3Dn
>> +CONFIG_SPI_SPIDEV=3Dn
>> \ No newline at end of file
>> diff --git a/recipes-kernel/linux/linux-xenomai.inc =
b/recipes-kernel/linux/linux-xenomai.inc
>> index 185b60b..ddc698b 100644
>> --- a/recipes-kernel/linux/linux-xenomai.inc
>> +++ b/recipes-kernel/linux/linux-xenomai.inc
>> @@ -13,7 +13,14 @@ require recipes-kernel/linux/linux-custom.inc
>>=20
>> KERNEL_DEFCONFIG ?=3D "${DISTRO_ARCH}_defconfig"
>>=20
>> -SRC_URI +=3D "file://${KERNEL_DEFCONFIG}"
>> +def is_bbb(d):
>> +    bbb =3D d.getVar('MACHINE') or ''
>> +    if bbb =3D=3D 'beagle-bone-black':
>> +        return "file://0001-BeagleBone-Black-RTDM-SPI-enabled.patch =
file://bbb.cfg"
>> +    return ""
>> +
>> +SRC_URI +=3D "file://${KERNEL_DEFCONFIG} \
>> +    ${@is_bbb(d)}"
>>=20
>=20
> Same as above.
>=20
>> DEPENDS +=3D "xenomai-kernel-source"
>> KBUILD_DEPENDS +=3D "xenomai-kernel-source"
>>=20
>=20
> Looks good otherwise. The smaller your patch becomes, the better it is
> already ;).
>=20
> Thanks,
> Jan
> --=20
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux

