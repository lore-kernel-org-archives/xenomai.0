Message-ID: <52E829FE.5040106@xenomai.org>
Date: Tue, 28 Jan 2014 23:06:54 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <52DF9C5F.70005@geral.com> <52DFAA18.6080703@xenomai.org>
 <52DFAD29.4000800@geral.com> <52DFB2DE.4050501@xenomai.org>
 <52DFC734.2090906@geral.com> <52DFC80D.6050101@xenomai.org>
 <52DFCFDE.9060700@geral.com> <52DFD1B0.6070303@xenomai.org>
 <52E5616F.90002@grandegger.com> <52E56221.5070005@xenomai.org>
 <52E56D0F.2040909@grandegger.com> <52E5766A.1040306@xenomai.org>
 <701f63f992829713e3d3d6b872165208@grandegger.com>
In-Reply-To: <701f63f992829713e3d3d6b872165208@grandegger.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] imx28 rtcan flexcan system freezes
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: xenomai@xenomai.org

On 01/27/2014 08:56 AM, Wolfgang Grandegger wrote:
> On Sun, 26 Jan 2014 21:56:10 +0100, Gilles Chanteperdrix
>> IMO, it is not just for the flexcan driver, it will avoid unaligned
> 
>> accesses for all drivers which access data 4 bytes at a time. And I do
> 
>> not think it "breaks" anything. What I do not know is:
> 
> 
> 
> But it's just the Flexcan driver which is doing unaligned accesses.

Ok, can we agree on the following patch then?

diff --git a/ksrc/drivers/can/rtcan_flexcan.c b/ksrc/drivers/can/rtcan_flexcan.c
index 8f0e8d1..1674b73 100644
--- a/ksrc/drivers/can/rtcan_flexcan.c
+++ b/ksrc/drivers/can/rtcan_flexcan.c
@@ -38,6 +38,7 @@
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
 #include <linux/pinctrl/consumer.h>
 #endif
+#include <asm/unaligned.h>
 
 #include <rtdm/rtdm_driver.h>
 
@@ -497,11 +498,9 @@ static void flexcan_rx_interrupt(struct rtcan_device *dev,
 		cf->can_id |= CAN_RTR_FLAG;
 		skb->rb_frame_size = EMPTY_RB_FRAME_SIZE;
 	} else {
-		skb->rb_frame_size = EMPTY_RB_FRAME_SIZE + cf->can_dlc ;
-		*(__be32 *)(cf->data + 0) =
-			cpu_to_be32(flexcan_read(&mb->data[0]));
-		*(__be32 *)(cf->data + 4) =
-			cpu_to_be32(flexcan_read(&mb->data[1]));
+		skb->rb_frame_size = EMPTY_RB_FRAME_SIZE + cf->can_dlc;
+		put_unaligned_be32(flexcan_read(&mb->data[0]), cf->data + 0);
+		put_unaligned_be32(flexcan_read(&mb->data[1]), cf->data + 4);
 	}
 
 	/* Store the interface index */



-- 
                                                                Gilles.

