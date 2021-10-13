From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 2/9] cobalt: Use close_fd for kernel 5.14+
Date: Wed, 13 Oct 2021 13:55:46 +0200
Message-Id: <5b4020692086af9bf8a760eda8a5b625992023cc.1634126152.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1634126152.git.jan.kiszka@siemens.com>
References: <cover.1634126152.git.jan.kiszka@siemens.com>
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

From: Jan Kiszka <jan.kiszka@siemens.com>

Wrap it on __close_fd for older kernels.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/include/asm-generic/xenomai/wrappers.h | 4 ++++
 kernel/cobalt/rtdm/core.c                            | 4 ++--
 kernel/cobalt/rtdm/fd.c                              | 2 +-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
index d3423016e9..cb3f2b242f 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
@@ -238,4 +238,8 @@ devm_hwmon_device_register_with_groups(struct device *dev, const char *name,
 }
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(5,14,0)
+#define close_fd(__ufd)	__close_fd(current->files, __ufd)
+#endif
+
 #endif /* _COBALT_ASM_GENERIC_WRAPPERS_H */
diff --git a/kernel/cobalt/rtdm/core.c b/kernel/cobalt/rtdm/core.c
index 2e5aeb44e2..dcced045df 100644
--- a/kernel/cobalt/rtdm/core.c
+++ b/kernel/cobalt/rtdm/core.c
@@ -66,7 +66,7 @@ int __rtdm_anon_getfd(const char *name, int flags)
 
 void __rtdm_anon_putfd(int ufd)
 {
-	__close_fd(current->files, ufd);
+	close_fd(ufd);
 }
 
 static int create_instance(int ufd, struct rtdm_device *dev,
@@ -247,7 +247,7 @@ int __rtdm_dev_socket(int protocol_family, int socket_type,
 fail_socket:
 	cleanup_instance(dev, context);
 fail_create:
-	__close_fd(current->files, ufd);
+	close_fd(ufd);
 fail_getfd:
 	__rtdm_put_device(dev);
 
diff --git a/kernel/cobalt/rtdm/fd.c b/kernel/cobalt/rtdm/fd.c
index c314d9f650..bbeea06ae9 100644
--- a/kernel/cobalt/rtdm/fd.c
+++ b/kernel/cobalt/rtdm/fd.c
@@ -902,7 +902,7 @@ eadv:
 	 * rtdm_fd are still pending.
 	 */
 	__fd_close(ppd, idx, s);
-	__close_fd(current->files, ufd);
+	close_fd(ufd);
 
 	return 0;
 }
-- 
2.31.1


