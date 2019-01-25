Subject: Re: [PATCH 05/12] net/stack: fresh rtskb should have ip_summed set to
 CHECKSUM_NONE
References: <20190124153428.21006-1-rpm@xenomai.org>
 <20190124153428.21006-6-rpm@xenomai.org>
 <5649a447-8187-2e69-91eb-dc9d4cd1f461@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <1fe5d27f-389f-7943-23bc-fb5b92c359a3@xenomai.org>
Date: Fri, 25 Jan 2019 10:26:07 +0100
MIME-Version: 1.0
In-Reply-To: <5649a447-8187-2e69-91eb-dc9d4cd1f461@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On 1/24/19 7:21 PM, Jan Kiszka wrote:
> Cleanup or fix?
> 
> I agree with the change, but if it's a fix, it should also go into stable.

There seem to be a general issue with checking for ip_summed. I can figure out how this is supposed to work in the regular IP stack, but I'm unsure about the RTnet logic regarding ip_summed. Specifically, the way rtskb_checksum_none_assert() is implemented puzzles me. I would expect some change along these lines for this code to ever make sense:

diff --git a/kernel/drivers/net/stack/include/rtskb.h b/kernel/drivers/net/stack/include/rtskb.h
index a1793e9a8..2d95d6ff8 100644
--- a/kernel/drivers/net/stack/include/rtskb.h
+++ b/kernel/drivers/net/stack/include/rtskb.h
@@ -282,6 +282,9 @@ extern unsigned int rtskb_amount_max;   /* maximum number of allocated rtskbs */
 #ifdef CONFIG_XENO_DRIVERS_NET_CHECKED
 extern void rtskb_over_panic(struct rtskb *skb, int len, void *here);
 extern void rtskb_under_panic(struct rtskb *skb, int len, void *here);
+#define rtskb_checksum_none_assert(skb) (WARN_ON_ONCE(skb->ip_summed != CHECKSUM_NONE))
+#else
+#define rtskb_checksum_none_assert(skb) do { (void)skb; } while (0)
 #endif
 
 extern struct rtskb *rtskb_pool_dequeue(struct rtskb_pool *pool);
@@ -294,8 +297,6 @@ extern void kfree_rtskb(struct rtskb *skb);
 #define dev_kfree_rtskb(a)  kfree_rtskb(a)
 
 
-#define rtskb_checksum_none_assert(skb) (skb->ip_summed = CHECKSUM_NONE)
-
 static inline void rtskb_tx_timestamp(struct rtskb *skb)
 {
 	nanosecs_abs_t *ts = skb->xmit_stamp;

-- 
Philippe.

