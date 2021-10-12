From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 1/4] lib/alchemy: Fix rt_pipe_read* with timeouts
Date: Tue, 12 Oct 2021 20:19:17 +0200
Message-Id: <9768c8ec898085287c783edeec025f9c5c37a2b7.1634062760.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1634062760.git.jan.kiszka@siemens.com>
References: <cover.1634062760.git.jan.kiszka@siemens.com>
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

From: Jan Kiszka <jan.kiszka@siemens.com>

The underlying IPC driver takes relative timeouts, but
rt_pipe_read_timed so far submitted absolute ones. This fixes this
function and also adds a non-inline rt_pipe_read to avoid pointless
conversions from relative to absolute and then to relative again.

Reported-by: Mauro S. <mau.salvi@tin.it>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/alchemy/pipe.h |  8 +-------
 lib/alchemy/pipe.c     | 45 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/include/alchemy/pipe.h b/include/alchemy/pipe.h
index a9eaf6c77c..4ae24f9817 100644
--- a/include/alchemy/pipe.h
+++ b/include/alchemy/pipe.h
@@ -64,14 +64,8 @@ ssize_t rt_pipe_read_until(RT_PIPE *pipe,
 				  alchemy_abs_timeout(timeout, &ts));
 }
 
-static inline
 ssize_t rt_pipe_read(RT_PIPE *pipe,
-		     void *buf, size_t size, RTIME timeout)
-{
-	struct timespec ts;
-	return rt_pipe_read_timed(pipe, buf, size,
-				  alchemy_rel_timeout(timeout, &ts));
-}
+		     void *buf, size_t size, RTIME timeout);
 
 ssize_t rt_pipe_write(RT_PIPE *pipe,
 		      const void *buf, size_t size, int mode);
diff --git a/lib/alchemy/pipe.c b/lib/alchemy/pipe.c
index 54d0164139..4b2c389806 100644
--- a/lib/alchemy/pipe.c
+++ b/lib/alchemy/pipe.c
@@ -310,6 +310,44 @@ out:
  *
  * @apitags{xthread-nowait, switch-primary}
  */
+ssize_t rt_pipe_read(RT_PIPE *pipe,
+		     void *buf, size_t size, RTIME timeout)
+{
+	struct alchemy_pipe *pcb;
+	int err = 0, flags;
+	struct timespec ts;
+	struct timeval tv;
+	ssize_t ret;
+
+	pcb = find_alchemy_pipe(pipe, &err);
+	if (pcb == NULL)
+		return err;
+
+	if (timeout == TM_NONBLOCK)
+		flags = MSG_DONTWAIT;
+	else {
+		if (!threadobj_current_p())
+			return -EPERM;
+		if (timeout != TM_INFINITE) {
+			clockobj_ticks_to_timespec(&alchemy_clock, timeout,
+						   &ts);
+			tv.tv_sec = ts.tv_sec;
+			tv.tv_usec = ts.tv_nsec / 1000;
+		} else {
+			tv.tv_sec = 0;
+			tv.tv_usec = 0;
+		}
+		__RT(setsockopt(pcb->sock, SOL_SOCKET,
+				SO_RCVTIMEO, &tv, sizeof(tv)));
+		flags = 0;
+	}
+
+	ret = __RT(recvfrom(pcb->sock, buf, size, flags, NULL, 0));
+	if (ret < 0)
+		ret = -errno;
+
+	return ret;
+}
 
 /**
  * @fn ssize_t rt_pipe_read_until(RT_PIPE *pipe, void *buf, size_t size, RTIME abs_timeout)
@@ -394,6 +432,7 @@ ssize_t rt_pipe_read_timed(RT_PIPE *pipe,
 			   void *buf, size_t size,
 			   const struct timespec *abs_timeout)
 {
+	struct timespec now, timeout;
 	struct alchemy_pipe *pcb;
 	int err = 0, flags;
 	struct timeval tv;
@@ -409,8 +448,10 @@ ssize_t rt_pipe_read_timed(RT_PIPE *pipe,
 		if (!threadobj_current_p())
 			return -EPERM;
 		if (abs_timeout) {
-			tv.tv_sec = abs_timeout->tv_sec;
-			tv.tv_usec = abs_timeout->tv_nsec / 1000;
+			__RT(clock_gettime(CLOCK_COPPERPLATE, &now));
+			timespec_sub(&timeout, abs_timeout, &now);
+			tv.tv_sec = timeout.tv_sec;
+			tv.tv_usec = timeout.tv_nsec / 1000;
 		} else {
 			tv.tv_sec = 0;
 			tv.tv_usec = 0;
-- 
2.31.1


