From: chensong <chensong@tj.kylinos.cn>
Subject: [PATCH 1/4] include: wrappers: introduce old_timespec32 and
 __kernel_timespec
Date: Thu, 11 Mar 2021 10:46:00 +0800
Message-Id: <1615430760-23736-1-git-send-email-chensong@tj.kylinos.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: florian.bezdeka@siemens.com, xenomai@xenomai.org, rpm@xenomai.org

old_timespec32 and __kernel_timespec were introduced to linux kernel specific
for y2038 problem, xenomai needs them as well, but it will break the build if
kernel version is old.

To be back compatibale with old version kernel. we introduce them in wrappers.h.

Signed-off-by: chensong <chensong@tj.kylinos.cn>
---
 kernel/cobalt/include/asm-generic/xenomai/wrappers.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
index f15fe43..a630247 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
@@ -235,4 +235,21 @@ devm_hwmon_device_register_with_groups(struct device *dev, const char *name,
 	kernel_read_file(__file, 0, __buf, __buf_size, __file_size, __id)
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 19, 0)
+typedef s32		old_time32_t;
+
+struct old_timespec32 {
+	old_time32_t	tv_sec;
+	s32		tv_nsec;
+};
+#endif /* < 4.19 */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 18, 0)
+typedef long long __kernel_time64_t;
+struct __kernel_timespec {
+	__kernel_time64_t       tv_sec;                 /* seconds */
+	long long               tv_nsec;                /* nanoseconds */
+};
+#endif /* < 4.18 */
+
 #endif /* _COBALT_ASM_GENERIC_WRAPPERS_H */
-- 
2.7.4




