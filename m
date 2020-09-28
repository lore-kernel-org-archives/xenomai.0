From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] demo: Remove obsolete includes
Message-ID: <69ad4bd5-97a8-a693-d4e8-e906322fc4ef@siemens.com>
Date: Mon, 28 Sep 2020 19:34:01 +0200
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

They only break building outside of the tree.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 demo/alchemy/altency.c             | 2 --
 demo/posix/cyclictest/cyclictest.c | 1 -
 2 files changed, 3 deletions(-)

diff --git a/demo/alchemy/altency.c b/demo/alchemy/altency.c
index 4b49755eda..e7c31d7c17 100644
--- a/demo/alchemy/altency.c
+++ b/demo/alchemy/altency.c
@@ -444,8 +444,6 @@ static void faulthand(int sig)
 
 #ifdef CONFIG_XENO_COBALT
 
-#include <cobalt/uapi/syscall.h>
-
 static const char *reason_str[] = {
 	[SIGDEBUG_UNDEFINED] = "received SIGDEBUG for unknown reason",
 	[SIGDEBUG_MIGRATE_SIGNAL] = "received signal",
diff --git a/demo/posix/cyclictest/cyclictest.c b/demo/posix/cyclictest/cyclictest.c
index cddc8dda87..b92596c25b 100644
--- a/demo/posix/cyclictest/cyclictest.c
+++ b/demo/posix/cyclictest/cyclictest.c
@@ -1817,7 +1817,6 @@ void *fifothread(void *param)
 }
 
 #ifdef CONFIG_XENO_COBALT
-#include <cobalt/uapi/syscall.h>
 
 static const char *reason_str[] = {
 	[SIGDEBUG_UNDEFINED] = "received SIGDEBUG for unknown reason",
-- 
2.26.2

