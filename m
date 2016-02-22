Sender: Michael Welling <mwelling79@gmail.com>
From: Michael Welling <mwelling@ieee.org>
Date: Mon, 22 Feb 2016 15:25:43 -0600
Message-Id: <1456176343-13522-1-git-send-email-mwelling@ieee.org>
Subject: [Xenomai] [PATCH] demo: cross-link: Properly handle ioctl error
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>, mwelling@ieee.org

Update cross-link demo to properly report ioctl errors.

Signed-off-by: Michael Welling <mwelling@ieee.org>
---
 demo/alchemy/cobalt/cross-link.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/demo/alchemy/cobalt/cross-link.c b/demo/alchemy/cobalt/cross-link.c
index 8c0f53f..f050524 100644
--- a/demo/alchemy/cobalt/cross-link.c
+++ b/demo/alchemy/cobalt/cross-link.c
@@ -23,6 +23,7 @@
 #include <stdio.h>
 #include <signal.h>
 #include <unistd.h>
+#include <errno.h>
 #include <sys/mman.h>
 #include <alchemy/task.h>
 #include <alchemy/timer.h>
@@ -199,6 +200,7 @@ static void read_task_proc(void *arg)
 		/* waiting for event */
 		err = ioctl(read_fd, RTSER_RTIOC_WAIT_EVENT, &rx_event);
 		if (err) {
+			err = -errno;
 			printf(RTASK_PREFIX
 			       "error on RTSER_RTIOC_WAIT_EVENT, %s\n",
 			       strerror(-err));
-- 
2.1.4


