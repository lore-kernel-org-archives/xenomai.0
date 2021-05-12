From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 1/7] cobalt/memory: fix __vmalloc() calls
Date: Wed, 12 May 2021 12:05:51 +0200
Message-Id: <cb76faf45c891829d52635cb56f5f3ff47bbc989.1620813957.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1620813957.git.jan.kiszka@siemens.com>
References: <cover.1620813957.git.jan.kiszka@siemens.com>
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

From: Philippe Gerum <rpm@xenomai.org>

Since kernel v5.8, __vmalloc() does not take protection bits as
PROT_KERNEL is now wired in. Therefore we cannot disable the cache for
the UMM segment via the allocation call directly anymore.

This said, we don't support any CPU architecture exhibiting cache
aliasing braindamage anymore either (was armv4/v5), so let's convert
to the new __vmalloc() call format without bothering for cache
settings.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/cobalt/include/asm-generic/xenomai/wrappers.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
index 930e6364e5..652a04759f 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
@@ -210,4 +210,10 @@ devm_hwmon_device_register_with_groups(struct device *dev, const char *name,
 #define old_timeval32     compat_timeval
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(5,8,0)
+#define vmalloc_kernel(__size, __flags)	__vmalloc(__size, GFP_KERNEL|__flags, PAGE_KERNEL)
+#else
+#define vmalloc_kernel(__size, __flags)	__vmalloc(__size, GFP_KERNEL|__flags)
+#endif
+
 #endif /* _COBALT_ASM_GENERIC_WRAPPERS_H */
-- 
2.26.2


