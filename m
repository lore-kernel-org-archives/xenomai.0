Subject: Re: [xenomai-images][PATCH] Enable RTDM SPI on BeagleBone Black
References: <CAMCM02tNgxiQfVZB5-LomJKLZH_J5_PL_LNsG+OXdb2HHCLU9w@mail.gmail.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Message-ID: <3ec5dbbd-669f-3333-dd70-cb61cf2ca7a4@siemens.com>
Date: Wed, 11 Nov 2020 10:35:04 +0100
MIME-Version: 1.0
In-Reply-To: <CAMCM02tNgxiQfVZB5-LomJKLZH_J5_PL_LNsG+OXdb2HHCLU9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, deniz343@gmail.com, "Kiszka, Jan (CT RDA IOT SES-DE)" <jan.kiszka@siemens.com>

Hi Deniz,

thanks for the patch. I have some comments on it.

On 11/9/20 7:49 PM, Deniz Ugur via Xenomai wrote:
>  From eb0caf6840423f9557037ca636b7d7dbeb6d566f Mon Sep 17 00:00:00 2001
> From: Deniz Ugur <deniz343@gmail.com>
> Date: Mon, 9 Nov 2020 21:39:13 +0300
> Subject: [xenomai-images][PATCH] Enable RTDM SPI on BeagleBone Black
> To: xenomai@xenomai.org
> Cc: jan.kiszka@siemens.com
> 
> Tested on the next branch but it possibly works on master as well.
> I've tried not to modify too many defconfig values but it wasn't
> possible to make it work without these modifications.
> 
> Worst latency during spitest was around 100us. Although, I don't think
> that's related to this patch.
> 
> On a final note, I'm not really sure if it's possible to assign
> spi0_cs1 but if that's possible then a second channel for SPI0 can be
> enabled.
> Any feedback on that would be appreciated.
> 

This text should be part of the patch cover letter(git format-patch 
--cover-letter). The commit note should contain what you have change and 
why.

> Signed-off-by: Deniz Ugur <deniz343@gmail.com>
> ---
>   recipes-core/customizations/files/postinst    |   4 +
>   ...01-BeagleBone-Black-RTDM-SPI-enabled.patch | 110 ++++++++++++++++++
>   recipes-kernel/linux/files/armhf_defconfig    |  54 ++++-----
>   recipes-kernel/linux/linux-xenomai.inc        |   3 +-
>   4 files changed, 143 insertions(+), 28 deletions(-)
>   create mode 100644
> recipes-kernel/linux/files/0001-BeagleBone-Black-RTDM-SPI-enabled.patch
> 
> diff --git a/recipes-core/customizations/files/postinst
> b/recipes-core/customizations/files/postinst
> index 691988f..5a53a8c 100644
> --- a/recipes-core/customizations/files/postinst
> +++ b/recipes-core/customizations/files/postinst
> @@ -15,3 +15,7 @@ echo "Xenomai Demo Image (login: root/root)" > /etc/issue
>   echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
> 
>   echo "demo" > /etc/hostname
> +
> +# Disable HDMI in order to enable SPI1 on BeagleBone Black
> +echo "enable_uboot_overlays=1" >> /boot/uEnv.txt
> +echo "disable_uboot_overlay_video=1" >> /boot/uEnv.txt
Could you move this lines in a beagle-bone specific recipe. Currently 
you try to added them on each board and most of them have no /boot/uEnv.txt.


