MIME-Version: 1.0
References: <f049bc90-fc68-3fff-1d1f-b223fc6871a4@siemens.com>
In-Reply-To: <f049bc90-fc68-3fff-1d1f-b223fc6871a4@siemens.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Thu, 5 Nov 2020 10:45:39 -0500
Message-ID: <CALLqZ8T4ASfCtCu2UxHLFYZA+0u+75KyxEdg9DSSgV0j1xWBAg@mail.gmail.com>
Subject: Re: [xenomai-images][PATCH] linux: arm: Enable Xenomai GPIO and SPI
 driver for BBB
Content-Type: text/plain; charset="UTF-8"
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
Cc: =?UTF-8?Q?Deniz_U=C4=9Fur?= <deniz343@gmail.com>, Xenomai <xenomai@xenomai.org>

On Thu, Nov 5, 2020 at 6:22 AM Jan Kiszka via Xenomai <xenomai@xenomai.org>
wrote:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> The GPIO driver still needs xenomai-next, though.
>
> Suggested-by: Deniz U=C4=9Fur <deniz343@gmail.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   recipes-kernel/linux/files/armhf_defconfig | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/recipes-kernel/linux/files/armhf_defconfig
> b/recipes-kernel/linux/files/armhf_defconfig
> index 99fb0a8..567b61b 100644
> --- a/recipes-kernel/linux/files/armhf_defconfig
> +++ b/recipes-kernel/linux/files/armhf_defconfig
> @@ -541,6 +541,7 @@ CONFIG_XENO_DRIVERS_GPIO_MXC=3Dm
>   CONFIG_XENO_DRIVERS_GPIO_SUN8I_H3=3Dm
>   CONFIG_XENO_DRIVERS_GPIO_ZYNQ7000=3Dm
>   CONFIG_XENO_DRIVERS_GPIO_XILINX=3Dm
> +CONFIG_XENO_DRIVERS_GPIO_OMAP=3Dm
>   # CONFIG_XENO_DRIVERS_GPIO_DEBUG is not set
>    #
> @@ -554,6 +555,7 @@ CONFIG_XENO_DRIVERS_GPIOPWM=3Dm
>   CONFIG_XENO_DRIVERS_SPI=3Dm
>   CONFIG_XENO_DRIVERS_SPI_BCM2835=3Dm
>   CONFIG_XENO_DRIVERS_SPI_SUN6I=3Dm
> +CONFIG_XENO_DRIVERS_SPI_OMAP2_MCSPI_RT=3Dm
>   # CONFIG_XENO_DRIVERS_SPI_DEBUG is not set
>    #
> --
> 2.26.2
>
>
> --
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux


Looks good to me

Greg

>
>
>
