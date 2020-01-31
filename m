From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 6/8] cobalt/registry: prevent use-after-free triggered by
 object removal
Date: Fri, 31 Jan 2020 16:27:11 +0100
Message-Id: <20200131152713.1811748-7-rpm@xenomai.org>
In-Reply-To: <20200131152713.1811748-1-rpm@xenomai.org>
References: <20200131152713.1811748-1-rpm@xenomai.org>
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

Since the vfile export and unexport operations are asynchronous,
returning from xnregistry_remove() is no guarantee that the registered
object won't be further accessed, especially by the vfile export
handler.

Plug this race at least for all in-band callers removing objects while
running on root stage like RTIPC protocols by synchronizing with the
workqueue which handles deferred export/unexport requests, before
returning from xnregistry_remove().

This does not cover the issue of removing objects from the head
stage. Fortunately, all users of the vfile export/unexport mechanism
are unregistering objects from the root stage only (typically some
RTDM close() handler).

This issue was reported by KASAN.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/cobalt/registry.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/cobalt/registry.c b/kernel/cobalt/registry.c
index 9dfd66b06..4b01abd63 100644
--- a/kernel/cobalt/registry.c
+++ b/kernel/cobalt/registry.c
@@ -850,8 +850,12 @@ int xnregistry_remove(xnhandle_t handle)
 			 * Leave the update of the object queues to
 			 * the work callback if it has been kicked.
 			 */
-			if (object->pnode)
-				goto unlock_and_exit;
+			if (object->pnode) {
+				xnlock_put_irqrestore(&nklock, s);
+				if (ipipe_root_p)
+					flush_work(&registry_proc_work);
+				return 0;
+			}
 		}
 #endif /* CONFIG_XENO_OPT_VFILE */
 
-- 
2.24.1


