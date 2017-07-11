From: Henning Schild <henning.schild@siemens.com>
Date: Tue, 11 Jul 2017 13:32:13 +0200
Message-Id: <20170711113213.16427-2-henning.schild@siemens.com>
In-Reply-To: <20170711113213.16427-1-henning.schild@siemens.com>
References: <20170711113213.16427-1-henning.schild@siemens.com>
Subject: [Xenomai] [PATCH 2/2] lib/alchemy: change API context tags
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai @ xenomai . org" <xenomai@xenomai.org>

From: Henning Schild <henning.schild@siemens.com>

changing the prio always changes the secondary-mode thread as well
see:
  http://xenomai.org/migrating-from-xenomai-2-x-to-3-x/#Scheduling

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 lib/alchemy/task.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/alchemy/task.c b/lib/alchemy/task.c
index d647d5c0ee..12acafc495 100644
--- a/lib/alchemy/task.c
+++ b/lib/alchemy/task.c
@@ -1243,7 +1243,7 @@ RT_TASK *rt_task_self(void)
  * - -EPERM is returned if @a task is NULL and this service was called
  * from an invalid context.
  *
- * @apitags{mode-unrestricted, switch-primary}
+ * @apitags{mode-unrestricted, switch-primary, switch-secondary}
  *
  * @note The caller must be an Alchemy task if @a task is NULL.
  *
-- 
2.13.0


