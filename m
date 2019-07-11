From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2 2/6] ipipe: lockdep: Remove duplicate context checks
Date: Thu, 11 Jul 2019 21:56:13 +0200
Message-Id: <59da6e784c1365ef663e7cdb6df8c6b339a78c9d.1562874977.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1562874977.git.jan.kiszka@siemens.com>
References: <cover.1562874977.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1562874977.git.jan.kiszka@siemens.com>
References: <cover.1562874977.git.jan.kiszka@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

All callers of lockdep_hardirqs_on/off already filter out !ipipe_root_p.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/locking/lockdep.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 715fe8a49c2e..a2a8267788c6 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2841,9 +2841,6 @@ static void __trace_hardirqs_on_caller(unsigned long ip)
 
 void lockdep_hardirqs_on(unsigned long ip)
 {
-	if (!ipipe_root_p)
-		return;
-
 	if (unlikely(!debug_locks || current->lockdep_recursion))
 		return;
 
@@ -2890,9 +2887,6 @@ void lockdep_hardirqs_off(unsigned long ip)
 {
 	struct task_struct *curr;
 
-	if (!ipipe_root_p)
-		return;
-
 	curr = current;
 
 	if (unlikely(!debug_locks || current->lockdep_recursion))
-- 
2.16.4


