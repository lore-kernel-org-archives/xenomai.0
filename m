From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 08/11] drivers/e1000: Fix unintended fallthrough
Date: Mon, 26 Oct 2020 12:04:54 +0100
Message-Id: <00e5e0309f255f48dc8672078e14e5812451f346.1603710297.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1603710297.git.jan.kiszka@siemens.com>
References: <cover.1603710297.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Fino Meng <fino.meng@linux.intel.com>, Mingliang Hu <mingliang.hu@intel.com>

From: Jan Kiszka <jan.kiszka@siemens.com>

Not desired here according ancient git logs.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/net/drivers/e1000/e1000_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/drivers/net/drivers/e1000/e1000_main.c b/kernel/drivers/net/drivers/e1000/e1000_main.c
index 329c69c7b8..3df35e033c 100644
--- a/kernel/drivers/net/drivers/e1000/e1000_main.c
+++ b/kernel/drivers/net/drivers/e1000/e1000_main.c
@@ -396,6 +396,7 @@ e1000_release_hw_control(struct e1000_adapter *adapter)
 		swsm = E1000_READ_REG(&adapter->hw, SWSM);
 		E1000_WRITE_REG(&adapter->hw, SWSM,
 				swsm & ~E1000_SWSM_DRV_LOAD);
+		break;
 	case e1000_ich8lan:
 		extcnf = E1000_READ_REG(&adapter->hw, CTRL_EXT);
 		E1000_WRITE_REG(&adapter->hw, CTRL_EXT,
-- 
2.26.2