> diff --git a/recipes-kernel/linux/files/0001-BeagleBone-Black-RTDM-SPI-enabled.patch
> b/recipes-kernel/linux/files/0001-BeagleBone-Black-RTDM-SPI-enabled.patch
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
> +diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi
> b/arch/arm/boot/dts/am335x-bone-common.dtsi
> +index 73b514ddd..91ccc0f4b 100644
> +--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
> ++++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
> +@@ -6,6 +6,8 @@
> +  * published by the Free Software Foundation.
> +  */
> +
> ++#include "am335x-boneblack-spi.dtsi"
> ++
> + / {
> + cpus {
> + cpu@0 {
> +diff --git a/arch/arm/boot/dts/am335x-boneblack-spi.dtsi
> b/arch/arm/boot/dts/am335x-boneblack-spi.dtsi
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
> diff --git a/recipes-kernel/linux/files/armhf_defconfig
> b/recipes-kernel/linux/files/armhf_defconfig
This should be a beagle bone specific defconfig instead of
using the default armhf.
> index 567b61b..713b143 100644
> --- a/recipes-kernel/linux/files/armhf_defconfig
> +++ b/recipes-kernel/linux/files/armhf_defconfig
> @@ -553,8 +553,8 @@ CONFIG_XENO_DRIVERS_GPIOPWM=m
>   # Real-time SPI master drivers
>   #
>   CONFIG_XENO_DRIVERS_SPI=m
> -CONFIG_XENO_DRIVERS_SPI_BCM2835=m
> -CONFIG_XENO_DRIVERS_SPI_SUN6I=m
> +CONFIG_XENO_DRIVERS_SPI_BCM2835=n
> +CONFIG_XENO_DRIVERS_SPI_SUN6I=n
>   CONFIG_XENO_DRIVERS_SPI_OMAP2_MCSPI_RT=m
>   # CONFIG_XENO_DRIVERS_SPI_DEBUG is not set
> 
> @@ -2938,53 +2938,53 @@ CONFIG_SPI_MASTER=y
>   #
>   # CONFIG_SPI_ALTERA is not set
>   # CONFIG_SPI_ARMADA_3700 is not set
> -CONFIG_SPI_ATMEL=m
> +CONFIG_SPI_ATMEL=n
>   # CONFIG_SPI_AXI_SPI_ENGINE is not set
> -CONFIG_SPI_BCM2835=y
> -CONFIG_SPI_BCM2835AUX=y
> +CONFIG_SPI_BCM2835=n
> +CONFIG_SPI_BCM2835AUX=n
>   # CONFIG_SPI_BCM53XX is not set
> -CONFIG_SPI_BCM_QSPI=y
> -CONFIG_SPI_BITBANG=y
> -CONFIG_SPI_CADENCE=y
> -CONFIG_SPI_DAVINCI=y
> +CONFIG_SPI_BCM_QSPI=n
> +CONFIG_SPI_BITBANG=n
> +CONFIG_SPI_CADENCE=n
> +CONFIG_SPI_DAVINCI=n
>   # CONFIG_SPI_DESIGNWARE is not set
>   # CONFIG_SPI_FSL_LPSPI is not set
> -CONFIG_SPI_GPIO=m
> +CONFIG_SPI_GPIO=n
>   # CONFIG_SPI_IMX is not set
>   # CONFIG_SPI_FSL_SPI is not set
> -CONFIG_SPI_FSL_DSPI=m
> +CONFIG_SPI_FSL_DSPI=n
>   # CONFIG_SPI_MESON_SPICC is not set
>   # CONFIG_SPI_MESON_SPIFC is not set
>   # CONFIG_SPI_MT65XX is not set
>   # CONFIG_SPI_OC_TINY is not set
> -CONFIG_SPI_OMAP24XX=y
> +CONFIG_SPI_OMAP24XX=n
>   # CONFIG_SPI_TI_QSPI is not set
> -CONFIG_SPI_ORION=y
> -CONFIG_SPI_PL022=y
> +CONFIG_SPI_ORION=n
> +CONFIG_SPI_PL022=n
>   # CONFIG_SPI_PXA2XX is not set
>   # CONFIG_SPI_PXA2XX_PCI is not set
> -CONFIG_SPI_ROCKCHIP=m
> -CONFIG_SPI_RSPI=y
> +CONFIG_SPI_ROCKCHIP=n
> +CONFIG_SPI_RSPI=n
>   # CONFIG_SPI_QUP is not set
> -CONFIG_SPI_S3C64XX=m
> +CONFIG_SPI_S3C64XX=n
>   # CONFIG_SPI_SC18IS602 is not set
> -CONFIG_SPI_SH_MSIOF=m
> -CONFIG_SPI_SH_HSPI=y
> -CONFIG_SPI_SIRF=y
> +CONFIG_SPI_SH_MSIOF=n
> +CONFIG_SPI_SH_HSPI=n
> +CONFIG_SPI_SIRF=n
>   # CONFIG_SPI_ST_SSC4 is not set
> -CONFIG_SPI_SUN4I=y
> -CONFIG_SPI_SUN6I=y
> -CONFIG_SPI_TEGRA114=y
> -CONFIG_SPI_TEGRA20_SFLASH=y
> -CONFIG_SPI_TEGRA20_SLINK=y
> +CONFIG_SPI_SUN4I=n
> +CONFIG_SPI_SUN6I=n
> +CONFIG_SPI_TEGRA114=n
> +CONFIG_SPI_TEGRA20_SFLASH=n
> +CONFIG_SPI_TEGRA20_SLINK=n
>   # CONFIG_SPI_XCOMM is not set
> -CONFIG_SPI_XILINX=y
> +CONFIG_SPI_XILINX=n
>   # CONFIG_SPI_ZYNQMP_GQSPI is not set
> 
>   #
>   # SPI Protocol Masters
>   #
> -CONFIG_SPI_SPIDEV=y
> +CONFIG_SPI_SPIDEV=n
>   # CONFIG_SPI_LOOPBACK_TEST is not set
>   # CONFIG_SPI_TLE62X0 is not set
>   # CONFIG_SPI_SLAVE is not set
> diff --git a/recipes-kernel/linux/linux-xenomai.inc
> b/recipes-kernel/linux/linux-xenomai.inc
> index 185b60b..cd2015d 100644
> --- a/recipes-kernel/linux/linux-xenomai.inc
> +++ b/recipes-kernel/linux/linux-xenomai.inc
> @@ -13,7 +13,8 @@ require recipes-kernel/linux/linux-custom.inc >
>   KERNEL_DEFCONFIG ?= "${DISTRO_ARCH}_defconfig"
> 
> -SRC_URI += "file://${KERNEL_DEFCONFIG}"
> +SRC_URI += "file://${KERNEL_DEFCONFIG} \
> + file://0001-BeagleBone-Black-RTDM-SPI-enabled.patch"
This patch applies to all kernels instead only to the kernel of the
beagle-bone-black. This patch should only apply to the build of the bbb.

> 
>   DEPENDS += "xenomai-kernel-source"
>   KBUILD_DEPENDS += "xenomai-kernel-source"
> 

-- 
With best regards,
Quirin Gylstorff

Siemens AG
T RDA IOT SES-DE

