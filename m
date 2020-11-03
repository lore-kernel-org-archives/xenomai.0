From: chensong <chensong@tj.kylinos.cn>
Subject: [PATCH 1/5] [y2038]wrappers:introduce old_timespec32
Date: Tue,  3 Nov 2020 11:04:38 +0800
Message-Id: <1604372678-2806-1-git-send-email-chensong@tj.kylinos.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, jan.kiszka@siemens.com, henning.schild@siemens.com

old_timespec32 was introduced in vanilla kernel at version 4.19
for y2038 problem, therefore, xenomai should introduce it in wrappers
as well to get compatible with old kernel versions.

Signed-off-by: chensong <chensong@tj.kylinos.cn>
---
 kernel/cobalt/include/asm-generic/xenomai/wrappers.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
index 23993dc..07faa26 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
@@ -156,4 +156,13 @@ devm_hwmon_device_register_with_groups(struct device *dev, const char *name,
 #error "Xenomai/cobalt requires Linux kernel 3.10 or above"
 #endif /* < 3.10 */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 19, 0)
+typedef s32		old_time32_t;
+
+struct old_timespec32 {
+	old_time32_t	tv_sec;
+	s32		tv_nsec;
+};
+#endif /* < 4.19 */
+
 #endif /* _COBALT_ASM_GENERIC_WRAPPERS_H */
-- 
2.7.4




