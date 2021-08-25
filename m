From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v2 3/7] cobalt/posix/process: Adding a xnptree for exporting
 registry entries
Date: Wed, 25 Aug 2021 12:32:26 +0200
Message-Id: <20210825103230.27274-4-florian.bezdeka@siemens.com>
In-Reply-To: <20210825103230.27274-1-florian.bezdeka@siemens.com>
References: <20210825103230.27274-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Will be used later for exporting registry entries, namely named
semaphores as well as mqueues to
/proc/xenomai/registry/posix/{mqueue,sem}

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/posix/internal.h | 2 ++
 kernel/cobalt/posix/process.c  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/kernel/cobalt/posix/internal.h b/kernel/cobalt/posix/internal.h
index 15dfc3454..8b134d0a7 100644
--- a/kernel/cobalt/posix/internal.h
+++ b/kernel/cobalt/posix/internal.h
@@ -47,6 +47,8 @@
 
 #define cobalt_mark_deleted(t) ((t)->magic = ~(t)->magic)
 
+extern struct xnptree posix_ptree;
+
 static inline xnhandle_t cobalt_get_handle_from_user(xnhandle_t *u_h)
 {
 	xnhandle_t handle;
diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
index 1f059ad83..87b4893b3 100644
--- a/kernel/cobalt/posix/process.c
+++ b/kernel/cobalt/posix/process.c
@@ -83,6 +83,8 @@ static struct xnsynch yield_sync;
 
 LIST_HEAD(cobalt_global_thread_list);
 
+DEFINE_XNPTREE(posix_ptree, "posix");
+
 struct cobalt_resources cobalt_global_resources = {
 	.condq = LIST_HEAD_INIT(cobalt_global_resources.condq),
 	.mutexq = LIST_HEAD_INIT(cobalt_global_resources.mutexq),
-- 
2.30.2


