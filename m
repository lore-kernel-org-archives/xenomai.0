Message-ID: <48295098.10204@domain.hid>
Date: Tue, 13 May 2008 10:26:00 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] Flush xnfree backlog after thread deletion
	in root context
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

The lazy xnfree mechanism turned out to be too lazy: Just run some
testsuite program and what /proc/xenomai/heap - it will not reach the
level it has on freshly booted box.

The reason is that TCBs of threads that are released over the ROOT
thread will only get purged after the next schedule-to-ROOT. And if
there is no more Xenomai thread scheduling in the system, this won't
happen. It can even leave your system useless if you ran into
out-of-heap with allocating TCBs, and the remaining heap is now too
small to start at least one thread again (happened to customer). Patch
below fixes this by adding an xnfreesync to the related code path.

However, I wonder if we shouldn't better run all those deferred releases
in Linux context with only O(1) critical path lengths. Why risking to
pile up a large backlog of TCBs when releasing a lot of threads in a
row? That may degrade system latency. What about pushing this into some
VIRQ over the Linux domain, releasing the nklock once after each
iteration?

Jan

Index: xenomai-2.4.x/ksrc/nucleus/pod.c
===================================================================
--- xenomai-2.4.x/ksrc/nucleus/pod.c	(Revision 3764)
+++ xenomai-2.4.x/ksrc/nucleus/pod.c	(Arbeitskopie)
@@ -1236,6 +1236,9 @@ void xnpod_delete_thread(xnthread_t *thr
 		xnthread_cleanup_tcb(thread);
 
 		xnarch_finalize_no_switch(xnthread_archtcb(thread));
+
+		if (xnthread_test_state(sched->runthread, XNROOT))
+			xnfreesync();
 	}
 
       unlock_and_exit:

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

