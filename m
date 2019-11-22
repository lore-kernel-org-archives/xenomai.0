From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 2/7] cobalt/thread: update inline documentation
Date: Fri, 22 Nov 2019 18:19:44 +0100
Message-Id: <20191122171949.18021-3-rpm@xenomai.org>
In-Reply-To: <20191122171949.18021-1-rpm@xenomai.org>
References: <20191122171949.18021-1-rpm@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Philippe Gerum <rpm@xenomai.org>

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/cobalt/thread.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index 666b4d4ca..a95396a0d 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -1012,16 +1012,16 @@ void xnthread_suspend(struct xnthread *thread, int mask,
 	 * We only care for threads that are not current, and for
 	 * XNSUSP, XNDELAY, XNDORMANT and XNHELD conditions, because:
 	 *
-	 * - There is no point in dealing with relaxed threads, since
-	 * personalities have to ask for primary mode switch when
-	 * processing any syscall which may block the caller
-	 * (i.e. __xn_exec_primary).
+	 * - There is no point in dealing with a relaxed thread which
+	 * is current, since personalities have to ask for primary
+	 * mode switch when processing any syscall which may block the
+	 * caller (i.e. __xn_exec_primary).
 	 *
 	 * - among all blocking bits (XNTHREAD_BLOCK_BITS), only
-	 * XNSUSP, XNDELAY and XNHELD may be applied by the current
-	 * thread to a non-current thread. XNPEND is always added by
-	 * the caller to its own state, XNMIGRATE and XNRELAX have
-	 * special semantics escaping this issue.
+	 * XNSUSP, XNDELAY, XNHELD and XNDBGSTOP may be applied by the
+	 * current thread to a non-current thread. XNPEND is always
+	 * added by the caller to its own state, XNMIGRATE, XNRELAX
+	 * and XNDBGSTOP have special semantics escaping this issue.
 	 *
 	 * We don't signal threads which are already in a dormant
 	 * state, since they are suspended by definition.
-- 
2.21.0


