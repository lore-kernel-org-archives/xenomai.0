From: Sebastian Smolorz <sebastian.smolorz@gmx.de>
Subject: [PATCH 2/3] cobalt/time: add missing include for old toolchains
Date: Tue, 30 Oct 2018 11:29:13 +0100
Message-Id: <1540895354-16866-3-git-send-email-sebastian.smolorz@gmx.de>
In-Reply-To: <1540895354-16866-1-git-send-email-sebastian.smolorz@gmx.de>
References: <1540895354-16866-1-git-send-email-sebastian.smolorz@gmx.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Without this patch compilation fails with

lib/cobalt/clock.c:251: error: conflicting types for '__wrap_clock_adjtime'
include/cobalt/time.h:43: error: previous declaration of '__wrap_clock_adjtime' was here
lib/cobalt/clock.c:251: error: conflicting types for '__cobalt_clock_adjtime'
include/cobalt/time.h:43: error: previous declaration of '__cobalt_clock_adjtime' was here

Signed-off-by: Sebastian Smolorz <sebastian.smolorz@gmx.de>
---
 include/cobalt/time.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/cobalt/time.h b/include/cobalt/time.h
index 9bafe34..6c65c77 100644
--- a/include/cobalt/time.h
+++ b/include/cobalt/time.h
@@ -23,6 +23,7 @@
 
 /* Re-read in case we came from selective __need* block. */
 #include_next <time.h>
+#include <sys/timex.h>
 #include <cobalt/wrappers.h>
 #include <cobalt/uapi/time.h>
 
-- 
2.7.4


