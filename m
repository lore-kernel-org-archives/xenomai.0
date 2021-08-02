Subject: Re: [PATCH 3/7] net/drivers: fec: rebase over original driver from
 kernel 4.14.85
References: <20210728072802.5816-1-jean-baptiste.tredez@ba-healthcare.com>
 <20210728072802.5816-4-jean-baptiste.tredez@ba-healthcare.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <b5c197d5-0f24-416c-b4d5-07737db51468@siemens.com>
Date: Mon, 2 Aug 2021 10:37:56 +0200
MIME-Version: 1.0
In-Reply-To: <20210728072802.5816-4-jean-baptiste.tredez@ba-healthcare.com>
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
To: =?UTF-8?Q?Jean-Baptiste_Tr=c3=a9dez?= <jean-baptiste.tredez@ba-healthcare.com>, xenomai@xenomai.org

On 28.07.21 09:27, Jean-Baptiste Trédez via Xenomai wrote:
> From: Philippe Gerum <rpm@xenomai.org>
> 
> This driver has three runtime modes:
> 
> - full RTnet mode for all devices (default)
> 
> - partial RTnet. RTnet mode only for devices which do not define/set
>   the boolean "rtnet-disabled" to true in the dts. The latter are
>   operated normally, interfacing with the standard network stack
>   instead of RTnet.
> 
> - full regular operations. RTnet mode disabled for all devices if the
>   "rtnet_disabled" module parameter is set to non-zero/true. In this
>   configuration, the driver operates all devices like the original
>   driver does, via the standard network stack.
> 
> In addition, the PHC device attached to the FEC is still available to
> the PTP stack, including when the driver operates devices in RTnet
> mode. There is no real-time guarantee though.
> 
> Tested on i.MX6Q.
> 
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> ---
>  kernel/drivers/net/drivers/Kconfig            |    9 +
>  kernel/drivers/net/drivers/Makefile           |    6 +-
>  kernel/drivers/net/drivers/fec.c              | 1859 -------
>  kernel/drivers/net/drivers/freescale/Makefile |    5 +
>  kernel/drivers/net/drivers/freescale/fec.h    |  610 +++
>  .../drivers/net/drivers/freescale/fec_main.c  | 4394 +++++++++++++++++
>  .../drivers/net/drivers/freescale/fec_ptp.c   |  640 +++
>  kernel/drivers/net/drivers/rt_fec.h           |  153 -
>  8 files changed, 5660 insertions(+), 2016 deletions(-)
>  delete mode 100644 kernel/drivers/net/drivers/fec.c
>  create mode 100644 kernel/drivers/net/drivers/freescale/Makefile
>  create mode 100644 kernel/drivers/net/drivers/freescale/fec.h
>  create mode 100644 kernel/drivers/net/drivers/freescale/fec_main.c
>  create mode 100644 kernel/drivers/net/drivers/freescale/fec_ptp.c
>  delete mode 100644 kernel/drivers/net/drivers/rt_fec.h
> 
> diff --git a/kernel/drivers/net/drivers/Kconfig b/kernel/drivers/net/drivers/Kconfig
> index 6889a500d..c36533479 100644
> --- a/kernel/drivers/net/drivers/Kconfig
> +++ b/kernel/drivers/net/drivers/Kconfig
> @@ -131,6 +131,15 @@ config XENO_DRIVERS_NET_DRV_MACB
>      Driver for internal MAC-controller on AT91SAM926x microcontrollers.
>      Porting by Cristiano Mantovani and Stefano Banzi (Marposs SpA).
>  
> +config XENO_DRIVERS_NET_FEC
> +    depends on XENO_DRIVERS_NET
> +    tristate "Freescale FEC"
> +    depends on ARCH_MXC || SOC_IMX28
> +    select PHYLIB
> +    imply PTP_1588_CLOCK
> +    ---help---

Deprected Kconfig style - again, please rebase patches before sending
and test against a /recent/ version.

Fixing up in next.

Jan

> +    For built-in 10/100 Fast ethernet controller on Freescale i.MX
> +    processors.
>  endif
>  
>  source "drivers/xenomai/net/drivers/experimental/Kconfig"

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

