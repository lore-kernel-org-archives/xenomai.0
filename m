From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 02/25] cobalt/kevents: dovetail: drop call to obsolete
 force_commit_memory()
Date: Thu, 20 May 2021 23:44:12 +0200
Message-Id: <0aef0e3a27e225564879c2c1fb2c54da8f935f0f.1621547075.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1621547075.git.jan.kiszka@siemens.com>
References: <cover.1621547075.git.jan.kiszka@siemens.com>
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

A process is now marked for COW-breaking on fork() upon the first call
to dovetail_init_altsched(), and must ensure its memory is locked via
a call to mlockall(MCL_CURRENT|MCL_FUTURE) as usual.

As a result, force_commit_memory() became pointless and was removed
from the Dovetail interface.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/dovetail/kevents.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/kevents.c
index 5efe30c22d..64f6f421c1 100644
--- a/kernel/cobalt/dovetail/kevents.c
+++ b/kernel/cobalt/dovetail/kevents.c
@@ -516,7 +516,8 @@ void handle_inband_event(enum inband_event_type event, void *data)
 }
 
 #ifdef CONFIG_MMU
-static inline int disable_ondemand_memory(void)
+
+int pipeline_prepare_current(void)
 {
 	struct task_struct *p = current;
 	kernel_siginfo_t si;
@@ -527,15 +528,9 @@ static inline int disable_ondemand_memory(void)
 		si.si_code = SI_QUEUE;
 		si.si_int = SIGDEBUG_NOMLOCK | sigdebug_marker;
 		send_sig_info(SIGDEBUG, &si, p);
-		return 0;
 	}
 
-	return force_commit_memory();
-}
-
-int pipeline_prepare_current(void)
-{
-	return disable_ondemand_memory();
+	return 0;
 }
 
 static inline int get_mayday_prot(void)
-- 
2.26.2


