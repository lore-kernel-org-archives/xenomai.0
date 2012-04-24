Message-ID: <4F965FA6.2070009@domain.hid>
Date: Tue, 24 Apr 2012 10:09:10 +0200
From: Michael Trimarchi <michael@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [PATCH 3/3] Fix imx time reprogramming issue
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Adeos <adeos-main@gna.org>
Cc: b.morelli@domain.hid

This patch includes:

* Fix invalid virtual address base of MX1_2_TCM
* Fix the minimum delay below which the hardware timer can not be reprogrammed.
  The value is the same of that one that is used to calculate the min_delta_ns

arch/arm/plat-mxc/time.c
414: clockevent_mxc.min_delta_ns = clockevent_delta2ns(0xff, &clockevent_mxc);

Signed-off-by: Michael Trimarchi <michael@domain.hid>
Signed-off-by: Bruno Morelli <b.morelli@domain.hid>
---
 arch/arm/plat-mxc/time.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-mxc/time.c b/arch/arm/plat-mxc/time.c
index aae2717..30916f8 100644
--- a/arch/arm/plat-mxc/time.c
+++ b/arch/arm/plat-mxc/time.c
@@ -400,11 +400,11 @@ mxc_timer_init(struct clk *timer_clk,
 	__ipipe_mach_timerint = irq;
 	__ipipe_mach_ticks_per_jiffy = (clk_get_rate(timer_clk) + HZ/2) / HZ;
 	tsc_info.freq = clk_get_rate(timer_clk);
-	mxc_min_delay = ((__ipipe_cpu_freq + 500000) / 1000000) ?: 1;
+	mxc_min_delay = 0xff;
 
 	if (timer_is_v1()) {
 		tsc_info.u.counter_paddr = phys + MX1_2_TCN;
-		tsc_info.counter_vaddr =(unsigned long)(phys + MX1_2_TCN);
+		tsc_info.counter_vaddr = (unsigned long)(timer_base + MX1_2_TCN);
 	} else {
 		tsc_info.u.counter_paddr = phys + V2_TCN;
 		tsc_info.counter_vaddr = (unsigned long)(timer_base + V2_TCN);
-- 
1.7.5.4

-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |



