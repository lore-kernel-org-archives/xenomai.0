From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 08/11] drivers/net: Do not load when the core is not available
Date: Fri, 13 Sep 2019 15:18:57 +0200
Message-Id: <a755ddb97bac3b18c1543e749e253171773095bf.1568380740.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1568380740.git.jan.kiszka@siemens.com>
References: <cover.1568380740.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1568380740.git.jan.kiszka@siemens.com>
References: <cover.1568380740.git.jan.kiszka@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Using the new rtdm_available() interface, this prevents any RTnet module
from being loaded when the real-time core is not available.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/net/stack/rtnet_module.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/drivers/net/stack/rtnet_module.c b/kernel/drivers/net/stack/rtnet_module.c
index f9f18ce221..16dc91fda0 100644
--- a/kernel/drivers/net/stack/rtnet_module.c
+++ b/kernel/drivers/net/stack/rtnet_module.c
@@ -318,6 +318,9 @@ int __init rtnet_init(void)
 {
 	int err = 0;
 
+	if (!rtdm_available())
+		return -ENOSYS;
+
 	printk("\n*** RTnet for Xenomai v" XENO_VERSION_STRING " ***\n\n");
 	printk("RTnet: initialising real-time networking\n");
 
-- 
2.16.4


