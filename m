From: Jan Kiszka <jan.kiszka@siemens.com>
Date: Mon, 16 Jul 2018 18:37:53 +0200
Message-Id: <37a4da6310e5b3c47f5c0a914d3e708b7a6d64a8.1531759073.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1531759073.git.jan.kiszka@siemens.com>
References: <cover.1531759073.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1531759073.git.jan.kiszka@siemens.com>
References: <cover.1531759073.git.jan.kiszka@siemens.com>
Subject: [Xenomai] [PATCH 5/6] lib/cobalt: Pass setsched requests for
	unknown threads to glibc
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

This aligns the implementation with the documentation: If we get an
error from the kernel that suggests the thread is unknown to it, let
glibc deal with it.

Note that pthread_setschedparam_ex currently returns an invalid error
code, EINVAL rather than ESRCH, so that we try to detect the remote
thread case with some heuristic.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 lib/cobalt/sched.c  | 10 ++++++++++
 lib/cobalt/thread.c | 11 +++++++++++
 2 files changed, 21 insertions(+)

diff --git a/lib/cobalt/sched.c b/lib/cobalt/sched.c
index 94f33231c4..bdb8603dad 100644
--- a/lib/cobalt/sched.c
+++ b/lib/cobalt/sched.c
@@ -308,6 +308,16 @@ int sched_setscheduler_ex(pid_t pid,
 				pid, policy, param_ex,
 				&u_winoff, &promoted);
 
+	/*
+	 * If the kernel has no reference to the target thread, let glibc
+	 * handle the call.
+	 */
+	if (ret == ESRCH) {
+		std_policy = cobalt_xlate_schedparam(policy, param_ex,
+						     &std_param);
+		return __STD(sched_setscheduler(pid, std_policy, &std_param));
+	}
+
 	if (ret == 0 && promoted) {
 		cobalt_sigshadow_install_once();
 		cobalt_set_tsd(u_winoff);
diff --git a/lib/cobalt/thread.c b/lib/cobalt/thread.c
index fac23109c1..b3c11abbb7 100644
--- a/lib/cobalt/thread.c
+++ b/lib/cobalt/thread.c
@@ -644,6 +644,17 @@ int pthread_setschedparam_ex(pthread_t thread,
 				thread, policy, param_ex,
 				u_winoff_ptr, &promoted);
 
+	/*
+	 * If the kernel has no reference to the target thread. let glibc
+	 * handle the call.
+	 */
+	if (!u_winoff_ptr && ret == EINVAL) {
+		std_policy = cobalt_xlate_schedparam(policy, param_ex,
+						     &std_param);
+		return __STD(pthread_setschedparam(thread, std_policy,
+						   &std_param));
+	}
+
 	if (ret == 0 && promoted) {
 		cobalt_sigshadow_install_once();
 		cobalt_set_tsd(u_winoff);
-- 
2.16.4


