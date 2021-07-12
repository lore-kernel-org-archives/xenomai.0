From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] cobalt/trace: Update symbolic syscall table with recently
 added calls
Message-ID: <65415a5a-70d6-ac97-4ed0-c697778c3e1a@siemens.com>
Date: Mon, 12 Jul 2021 20:03:36 +0200
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

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

"Denke dran" (remind) on the upcoming syscalls.

 kernel/cobalt/trace/cobalt-posix.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/cobalt/trace/cobalt-posix.h b/kernel/cobalt/trace/cobalt-posix.h
index d66053da8d..d994007bba 100644
--- a/kernel/cobalt/trace/cobalt-posix.h
+++ b/kernel/cobalt/trace/cobalt-posix.h
@@ -154,7 +154,13 @@
 		__cobalt_symbolic_syscall(ftrace_puts),			\
 		__cobalt_symbolic_syscall(recvmmsg),			\
 		__cobalt_symbolic_syscall(sendmmsg),			\
-		__cobalt_symbolic_syscall(clock_adjtime))
+		__cobalt_symbolic_syscall(clock_adjtime),		\
+		__cobalt_symbolic_syscall(sem_timedwait64),		\
+		__cobalt_symbolic_syscall(clock_gettime64),		\
+		__cobalt_symbolic_syscall(clock_settime64),		\
+		__cobalt_symbolic_syscall(clock_nanosleep64),		\
+		__cobalt_symbolic_syscall(clock_getres64),		\
+		__cobalt_symbolic_syscall(clock_adjtime64))
 
 DECLARE_EVENT_CLASS(cobalt_syscall_entry,
 	TP_PROTO(unsigned int nr),
-- 
2.26.2

