From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 4/5] perf beauty: dovetail: declare oob socket class
Date: Tue, 31 Aug 2021 10:27:08 +0200
Message-Id: <20210831082709.1296249-5-rpm@xenomai.org>
In-Reply-To: <20210831082709.1296249-1-rpm@xenomai.org>
References: <20210831082709.1296249-1-rpm@xenomai.org>
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

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 tools/perf/trace/beauty/include/linux/socket.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/include/linux/socket.h b/tools/perf/trace/beauty/include/linux/socket.h
index 9aa530d497da8f7..93b104ee264f47d 100644
--- a/tools/perf/trace/beauty/include/linux/socket.h
+++ b/tools/perf/trace/beauty/include/linux/socket.h
@@ -223,8 +223,9 @@ struct ucred {
 				 * reuses AF_INET address family
 				 */
 #define AF_XDP		44	/* XDP sockets			*/
+#define AF_OOB		45	/* Out-of-band domain sockets */
 
-#define AF_MAX		45	/* For now.. */
+#define AF_MAX		46	/* For now.. */
 
 /* Protocol families, same as address families. */
 #define PF_UNSPEC	AF_UNSPEC
-- 
2.31.1


