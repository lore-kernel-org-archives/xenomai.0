Subject: Re: [PATCH 5/7] Kconfig : enable fec for ARM64 build
References: <20210728072802.5816-1-jean-baptiste.tredez@ba-healthcare.com>
 <20210728072802.5816-6-jean-baptiste.tredez@ba-healthcare.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <7ef21b00-a938-868d-a0d6-6b97442c80ee@siemens.com>
Date: Mon, 2 Aug 2021 10:14:06 +0200
MIME-Version: 1.0
In-Reply-To: <20210728072802.5816-6-jean-baptiste.tredez@ba-healthcare.com>
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

On 28.07.21 09:28, Jean-Baptiste Trédez via Xenomai wrote:
> Signed-off-by: Jean-Baptiste Trédez <jean-baptiste.tredez@ba-healthcare.com>
> ---
>  kernel/drivers/net/drivers/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/drivers/net/drivers/Kconfig b/kernel/drivers/net/drivers/Kconfig
> index c36533479..60889aa70 100644
> --- a/kernel/drivers/net/drivers/Kconfig
> +++ b/kernel/drivers/net/drivers/Kconfig
> @@ -116,7 +116,7 @@ config XENO_DRIVERS_NET_DRV_SMC91111
>      depends on XENO_DRIVERS_NET
>      tristate "SMSC LAN91C111"
>  
> -if ARM
> +if ARM || ARM64
>  
>  config XENO_DRIVERS_NET_DRV_AT91_ETHER
>      depends on XENO_DRIVERS_NET && SOC_AT91RM9200
> 

This one is overshooting. I've adjusted it to actually target what the
subject was aiming at.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

