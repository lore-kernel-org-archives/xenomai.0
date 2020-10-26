From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 06/11] wrappers: Add mmiowb stub for kernels >= 5.2
Date: Mon, 26 Oct 2020 12:04:52 +0100
Message-Id: <b9bd8a0dc930d995d6f7bc70028c28f1fdbe36ee.1603710297.git.jan.kiszka@siemens.com>
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

This was folded into spin_unlock, thus obsoleted. Keep it for older
kernels.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/include/asm-generic/xenomai/wrappers.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
index b910138395..e266d5acf8 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
@@ -162,4 +162,8 @@ devm_hwmon_device_register_with_groups(struct device *dev, const char *name,
 #define SO_SNDTIMEO_OLD		SO_SNDTIMEO
 #endif
 
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(5,2,0)
+#define mmiowb()		do { } while (0)
+#endif
+
 #endif /* _COBALT_ASM_GENERIC_WRAPPERS_H */
-- 
2.26.2


