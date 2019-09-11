From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 3.0.x] lib/cobalt: init: do not call pthread_atfork() from
 atfork() handlers
Message-ID: <d93e1ee7-4bcb-de04-e499-73f714f8b8ee@siemens.com>
Date: Wed, 11 Sep 2019 17:21:41 +0200
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
To: Xenomai <xenomai@xenomai.org>

From: Philippe Gerum <rpm@xenomai.org>

Since glibc 2.28, calling pthread_atfork() over the context of a fork
handler hangs, due to unexpected recursive locking on a common lock
both want to acquire.  To fix this, the cobalt fork handler needs to
be registered outside of the atfork handling context it installs.

At this chance, group all base inits which do not need to be
reiterated in the forkee to exclude them from the atfork context.

The problematic change was introduced between glibc-2.27.9000 and
glibc-2.28 [1]; it triggered a bug in the glibc test suite [2].

[1] git://sourceware.org/git/glibc.git, 27761a104
[2] git://sourceware.org/git/glibc.git, 669ff911e

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

This resolves the LAVA test issue we saw - our image is Debian 10
based, thus with a glibc 2.28.

 lib/cobalt/init.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/lib/cobalt/init.c b/lib/cobalt/init.c
index 92ce45a884..57d5ec85d6 100644
--- a/lib/cobalt/init.c
+++ b/lib/cobalt/init.c
@@ -181,20 +181,26 @@ static void low_init(void)
 	cobalt_ticks_init(f->clock_freq);
 }
 
+static int cobalt_init_2(void);
+
 static void cobalt_fork_handler(void)
 {
 	cobalt_unmap_umm();
 	cobalt_clear_tsd();
 	cobalt_print_init_atfork();
-	if (cobalt_init())
+	if (cobalt_init_2())
 		exit(EXIT_FAILURE);
 }
 
-static void __cobalt_init(void)
+static inline void commit_stack_memory(void)
 {
-	struct sigaction sa;
+	char stk[PTHREAD_STACK_MIN / 2];
+	cobalt_commit_memory(stk);
+}
 
-	low_init();
+static void cobalt_init_1(void)
+{
+	struct sigaction sa;
 
 	sa.sa_sigaction = cobalt_sigdebug_handler;
 	sigemptyset(&sa.sa_mask);
@@ -225,19 +231,9 @@ static void __cobalt_init(void)
 			    " sizeof(cobalt_sem_shadow): %Zd!",
 			    sizeof(sem_t),
 			    sizeof(struct cobalt_sem_shadow));
-
-	cobalt_mutex_init();
-	cobalt_thread_init();
-	cobalt_print_init();
 }
 
-static inline void commit_stack_memory(void)
-{
-	char stk[PTHREAD_STACK_MIN / 2];
-	cobalt_commit_memory(stk);
-}
-
-int cobalt_init(void)
+static int cobalt_init_2(void)
 {
 	pthread_t ptid = pthread_self();
 	struct sched_param parm;
@@ -245,7 +241,11 @@ int cobalt_init(void)
 
 	commit_stack_memory();	/* We only need this for the main thread */
 	cobalt_default_condattr_init();
-	__cobalt_init();
+
+	low_init();
+	cobalt_mutex_init();
+	cobalt_thread_init();
+	cobalt_print_init();
 
 	if (__cobalt_control_bind)
 		return 0;
@@ -284,12 +284,19 @@ int cobalt_init(void)
 	return 0;
 }
 
+int cobalt_init(void)
+{
+	cobalt_init_1();
+
+	return cobalt_init_2();
+}
+
 static int get_int_arg(const char *name, const char *arg,
 		       int *valp, int min)
 {
 	int value, ret;
 	char *p;
-	
+
 	errno = 0;
 	value = (int)strtol(arg, &p, 10);
 	if (errno || *p || value < min) {
-- 

2.16.4

