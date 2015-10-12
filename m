From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Date: Mon, 12 Oct 2015 19:40:27 +0200
Message-Id: <1444671627-20800-2-git-send-email-gilles.chanteperdrix@xenomai.org>
In-Reply-To: <1444671627-20800-1-git-send-email-gilles.chanteperdrix@xenomai.org>
References: <561B7652.30508@siemens.com>
 <1444671627-20800-1-git-send-email-gilles.chanteperdrix@xenomai.org>
Subject: [Xenomai] [PATCH 2/2] ipipe: fix __ipipe_check_percpu_access()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

Use preemptible() instead of testing the preempt_count and the stall
flags, since using preemptible() also works when CONFIG_PREEMPT_COUNT is
not defined.
---
 kernel/ipipe/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
index b02883d..d7c8934 100644
--- a/kernel/ipipe/core.c
+++ b/kernel/ipipe/core.c
@@ -1738,7 +1738,7 @@ int notrace __ipipe_check_percpu_access(void)
 	 */
 
 	p = raw_cpu_ptr(&ipipe_percpu.root);
-	if (test_bit(IPIPE_STALL_FLAG, &p->status) || preempt_count())
+	if (!preemptible())
 		goto out;
 	/*
 	 * Our caller may end up accessing the wrong per-cpu variable
-- 
1.8.4


