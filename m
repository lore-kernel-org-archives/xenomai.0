From: Jan Kiszka <jan.kiszka@siemens.com>
References: <ac9368a5-6f44-64ae-5999-0e60d2d9ffb8@siemens.com>
Message-ID: <2b01c1f9-46a0-62cd-e83e-7dd33dc2586f@siemens.com>
Date: Wed, 2 May 2018 18:34:33 +0200
MIME-Version: 1.0
In-Reply-To: <ac9368a5-6f44-64ae-5999-0e60d2d9ffb8@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH 2/2] cobalt/synch: Do not drop PP on
 xnsynch_release if it wasn't committed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

We must not try to drop the prio ceiling in the kernel if it wasn't
committed yet. That could easily happen when using a prio-ceiling mutex
to wait on a cond-var.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/synch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cobalt/synch.c b/kernel/cobalt/synch.c
index 8c217c247..c65c07aac 100644
--- a/kernel/cobalt/synch.c
+++ b/kernel/cobalt/synch.c
@@ -942,7 +942,7 @@ bool xnsynch_release(struct xnsynch *synch, struct xnthread *curr)
 	 */
 	xnlock_get_irqsave(&nklock, s);
 
-	if (synch->status & XNSYNCH_PP) {
+	if (synch->status & XNSYNCH_CEILING) {
 		clear_pp_boost(synch, curr);
 		need_resched = true;
 	}
-- 
2.13.6

