Subject: Re: [PATCH 1/2] drivers/net: Kconfig: fix tests for architecture
References: <20190830160514.29592-1-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <8dd41903-b86b-89c0-4cb8-180e17ec655c@siemens.com>
Date: Fri, 30 Aug 2019 19:01:07 +0200
MIME-Version: 1.0
In-Reply-To: <20190830160514.29592-1-rpm@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 30.08.19 18:05, Philippe Gerum wrote:
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> ---
>   kernel/drivers/net/drivers/Kconfig | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/drivers/net/drivers/Kconfig b/kernel/drivers/net/drivers/Kconfig
> index 9ebc59a89..65f0855c1 100644
> --- a/kernel/drivers/net/drivers/Kconfig
> +++ b/kernel/drivers/net/drivers/Kconfig
> @@ -77,7 +77,7 @@ config XENO_DRIVERS_NET_DRV_R8169
>       tristate "Realtek 8169 (Gigabit)"
>   
>   
> -if ARCH = ppc
> +if PPC
>   
>   comment "Embedded MPC Drivers"
>       depends on XENO_DRIVERS_NET
> @@ -116,7 +116,7 @@ config XENO_DRIVERS_NET_DRV_SMC91111
>       depends on XENO_DRIVERS_NET
>       tristate "SMSC LAN91C111"
>   
> -if ARCH = arm
> +if ARM
>   
>   config XENO_DRIVERS_NET_DRV_AT91_ETHER
>       depends on XENO_DRIVERS_NET && SOC_AT91RM9200
> 

Thanks, applied to next, queued for stable.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

