From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 21/25] cobalt/clock: dovetail: implement
 pipeline_read_cycle_counter()
Date: Thu, 20 May 2021 23:44:31 +0200
Message-Id: <906c4ec217c4b624093ecc723b97bc1acc6ea41b.1621547075.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1621547075.git.jan.kiszka@siemens.com>
References: <cover.1621547075.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Hongzhan Chen <hongzhan.chen@intel.com>

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/dovetail/pipeline/clock.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/cobalt/kernel/dovetail/pipeline/clock.h b/include/cobalt/kernel/dovetail/pipeline/clock.h
index 82f02d4d77..6761ed70db 100644
--- a/include/cobalt/kernel/dovetail/pipeline/clock.h
+++ b/include/cobalt/kernel/dovetail/pipeline/clock.h
@@ -14,9 +14,7 @@ struct timespec64;
 static inline u64 pipeline_read_cycle_counter(void)
 {
 	/* Read the raw cycle counter of the core clock. */
-	TODO();
-
-	return 0;
+	return  ktime_get_raw_fast_ns();
 }
 
 void pipeline_set_timer_shot(unsigned long cycles);
-- 
2.26.2


