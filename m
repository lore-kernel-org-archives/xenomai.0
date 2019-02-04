Subject: Re: [PATCH 17/18] net/stack: fix assertion testing checksum init value
References: <20190204105647.5034-1-rpm@xenomai.org>
 <20190204105647.5034-18-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <66e888a6-bda1-e207-fd20-8520df9157e4@siemens.com>
Date: Mon, 4 Feb 2019 19:43:38 +0100
MIME-Version: 1.0
In-Reply-To: <20190204105647.5034-18-rpm@xenomai.org>
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

On 04.02.19 11:56, Philippe Gerum wrote:
> ---
>   kernel/drivers/net/stack/include/rtskb.h | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/drivers/net/stack/include/rtskb.h b/kernel/drivers/net/stack/include/rtskb.h
> index a1793e9a8..2d95d6ff8 100644
> --- a/kernel/drivers/net/stack/include/rtskb.h
> +++ b/kernel/drivers/net/stack/include/rtskb.h
> @@ -282,6 +282,9 @@ extern unsigned int rtskb_amount_max;   /* maximum number of allocated rtskbs */
>   #ifdef CONFIG_XENO_DRIVERS_NET_CHECKED
>   extern void rtskb_over_panic(struct rtskb *skb, int len, void *here);
>   extern void rtskb_under_panic(struct rtskb *skb, int len, void *here);
> +#define rtskb_checksum_none_assert(skb) (WARN_ON_ONCE(skb->ip_summed != CHECKSUM_NONE))
> +#else
> +#define rtskb_checksum_none_assert(skb) do { (void)skb; } while (0)
>   #endif
>   
>   extern struct rtskb *rtskb_pool_dequeue(struct rtskb_pool *pool);
> @@ -294,8 +297,6 @@ extern void kfree_rtskb(struct rtskb *skb);
>   #define dev_kfree_rtskb(a)  kfree_rtskb(a)
>   
>   
> -#define rtskb_checksum_none_assert(skb) (skb->ip_summed = CHECKSUM_NONE)
> -
>   static inline void rtskb_tx_timestamp(struct rtskb *skb)
>   {
>   	nanosecs_abs_t *ts = skb->xmit_stamp;
> 

This commit disables the check, effectively. CONFIG_XENO_DRIVERS_NET_CHECKED 
likely corresponds to CONFIG_RTNET_CHECKED in the original code base. There, it 
was a Kconfig switch for internal bug checks, but that got lost during migration.

rtskb_checksum_none_assert corresponds to skb_checksum_none_assert in the 
kernel. The kernel's variant is in heavy use. In RTnet, we never left it in, 
except for the macb. For that, Gilles added 0d903b8b4f1c. At the same time, the 
last driver I touched, e1000e, simple got this removed: 
https://sourceforge.net/p/rtnet/code/ci/7dbf1a4b910d849f28ea74783541e8f40572912d

So I would rather vote for removing the wrapper completely.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

