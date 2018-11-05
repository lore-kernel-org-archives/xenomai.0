From: Mauro Salvini <mauro.salvini@smigroup.net>
Subject: [PATCH] copperplate/clockobj: prevent warning with -Wconversion
Date: Mon,  5 Nov 2018 14:03:28 +0100
Message-Id: <20181105130328.7771-1-mauro.salvini@smigroup.net>
In-Reply-To: <43f0ce47-d677-3600-1826-2f696d258936@siemens.com>
References: <43f0ce47-d677-3600-1826-2f696d258936@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

make cast explicit to avoid warning when user code is compiled with
-Wconversion

Signed-off-by: Mauro Salvini <mauro.salvini@smigroup.net>
---
 include/copperplate/clockobj.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/copperplate/clockobj.h b/include/copperplate/clockobj.h
index 8568794d9..24c748557 100644
--- a/include/copperplate/clockobj.h
+++ b/include/copperplate/clockobj.h
@@ -136,7 +136,7 @@ void clockobj_ns_to_timespec(ticks_t ns, struct timespec *ts)
 {
 	unsigned long rem;
 
-	ts->tv_sec = cobalt_divrem_billion(ns, &rem);
+	ts->tv_sec = (time_t)cobalt_divrem_billion(ns, &rem);
 	ts->tv_nsec = rem;
 }
 
-- 
2.11.0


