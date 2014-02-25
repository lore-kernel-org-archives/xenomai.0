Message-ID: <530C6AC6.6030200@xenomai.org>
Date: Tue, 25 Feb 2014 11:04:54 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1392993075.52404.YahooMailNeo@web140605.mail.bf1.yahoo.com>
 <530766CD.3060707@xenomai.org>
 <1393198348.29895.YahooMailNeo@web140605.mail.bf1.yahoo.com>
 <530A862C.1060805@xenomai.org>
 <1393204287.98060.YahooMailNeo@web140606.mail.bf1.yahoo.com>
 <530B374B.1080507@xenomai.org>
 <1393298793.43978.YahooMailNeo@web140605.mail.bf1.yahoo.com>
In-Reply-To: <1393298793.43978.YahooMailNeo@web140605.mail.bf1.yahoo.com>
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

On 02/25/2014 04:26 AM, Bruno Tunes de Mello wrote:
> Hi Gilles,
> The kernel is booting and I executed latency and xeno-test commands. The results are below.

You also need this patch.

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index d9cb476..1e2c52d 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -41,7 +41,7 @@ static inline void cache_wait_way(void __iomem *reg, unsigned long mask)
 {
 	/* wait for cache operation by line or way to complete */
 	while (readl_relaxed(reg) & mask)
-		;
+		cpu_relax();
 }
 
 #ifdef CONFIG_CACHE_PL310
@@ -136,6 +136,7 @@ static void __l2x0_flush_all(void)
 	debug_writel(0x00);
 }
 
+#ifndef CONFIG_IPIPE
 static void l2x0_flush_all(void)
 {
 	unsigned long flags;
@@ -157,6 +158,81 @@ static void l2x0_clean_all(void)
 	cache_sync();
 	spin_unlock_irqrestore(&l2x0_lock, flags);
 }
+#else
+static void l2x0_clean_inv_line_idx(unsigned line, unsigned way)
+{
+	void __iomem *base = l2x0_base;
+
+	writel_relaxed((way << 28) | (line << 5), 
+		base + L2X0_CLEAN_INV_LINE_IDX);
+	cache_wait(base + L2X0_CLEAN_INV_LINE_IDX, 1);
+}
+
+static void l2x0_flush_way(unsigned way, unsigned len, unsigned lines)
+{
+	unsigned long flags;
+	unsigned line, i;
+	
+	for (line = 0; line < lines; line += len ) {
+		spin_lock_irqsave(&l2x0_lock, flags);
+		debug_writel(0x03);
+		for (i = 0; i < len && line + i < lines; i++)
+			l2x0_clean_inv_line_idx(line + i, way);
+		cache_sync();
+		debug_writel(0x00);
+		spin_unlock_irqrestore(&l2x0_lock, flags);
+	}
+}
+
+static void l2x0_flush_all(void)
+{
+	unsigned lines, len, way, ways;
+
+	ways = fls(l2x0_way_mask);
+	lines = l2x0_size / (ways * CACHE_LINE_SIZE);
+	len = L2X0_SPINLOCK_LEN / CACHE_LINE_SIZE;
+
+	for (way = 0; way < ways; way++)
+		l2x0_flush_way(way, len, lines);
+}
+
+static void l2x0_clean_line_idx(unsigned line, unsigned way)
+{
+	void __iomem *base = l2x0_base;
+
+	writel_relaxed((way << 28) | (line << 5), 
+		base + L2X0_CLEAN_LINE_IDX);
+	cache_wait(base + L2X0_CLEAN_LINE_IDX, 1);
+}
+
+static void l2x0_clean_way(unsigned way, unsigned len, unsigned lines)
+{
+	unsigned long flags;
+	unsigned line, i;
+	
+	for (line = 0; line < lines; line += len ) {
+		spin_lock_irqsave(&l2x0_lock, flags);
+		debug_writel(0x03);
+		for (i = 0; i < len && line + i < lines; i++)
+			l2x0_clean_line_idx(line + i, way);
+		cache_sync();
+		debug_writel(0x00);
+		spin_unlock_irqrestore(&l2x0_lock, flags);
+	}
+}
+
+static void l2x0_clean_all(void)
+{
+	unsigned lines, len, way, ways;
+
+	ways = fls(l2x0_way_mask);
+	lines = l2x0_size / (ways * CACHE_LINE_SIZE);
+	len = L2X0_SPINLOCK_LEN / CACHE_LINE_SIZE;
+
+	for (way = 0; way < ways; way++)
+		l2x0_clean_way(way, len, lines);
+}
+#endif
 
 static void l2x0_inv_all(void)
 {

-- 
                                                                Gilles.

