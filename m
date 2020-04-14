From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] dovetail: Add missing uapi header include
Message-ID: <b9c1832b-033a-c95a-124a-cd2f16487588@siemens.com>
Date: Tue, 14 Apr 2020 19:30:01 +0200
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Needed for __OOB_SYSCALL_BIT at least.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

This targets current dovetail/master.

BTW, evl/master seems to lag behind dovetail/master ATM.

 kernel/dovetail.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/dovetail.c b/kernel/dovetail.c
index 14922e6a26c7..153b9ba6e8ea 100644
--- a/kernel/dovetail.c
+++ b/kernel/dovetail.c
@@ -9,6 +9,7 @@
 #include <linux/dovetail.h>
 #include <asm/unistd.h>
 #include <asm/syscall.h>
+#include <uapi/asm-generic/dovetail.h>
 
 static bool dovetail_enabled;
 
-- 
2.16.4

