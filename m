Subject: Re: [xenomai-images][PATCH 1/1][REV 2] Enable RTDM SPI on BeagleBone
 Black
References: <30F08CB9-A6E9-4C78-B40F-D6454048E786@gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <0403b386-7c15-b32d-f009-25c49d105dcc@siemens.com>
Date: Thu, 12 Nov 2020 08:09:35 +0100
MIME-Version: 1.0
In-Reply-To: <30F08CB9-A6E9-4C78-B40F-D6454048E786@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Deniz_U=c4=9fur?= <deniz343@gmail.com>, Xenomai <xenomai@xenomai.org>

On 11.11.20 20:47, Deniz Uğur via Xenomai wrote:
> From dbc3add6bb3130d40602d3144d152acc0e0e3bd9 Mon Sep 17 00:00:00 2001
> From: Deniz Ugur <deniz343@gmail.com>
> Date: Wed, 11 Nov 2020 22:23:03 +0300
> Subject: [xenomai-images][PATCH 1/1][REV 2] Enable RTDM SPI on BeagleBone Black
> To: xenomai@xenomai.org
> Cc: quirin.gylstorff@siemens.com
> 
> Indentation was messed up on previous post. This one fixes it.
> 

This is not place to put some kind or "versioning" info. It's rather the
place to put your commit message, explaining *why* we want this change.

