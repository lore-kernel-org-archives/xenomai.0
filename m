From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH v2 4/7] cobalt/debug: prefer dump_stack() to show_stack()
Date: Sat, 27 Mar 2021 11:19:09 +0100
Message-Id: <20210327101912.2291474-5-rpm@xenomai.org>
In-Reply-To: <20210327101912.2291474-1-rpm@xenomai.org>
References: <20210327101912.2291474-1-rpm@xenomai.org>
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

dump_stack() also prints out the system information, which is always
good to have.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/cobalt/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cobalt/debug.c b/kernel/cobalt/debug.c
index f97144aeb..a6e2cc42d 100644
--- a/kernel/cobalt/debug.c
+++ b/kernel/cobalt/debug.c
@@ -592,7 +592,7 @@ int xnlock_dbg_release(struct xnlock *lock,
 				"          last owner = %s:%u (%s(), CPU #%d)\n",
 		       lock, cpu, lock->file, lock->line, lock->function,
 		       lock->cpu);
-		show_stack(NULL,NULL);
+		dump_stack();
 		return 1;
 	}
 
-- 
2.29.2


