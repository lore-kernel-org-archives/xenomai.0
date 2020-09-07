From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 1/6] ipipe: fix build with CONFIG_IPIPE disabled
Date: Mon,  7 Sep 2020 15:09:33 +0200
Message-Id: <20200907130938.416831-1-rpm@xenomai.org>
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
 kernel/fork.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index e73964a45fb5..a5d3aa5dd4c7 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -845,8 +845,10 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 #endif
 
 	setup_thread_stack(tsk, orig);
+#ifdef CONFIG_IPIPE
 	__ipipe_init_threadflags(task_thread_info(tsk));
 	__ipipe_init_threadinfo(&task_thread_info(tsk)->ipipe_data);
+#endif
 	clear_user_return_notifier(tsk);
 	clear_tsk_need_resched(tsk);
 	set_task_stack_end_magic(tsk);
-- 
2.26.2


