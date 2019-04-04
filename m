From: roman.stratiienko@globallogic.com
Subject: [PATCH] kernel: drivers: igb: use READ_ONCE instead of ACCESS_ONCE
Date: Thu,  4 Apr 2019 19:57:17 +0300
Message-Id: <20190404165717.7124-1-roman.stratiienko@globallogic.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Roman Stratiienko <roman.stratiienko@globallogic.com>

From: Roman Stratiienko <roman.stratiienko@globallogic.com>

ACCESS_ONCE isn't available starting from kernel v4.15.

Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
---
 kernel/drivers/net/drivers/igb/e1000_regs.h | 2 +-
 kernel/drivers/net/drivers/igb/igb_main.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/drivers/net/drivers/igb/e1000_regs.h b/kernel/drivers/net/drivers/igb/e1000_regs.h
index 30df9bad4..0d1d1406d 100644
--- a/kernel/drivers/net/drivers/igb/e1000_regs.h
+++ b/kernel/drivers/net/drivers/igb/e1000_regs.h
@@ -372,7 +372,7 @@ u32 igb_rd32(struct e1000_hw *hw, u32 reg);
 /* write operations, indexed using DWORDS */
 #define wr32(reg, val) \
 do { \
-	u8 __iomem *hw_addr = ACCESS_ONCE((hw)->hw_addr); \
+	u8 __iomem *hw_addr = READ_ONCE((hw)->hw_addr); \
 	if (!E1000_REMOVED(hw_addr)) \
 		writel((val), &hw_addr[(reg)]); \
 } while (0)
diff --git a/kernel/drivers/net/drivers/igb/igb_main.c b/kernel/drivers/net/drivers/igb/igb_main.c
index c1d1000ea..093ff3480 100644
--- a/kernel/drivers/net/drivers/igb/igb_main.c
+++ b/kernel/drivers/net/drivers/igb/igb_main.c
@@ -654,7 +654,7 @@ static void igb_cache_ring_register(struct igb_adapter *adapter)
 u32 igb_rd32(struct e1000_hw *hw, u32 reg)
 {
 	struct igb_adapter *igb = container_of(hw, struct igb_adapter, hw);
-	u8 __iomem *hw_addr = ACCESS_ONCE(hw->hw_addr);
+	u8 __iomem *hw_addr = READ_ONCE(hw->hw_addr);
 	u32 value = 0;
 
 	if (E1000_REMOVED(hw_addr))
-- 
2.17.1


