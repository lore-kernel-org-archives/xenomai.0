From: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
Date: Fri, 21 Dec 2012 14:26:15 +0100
Message-Id: <1356096375-29859-11-git-send-email-wolfgang.mauerer@siemens.com>
In-Reply-To: <1356096375-29859-1-git-send-email-wolfgang.mauerer@siemens.com>
References: <1356096375-29859-1-git-send-email-wolfgang.mauerer@siemens.com>
Subject: [Xenomai] [PATCH 10/10] ipipe: Make ftrace compatible with ipipe
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: jan.kiszka@siemens.com, wolfgang.mauerer@siemens.com

Replace the standard preemption definitions with the
ipipe-safe variants. Including ipipe_switch_preempt.h
into the ftrace local header trace.h is sufficient for
this because the definition propagates into all involved
C files, either directly or via trace_probe.h respectively
trace_output.h.

Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
---
 kernel/trace/trace.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 5aec220..50d1e9d 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -12,6 +12,7 @@
 #include <linux/hw_breakpoint.h>
 #include <linux/trace_seq.h>
 #include <linux/ftrace_event.h>
+#include <linux/ipipe_switch_preempt.h>
 
 enum trace_type {
 	__TRACE_FIRST_TYPE = 0,
-- 
1.7.1


