References: <1517366181-6547-1-git-send-email-greg@embeddedgreg.com>
 <1517366181-6547-3-git-send-email-greg@embeddedgreg.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <589d8fbe-eda1-69b5-2bc5-1d518e4c59f8@xenomai.org>
Date: Thu, 1 Feb 2018 11:30:48 +0100
MIME-Version: 1.0
In-Reply-To: <1517366181-6547-3-git-send-email-greg@embeddedgreg.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH 3/3] Allow for more then one rt gpio driver to
 be built and loaded at the same build
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>, xenomai@xenomai.org

On 01/31/2018 03:36 AM, Greg Gallagher wrote:
> Some SOCs will have two GPIO chips that require two independent drivers.  In my
> case I was working with the Zynq SOC and needed a driver for the gpios on the
> FPGA and a driver for the gpios available on the ARM core. This change allows
> for two rt gpio drivers to be built and loaded at the same time.
> The rt gpio driver will be renamed from xeno-gpio to the following:
> 
> xeno-gpio-bcm2835.ko
> xeno-gpio-mxc.ko
> xeno-gpio-sun8i-h3.ko
> xeno-gpio-zynq7000.ko
> 
> This also moves the gpio-core logic into the kernel image.
> ---
>  kernel/drivers/gpio/Kconfig       | 12 ++++++------
>  kernel/drivers/gpio/Makefile      | 22 ++++++++++++----------
>  kernel/drivers/gpio/gpio-xilinx.c |  4 ++--
>  3 files changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/kernel/drivers/gpio/Kconfig b/kernel/drivers/gpio/Kconfig
> index b7efa54..48475f2 100644
> --- a/kernel/drivers/gpio/Kconfig
> +++ b/kernel/drivers/gpio/Kconfig
> @@ -1,7 +1,7 @@
>  menu "Real-time GPIO drivers"
>  
>  config XENO_DRIVERS_GPIO
> -       tristate "GPIO controller"
> +       bool "GPIO controller"
>         depends on GPIOLIB
>         help
>  
> @@ -11,7 +11,7 @@ if XENO_DRIVERS_GPIO
>  
>  config XENO_DRIVERS_GPIO_BCM2835
>  	depends on MACH_BCM2708 || ARCH_BCM2835
> -	bool "Support for BCM2835 GPIOs"
> +	tristate "Support for BCM2835 GPIOs"
>  	help
>  
>  	Enables support for the GPIO controller available from
> @@ -19,7 +19,7 @@ config XENO_DRIVERS_GPIO_BCM2835
>  
>  config XENO_DRIVERS_GPIO_MXC
>  	depends on GPIO_MXC
> -	bool "Support for MXC GPIOs"
> +	tristate "Support for MXC GPIOs"
>  	help
>  
>  	Suitable for the GPIO controller available from
> @@ -27,7 +27,7 @@ config XENO_DRIVERS_GPIO_MXC
>  
>  config XENO_DRIVERS_GPIO_SUN8I_H3
>  	depends on MACH_SUN8I && PINCTRL_SUN8I_H3
> -	bool "Support for SUN8I H3 GPIOs"
> +	tristate "Support for SUN8I H3 GPIOs"
>  	help
>  
>  	Suitable for the GPIO controller available from Allwinner's H3
> @@ -35,7 +35,7 @@ config XENO_DRIVERS_GPIO_SUN8I_H3
>  
>  config XENO_DRIVERS_GPIO_ZYNQ7000
>  	depends on ARCH_ZYNQ
> -	bool "Support for Zynq7000 GPIOs"
> +	tristate "Support for Zynq7000 GPIOs"
>  	help
>  
>  	Enables support for the GPIO controller available from
> @@ -43,7 +43,7 @@ config XENO_DRIVERS_GPIO_ZYNQ7000
>  
>  config XENO_DRIVERS_GPIO_XILINX
>  	depends on ARCH_ZYNQ
> -	bool "Support for Xilinx GPIOs"
> +	tristate "Support for Xilinx GPIOs"
>  	help
>  
>  	Enables support for the GPIO controller available from
> diff --git a/kernel/drivers/gpio/Makefile b/kernel/drivers/gpio/Makefile
> index 3737330..8648fcc 100644
> --- a/kernel/drivers/gpio/Makefile
> +++ b/kernel/drivers/gpio/Makefile
> @@ -1,12 +1,14 @@
>  ccflags-$(CONFIG_XENO_DRIVERS_GPIO_DEBUG) := -DDEBUG
>  
> -obj-$(CONFIG_XENO_DRIVERS_GPIO) += xeno_gpio.o
> -
> -xeno_gpio-y := gpio-core.o
> -
> -xeno_gpio-$(CONFIG_XENO_DRIVERS_GPIO_BCM2835) += gpio-bcm2835.o
> -xeno_gpio-$(CONFIG_XENO_DRIVERS_GPIO_MXC) += gpio-mxc.o
> -xeno_gpio-$(CONFIG_XENO_DRIVERS_GPIO_SUN8I_H3) += gpio-sun8i-h3.o
> -xeno_gpio-$(CONFIG_XENO_DRIVERS_GPIO_ZYNQ7000) += gpio-zynq7000.o
> -xeno_gpio-$(CONFIG_XENO_DRIVERS_GPIO_XILINX) += gpio-xilinx.o
> -
> +obj-$(CONFIG_XENO_DRIVERS_GPIO_BCM2835) += xeno-gpio-bcm2835.o
> +obj-$(CONFIG_XENO_DRIVERS_GPIO_MXC) += xeno-gpio-mxc.o
> +obj-$(CONFIG_XENO_DRIVERS_GPIO_SUN8I_H3) += xeno-gpio-sun8i-h3.o
> +obj-$(CONFIG_XENO_DRIVERS_GPIO_ZYNQ7000) += xeno-gpio-zynq7000.o
> +obj-$(CONFIG_XENO_DRIVERS_GPIO_XILINX) += xeno-gpio-xilinx.o
> +obj-$(CONFIG_XENO_DRIVERS_GPIO) += gpio-core.o
> +
> +xeno-gpio-bcm2835-y := gpio-bcm2835.o
> +xeno-gpio-mxc-y := gpio-mxc.o
> +xeno-gpio-sun8i-h3-y := gpio-sun8i-h3.o
> +xeno-gpio-zynq7000-y := gpio-zynq7000.o
> +xeno-gpio-xilinx-y := gpio-xilinx.o

Ok.

> diff --git a/kernel/drivers/gpio/gpio-xilinx.c b/kernel/drivers/gpio/gpio-xilinx.c
> index 72d4364..e982f5f 100644
> --- a/kernel/drivers/gpio/gpio-xilinx.c
> +++ b/kernel/drivers/gpio/gpio-xilinx.c
> @@ -19,13 +19,13 @@
>   * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
>   */
>  #include <linux/module.h>
> -#include "gpio-core.h"
> +#include <rtdm/gpio.h>
>  
>  #define RTDM_SUBCLASS_XILINX  5
>  
>  static int __init xilinx_gpio_init(void)
>  {
> - 	return rtdm_gpiochip_scan_of(NULL, "xlnx,xps-gpio-1.00.a",
> +	return rtdm_gpiochip_scan_of(NULL, "xlnx,xps-gpio-1.00.a",
>                       RTDM_SUBCLASS_XILINX);
>  }
>  module_init(xilinx_gpio_init);
> 

Left over from patch #1?

-- 
Philippe.

