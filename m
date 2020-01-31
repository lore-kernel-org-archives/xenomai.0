From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 2/3] kernel/cobalt/posix: Fix cobalt_event_wait for
 COBALT_EVENT_ALL case
Date: Fri, 31 Jan 2020 15:37:59 +0100
Message-Id: <14607200d908a4c5bb585a70b951cd2ea27babdb.1580481480.git.jan.kiszka@siemens.com>
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
 kernel/cobalt/posix/event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cobalt/posix/event.c b/kernel/cobalt/posix/event.c
index 407ef8d8e1..c566a09e36 100644
--- a/kernel/cobalt/posix/event.c
+++ b/kernel/cobalt/posix/event.c
@@ -153,7 +153,7 @@ int __cobalt_event_wait(struct cobalt_event_shadow __user *u_event,
 
 	state->flags |= COBALT_EVENT_PENDED;
 	rbits = state->value & bits;
-	testval = mode & COBALT_EVENT_ANY ? rbits : state->value;
+	testval = mode & COBALT_EVENT_ANY ? rbits : bits;
 	if (rbits && rbits == testval)
 		goto done;
 
-- 
2.16.4


