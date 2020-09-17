From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] cobalt/posix/sem: Fix invalid parameter in tracepoint
Message-ID: <b3b66012-7db1-cfd6-88c4-c0dacb943a61@siemens.com>
Date: Thu, 17 Sep 2020 17:55:01 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
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

This not just traces garbage, it usually crashes the system one the
tracepoint is enabled.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
  kernel/cobalt/posix/sem.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cobalt/posix/sem.c b/kernel/cobalt/posix/sem.c
index b02667e5f0..05a861dfe3 100644
--- a/kernel/cobalt/posix/sem.c
+++ b/kernel/cobalt/posix/sem.c
@@ -502,7 +502,7 @@ COBALT_SYSCALL(sem_broadcast_np, current,
  	int ret;

  	handle = cobalt_get_handle_from_user(&u_sem->handle);
-	trace_cobalt_psem_broadcast(u_sem->handle);
+	trace_cobalt_psem_broadcast(handle);

  	xnlock_get_irqsave(&nklock, s);

-- 
2.26.2

