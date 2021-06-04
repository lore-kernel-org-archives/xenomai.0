From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 04/12] cobalt/trace: Avoid clash with kernel trace definitions
Date: Fri,  4 Jun 2021 12:05:14 +0200
Message-Id: <b7b7dc0cc95710426319579001d4e53428e8ce4c.1622801122.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1622801122.git.jan.kiszka@siemens.com>
References: <cover.1622801122.git.jan.kiszka@siemens.com>
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

Started to bite us on newer kernels / with dovetail.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/trace/cobalt-posix.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/cobalt/trace/cobalt-posix.h b/kernel/cobalt/trace/cobalt-posix.h
index a3713e9c9..1d623069d 100644
--- a/kernel/cobalt/trace/cobalt-posix.h
+++ b/kernel/cobalt/trace/cobalt-posix.h
@@ -156,7 +156,7 @@
 		__cobalt_symbolic_syscall(sendmmsg),			\
 		__cobalt_symbolic_syscall(clock_adjtime))
 
-DECLARE_EVENT_CLASS(syscall_entry,
+DECLARE_EVENT_CLASS(cobalt_syscall_entry,
 	TP_PROTO(unsigned int nr),
 	TP_ARGS(nr),
 
@@ -171,7 +171,7 @@ DECLARE_EVENT_CLASS(syscall_entry,
 	TP_printk("syscall=%s", __cobalt_syscall_name(__entry->nr))
 );
 
-DECLARE_EVENT_CLASS(syscall_exit,
+DECLARE_EVENT_CLASS(cobalt_syscall_exit,
 	TP_PROTO(long result),
 	TP_ARGS(result),
 
@@ -266,22 +266,22 @@ DECLARE_EVENT_CLASS(cobalt_void,
 	TP_printk("%s", "")
 );
 
-DEFINE_EVENT(syscall_entry, cobalt_head_sysentry,
+DEFINE_EVENT(cobalt_syscall_entry, cobalt_head_sysentry,
 	TP_PROTO(unsigned int nr),
 	TP_ARGS(nr)
 );
 
-DEFINE_EVENT(syscall_exit, cobalt_head_sysexit,
+DEFINE_EVENT(cobalt_syscall_exit, cobalt_head_sysexit,
 	TP_PROTO(long result),
 	TP_ARGS(result)
 );
 
-DEFINE_EVENT(syscall_entry, cobalt_root_sysentry,
+DEFINE_EVENT(cobalt_syscall_entry, cobalt_root_sysentry,
 	TP_PROTO(unsigned int nr),
 	TP_ARGS(nr)
 );
 
-DEFINE_EVENT(syscall_exit, cobalt_root_sysexit,
+DEFINE_EVENT(cobalt_syscall_exit, cobalt_root_sysexit,
 	TP_PROTO(long result),
 	TP_ARGS(result)
 );
-- 
2.26.2


