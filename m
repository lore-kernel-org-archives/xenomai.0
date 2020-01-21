Subject: Re: [PATCH] spi: update Makefile and Kconfig to include bbb spi driver
References: <20200120132217.3802-1-laurentiu.duca@gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <fa436ab6-7ef2-2c29-e594-f1ae09535854@siemens.com>
Date: Tue, 21 Jan 2020 18:44:57 +0100
MIME-Version: 1.0
In-Reply-To: <20200120132217.3802-1-laurentiu.duca@gmail.com>
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
To: Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>, xenomai@xenomai.org

On 20.01.20 14:22, Laurentiu-Cristian Duca via Xenomai wrote:
> Updated SPI Makefile and Kconfig in order to contain the option
> to compile am335x beaglebone black omap4 spi real-time driver.
> 
> Signed-off-by: Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>
> ---
>   kernel/drivers/spi/Kconfig  | 10 ++++++++++
>   kernel/drivers/spi/Makefile |  2 ++
>   2 files changed, 12 insertions(+)
> 
> diff --git a/kernel/drivers/spi/Kconfig b/kernel/drivers/spi/Kconfig
> index c2d47aa6c..b48aaf3f9 100644
> --- a/kernel/drivers/spi/Kconfig
> +++ b/kernel/drivers/spi/Kconfig
> @@ -22,6 +22,16 @@ config XENO_DRIVERS_SPI_SUN6I
>   	Enables support for the SPI controller available from
>   	Allwinner's A31, H3 SoCs.
>   
> +config XENO_DRIVERS_SPI_OMAP2_MCSPI_RT
> +	tristate "McSPI rt-driver for OMAP"
> +	depends on HAS_DMA
> +	depends on ARCH_OMAP2PLUS || COMPILE_TEST
> +	select XENO_DRIVERS_SPI
> +	help
> +
> +	SPI real-time master controller for OMAP24XX and later Multichannel SPI
> +	(McSPI) modules.
> +
>   config XENO_DRIVERS_SPI_DEBUG
>          depends on XENO_DRIVERS_SPI
>          bool "Enable SPI core debugging features"
> diff --git a/kernel/drivers/spi/Makefile b/kernel/drivers/spi/Makefile
> index 075641f92..889033c4f 100644
> --- a/kernel/drivers/spi/Makefile
> +++ b/kernel/drivers/spi/Makefile
> @@ -7,6 +7,8 @@ xeno_spi-y := spi-master.o spi-device.o
>   
>   obj-$(CONFIG_XENO_DRIVERS_SPI_BCM2835) += xeno_spi_bcm2835.o
>   obj-$(CONFIG_XENO_DRIVERS_SPI_SUN6I) += xeno_spi_sun6i.o
> +obj-$(CONFIG_XENO_DRIVERS_SPI_OMAP2_MCSPI_RT) += xeno_spi_omap2_mcspi_rt.o
>   
>   xeno_spi_bcm2835-y := spi-bcm2835.o
>   xeno_spi_sun6i-y := spi-sun6i.o
> +xeno_spi_omap2_mcspi_rt-y := spi-omap2-mcspi-rt.o
> 

Thanks, applied to next. I've also turned it on in CI build testing - we 
need to check the build logs if that catches it on ARM builds. If not, 
we should tune that config further to ensure this.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

