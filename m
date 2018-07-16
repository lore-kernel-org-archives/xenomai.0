From: Jan Kiszka <jan.kiszka@siemens.com>
Date: Mon, 16 Jul 2018 18:37:54 +0200
Message-Id: <5508499edf9b57ef21d97750bdf0e26d9f7de109.1531759073.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1531759073.git.jan.kiszka@siemens.com>
References: <cover.1531759073.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1531759073.git.jan.kiszka@siemens.com>
References: <cover.1531759073.git.jan.kiszka@siemens.com>
Subject: [Xenomai] [PATCH 6/6] cobalt: Fix error code of
	cobalt_thread_setschedparam_ex
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

This aligns the return code with cobalt_sched_setschedparam_ex: If there
is no u_winoff and no thread, we should return ESRCH so that userspace
can easily detect that it should call the standard libc service instead.
Fix the core and remove the related workaround from the userspace lib.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/posix/thread.c | 2 +-
 lib/cobalt/thread.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cobalt/posix/thread.c b/kernel/cobalt/posix/thread.c
index 86f667488c..44f655a300 100644
--- a/kernel/cobalt/posix/thread.c
+++ b/kernel/cobalt/posix/thread.c
@@ -478,7 +478,7 @@ int cobalt_thread_setschedparam_ex(unsigned long pth,
 	thread = thread_lookup(&hkey);
 	if (thread == NULL) {
 		if (u_winoff == NULL)
-			return -EINVAL;
+			return -ESRCH;
 			
 		thread = cobalt_thread_shadow(&hkey, u_winoff);
 		if (IS_ERR(thread))
diff --git a/lib/cobalt/thread.c b/lib/cobalt/thread.c
index b3c11abbb7..86db6343c9 100644
--- a/lib/cobalt/thread.c
+++ b/lib/cobalt/thread.c
@@ -648,7 +648,7 @@ int pthread_setschedparam_ex(pthread_t thread,
 	 * If the kernel has no reference to the target thread. let glibc
 	 * handle the call.
 	 */
-	if (!u_winoff_ptr && ret == EINVAL) {
+	if (ret == ESRCH) {
 		std_policy = cobalt_xlate_schedparam(policy, param_ex,
 						     &std_param);
 		return __STD(pthread_setschedparam(thread, std_policy,
-- 
2.16.4


