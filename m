From: Philippe Gerum <rpm@xenomai.org>
Date: Tue, 25 Sep 2018 12:37:49 +0200
Message-Id: <20180925103809.4932-13-rpm@xenomai.org>
In-Reply-To: <20180925103809.4932-1-rpm@xenomai.org>
References: <20180925103809.4932-1-rpm@xenomai.org>
Subject: [Xenomai] [PATCH 12/32] x86: ipipe: notify about GTOD update
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

---
 arch/x86/entry/vsyscall/vsyscall_gtod.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/entry/vsyscall/vsyscall_gtod.c b/arch/x86/entry/vsyscall/vsyscall_gtod.c
index e1216dd95c04..9fb89b6e88c3 100644
--- a/arch/x86/entry/vsyscall/vsyscall_gtod.c
+++ b/arch/x86/entry/vsyscall/vsyscall_gtod.c
@@ -14,6 +14,7 @@
  */
 
 #include <linux/timekeeper_internal.h>
+#include <linux/ipipe_tickdev.h>
 #include <asm/vgtod.h>
 #include <asm/vvar.h>
 
@@ -75,4 +76,7 @@ void update_vsyscall(struct timekeeper *tk)
 	}
 
 	gtod_write_end(vdata);
+
+	if (tk->tkr_mono.clock == &clocksource_tsc)
+		ipipe_update_hostrt(tk);
 }
-- 
2.14.4


