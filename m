From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 3/3] lib/copperplate: Fix eventobj_wait for COBALT_EVENT_ALL
 case
Date: Fri, 31 Jan 2020 15:38:00 +0100
Message-Id: <167f29892476b23976ec23669805c798b6d068ba.1580481480.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1580481480.git.jan.kiszka@siemens.com>
References: <cover.1580481480.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1580481480.git.jan.kiszka@siemens.com>
References: <cover.1580481480.git.jan.kiszka@siemens.com>
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

When we wait for all passed event bits to be set, we need to test for
those bits, not the ones that are currently pending. The current code
fails to detect that the condition is met when both the desired as well
as other events are already pending.

Reported by: Ronny Meeus <ronny.meeus@gmail.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 lib/copperplate/eventobj.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/copperplate/eventobj.c b/lib/copperplate/eventobj.c
index ff8c526282..dce5bd242f 100644
--- a/lib/copperplate/eventobj.c
+++ b/lib/copperplate/eventobj.c
@@ -217,7 +217,7 @@ int eventobj_wait(struct eventobj *evobj,
 	}
 
 	waitval = evobj->core.value & bits;
-	testval = mode & EVOBJ_ANY ? waitval : evobj->core.value;
+	testval = mode & EVOBJ_ANY ? waitval : bits;
 
 	if (waitval && waitval == testval) {
 		*bits_r = waitval;
-- 
2.16.4


