From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] mercury: Fix include path for cobalt/wrapper.h
Message-ID: <18fee8f3-6d25-0e71-5f7d-737c3c34b293@siemens.com>
Date: Mon, 15 Feb 2021 22:59:21 +0100
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

Long broken, likely not practically relevant. But now that we known it,
let's fix it: There is no mercury/wrapper.h, but we have that file under
mercury/copperplate.

Reported-by: Florian Bezdeka <florian.bezdeka@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/copperplate/wrappers.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/copperplate/wrappers.h b/include/copperplate/wrappers.h
index a7c68f5cb8..06b94b5e4c 100644
--- a/include/copperplate/wrappers.h
+++ b/include/copperplate/wrappers.h
@@ -24,7 +24,7 @@
 #ifdef CONFIG_XENO_COBALT
 #include <cobalt/wrappers.h>
 #else /* CONFIG_XENO_MERCURY */
-#include <mercury/wrappers.h>
+#include <mercury/boilerplate/wrappers.h>
 #endif /* CONFIG_XENO_MERCURY */
 
 #endif /* _COPPERPLATE_WRAPPERS_H */
-- 
2.26.2


-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

