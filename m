From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] copperplate: Do not clear thread object pid on finalization
Message-ID: <f3dcde59-fbc0-6756-9f53-4ff5261b37dd@siemens.com>
Date: Fri, 13 Sep 2019 20:35:20 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

This field might be used by the finalizer callback and, thus, should
remain intact. Moreover, there is no safety benefit in clearing it.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 lib/copperplate/threadobj.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/copperplate/threadobj.c b/lib/copperplate/threadobj.c
index f46d8fb167..8e7c14a641 100644
--- a/lib/copperplate/threadobj.c
+++ b/lib/copperplate/threadobj.c
@@ -1515,7 +1515,6 @@ static void finalize_thread(void *p) /* thobj->lock free */
 	thobj->magic = ~thobj->magic;
 	pthread_setcanceltype(PTHREAD_CANCEL_DEFERRED, NULL);
 	threadobj_set_current(p);
-	thobj->pid = 0;
 
 	if (thobj->wait_sobj)
 		__syncobj_cleanup_wait(thobj->wait_sobj, thobj);
-- 
2.16.4

