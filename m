From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 3/6] cobalt/registry: Adding a new xnptree for exporting posix
 entries
Date: Mon, 23 Aug 2021 17:00:28 +0200
Message-Id: <20210823150031.78791-4-florian.bezdeka@siemens.com>
In-Reply-To: <20210823150031.78791-1-florian.bezdeka@siemens.com>
References: <20210823150031.78791-1-florian.bezdeka@siemens.com>
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

Will be used later for exporting named semaphores as well as mqueues
to /proc/xenomai/registry/posix/{mqueue,sem}

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/registry.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/cobalt/registry.c b/kernel/cobalt/registry.c
index 211e0f76f..3c67b64e6 100644
--- a/kernel/cobalt/registry.c
+++ b/kernel/cobalt/registry.c
@@ -73,6 +73,8 @@ static int proc_virq;
 
 static struct xnvfile_directory registry_vfroot;
 
+DEFINE_XNPTREE(posix_ptree, "posix");
+
 static int usage_vfile_show(struct xnvfile_regular_iterator *it, void *data)
 {
 	xnvfile_printf(it, "%u/%u\n",
-- 
2.30.2


