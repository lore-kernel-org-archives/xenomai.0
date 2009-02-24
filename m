Message-ID: <49A3F793.3010204@domain.hid>
Date: Tue, 24 Feb 2009 14:35:15 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] Fix gatekeeper affinity
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

As the xnsched structures get initialized later, during xnpod_init,
xnsched_cpu always returned 0 in the gatekeeper_thread prologue. That
caused binding of all gatekeepers to CPU 0.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 ksrc/nucleus/shadow.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
index 1dedd85..2243c0e 100644
--- a/ksrc/nucleus/shadow.c
+++ b/ksrc/nucleus/shadow.c
@@ -823,11 +823,14 @@ static int gatekeeper_thread(void *data)
 	struct task_struct *this_task = current;
 	DECLARE_WAITQUEUE(wait, this_task);
 	struct xnsched *sched = data;
-	int cpu = xnsched_cpu(sched);
 	struct xnthread *target;
 	cpumask_t cpumask;
+	int cpu;
 	spl_t s;
 
+	/* sched not fully initialized, xnsched_cpu does not work yet */
+	cpu = sched - nkpod_struct.sched;
+
 	this_task->flags |= PF_NOFREEZE;
 	sigfillset(&this_task->blocked);
 	cpumask = cpumask_of_cpu(cpu);

