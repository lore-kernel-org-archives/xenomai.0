From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v2 7/7] testsuite/smokey/leaks: Adding checks for procfs
 exports
Date: Wed, 25 Aug 2021 12:32:30 +0200
Message-Id: <20210825103230.27274-8-florian.bezdeka@siemens.com>
In-Reply-To: <20210825103230.27274-1-florian.bezdeka@siemens.com>
References: <20210825103230.27274-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Make sure that named semaphores as well as mqueues are exported to the
procfs.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/leaks/leaks.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/testsuite/smokey/leaks/leaks.c b/testsuite/smokey/leaks/leaks.c
index bbe5fc3ad..b867bc727 100644
--- a/testsuite/smokey/leaks/leaks.c
+++ b/testsuite/smokey/leaks/leaks.c
@@ -28,6 +28,7 @@
 #include <pthread.h>
 #include <fcntl.h>
 #include <sys/mman.h>
+#include <sys/stat.h>
 #include <semaphore.h>
 #include <mqueue.h>
 #include <signal.h>
@@ -71,6 +72,24 @@ const char *memdev[] = {
 
 static int memdevfd[3];
 
+static int procfs_exists(const char *type, const char *name)
+{
+	struct stat s;
+	char path[128];
+	int ret;
+
+	/* Ignore if the kernel seems to be compiled without procfs support */
+	if (stat("/proc/xenomai", &s) || !S_ISDIR(s.st_mode))
+		return 0;
+
+	ret = snprintf(path, 128, "%s/%s/%s", "/proc/xenomai/registry/posix",
+		       type, &name[1]);
+	if (ret < 0)
+		return -EINVAL;
+
+	return smokey_check_errno(stat(path, &s));
+}
+
 static unsigned long long get_used(void)
 {
 	struct cobalt_memdev_stat statbuf;
@@ -121,6 +140,10 @@ static inline int subprocess_leak(void)
 	if (ret)
 		return ret;
 
+	ret = procfs_exists("sem", SEM_NAME);
+	if (ret)
+		return ret;
+
 	sevt.sigev_notify = SIGEV_THREAD_ID;
 	sevt.sigev_signo = SIGALRM;
 	sevt.sigev_notify_thread_id = syscall(__NR_gettid);
@@ -132,6 +155,10 @@ static inline int subprocess_leak(void)
 	if (ret < 0)
 		return ret;
 
+	ret = procfs_exists("mqueue", MQ_NAME);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
-- 
2.30.2


