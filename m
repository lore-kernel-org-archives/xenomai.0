Message-ID: <4824197E.90709@domain.hid>
Date: Fri, 09 May 2008 11:29:34 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] Unfreeze timers when debugged target exits
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core@domain.hid

I expressed my skepticism about this global timer freeze before :->, and
now it hit me unpleasantly (Customer: "Is it normal that Xenomai stops
working after the gdb session?" Jan [scratching head]: "Hmm, no...").

After more scratching I think I found the reason: The target decided to
die after some fault, but Xenomai missed to unfreeze the timers. Patch
below fixes that.

Without hearing complains, this also goes into trunk/2.4.x later today.

Jan

---
 ksrc/nucleus/shadow.c |    3 +++
 1 file changed, 3 insertions(+)

Index: b/ksrc/nucleus/shadow.c
===================================================================
--- a/ksrc/nucleus/shadow.c
+++ b/ksrc/nucleus/shadow.c
@@ -2148,6 +2148,9 @@ static inline void do_taskexit_event(str
 	if (!thread)
 		return;
 
+	if (xnthread_test_info(thread, XNDEBUG))
+		unlock_timers();
+
 	if (xnpod_shadow_p())
 		xnshadow_relax(0);
 

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

