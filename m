From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 4/5] cobalt/posix/clock: Remove unneeded local variable
Date: Wed, 12 Jun 2019 17:31:17 +0200
Message-Id: <3a47c8403f0dd5f52e0f1370236abf91ded9449f.1560353478.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1560353478.git.jan.kiszka@siemens.com>
References: <cover.1560353478.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1560353478.git.jan.kiszka@siemens.com>
References: <cover.1560353478.git.jan.kiszka@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/posix/clock.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/cobalt/posix/clock.c b/kernel/cobalt/posix/clock.c
index 6ba389efd0..561358e749 100644
--- a/kernel/cobalt/posix/clock.c
+++ b/kernel/cobalt/posix/clock.c
@@ -276,7 +276,6 @@ int __cobalt_clock_nanosleep(clockid_t clock_id, int flags,
 	struct restart_block *restart;
 	struct xnthread *cur;
 	xnsticks_t timeout, rem;
-	int ret = 0;
 	spl_t s;
 
 	trace_cobalt_clock_nanosleep(clock_id, flags, rqt);
@@ -347,7 +346,7 @@ int __cobalt_clock_nanosleep(clockid_t clock_id, int flags,
 
 	xnlock_put_irqrestore(&nklock, s);
 
-	return ret;
+	return 0;
 }
 
 COBALT_SYSCALL(clock_nanosleep, primary,
-- 
2.16.4


