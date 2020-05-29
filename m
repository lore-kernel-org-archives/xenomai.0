Subject: Re: [PATCH] Enable zynq gpio and xilinx gpio support for the Zynq MP
 platform.
References: <20200529041233.536263-1-greg@embeddedgreg.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <530a8c03-8367-6adb-800a-a7a63d60b795@siemens.com>
Date: Fri, 29 May 2020 19:04:16 +0200
MIME-Version: 1.0
In-Reply-To: <20200529041233.536263-1-greg@embeddedgreg.com>
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
To: Greg Gallagher <greg@embeddedgreg.com>, xenomai@xenomai.org
Cc: Joshua Karch <jkarch48@hotmail.com>

On 29.05.20 06:12, Greg Gallagher via Xenomai wrote:
> Signed-off-by: Greg Gallagher <greg@embeddedgreg.com>
> Signed-off-by: Joshua Karch <jkarch48@hotmail.com>

Did you mean "Reported-by: Joshua" or should "From:" be rather Josh?

Jan

> ---
>  kernel/drivers/gpio/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/drivers/gpio/Kconfig b/kernel/drivers/gpio/Kconfig
> index dbc862754..44f41688c 100644
> --- a/kernel/drivers/gpio/Kconfig
> +++ b/kernel/drivers/gpio/Kconfig
> @@ -34,7 +34,7 @@ config XENO_DRIVERS_GPIO_SUN8I_H3
>  	SoC, as found on the NanoPI boards.
>  
>  config XENO_DRIVERS_GPIO_ZYNQ7000
> -	depends on ARCH_ZYNQ
> +	depends on ARCH_ZYNQ || ARCH_ZYNQMP
>  	tristate "Support for Zynq7000 GPIOs"
>  	help
>  
> @@ -42,7 +42,7 @@ config XENO_DRIVERS_GPIO_ZYNQ7000
>  	Xilinx's Zynq7000 SoC.
>  
>  config XENO_DRIVERS_GPIO_XILINX
> -	depends on ARCH_ZYNQ
> +	depends on ARCH_ZYNQ || ARCH_ZYNQMP
>  	tristate "Support for Xilinx GPIOs"
>  	help
>  
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

