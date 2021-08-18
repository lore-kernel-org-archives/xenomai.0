From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [RFC PATCH 1/4] cobalt/registry: Make the root directory for proc
 exports optional
Date: Wed, 18 Aug 2021 13:24:04 +0200
Message-Id: <20210818112407.12264-2-florian.bezdeka@siemens.com>
In-Reply-To: <20210818112407.12264-1-florian.bezdeka@siemens.com>
References: <20210818112407.12264-1-florian.bezdeka@siemens.com>
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

Previously the root directory was mandatory, which means that exports
to the proc file system were forced to be located in
/proc/xenomai/registry/<root-dir>/<class>/<file>.

The <root-dir> virtual directory is now optional. If not supplied the
root node of <class> is set to registry_vfroot, which represents
/proc/xenomai/registry.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/registry.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/cobalt/registry.c b/kernel/cobalt/registry.c
index fa1de66c3..5cbebdc5b 100644
--- a/kernel/cobalt/registry.c
+++ b/kernel/cobalt/registry.c
@@ -242,8 +242,8 @@ static void proc_callback(struct work_struct *work)
 		pnode = object->pnode;
 		type = pnode->dirname;
 		dir = &pnode->vdir;
-		rdir = &pnode->root->vdir;
-		rname = pnode->root->dirname;
+		rdir = pnode->root ? &pnode->root->vdir : &registry_vfroot;
+		rname = pnode->root ? pnode->root->dirname : NULL;
 
 		if (object->vfilp != XNOBJECT_EXPORT_SCHEDULED)
 			goto unexport;
@@ -254,7 +254,7 @@ static void proc_callback(struct work_struct *work)
 		xnlock_put_irqrestore(&nklock, s);
 
 		if (pnode->entries++ == 0) {
-			if (pnode->root->entries++ == 0) {
+			if (pnode->root && pnode->root->entries++ == 0) {
 				/* Create the root directory on the fly. */
 				ret = xnvfile_init_dir(rname, rdir, &registry_vfroot);
 				if (ret) {
@@ -268,7 +268,7 @@ static void proc_callback(struct work_struct *work)
 			/* Create the class directory on the fly. */
 			ret = xnvfile_init_dir(type, dir, rdir);
 			if (ret) {
-				if (pnode->root->entries == 1) {
+				if (pnode->root && pnode->root->entries == 1) {
 					pnode->root->entries = 0;
 					xnvfile_destroy_dir(rdir);
 				}
@@ -282,7 +282,7 @@ static void proc_callback(struct work_struct *work)
 		ret = pnode->ops->export(object, pnode);
 		if (ret && --pnode->entries == 0) {
 			xnvfile_destroy_dir(dir);
-			if (--pnode->root->entries == 0)
+			if (pnode->root && --pnode->root->entries == 0)
 				xnvfile_destroy_dir(rdir);
 			xnlock_get_irqsave(&nklock, s);
 			object->pnode = NULL;
@@ -315,7 +315,7 @@ static void proc_callback(struct work_struct *work)
 
 		if (--pnode->entries == 0) {
 			xnvfile_destroy_dir(dir);
-			if (--pnode->root->entries == 0)
+			if (pnode->root && --pnode->root->entries == 0)
 				xnvfile_destroy_dir(rdir);
 		}
 
-- 
2.30.2


