Message-ID: <54AFFD81.3030803@mitre.org>
Date: Fri, 9 Jan 2015 11:10:41 -0500
From: Jeffrey Melville <jmelville@mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH] doc: Fix return description for POSIX
 sched_get_priority functions.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

---

I found a minor issue in the documentation for scheduler priorities in
the 2.6.x tree. See the patch below.

Cheers,
Jeff

 ksrc/skins/posix/sched.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ksrc/skins/posix/sched.c b/ksrc/skins/posix/sched.c
index bdb79d3..b1af274 100644
--- a/ksrc/skins/posix/sched.c
+++ b/ksrc/skins/posix/sched.c
@@ -69,7 +69,7 @@
  * @param policy scheduling policy, one of SCHED_FIFO, SCHED_RR,
  * SCHED_SPORADIC, SCHED_TP or SCHED_OTHER.
  *
- * @retval 0 on success;
+ * @retval The minimum priority of @a policy on success;
  * @retval -1 with @a errno set if:
  * - EINVAL, @a policy is invalid.
  *
@@ -105,7 +105,7 @@ int sched_get_priority_min(int policy)
  * @param policy scheduling policy, one of SCHED_FIFO, SCHED_RR,
  * SCHED_SPORADIC, SCHED_TP or SCHED_OTHER.
  *
- * @retval 0 on success;
+ * @retval The maximum priority of @a policy on success;
  * @retval -1 with @a errno set if:
  * - EINVAL, @a policy is invalid.
  *
-- 
1.9.1

