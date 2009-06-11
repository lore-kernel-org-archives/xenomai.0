Message-ID: <4A30FB2D.6050003@domain.hid>
Date: Thu, 11 Jun 2009 14:40:13 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] Reorder headers include directives.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <Xenomai-core@domain.hid>

Following usual Linux rules, asm/* headers should be included after linux/*
headers, and this fixes the following warning on ARM:

In file included from arch/arm/include/asm/pgtable.h:449,
from kernel/xenomai/skins/rtdm/drvlib.c:37:
include/asm-generic/pgtable.h:305: warning: 'struct vm_area_struct' declared inside parameter list
(...)
---
 ksrc/skins/rtdm/drvlib.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/ksrc/skins/rtdm/drvlib.c b/ksrc/skins/rtdm/drvlib.c
index 2d28e09..c5b2b91 100644
--- a/ksrc/skins/rtdm/drvlib.c
+++ b/ksrc/skins/rtdm/drvlib.c
@@ -31,12 +31,12 @@
  */

 #include <linux/bitops.h>
-#include <asm/page.h>
-#include <asm/io.h>
-#include <asm/pgtable.h>
 #include <linux/delay.h>
 #include <linux/mman.h>
 #include <linux/highmem.h>
+#include <asm/page.h>
+#include <asm/io.h>
+#include <asm/pgtable.h>

 #include <rtdm/rtdm_driver.h>

--
1.5.6.5


-- 
                                          Gilles


