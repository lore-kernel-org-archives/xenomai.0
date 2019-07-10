From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 2/2] alchemy/mutex: Fix typo in comment
Date: Wed, 10 Jul 2019 23:46:12 +0200
Message-Id: <20190710214612.27506-2-richard@nod.at>
In-Reply-To: <20190710214612.27506-1-richard@nod.at>
References: <20190710214612.27506-1-richard@nod.at>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Richard Weinberger <richard@nod.at>

s/rt_mutex_acquite/rt_mutex_acquire

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 lib/alchemy/mutex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/alchemy/mutex.c b/lib/alchemy/mutex.c
index ffdc2dbea323..42cd1375b34b 100644
--- a/lib/alchemy/mutex.c
+++ b/lib/alchemy/mutex.c
@@ -182,7 +182,7 @@ out:
  *
  * - -EBUSY is returned upon an attempt to destroy the object
  * referenced by @a mutex while it is referenced (for example, while
- * being used in a rt_mutex_acquite(), rt_mutex_acquire_timed() or
+ * being used in a rt_mutex_acquire(), rt_mutex_acquire_timed() or
  * rt_mutex_acquire_until() by another task).
  *
  * @apitags{mode-unrestricted, switch-secondary}
-- 
2.16.4


