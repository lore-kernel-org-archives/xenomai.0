From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Date: Mon, 12 Oct 2015 19:40:26 +0200
Message-Id: <1444671627-20800-1-git-send-email-gilles.chanteperdrix@xenomai.org>
In-Reply-To: <561B7652.30508@siemens.com>
References: <561B7652.30508@siemens.com>
Subject: [Xenomai] [PATCH 1/2] ipipe: simplify __ipipe_check_perccpu_access()
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

by removing a redundant test.
---
 kernel/ipipe/core.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
index 0320453..b02883d 100644
--- a/kernel/ipipe/core.c
+++ b/kernel/ipipe/core.c
@@ -1736,11 +1736,10 @@ int notrace __ipipe_check_percpu_access(void)
 	 * currently stalled, in which case preemption would be
 	 * disabled, and no migration could occur.
 	 */
-	if (this_domain == ipipe_root_domain) {
-		p = raw_cpu_ptr(&ipipe_percpu.root);
-		if (test_bit(IPIPE_STALL_FLAG, &p->status) || preempt_count())
-			goto out;
-	}
+
+	p = raw_cpu_ptr(&ipipe_percpu.root);
+	if (test_bit(IPIPE_STALL_FLAG, &p->status) || preempt_count())
+		goto out;
 	/*
 	 * Our caller may end up accessing the wrong per-cpu variable
 	 * instance due to CPU migration; tell it to complain about
-- 
1.8.4


