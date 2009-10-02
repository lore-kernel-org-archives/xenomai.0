From: wolfgang.mauerer@domain.hid
Date: Fri,  2 Oct 2009 10:52:34 +0200
Message-Id: <1254473555-11957-1-git-send-email-wolfgang.mauerer@domain.hid>
Subject: [Xenomai-core] [PATCH] Make marker string for faults less ambiguous
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

From: Wolfgang Mauerer <wm@domain.hid>

The trace mark string for faults uses an address
element to notify about the location of the instruction
that caused the fault. "address" is a bit dubious in
this context because it can mean either faulting address
or IP address. Replacing "address" with "ip" also makes
the message more consistent with Linux' page_fault_entry
trace point.

Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 ksrc/nucleus/pod.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/ksrc/nucleus/pod.c b/ksrc/nucleus/pod.c
index 21763d5..37d35f5 100644
--- a/ksrc/nucleus/pod.c
+++ b/ksrc/nucleus/pod.c
@@ -2511,7 +2511,7 @@ int xnpod_trap_fault(xnarch_fltinfo_t *fltinfo)
 	thread = xnpod_current_thread();
 
 	trace_mark(xn_nucleus, thread_fault,
-		   "thread %p thread_name %s address %lu type %d",
+		   "thread %p thread_name %s ip %p type %d",
 		   thread, xnthread_name(thread), xnarch_fault_pc(fltinfo),
 		   xnarch_fault_trap(fltinfo));
 
-- 
1.6.4


