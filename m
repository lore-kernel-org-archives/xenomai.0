Message-ID: <49B641A2.40503@domain.hid>
Date: Tue, 10 Mar 2009 11:32:02 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <49B62D9A.9030406@domain.hid>
In-Reply-To: <49B62D9A.9030406@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH v2] Suppress switch warnings while debugging
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

Don't raise SIGXCPU while the process is being debugged. These mode
changes are expected, and reporting them doesn't provide any helpful
information to the application. Rather, it may raise error storms on the
application side.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 ksrc/nucleus/shadow.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
index bcf3b8b..12b4073 100644
--- a/ksrc/nucleus/shadow.c
+++ b/ksrc/nucleus/shadow.c
@@ -667,7 +667,7 @@ static inline void request_syscall_restart(xnthread_t *thread,
 			__xn_error_return(regs,
 					  (sysflags & __xn_exec_norestart) ?
 					  -ERESTARTNOHAND : -ERESTARTSYS);
-			notify = 1;
+			notify = !xnthread_test_state(thread, XNDEBUG);
 		}
 
 		xnthread_clear_info(thread, XNKICKED);

