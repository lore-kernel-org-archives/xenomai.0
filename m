Subject: Re: [PATCH] rtnet: experimental: 3c59x: fix config name in makefile
References: <20190404165218.7063-1-roman.stratiienko@globallogic.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <73cb5e38-5823-a199-6d4f-1b5cb88af221@siemens.com>
Date: Thu, 4 Apr 2019 19:28:52 +0200
MIME-Version: 1.0
In-Reply-To: <20190404165218.7063-1-roman.stratiienko@globallogic.com>
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
To: roman.stratiienko@globallogic.com, xenomai@xenomai.org

On 04.04.19 18:52, roman.stratiienko--- via Xenomai wrote:
> From: Roman Stratiienko <roman.stratiienko@globallogic.com>
> 
> Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
> ---
> This also breaks the build, see:
> https://travis-ci.org/devel-opi/xenomai-fork/jobs/515800815#L8087
> 
>   kernel/drivers/net/drivers/experimental/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/drivers/net/drivers/experimental/Makefile b/kernel/drivers/net/drivers/experimental/Makefile
> index ad2317790..5748c2843 100644
> --- a/kernel/drivers/net/drivers/experimental/Makefile
> +++ b/kernel/drivers/net/drivers/experimental/Makefile
> @@ -4,6 +4,6 @@ obj-$(CONFIG_XENO_DRIVERS_NET_DRV_RT2500) += rt2500/
>   
>   obj-$(CONFIG_XENO_DRIVERS_NET_DRV_E1000_NEW) += e1000/
>   
> -obj-$(CONFIG_RTNET_DRV_3C59X) += rt_3c59x.o
> +obj-$(CONFIG_XENO_DRIVERS_NET_DRV_3C59X) += rt_3c59x.o
>   
>   rt_3c59x-y := 3c59x.o
> 

I suppose this hardware is no longer worth re-enabling. It was apparently 
unusable since the merge of RTnet into Xenomai, and it is broken - let's remove it.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

