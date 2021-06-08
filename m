From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] drivers/testing/heapcheck: Add compat support
Message-ID: <39804cc2-1b0f-6746-a26e-9b9193e97c18@siemens.com>
Date: Tue, 8 Jun 2021 08:30:06 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

This unbreaks smokey's memory_coreheap check with 32-bit userland on
64-bit kernels.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/rtdm/testing.h |  5 +++++
 kernel/drivers/testing/heapcheck.c   | 32 ++++++++++++++++++++++++----
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/include/cobalt/kernel/rtdm/testing.h b/include/cobalt/kernel/rtdm/testing.h
index 070ee98fe..d2669e122 100644
--- a/include/cobalt/kernel/rtdm/testing.h
+++ b/include/cobalt/kernel/rtdm/testing.h
@@ -32,6 +32,11 @@ struct compat_rttst_overall_bench_res {
 	compat_uptr_t histogram_max;
 };
 
+struct compat_rttst_heap_stathdr {
+	int nrstats;
+	compat_uptr_t buf;
+};
+
 #define RTTST_RTIOC_TMBENCH_STOP_COMPAT \
 	_IOWR(RTIOC_TYPE_TESTING, 0x11, struct compat_rttst_overall_bench_res)
 
diff --git a/kernel/drivers/testing/heapcheck.c b/kernel/drivers/testing/heapcheck.c
index 207f20921..32d69b933 100644
--- a/kernel/drivers/testing/heapcheck.c
+++ b/kernel/drivers/testing/heapcheck.c
@@ -23,7 +23,7 @@
 #include <linux/random.h>
 #include <cobalt/kernel/assert.h>
 #include <cobalt/kernel/heap.h>
-#include <rtdm/uapi/testing.h>
+#include <rtdm/testing.h>
 #include <rtdm/driver.h>
 
 #define complain(__fmt, __args...)	\
@@ -446,6 +446,7 @@ static void heapcheck_close(struct rtdm_fd *fd)
 static int heapcheck_ioctl(struct rtdm_fd *fd,
 			   unsigned int request, void __user *arg)
 {
+	struct compat_rttst_heap_stathdr compat_sthdr;
 	struct rttst_heap_stathdr sthdr;
 	struct rttst_heap_parms parms;
 	int ret;
@@ -465,14 +466,37 @@ static int heapcheck_ioctl(struct rtdm_fd *fd,
 		break;
 	case RTTST_RTIOC_HEAP_STAT_COLLECT:
 		sthdr.buf = NULL;
-		ret = rtdm_copy_from_user(fd, &sthdr, arg, sizeof(sthdr));
+#ifdef CONFIG_XENO_ARCH_SYS3264
+		if (rtdm_fd_is_compat(fd)) {
+			ret = rtdm_copy_from_user(fd, &compat_sthdr, arg,
+						  sizeof(compat_sthdr));
+			if (ret)
+				return ret;
+			sthdr.buf = compat_ptr(compat_sthdr.buf);
+			sthdr.nrstats = compat_sthdr.nrstats;
+		} else
+#endif
+		{
+			ret = rtdm_copy_from_user(fd, &sthdr, arg,
+						  sizeof(sthdr));
+		}
 		if (ret)
 			return ret;
+
 		ret = collect_stats(fd, sthdr.buf, sthdr.nrstats);
 		if (ret < 0)
 			return ret;
-		sthdr.nrstats = ret;
-		ret = rtdm_copy_to_user(fd, arg, &sthdr, sizeof(sthdr));
+#ifdef CONFIG_XENO_ARCH_SYS3264
+		if (rtdm_fd_is_compat(fd)) {
+			compat_sthdr.nrstats = ret;
+			ret = rtdm_copy_to_user(fd, arg, &compat_sthdr,
+						sizeof(compat_sthdr));
+		} else
+#endif
+		{
+			sthdr.nrstats = ret;
+			ret = rtdm_copy_to_user(fd, arg, &sthdr, sizeof(sthdr));
+		}
 		break;
 	default:
 		ret = -EINVAL;
-- 
2.26.2

