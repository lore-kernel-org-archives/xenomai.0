From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [RFC][PATCH] lib/cobalt: Warn if forking without
 CONFIG_XENO_OPT_DEBUG_POSIX_SYNCHRO
Message-ID: <9cf97198-1d8c-9499-0fc6-228bebdd7ab2@siemens.com>
Date: Tue, 30 Jul 2019 19:36:20 +0200
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
To: Xenomai <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>

This can crash too easily when a resource allocated by the parent is
erroneously reused in the child process.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

I debugged basically this mistake today:

    sem_init(&sem, 0, 0);

    res = fork();
    if (res == 0)
        sem_destroy(&sem);
    else
        waitpid(res, NULL, 0);

With that debug switch on, sem_destroy just returns an error. Without
it, the kernel crashes. Now I'm wondering if

a) we should make that check mandatory
b) make the check at least default y
c) apply a warning patch like this

Thoughts welcome!

 lib/cobalt/init.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/cobalt/init.c b/lib/cobalt/init.c
index 02a99c569c..193d24009e 100644
--- a/lib/cobalt/init.c
+++ b/lib/cobalt/init.c
@@ -188,11 +188,20 @@ static int cobalt_init_2(void);
 
 static void cobalt_fork_handler(void)
 {
+	int corectl_debug, err;
+
 	cobalt_unmap_umm();
 	cobalt_clear_tsd();
 	cobalt_print_init_atfork();
 	if (cobalt_init_2())
 		exit(EXIT_FAILURE);
+
+	err = cobalt_corectl(_CC_COBALT_GET_DEBUG, &corectl_debug,
+			     sizeof(corectl_debug));
+	if (err == 0 && !(corectl_debug & _CC_COBALT_DEBUG_POSIX_SYNCHRO))
+		warning("Forking with CONFIG_XENO_OPT_DEBUG_POSIX_SYNCHRO\n"
+			"                       "
+			"disabled - improper resource usage can cause crashes!\n");
 }
 
 static inline void commit_stack_memory(void)
-- 
2.16.4

