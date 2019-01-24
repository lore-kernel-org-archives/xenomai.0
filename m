Subject: Re: [PATCH 06/12] net/rtdev: ensure per-device skbs get mapped at
 registration
References: <20190124153428.21006-1-rpm@xenomai.org>
 <20190124153428.21006-7-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <1696c16b-500d-67b9-a73c-470f19c03424@siemens.com>
Date: Thu, 24 Jan 2019 19:24:47 +0100
MIME-Version: 1.0
In-Reply-To: <20190124153428.21006-7-rpm@xenomai.org>
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

On 24.01.19 16:34, Philippe Gerum wrote:
> This patch works around a regression introduced by #74464ee37d0,
> causing a new device's skbs not to be passed to its ->map_rtskb()
> handler when registered, breaking further DMA inits in the driver.
> 
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> ---
>   kernel/drivers/net/stack/rtdev.c | 37 +++++++++++++++++++++++---------
>   1 file changed, 27 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/drivers/net/stack/rtdev.c b/kernel/drivers/net/stack/rtdev.c
> index 631ca1804..286d08cb1 100644
> --- a/kernel/drivers/net/stack/rtdev.c
> +++ b/kernel/drivers/net/stack/rtdev.c
> @@ -45,6 +45,7 @@ struct rtnet_device         *rtnet_devices[MAX_RT_DEVICES];
>   static struct rtnet_device  *loopback_device;
>   static DEFINE_RTDM_LOCK(rtnet_devices_rt_lock);
>   static LIST_HEAD(rtskb_mapped_list);
> +static LIST_HEAD(rtskb_mapwait_list);
>   
>   LIST_HEAD(event_hook_list);
>   DEFINE_MUTEX(rtnet_devices_nrt_lock);
> @@ -459,8 +460,12 @@ int rtdev_map_rtskb(struct rtskb *skb)
>   	}
>       }
>   
> -    if (!err && skb->buf_dma_addr != RTSKB_UNMAPPED)
> -	list_add(&skb->entry, &rtskb_mapped_list);
> +    if (!err) {
> +	    if (skb->buf_dma_addr != RTSKB_UNMAPPED)
> +		    list_add(&skb->entry, &rtskb_mapped_list);
> +	    else
> +		    list_add(&skb->entry, &rtskb_mapwait_list);
> +    }
>   
>       mutex_unlock(&rtnet_devices_nrt_lock);
>   
> @@ -471,19 +476,31 @@ int rtdev_map_rtskb(struct rtskb *skb)
>   
>   static int rtdev_map_all_rtskbs(struct rtnet_device *rtdev)
>   {
> -    struct rtskb *skb;
> -    int err = 0;
> +    struct rtskb *skb, *n;
> +    int err;
>   
>       if (!rtdev->map_rtskb)
> -	return 0;
> +	    return 0;
>   
> -    list_for_each_entry(skb, &rtskb_mapped_list, entry) {
> -	err = rtskb_map(rtdev, skb);
> -	if (err)
> -	   break;
> +    if (!list_empty(&rtskb_mapped_list)) {

Why this extra check? list_for_each_entry should just do nothing if the list is 
empty.

> +	    list_for_each_entry(skb, &rtskb_mapped_list, entry) {
> +		    err = rtskb_map(rtdev, skb);
> +		    if (err)
> +			    return err;
> +	    }
>       }
>   
> -    return err;
> +    if (!list_empty(&rtskb_mapwait_list)) {

Same here.

> +	    list_for_each_entry_safe(skb, n, &rtskb_mapwait_list, entry) {
> +		    err = rtskb_map(rtdev, skb);
> +		    if (err)
> +			    return err;
> +		    list_del(&skb->entry);
> +		    list_add(&skb->entry, &rtskb_mapped_list);
> +	    }
> +    }
> +
> +    return 0;
>   }
>   
>   
> 

Style mix: Eventually, we should switch all RTnet code to kernel style. For now, 
we have 4-space-indention, and we should keep it until then. Mixing things will 
only make it more messy.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

