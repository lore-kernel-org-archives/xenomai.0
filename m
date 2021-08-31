Subject: Re: [PATCH 1/3] drivers/gpio: core: Move out of OF config conditional
 compilation
References: <20210831050736.5371-1-hongzhan.chen@intel.com>
 <20210831050736.5371-2-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <69fa23f2-d9f4-dbca-0995-441b6bb10a5a@siemens.com>
Date: Tue, 31 Aug 2021 15:05:51 +0200
MIME-Version: 1.0
In-Reply-To: <20210831050736.5371-2-hongzhan.chen@intel.com>
Content-Type: text/plain; charset=utf-8
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
To: Hongzhan Chen <hongzhan.chen@intel.com>, xenomai@xenomai.org

On 31.08.21 07:07, Hongzhan Chen via Xenomai wrote:
> Rename interface name because it is undependent of OF platform and
> non-OF platform would also call it to remove rtdm gpio chip device.
> 
> Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
> ---
>  include/cobalt/kernel/rtdm/gpio.h   | 5 ++---
>  kernel/drivers/gpio/gpio-bcm2835.c  | 2 +-
>  kernel/drivers/gpio/gpio-core.c     | 8 ++++----
>  kernel/drivers/gpio/gpio-mxc.c      | 2 +-
>  kernel/drivers/gpio/gpio-omap.c     | 2 +-
>  kernel/drivers/gpio/gpio-sun8i-h3.c | 2 +-
>  kernel/drivers/gpio/gpio-xilinx.c   | 2 +-
>  kernel/drivers/gpio/gpio-zynq7000.c | 2 +-
>  8 files changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/include/cobalt/kernel/rtdm/gpio.h b/include/cobalt/kernel/rtdm/gpio.h
> index 72cc3a035..29f26d6c6 100644
> --- a/include/cobalt/kernel/rtdm/gpio.h
> +++ b/include/cobalt/kernel/rtdm/gpio.h
> @@ -70,9 +70,8 @@ int rtdm_gpiochip_scan_of(struct device_node *from,
>  int rtdm_gpiochip_scan_array_of(struct device_node *from,
>  				const char *compat[],
>  				int nentries, int type);
> -
> -void rtdm_gpiochip_remove_of(int type);
> -
>  #endif
>  
> +void rtdm_gpiochip_remove(int type);
> +
>  #endif /* !_COBALT_RTDM_GPIO_H */
> diff --git a/kernel/drivers/gpio/gpio-bcm2835.c b/kernel/drivers/gpio/gpio-bcm2835.c
> index f30d6b591..a0c17f875 100644
> --- a/kernel/drivers/gpio/gpio-bcm2835.c
> +++ b/kernel/drivers/gpio/gpio-bcm2835.c
> @@ -29,7 +29,7 @@ module_init(bcm2835_gpio_init);
>  
>  static void __exit bcm2835_gpio_exit(void)
>  {
> -	rtdm_gpiochip_remove_of(RTDM_SUBCLASS_BCM2835);
> +	rtdm_gpiochip_remove(RTDM_SUBCLASS_BCM2835);
>  }
>  module_exit(bcm2835_gpio_exit);
>  
> diff --git a/kernel/drivers/gpio/gpio-core.c b/kernel/drivers/gpio/gpio-core.c
> index 06a19b33a..ccda67bd1 100644
> --- a/kernel/drivers/gpio/gpio-core.c
> +++ b/kernel/drivers/gpio/gpio-core.c
> @@ -626,7 +626,9 @@ int rtdm_gpiochip_scan_array_of(struct device_node *from,
>  }
>  EXPORT_SYMBOL_GPL(rtdm_gpiochip_scan_array_of);
>  
> -void rtdm_gpiochip_remove_of(int type)
> +#endif /* CONFIG_OF */
> +
> +void rtdm_gpiochip_remove(int type)
>  {
>  	struct rtdm_gpio_chip *rgc, *n;
>  
> @@ -643,6 +645,4 @@ void rtdm_gpiochip_remove_of(int type)
>  
>  	mutex_unlock(&chip_lock);
>  }
> -EXPORT_SYMBOL_GPL(rtdm_gpiochip_remove_of);
> -
> -#endif /* CONFIG_OF */
> +EXPORT_SYMBOL_GPL(rtdm_gpiochip_remove);
> diff --git a/kernel/drivers/gpio/gpio-mxc.c b/kernel/drivers/gpio/gpio-mxc.c
> index 7b28111f6..99162e5f8 100644
> --- a/kernel/drivers/gpio/gpio-mxc.c
> +++ b/kernel/drivers/gpio/gpio-mxc.c
> @@ -35,7 +35,7 @@ module_init(mxc_gpio_init);
>  
>  static void __exit mxc_gpio_exit(void)
>  {
> -	rtdm_gpiochip_remove_of(RTDM_SUBCLASS_MXC);
> +	rtdm_gpiochip_remove(RTDM_SUBCLASS_MXC);
>  }
>  module_exit(mxc_gpio_exit);
>  
> diff --git a/kernel/drivers/gpio/gpio-omap.c b/kernel/drivers/gpio/gpio-omap.c
> index 5f10278f3..848d84694 100644
> --- a/kernel/drivers/gpio/gpio-omap.c
> +++ b/kernel/drivers/gpio/gpio-omap.c
> @@ -36,7 +36,7 @@ module_init(omap_gpio_init);
>  
>  static void __exit omap_gpio_exit(void)
>  {
> -	rtdm_gpiochip_remove_of(RTDM_SUBCLASS_OMAP);
> +	rtdm_gpiochip_remove(RTDM_SUBCLASS_OMAP);
>  }
>  module_exit(omap_gpio_exit);
>  
> diff --git a/kernel/drivers/gpio/gpio-sun8i-h3.c b/kernel/drivers/gpio/gpio-sun8i-h3.c
> index 94303dd00..0dcfe8c00 100644
> --- a/kernel/drivers/gpio/gpio-sun8i-h3.c
> +++ b/kernel/drivers/gpio/gpio-sun8i-h3.c
> @@ -36,7 +36,7 @@ module_init(h3_gpio_init);
>  
>  static void __exit h3_gpio_exit(void)
>  {
> -	rtdm_gpiochip_remove_of(RTDM_SUBCLASS_H3);
> +	rtdm_gpiochip_remove(RTDM_SUBCLASS_H3);
>  }
>  module_exit(h3_gpio_exit);
>  
> diff --git a/kernel/drivers/gpio/gpio-xilinx.c b/kernel/drivers/gpio/gpio-xilinx.c
> index e982f5fa4..05bf870df 100644
> --- a/kernel/drivers/gpio/gpio-xilinx.c
> +++ b/kernel/drivers/gpio/gpio-xilinx.c
> @@ -32,7 +32,7 @@ module_init(xilinx_gpio_init);
>  
>  static void __exit xilinx_gpio_exit(void)
>  {
> -	rtdm_gpiochip_remove_of(RTDM_SUBCLASS_XILINX);
> +	rtdm_gpiochip_remove(RTDM_SUBCLASS_XILINX);
>  }
>  module_exit(xilinx_gpio_exit);
>  
> diff --git a/kernel/drivers/gpio/gpio-zynq7000.c b/kernel/drivers/gpio/gpio-zynq7000.c
> index 070db3fe4..5a6f2b83d 100644
> --- a/kernel/drivers/gpio/gpio-zynq7000.c
> +++ b/kernel/drivers/gpio/gpio-zynq7000.c
> @@ -32,7 +32,7 @@ module_init(zynq7000_gpio_init);
>  
>  static void __exit zynq7000_gpio_exit(void)
>  {
> -	rtdm_gpiochip_remove_of(RTDM_SUBCLASS_ZYNQ7000);
> +	rtdm_gpiochip_remove(RTDM_SUBCLASS_ZYNQ7000);
>  }
>  module_exit(zynq7000_gpio_exit);
>  
> 

Oops, we already had a rtdm_gpiochip_remove. Renaming this one to
rtdm_gpiochip_remove_by_type".

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

