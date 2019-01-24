Subject: Re: [PATCH 05/12] net/stack: fresh rtskb should have ip_summed set to
 CHECKSUM_NONE
References: <20190124153428.21006-1-rpm@xenomai.org>
 <20190124153428.21006-6-rpm@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5649a447-8187-2e69-91eb-dc9d4cd1f461@siemens.com>
Date: Thu, 24 Jan 2019 19:21:17 +0100
MIME-Version: 1.0
In-Reply-To: <20190124153428.21006-6-rpm@xenomai.org>
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

Cleanup or fix?

I agree with the change, but if it's a fix, it should also go into stable.

On 24.01.19 16:34, Philippe Gerum wrote:
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> ---
>   kernel/drivers/net/stack/rtskb.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/drivers/net/stack/rtskb.c b/kernel/drivers/net/stack/rtskb.c
> index f5609027b..cc7563719 100644
> --- a/kernel/drivers/net/stack/rtskb.c
> +++ b/kernel/drivers/net/stack/rtskb.c
> @@ -223,6 +223,7 @@ struct rtskb *alloc_rtskb(unsigned int size, struct rtskb_pool *pool)
>       skb->len = 0;
>       skb->pkt_type = PACKET_HOST;
>       skb->xmit_stamp = NULL;
> +    skb->ip_summed = CHECKSUM_NONE;
>   
>   #if IS_ENABLED(CONFIG_XENO_DRIVERS_NET_ADDON_RTCAP)
>       skb->cap_flags = 0;
> 

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

