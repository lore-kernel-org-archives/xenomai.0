From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Date: Thu,  4 Jul 2013 21:31:17 +0200
Message-Id: <1372966277-2324-1-git-send-email-gilles.chanteperdrix@xenomai.org>
Subject: [Xenomai] [PATCH] x86/ipipe: fix compilation without I-pipe
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


Signed-off-by: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
---
 kernel/time/clocksource.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 84a290f..172d3c8 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -273,7 +273,9 @@ static void clocksource_watchdog(unsigned long data)
 retry:
 #endif
 		local_irq_disable();
+#ifdef CONFIG_IPIPE
 		wdref = watchdog->read(watchdog);
+#endif
 		csnow = cs->read(cs);
 		wdnow = watchdog->read(watchdog);
 		local_irq_enable();
-- 
1.7.2.5


