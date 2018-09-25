From: Philippe Gerum <rpm@xenomai.org>
Date: Tue, 25 Sep 2018 12:37:50 +0200
Message-Id: <20180925103809.4932-14-rpm@xenomai.org>
In-Reply-To: <20180925103809.4932-1-rpm@xenomai.org>
References: <20180925103809.4932-1-rpm@xenomai.org>
Subject: [Xenomai] [PATCH 13/32] x86/kgdb: ipipe: enable support from head
 domain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Make sure the KGDB notifier can run over the head domain sanely by
manipulating the hardware interrupt state (not the virtual one).
---
 arch/x86/kernel/kgdb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
index 8e36f249646e..c9ff690c23ca 100644
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -598,9 +598,9 @@ kgdb_notify(struct notifier_block *self, unsigned long cmd, void *ptr)
 	unsigned long flags;
 	int ret;
 
-	local_irq_save(flags);
+	flags = hard_local_irq_save();
 	ret = __kgdb_notify(ptr, cmd);
-	local_irq_restore(flags);
+	hard_local_irq_restore(flags);
 
 	return ret;
 }
-- 
2.14.4


