From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 22/25] lib/cobalt: ticks: drop cobalt_read_hrclock()
Date: Thu, 20 May 2021 23:44:32 +0200
Message-Id: <540d637ea4576c43502750c03cf91b5eecebb58d.1621547075.git.jan.kiszka@siemens.com>
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

From: Philippe Gerum <rpm@xenomai.org>

As we move away from the representation of time based on hardware
clock ticks, keeping cobalt_read_hrclock() makes no sense anymore.

This was an internal, undocumented service returning the hardware TSC
value for the platform. The log of commit #d584a57 which introduced it
clearly stated that applications should stick with the common
representation used by clock_gettime(), i.e. nanosecs.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/ticks.h | 2 --
 lib/cobalt/ticks.c     | 5 -----
 2 files changed, 7 deletions(-)

diff --git a/include/cobalt/ticks.h b/include/cobalt/ticks.h
index d9abd390af..2d0132db78 100644
--- a/include/cobalt/ticks.h
+++ b/include/cobalt/ticks.h
@@ -24,8 +24,6 @@
 extern "C" {
 #endif
 
-xnticks_t cobalt_read_hrclock(void);
-
 xnsticks_t cobalt_ticks_to_ns(xnsticks_t ticks);
 
 xnsticks_t cobalt_ticks_to_ns_rounded(xnsticks_t ticks);
diff --git a/lib/cobalt/ticks.c b/lib/cobalt/ticks.c
index 0e5682d832..89d7f51e38 100644
--- a/lib/cobalt/ticks.c
+++ b/lib/cobalt/ticks.c
@@ -99,11 +99,6 @@ unsigned long long cobalt_divrem_billion(unsigned long long value,
 }
 #endif /* !XNARCH_HAVE_NODIV_LLIMD */
 
-xnticks_t cobalt_read_hrclock(void)
-{
-	return cobalt_read_tsc();
-}
-
 void cobalt_ticks_init(unsigned long long freq)
 {
 	clockfreq = freq;
-- 
2.26.2


