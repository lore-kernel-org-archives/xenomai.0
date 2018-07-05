From: Jan Kiszka <jan.kiszka@siemens.com>
Date: Thu,  5 Jul 2018 17:46:09 +0200
Message-Id: <7369128ddd8ae9f447d76377ac8844fa40949353.1530805570.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1530805570.git.jan.kiszka@siemens.com>
References: <cover.1530805570.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1530805570.git.jan.kiszka@siemens.com>
References: <cover.1530805570.git.jan.kiszka@siemens.com>
Subject: [Xenomai] [PATCH 2/4] cobalt/posix/signal: Replace RT-unsafe
	printk_ratelimit with xnclock_ratelimit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/posix/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cobalt/posix/signal.c b/kernel/cobalt/posix/signal.c
index 8e4d920b2d..39e4733f69 100644
--- a/kernel/cobalt/posix/signal.c
+++ b/kernel/cobalt/posix/signal.c
@@ -153,7 +153,7 @@ struct cobalt_sigpending *cobalt_signal_alloc(void)
 	struct cobalt_sigpending *sigp;
 
 	if (list_empty(&sigpending_pool)) {
-		if (printk_ratelimit())
+		if (xnclock_ratelimit())
 			printk(XENO_WARNING "signal bucket pool underflows\n");
 		return NULL;
 	}
-- 
2.16.4


