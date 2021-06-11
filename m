From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 09/17] lib/cobalt: Reorder low_init for having
 cobalt_use_legacy_tsc earlier available
Date: Fri, 11 Jun 2021 20:05:35 +0200
Message-Id: <1fe32dddc429e6cbbcca0d374faf0823803956e7.1623434743.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1623434743.git.jan.kiszka@siemens.com>
References: <cover.1623434743.git.jan.kiszka@siemens.com>
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

From: Jan Kiszka <jan.kiszka@siemens.com>

This is needed as cobalt_arch_check_features() will make use of
__cobalt_tsc_clockfreq via cobalt_use_legacy_tsc().

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 lib/cobalt/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/cobalt/init.c b/lib/cobalt/init.c
index 20e28ccb0..dcd63cad8 100644
--- a/lib/cobalt/init.c
+++ b/lib/cobalt/init.c
@@ -177,11 +177,11 @@ static void low_init(void)
 		early_panic("mlockall: %s", strerror(errno));
 
 	trace_me("memory locked");
+	cobalt_ticks_init(f->clock_freq);
 	cobalt_features_init(f);
 	cobalt_init_umm(f->vdso_offset);
 	trace_me("memory heaps mapped");
 	cobalt_init_current_keys();
-	cobalt_ticks_init(f->clock_freq);
 }
 
 static int cobalt_init_2(void);
-- 
2.26.2


