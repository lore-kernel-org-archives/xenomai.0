From: roman.stratiienko@globallogic.com
Subject: [PATCH v2 05/10] kernel: cobalt: trace: replace dummy array with field
Date: Wed,  6 Mar 2019 19:53:26 +0200
Message-Id: <20190306175331.25444-5-roman.stratiienko@globallogic.com>
In-Reply-To: <20190306175331.25444-1-roman.stratiienko@globallogic.com>
References: <20190306175331.25444-1-roman.stratiienko@globallogic.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Roman Stratiienko <roman.stratiienko@globallogic.com>

From: Roman Stratiienko <roman.stratiienko@globallogic.com>

After kernel v4.18 commit 4a0772cf0674
("tracing: Prevent further users of zero size static arrays in trace events")
creating zero length arrays will force compile-time error

This will fix BUILD_BUG_ON error on v4.18 and later

Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
---
Since v1: Changed to __field
 kernel/cobalt/trace/cobalt-posix.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cobalt/trace/cobalt-posix.h b/kernel/cobalt/trace/cobalt-posix.h
index 77392e725..910ef876a 100644
--- a/kernel/cobalt/trace/cobalt-posix.h
+++ b/kernel/cobalt/trace/cobalt-posix.h
@@ -266,7 +266,7 @@ DECLARE_EVENT_CLASS(cobalt_void,
 	TP_PROTO(int dummy),
 	TP_ARGS(dummy),
 	TP_STRUCT__entry(
-		__array(char, dummy, 0)
+		__field(int, dummy)
 	),
 	TP_fast_assign(
 		(void)dummy;
-- 
2.17.1


