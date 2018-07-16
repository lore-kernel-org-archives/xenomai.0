From: Jan Kiszka <jan.kiszka@siemens.com>
Date: Mon, 16 Jul 2018 18:37:52 +0200
Message-Id: <9c316ea60ac2b083aa22654c6319ab9b789a6789.1531759073.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1531759073.git.jan.kiszka@siemens.com>
References: <cover.1531759073.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1531759073.git.jan.kiszka@siemens.com>
References: <cover.1531759073.git.jan.kiszka@siemens.com>
Subject: [Xenomai] [PATCH 4/6] lib/cobalt: Avoid requesting shadowing for
	remote threads
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

Fix pthread_setschedparam_ex that it does not suggests the core to map
the current thread if the target thread of the request is actually not
pthread_self(). The core will reject such requests now, but we should
avoid them in the first place so that we get a clear error code.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 lib/cobalt/thread.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/cobalt/thread.c b/lib/cobalt/thread.c
index 62ca0a02d9..fac23109c1 100644
--- a/lib/cobalt/thread.c
+++ b/lib/cobalt/thread.c
@@ -607,7 +607,7 @@ int pthread_setschedparam_ex(pthread_t thread,
 {
 	int ret, promoted, std_policy;
 	struct sched_param std_param;
-	__u32 u_winoff;
+	__u32 u_winoff, *u_winoff_ptr;
 
 	/*
 	 * If we enter this call over a relaxed context, take the
@@ -637,9 +637,12 @@ int pthread_setschedparam_ex(pthread_t thread,
 			return ret;
 	}
 
+	/* only request promotion when this targets the current thread */
+	u_winoff_ptr = thread == pthread_self() ? &u_winoff : NULL;
+
 	ret = -XENOMAI_SYSCALL5(sc_cobalt_thread_setschedparam_ex,
 				thread, policy, param_ex,
-				&u_winoff, &promoted);
+				u_winoff_ptr, &promoted);
 
 	if (ret == 0 && promoted) {
 		cobalt_sigshadow_install_once();
-- 
2.16.4


