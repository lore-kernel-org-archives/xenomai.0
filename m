From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] cobalt/dovetail: Resolve pipeline_clock_name TODO
Message-ID: <7724f1f3-85b7-4dcf-2993-d70ac49d5345@siemens.com>
Date: Mon, 29 Nov 2021 11:03:03 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

We don't have access to the kernel's curr_clocksource variable, so just
make a general statement.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/dovetail/pipeline/clock.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/cobalt/kernel/dovetail/pipeline/clock.h b/include/cobalt/kernel/dovetail/pipeline/clock.h
index d8c94ab435..cdb0dac4fe 100644
--- a/include/cobalt/kernel/dovetail/pipeline/clock.h
+++ b/include/cobalt/kernel/dovetail/pipeline/clock.h
@@ -40,10 +40,7 @@ const char *pipeline_timer_name(void);
 
 static inline const char *pipeline_clock_name(void)
 {
-	/* Return the name of the current clock source. */
-	TODO();
-
-	return "?";
+	return "<Linux clocksource>";
 }
 
 static inline int pipeline_get_host_time(struct timespec64 *tp)
-- 
2.31.1

