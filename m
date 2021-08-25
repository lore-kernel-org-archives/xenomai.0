From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v2 2/7] cobalt/registry: Initialize refcnt of exported virtual
 proc files
Date: Wed, 25 Aug 2021 12:32:25 +0200
Message-Id: <20210825103230.27274-3-florian.bezdeka@siemens.com>
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

The refcnt field was never initialized and triggered a BUG() in
vfile_regular_release (vfile.c) when closing / releasing such a virtual
file.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/registry.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cobalt/registry.c b/kernel/cobalt/registry.c
index fa1de66c3..211e0f76f 100644
--- a/kernel/cobalt/registry.c
+++ b/kernel/cobalt/registry.c
@@ -403,6 +403,7 @@ static int registry_export_vfreg(struct xnobject *object,
 	object->vfile_u.vfreg.privsz = p->vfile.privsz;
 	object->vfile_u.vfreg.ops = p->vfile.ops;
 	object->vfile_u.vfreg.entry.lockops = p->vfile.lockops;
+	object->vfile_u.vfreg.entry.refcnt = 0;
 
 	ret = xnvfile_init_regular(object->key, &object->vfile_u.vfreg,
 				   &pnode->vdir);
-- 
2.30.2


