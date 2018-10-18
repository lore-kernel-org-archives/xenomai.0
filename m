From: Sebastian Smolorz <sebastian.smolorz@gmx.de>
Date: Thu, 18 Oct 2018 14:20:20 +0200
Message-Id: <1539865220-1372-1-git-send-email-sebastian.smolorz@gmx.de>
Subject: [Xenomai] [PATCH] boilerplate/avl: fix missing include
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Signed-off-by: Sebastian Smolorz <sebastian.smolorz@gmx.de>
---
 lib/boilerplate/avl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/boilerplate/avl.c b/lib/boilerplate/avl.c
index 3bf9bf1..2e16e7d 100644
--- a/lib/boilerplate/avl.c
+++ b/lib/boilerplate/avl.c
@@ -22,6 +22,7 @@
  */
 #include <errno.h>
 #include <memory.h>
+#include <boilerplate/avl.h>
 
 #ifdef AVL_PSHARED
 #define __AVL(__decl)	shavl_ ## __decl
-- 
2.7.4


