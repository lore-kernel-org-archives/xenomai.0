From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [RFC][PATCH 6/7] cobalt/kernel: Clear mayday request of relaxed task
Date: Fri, 30 Nov 2018 21:03:20 +0100
Message-Id: <b4ebe287b44c9ca1965cde0b14718221b8637e29.1543608201.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1543608201.git.jan.kiszka@siemens.com>
References: <cover.1543608201.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1543608201.git.jan.kiszka@siemens.com>
References: <cover.1543608201.git.jan.kiszka@siemens.com>
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

If a task relaxes on its own, before processing a mayday request, clear
this request to avoid redundant calls of the machinery. This is
particularly important for ensuring XNCONTHI works as expected after
ptrace resumption.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/thread.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index 6597749a20..bb1eda1052 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -2174,6 +2174,8 @@ void xnthread_relax(int notify, int reason)
 	}
 #endif
 
+	ipipe_clear_thread_flag(TIP_MAYDAY);
+
 	trace_cobalt_shadow_relaxed(thread);
 }
 EXPORT_SYMBOL_GPL(xnthread_relax);
-- 
2.16.4


