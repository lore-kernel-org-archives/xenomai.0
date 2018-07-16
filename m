From: Jan Kiszka <jan.kiszka@siemens.com>
Date: Mon, 16 Jul 2018 18:37:50 +0200
Message-Id: <4edb914d1742cf4e6216efe866afd3dae22c40ac.1531759073.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1531759073.git.jan.kiszka@siemens.com>
References: <cover.1531759073.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1531759073.git.jan.kiszka@siemens.com>
References: <cover.1531759073.git.jan.kiszka@siemens.com>
Subject: [Xenomai] [PATCH 2/6] cobalt/posix: Avoid mapping remote threads in
	cobalt_sched_setscheduler_ex
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

Detect if the caller passed the PID of a remote thread that we do not
know yet. In that case, do not try to shadow anything, that will only
end up in a mess.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/posix/sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cobalt/posix/sched.c b/kernel/cobalt/posix/sched.c
index 4ae8738c7b..9b61193845 100644
--- a/kernel/cobalt/posix/sched.c
+++ b/kernel/cobalt/posix/sched.c
@@ -752,7 +752,7 @@ int cobalt_sched_setscheduler_ex(pid_t pid,
 		thread = cobalt_current_thread();
 
 	if (thread == NULL) {
-		if (u_winoff == NULL)
+		if (u_winoff == NULL || pid != task_pid_vnr(current))
 			return -ESRCH;
 			
 		thread = cobalt_thread_shadow(current, &hkey, u_winoff);
-- 
2.16.4


