From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5669484d-19e6-a2a3-b08b-9ac6a34cab1c@siemens.com>
Date: Fri, 13 Apr 2018 19:49:19 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH] copperplate: Remove redundant cleanups
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

We are running this section with cancellation deferred, so no
termination possible, thus nothing to clean up.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 lib/copperplate/traceobj.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/copperplate/traceobj.c b/lib/copperplate/traceobj.c
index d10c47905..8a3f4f5e6 100644
--- a/lib/copperplate/traceobj.c
+++ b/lib/copperplate/traceobj.c
@@ -200,11 +200,9 @@ static void dump_marks_on_error(struct traceobj *trobj)
 
 	CANCEL_DEFER(svc);
 
-	push_cleanup_lock(&trobj->lock);
 	read_lock(&trobj->lock);
 	dump_marks(trobj);
 	read_unlock(&trobj->lock);
-	pop_cleanup_lock(&trobj->lock);
 
 	CANCEL_RESTORE(svc);
 }
-- 
2.13.6

