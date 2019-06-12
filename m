From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 3/5] cobalt/thread: Clear XNSYSRST when migrating to Linux
Date: Wed, 12 Jun 2019 17:31:16 +0200
Message-Id: <a20d958d5f11e56dc3592a341e171d7f3d13e313.1560353478.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1560353478.git.jan.kiszka@siemens.com>
References: <cover.1560353478.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1560353478.git.jan.kiszka@siemens.com>
References: <cover.1560353478.git.jan.kiszka@siemens.com>
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

This fixes the issue of spurious syscall-restart detection in
clock_nanosleep and select when a signal was delivered. In that case,
Linux replaces the ESYSRESTART with EINTR and does not perform any
restart attempt. As a signal delivery implies migration, clearing
XNSYSRST in the migration path resolves the issue.

Fixes: 36132cdb21cd ("cobalt/kernel: Allow to restart clock_nanosleep and select after signal processing")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/thread.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index eacdd9a089..666b4d4ca0 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -2171,6 +2171,11 @@ void xnthread_relax(int notify, int reason)
 		set_cpus_allowed_ptr(p, cpumask_of(cpu));
 	}
 #endif
+	/*
+	 * After migration there will be no syscall restart (rather a signal
+	 * delivery).
+	 */
+	xnthread_clear_localinfo(thread, XNSYSRST);
 
 	ipipe_clear_thread_flag(TIP_MAYDAY);
 
-- 
2.16.4


