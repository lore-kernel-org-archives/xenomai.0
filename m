From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 8/8] cobalt/assert: remove extraneous header inclusion
Date: Sat, 20 Feb 2021 13:45:27 +0100
Message-Id: <20210220124527.401015-8-rpm@xenomai.org>
In-Reply-To: <20210220124527.401015-1-rpm@xenomai.org>
References: <20210220124527.401015-1-rpm@xenomai.org>
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org, Philippe Gerum <rpm@xenomai.org>

From: Philippe Gerum <rpm@xenomai.org>

In the same move, fix places which depend on such inclusion but fail
to pull the related headers directly.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 include/cobalt/kernel/assert.h | 3 ---
 kernel/cobalt/heap.c           | 1 +
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/cobalt/kernel/assert.h b/include/cobalt/kernel/assert.h
index 8d004476b..abe044100 100644
--- a/include/cobalt/kernel/assert.h
+++ b/include/cobalt/kernel/assert.h
@@ -20,9 +20,6 @@
 #define _COBALT_KERNEL_ASSERT_H
 
 #include <linux/kconfig.h>
-#include <pipeline/pipeline.h>
-#include <cobalt/kernel/trace.h>
-#include <cobalt/kernel/ancillaries.h>
 
 #define XENO_INFO	KERN_INFO    "[Xenomai] "
 #define XENO_WARNING	KERN_WARNING "[Xenomai] "
diff --git a/kernel/cobalt/heap.c b/kernel/cobalt/heap.c
index 5d14a4739..9e184d4c3 100644
--- a/kernel/cobalt/heap.c
+++ b/kernel/cobalt/heap.c
@@ -27,6 +27,7 @@
 #include <cobalt/kernel/assert.h>
 #include <cobalt/kernel/heap.h>
 #include <cobalt/kernel/vfile.h>
+#include <cobalt/kernel/ancillaries.h>
 
 /**
  * @ingroup cobalt_core
-- 
2.26.2


