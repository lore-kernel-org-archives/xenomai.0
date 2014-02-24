Message-ID: <530B374B.1080507@xenomai.org>
Date: Mon, 24 Feb 2014 13:12:59 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1392993075.52404.YahooMailNeo@web140605.mail.bf1.yahoo.com>
 <530766CD.3060707@xenomai.org>
 <1393198348.29895.YahooMailNeo@web140605.mail.bf1.yahoo.com>
 <530A862C.1060805@xenomai.org>
 <1393204287.98060.YahooMailNeo@web140606.mail.bf1.yahoo.com>
In-Reply-To: <1393204287.98060.YahooMailNeo@web140606.mail.bf1.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] User Space Problems
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Bruno Tunes de Mello <bruno_v05_2005@yahoo.com.br>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 02/24/2014 02:11 AM, Bruno Tunes de Mello wrote:
> Hi Gilles,
> 
> I did the changes, but the kernel is not booting.

Ok, you are the second to report this issue, so the patch must
be touching bits it should not touch. Please try that one instead:

diff --git a/arch/arm/mach-mx6/mm.c b/arch/arm/mach-mx6/mm.c
index 3cf6b22..d89393c 100644
--- a/arch/arm/mach-mx6/mm.c
+++ b/arch/arm/mach-mx6/mm.c
@@ -97,7 +97,7 @@ void __init mx6_map_io(void)
 #ifdef CONFIG_CACHE_L2X0
 int mxc_init_l2x0(void)
 {
-	unsigned int val;
+	unsigned int val, aux_ctrl;
 
 	#define IOMUXC_GPR11_L2CACHE_AS_OCRAM 0x00000002
 
@@ -114,12 +114,28 @@ int mxc_init_l2x0(void)
 	val = readl(IO_ADDRESS(L2_BASE_ADDR + L2X0_PREFETCH_CTRL));
 	val |= 0x40800000;
 	writel(val, IO_ADDRESS(L2_BASE_ADDR + L2X0_PREFETCH_CTRL));
+#ifndef CONFIG_IPIPE
 	val = readl(IO_ADDRESS(L2_BASE_ADDR + L2X0_POWER_CTRL));
 	val |= L2X0_DYNAMIC_CLK_GATING_EN;
 	val |= L2X0_STNDBY_MODE_EN;
 	writel(val, IO_ADDRESS(L2_BASE_ADDR + L2X0_POWER_CTRL));
+#endif
+
+#if 0
+	aux_ctrl = ((1 << L2X0_AUX_CTRL_ASSOCIATIVITY_SHIFT) |
+		(0x1 << L2X0_AUX_CTRL_NS_LOCKDOWN_SHIFT) |
+		(0x1 << L2X0_AUX_CTRL_NS_INT_CTRL_SHIFT) |
+		(1 << 23) |
+		(1 << L2X0_AUX_CTRL_SHARE_OVERRIDE_SHIFT) |
+		(1 << L2X0_AUX_CTRL_DATA_PREFETCH_SHIFT) |
+		(1 << L2X0_AUX_CTRL_INSTR_PREFETCH_SHIFT) |
+		(1 << L2X0_AUX_CTRL_EARLY_BRESP_SHIFT));
+
+	l2x0_init(IO_ADDRESS(L2_BASE_ADDR), aux_ctrl, L2X0_AUX_CTRL_MASK);
+#else
+	l2x0_init(IO_ADDRESS(L2_BASE_ADDR), 1 << 23, ~(1 << 23));
+#endif
 
-	l2x0_init(IO_ADDRESS(L2_BASE_ADDR), 0x0, ~0x00000000);
 	return 0;
 }
 
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 1e2c52d..27550b3 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -421,6 +421,9 @@ void l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
 		writel_relaxed(1, l2x0_base + L2X0_CTRL);
 	}
 
+	/* Re-read it in case some bits are reserved. */
+	aux = readl_relaxed(l2x0_base + L2X0_AUX_CTRL);
+
 	outer_cache.inv_range = l2x0_inv_range;
 	outer_cache.clean_range = l2x0_clean_range;
 	outer_cache.flush_range = l2x0_flush_range;

-- 
                                                                Gilles.

