From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 8/8] ipipe: Drop unneeded NULL check from grab_timer
Date: Wed, 27 Mar 2019 14:18:07 +0100
Message-Id: <3b1f196cc80bdc753eb2b1adfd1436a74435acd2.1553692686.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1553692686.git.jan.kiszka@siemens.com>
References: <cover.1553692686.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1553692686.git.jan.kiszka@siemens.com>
References: <cover.1553692686.git.jan.kiszka@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, Philippe Gerum <rpm@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

If evtdev should be NULL, we will crash on get_dev_mode(evtdev) further
down. So this test is never false in absence of sever bugs.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/ipipe/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/ipipe/timer.c b/kernel/ipipe/timer.c
index 1471a4ed85ea..22d5e5be874a 100644
--- a/kernel/ipipe/timer.c
+++ b/kernel/ipipe/timer.c
@@ -452,7 +452,7 @@ static void grab_timer(void *arg)
 		return;
 	}
 
-	steal = evtdev != NULL && !clockevent_state_detached(evtdev);
+	steal = !clockevent_state_detached(evtdev);
 	if (steal && evtdev->ipipe_stolen == 0) {
 		timer->real_mult = evtdev->mult;
 		timer->real_shift = evtdev->shift;
-- 
2.16.4


