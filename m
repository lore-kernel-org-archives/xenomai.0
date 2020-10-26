From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 04/11] drivers/ipc: Account for renaming of
 SO_RCVTIMEO/SO_SNDTIMEO
Date: Mon, 26 Oct 2020 12:04:50 +0100
Message-Id: <6c3c9702861f15476c6e41cb89e08c79e04d90ab.1603710297.git.jan.kiszka@siemens.com>
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

Use the *_OLD defines for the 2038-wise unconverted socket options.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/include/asm-generic/xenomai/wrappers.h | 2 ++
 kernel/drivers/ipc/bufp.c                            | 8 ++++----
 kernel/drivers/ipc/iddp.c                            | 8 ++++----
 kernel/drivers/ipc/xddp.c                            | 4 ++--
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
index de5a992850..b910138395 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
@@ -158,6 +158,8 @@ devm_hwmon_device_register_with_groups(struct device *dev, const char *name,
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(5,1,0)
 #define old_timex32		compat_timex
+#define SO_RCVTIMEO_OLD		SO_RCVTIMEO
+#define SO_SNDTIMEO_OLD		SO_SNDTIMEO
 #endif
 
 #endif /* _COBALT_ASM_GENERIC_WRAPPERS_H */
diff --git a/kernel/drivers/ipc/bufp.c b/kernel/drivers/ipc/bufp.c
index 45c917eb07..9410973f2c 100644
--- a/kernel/drivers/ipc/bufp.c
+++ b/kernel/drivers/ipc/bufp.c
@@ -830,14 +830,14 @@ static int __bufp_setsockopt(struct bufp_socket *sk,
 	if (sopt.level == SOL_SOCKET) {
 		switch (sopt.optname) {
 
-		case SO_RCVTIMEO:
+		case SO_RCVTIMEO_OLD:
 			ret = rtipc_get_timeval(fd, &tv, sopt.optval, sopt.optlen);
 			if (ret)
 				return ret;
 			sk->rx_timeout = rtipc_timeval_to_ns(&tv);
 			break;
 
-		case SO_SNDTIMEO:
+		case SO_SNDTIMEO_OLD:
 			ret = rtipc_get_timeval(fd, &tv, sopt.optval, sopt.optlen);
 			if (ret)
 				return ret;
@@ -922,14 +922,14 @@ static int __bufp_getsockopt(struct bufp_socket *sk,
 	if (sopt.level == SOL_SOCKET) {
 		switch (sopt.optname) {
 
-		case SO_RCVTIMEO:
+		case SO_RCVTIMEO_OLD:
 			rtipc_ns_to_timeval(&tv, sk->rx_timeout);
 			ret = rtipc_put_timeval(fd, sopt.optval, &tv, len);
 			if (ret)
 				return ret;
 			break;
 
-		case SO_SNDTIMEO:
+		case SO_SNDTIMEO_OLD:
 			rtipc_ns_to_timeval(&tv, sk->tx_timeout);
 			ret = rtipc_put_timeval(fd, sopt.optval, &tv, len);
 			if (ret)
diff --git a/kernel/drivers/ipc/iddp.c b/kernel/drivers/ipc/iddp.c
index 2a80eba65a..5bb2b85337 100644
--- a/kernel/drivers/ipc/iddp.c
+++ b/kernel/drivers/ipc/iddp.c
@@ -712,14 +712,14 @@ static int __iddp_setsockopt(struct iddp_socket *sk,
 	if (sopt.level == SOL_SOCKET) {
 		switch (sopt.optname) {
 
-		case SO_RCVTIMEO:
+		case SO_RCVTIMEO_OLD:
 			ret = rtipc_get_timeval(fd, &tv, sopt.optval, sopt.optlen);
 			if (ret)
 				return ret;
 			sk->rx_timeout = rtipc_timeval_to_ns(&tv);
 			break;
 
-		case SO_SNDTIMEO:
+		case SO_SNDTIMEO_OLD:
 			ret = rtipc_get_timeval(fd, &tv, sopt.optval, sopt.optlen);
 			if (ret)
 				return ret;
@@ -805,14 +805,14 @@ static int __iddp_getsockopt(struct iddp_socket *sk,
 	if (sopt.level == SOL_SOCKET) {
 		switch (sopt.optname) {
 
-		case SO_RCVTIMEO:
+		case SO_RCVTIMEO_OLD:
 			rtipc_ns_to_timeval(&tv, sk->rx_timeout);
 			ret = rtipc_put_timeval(fd, sopt.optval, &tv, len);
 			if (ret)
 				return ret;
 			break;
 
-		case SO_SNDTIMEO:
+		case SO_SNDTIMEO_OLD:
 			rtipc_ns_to_timeval(&tv, sk->tx_timeout);
 			ret = rtipc_put_timeval(fd, sopt.optval, &tv, len);
 			if (ret)
diff --git a/kernel/drivers/ipc/xddp.c b/kernel/drivers/ipc/xddp.c
index 57275d0c60..2bf26fcaa8 100644
--- a/kernel/drivers/ipc/xddp.c
+++ b/kernel/drivers/ipc/xddp.c
@@ -867,7 +867,7 @@ static int __xddp_setsockopt(struct xddp_socket *sk,
 	if (sopt.level == SOL_SOCKET) {
 		switch (sopt.optname) {
 
-		case SO_RCVTIMEO:
+		case SO_RCVTIMEO_OLD:
 			ret = rtipc_get_timeval(fd, &tv, sopt.optval, sopt.optlen);
 			if (ret)
 				return ret;
@@ -976,7 +976,7 @@ static int __xddp_getsockopt(struct xddp_socket *sk,
 	if (sopt.level == SOL_SOCKET) {
 		switch (sopt.optname) {
 
-		case SO_RCVTIMEO:
+		case SO_RCVTIMEO_OLD:
 			rtipc_ns_to_timeval(&tv, sk->timeout);
 			ret = rtipc_put_timeval(fd, sopt.optval, &tv, len);
 			if (ret)
-- 
2.26.2