Also missing: signed-off-by (DCO, https://developercertificate.org/).

> ---
>  recipes-core/customizations/customizations.bb |   9 +-
>  recipes-core/customizations/files/post-bbb    |   5 +
>  ...01-BeagleBone-Black-RTDM-SPI-enabled.patch | 110 ++++++++++++++++++
>  recipes-kernel/linux/files/bbb.cfg            |  28 +++++
>  recipes-kernel/linux/linux-xenomai.inc        |   9 +-
>  5 files changed, 159 insertions(+), 2 deletions(-)
>  create mode 100644 recipes-core/customizations/files/post-bbb
>  create mode 100644 recipes-kernel/linux/files/0001-BeagleBone-Black-RTDM-SPI-enabled.patch
>  create mode 100644 recipes-kernel/linux/files/bbb.cfg
> 
> diff --git a/recipes-core/customizations/customizations.bb b/recipes-core/customizations/customizations.bb
> index e35c0a5..ecfd1d0 100644
> --- a/recipes-core/customizations/customizations.bb
> +++ b/recipes-core/customizations/customizations.bb
> @@ -13,10 +13,17 @@ inherit dpkg-raw
>  
>  DESCRIPTION = "demo image customizations"
>  
> +def is_bbb(d):
> +    bbb = d.getVar('MACHINE') or ''
> +    if bbb == 'beagle-bone-black':
> +        return "file://post-bbb"
> +    return ""
> +
>  SRC_URI = " \
>      file://postinst \
>      file://ethernet \
> -    file://99-silent-printk.conf"
> +    file://99-silent-printk.conf \
> +    ${@is_bbb(d)}"

bitbake override magic can be used here:

SRC_URI_append_beagle-bone-black = ...

>  
>  DEBIAN_DEPENDS = "passwd"
>  
> diff --git a/recipes-core/customizations/files/post-bbb b/recipes-core/customizations/files/post-bbb
> new file mode 100644
> index 0000000..9befbcf
> --- /dev/null
> +++ b/recipes-core/customizations/files/post-bbb
> @@ -0,0 +1,5 @@
> +#!/bin/sh
> +
> +# Disable HDMI in order to enable SPI1 on BeagleBone Black
> +echo "enable_uboot_overlays=1" >> /boot/uEnv.txt

Why do we need to *enable* overlays first...

> +echo "disable_uboot_overlay_video=1" >> /boot/uEnv.txt

...in order to disable a specific one?

> \ No newline at end of file
> diff --git a/recipes-kernel/linux/files/0001-BeagleBone-Black-RTDM-SPI-enabled.patch b/recipes-kernel/linux/files/0001-BeagleBone-Black-RTDM-SPI-enabled.patch
> new file mode 100644
> index 0000000..3b8b542
> --- /dev/null
> +++ b/recipes-kernel/linux/files/0001-BeagleBone-Black-RTDM-SPI-enabled.patch
> @@ -0,0 +1,110 @@
> +From 1badee8e16340d063f8bff04c39c9fd3d6749a8f Mon Sep 17 00:00:00 2001
> +From: Deniz Ugur <deniz343@gmail.com>
> +Date: Mon, 9 Nov 2020 20:19:49 +0300
> +Subject: [PATCH] BeagleBone Black RTDM SPI enabled
> +
> +---
> + arch/arm/boot/dts/am335x-bone-common.dtsi   |  2 +
> + arch/arm/boot/dts/am335x-boneblack-spi.dtsi | 77 +++++++++++++++++++++
> + 2 files changed, 79 insertions(+)
> + create mode 100644 arch/arm/boot/dts/am335x-boneblack-spi.dtsi
> +
> +diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
> +index 73b514ddd..91ccc0f4b 100644
> +--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
> ++++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
> +@@ -6,6 +6,8 @@
> +  * published by the Free Software Foundation.
> +  */
> + 
> ++#include "am335x-boneblack-spi.dtsi"
> ++

I think we should rather patch that into am335x-boneblack.dts.

> + / {
> +   cpus {
> +       cpu@0 {
> +diff --git a/arch/arm/boot/dts/am335x-boneblack-spi.dtsi b/arch/arm/boot/dts/am335x-boneblack-spi.dtsi
> +new file mode 100644
> +index 000000000..47485af64
> +--- /dev/null
> ++++ b/arch/arm/boot/dts/am335x-boneblack-spi.dtsi
> +@@ -0,0 +1,77 @@
> ++&am33xx_pinmux {
> ++    spi0_pins: pinmux_spi0_pins {
> ++        pinctrl-single,pins = <
> ++            /* This output signal is also used as a re-timing input. */
> ++            0x150 0x30  /* P9_22 spi0_sclk, INPUT_PULLUP | MODE0 */
> ++            0x154 0x30  /* P9_21 spi0_d0, INPUT_PULLUP | MODE0 */
> ++            0x158 0x10  /* P9_18 spi0_d1, OUTPUT_PULLUP | MODE0 */
> ++            0x15c 0x10  /* P9_17 spi0_cs0, OUTPUT_PULLUP | MODE0 */
> ++        >;
> ++    };
> ++
> ++    spi1_pins: pinmux_spi1_pins {
> ++        pinctrl-single,pins = <
> ++            /* This output signal is also used as a re-timing input. */
> ++            0x190 0x33  /* P9_31 spi1_sclk, INPUT_PULLUP | MODE3 */
> ++            0x194 0x33  /* P9_29 spi1_d0, INPUT_PULLUP | MODE3 */
> ++            0x198 0x13  /* P9_30 spi1_d1, OUTPUT_PULLUP | MODE3 */
> ++            0x19c 0x13  /* P9_28 spi1_cs0, OUTPUT_PULLUP | MODE3 */
> ++            0x164 0x12  /* P9_42 spi1_cs1 OUTPUT_PULLUP | MODE2 */
> ++        >;
> ++    };
> ++};
> ++
> ++&spi0 {
> ++    compatible = "ti,omap4-mcspi";
> ++    #address-cells = <0x1>;
> ++    #size-cells = <0x0>;
> ++    reg = <0x48030000 0x400>;
> ++    interrupts = <0x41>;
> ++    ti,spi-num-cs = <0x2>;
> ++    ti,hwmods = "spi0";
> ++    dmas = <0x27 0x10 0x0 0x27 0x11 0x0 0x27 0x12 0x0 0x27 0x13 0x0>;
> ++    dma-names = "tx0", "rx0", "tx1", "rx1";
> ++    status = "okay";
> ++    pinctrl-names = "default";
> ++    pinctrl-0 = <&spi0_pins>;
> ++
> ++    channel0@0 {
> ++        #address-cells = <0x1>;
> ++        #size-cells = <0x0>;
> ++        compatible = "rtdm-spidev";
> ++        reg = <0x0>;
> ++        spi-max-frequency = <0x1312d00>;
> ++    };
> ++};
> ++
> ++&spi1 {
> ++    compatible = "ti,omap4-mcspi";
> ++    #address-cells = <0x1>;
> ++    #size-cells = <0x0>;
> ++    reg = <0x481a0000 0x400>;
> ++    interrupts = <0x7d>;
> ++    ti,spi-num-cs = <0x2>;
> ++    ti,hwmods = "spi1";
> ++    dmas = <0x27 0x2a 0x0 0x27 0x2b 0x0 0x27 0x2c 0x0 0x27 0x2d 0x0>;
> ++    dma-names = "tx0", "rx0", "tx1", "rx1";
> ++    status = "okay";
> ++    pinctrl-names = "default";
> ++    pinctrl-0 = <&spi1_pins>;
> ++
> ++    channel1@0 {
> ++        #address-cells = <0x1>;
> ++        #size-cells = <0x0>;
> ++        compatible = "rtdm-spidev";
> ++        reg = <0x0>;
> ++        spi-max-frequency = <0x1312d00>;
> ++    };
> ++
> ++    channel1@1 {
> ++        #address-cells = <0x1>;
> ++        #size-cells = <0x0>;
> ++        compatible = "rtdm-spidev";
> ++        reg = <0x1>;
> ++        spi-max-frequency = <0x1312d00>;
> ++    };
> ++
> ++};
> +\ No newline at end of file
> +-- 
> +2.17.1
> \ No newline at end of file
> diff --git a/recipes-kernel/linux/files/bbb.cfg b/recipes-kernel/linux/files/bbb.cfg
> new file mode 100644
> index 0000000..5e2a112
> --- /dev/null
> +++ b/recipes-kernel/linux/files/bbb.cfg
> @@ -0,0 +1,28 @@
> +# Disable conflicting drivers

How can non-matching drivers be in conflict? Most of those below do not
match on any of the DT entries on the BBB.

> +CONFIG_XENO_DRIVERS_SPI_BCM2835=n
> +CONFIG_XENO_DRIVERS_SPI_SUN6I=n
> +CONFIG_SPI_ATMEL=n
> +CONFIG_SPI_BCM2835=n
> +CONFIG_SPI_BCM2835AUX=n
> +CONFIG_SPI_BCM_QSPI=n
> +CONFIG_SPI_BITBANG=n
> +CONFIG_SPI_CADENCE=n
> +CONFIG_SPI_DAVINCI=n
> +CONFIG_SPI_GPIO=n
> +CONFIG_SPI_FSL_DSPI=n
> +CONFIG_SPI_OMAP24XX=n
> +CONFIG_SPI_ORION=n
> +CONFIG_SPI_PL022=n
> +CONFIG_SPI_ROCKCHIP=n
> +CONFIG_SPI_RSPI=n
> +CONFIG_SPI_S3C64XX=n
> +CONFIG_SPI_SH_MSIOF=n
> +CONFIG_SPI_SH_HSPI=n
> +CONFIG_SPI_SIRF=n
> +CONFIG_SPI_SUN4I=n
> +CONFIG_SPI_SUN6I=n
> +CONFIG_SPI_TEGRA114=n
> +CONFIG_SPI_TEGRA20_SFLASH=n
> +CONFIG_SPI_TEGRA20_SLINK=n
> +CONFIG_SPI_XILINX=n
> +CONFIG_SPI_SPIDEV=n
> \ No newline at end of file
> diff --git a/recipes-kernel/linux/linux-xenomai.inc b/recipes-kernel/linux/linux-xenomai.inc
> index 185b60b..ddc698b 100644
> --- a/recipes-kernel/linux/linux-xenomai.inc
> +++ b/recipes-kernel/linux/linux-xenomai.inc
> @@ -13,7 +13,14 @@ require recipes-kernel/linux/linux-custom.inc
>  
>  KERNEL_DEFCONFIG ?= "${DISTRO_ARCH}_defconfig"
>  
> -SRC_URI += "file://${KERNEL_DEFCONFIG}"
> +def is_bbb(d):
> +    bbb = d.getVar('MACHINE') or ''
> +    if bbb == 'beagle-bone-black':
> +        return "file://0001-BeagleBone-Black-RTDM-SPI-enabled.patch file://bbb.cfg"
> +    return ""
> +
> +SRC_URI += "file://${KERNEL_DEFCONFIG} \
> +    ${@is_bbb(d)}"
>  

Same as above.

>  DEPENDS += "xenomai-kernel-source"
>  KBUILD_DEPENDS += "xenomai-kernel-source"
> 

Looks good otherwise. The smaller your patch becomes, the better it is
already ;).

Thanks,
Jan
-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


