Message-ID: <52ECF912.10308@xenomai.org>
Date: Sat, 01 Feb 2014 14:39:30 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAN1+YZVvgPNNHFub5QAkw6SeSUPuf1dv_94kYGqhbjMpNt70Sg@mail.gmail.com>
 <52D8609C.5050903@xenomai.org>
 <CAN1+YZW+nJgMb0hLy2JWZW6JrxA+mZzA+-oN-gjQgeGTcoe0jg@mail.gmail.com>
 <CAN1+YZUY_3FExF=qrUtMQDQxTqossnQsPCy6zfPjfqp8PitZCg@mail.gmail.com>
 <52D9984F.9080203@xenomai.org>
 <CAN1+YZWnLC=MLxWqYd9xH1URimWnOdEhU4mwZ0S3QFdpghUaGQ@mail.gmail.com>
 <52DAE756.3070606@xenomai.org>
 <CAN1+YZWmjvsu7My92EBktFhWYhheRJvdYrEq=r3+Ravp_Wzoyw@mail.gmail.com>
 <52DBC5FE.6060806@xenomai.org> <52DBD649.2000908@xenomai.org>
 <CAN1+YZWCMh4mR0ccw2v7FeuLKpYDUoPoB-FGHZmutj623DW7hw@mail.gmail.com>
 <52EB6BBC.8040600@xenomai.org>
 <CAN1+YZUhzb1zRE=dhjX+_1_b2cD2vEWatP6-je7b9NdNPosFvA@mail.gmail.com>
 <52EBE4B7.6060800@xenomai.org>
 <CAN1+YZXKAen4YAxKfG9TZTL8B5qXqA-u7O41-ZJqbHqCdbcyow@mail.gmail.com>
 <52EC054C.9070707@xenomai.org>
 <CAN1+YZX=cnRDcadrUHMzLaNBjNPnNbVuBnBHfEK-mTFYmx+3fA@mail.gmail.com>
 <52EC1079.2040300@xenomai.org>
 <CAN1+YZVq7cwFnUX=bkJs8MbAkpio3azSvev2fmZwqQpgjTnvfg@mail.gmail.com>
In-Reply-To: <CAN1+YZVq7cwFnUX=bkJs8MbAkpio3azSvev2fmZwqQpgjTnvfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Fwd: Kernel Compilation Problems
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Andy Pugh <andy@bodgesoc.org>
Cc: xenomai <xenomai@xenomai.org>

On 01/31/2014 11:58 PM, Andy Pugh wrote:
> On 31 January 2014 21:07, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
> 
>> Ok, I am still interested by your kernel logs though, to see whether we
>> can improve the latencies by using the cache auxiliary configuration
>> register.
> 
> Is this what you need, or do you need Xenomai actually active?
> 
> http://pastebin.com/PSKwQH3A

Could you try and apply the following patch?

When you are booted, try dmesg | grep AUX_CTRL, then run a latency test
and see if latency has improved?

Regards.

diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
index bfa706ff..bd3c8ce 100644
--- a/arch/arm/include/asm/hardware/cache-l2x0.h
+++ b/arch/arm/include/asm/hardware/cache-l2x0.h
@@ -61,7 +61,7 @@
 #define L2X0_CACHE_ID_PART_L210		(1 << 6)
 #define L2X0_CACHE_ID_PART_L310		(3 << 6)
 
-#define L2X0_AUX_CTRL_MASK			0xc0000fff
+#define L2X0_AUX_CTRL_MASK			0xc00007ff
 #define L2X0_AUX_CTRL_ASSOCIATIVITY_SHIFT	16
 #define L2X0_AUX_CTRL_WAY_SIZE_SHIFT		17
 #define L2X0_AUX_CTRL_WAY_SIZE_MASK		(0x7 << 17)
diff --git a/arch/arm/mach-mx6/mm.c b/arch/arm/mach-mx6/mm.c
index 3cf6b22..cec64b6 100644
--- a/arch/arm/mach-mx6/mm.c
+++ b/arch/arm/mach-mx6/mm.c
@@ -97,7 +97,7 @@ void __init mx6_map_io(void)
 #ifdef CONFIG_CACHE_L2X0
 int mxc_init_l2x0(void)
 {
-	unsigned int val;
+	unsigned int val, aux_ctrl;
 
 	#define IOMUXC_GPR11_L2CACHE_AS_OCRAM 0x00000002
 
@@ -114,12 +114,34 @@ int mxc_init_l2x0(void)
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
+	aux_ctrl = ((1 << L2X0_AUX_CTRL_ASSOCIATIVITY_SHIFT) |
+		(0x1 << L2X0_AUX_CTRL_NS_LOCKDOWN_SHIFT) |
+		(0x1 << L2X0_AUX_CTRL_NS_INT_CTRL_SHIFT) |
+		(1 << L2X0_AUX_CTRL_DATA_PREFETCH_SHIFT) |
+		(1 << L2X0_AUX_CTRL_INSTR_PREFETCH_SHIFT) |
+		(1 << L2X0_AUX_CTRL_EARLY_BRESP_SHIFT) |
+		(1 << 11));
+
+	l2x0_init(IO_ADDRESS(L2_BASE_ADDR), aux_ctrl, L2X0_AUX_CTRL_MASK);
+
+#ifdef CONFIG_IPIPE
+	writel_relaxed(0xEEEE, l2x0_base + 0x900);
+	writel_relaxed(0xEEEE, l2x0_base + 0x904);	
+	writel_relaxed(0xDDDD, l2x0_base + 0x908);
+	writel_relaxed(0xDDDD, l2x0_base + 0x90C);	
+	writel_relaxed(0xBBBB, l2x0_base + 0x910);
+	writel_relaxed(0xBBBB, l2x0_base + 0x914);	
+	writel_relaxed(0x7777, l2x0_base + 0x918);
+	writel_relaxed(0x7777, l2x0_base + 0x91C);	
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

