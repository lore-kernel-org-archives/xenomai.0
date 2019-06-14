From: Norbert Lange <nolange79@gmail.com>
Subject: [PATCH 1/2] lib/cobalt: start helper thread with signals blocked
Date: Fri, 14 Jun 2019 12:23:48 +0200
Message-Id: <20190614102349.22912-1-norbert.lange@andritz.com>
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

Delivery mechanisms like sigwait and signalfd require *all* threads
to block the relevant signals.
The cobalt init should not spawn a thread affecting the
signal-handling.

Signed-off-by: Norbert Lange <norbert.lange@andritz.com>
---
 lib/cobalt/printf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/cobalt/printf.c b/lib/cobalt/printf.c
index e109deaec..33ff7f9ac 100644
--- a/lib/cobalt/printf.c
+++ b/lib/cobalt/printf.c
@@ -20,6 +20,7 @@
 #include <inttypes.h>
 #include <limits.h>
 #include <pthread.h>
+#include <signal.h>
 #include <stdarg.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -640,9 +641,13 @@ static void *printer_loop(void *arg)
 static void spawn_printer_thread(void)
 {
 	pthread_attr_t thattr;
+	sigset_t sset, oset;
 
 	pthread_attr_init(&thattr);
+	sigfillset(&sset);
+	pthread_sigmask(SIG_BLOCK, &sset, &oset);
 	pthread_create(&printer_thread, &thattr, printer_loop, NULL);
+	sigprocmask(SIG_SETMASK, &oset, NULL);
 }
 
 void cobalt_print_init_atfork(void)
-- 
2.20.1


