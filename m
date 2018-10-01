From: Philippe Gerum <rpm@xenomai.org>
Date: Mon,  1 Oct 2018 15:56:19 +0200
Message-Id: <20181001135619.24883-7-rpm@xenomai.org>
In-Reply-To: <20181001135619.24883-1-rpm@xenomai.org>
References: <20181001135619.24883-1-rpm@xenomai.org>
Subject: [Xenomai] [PATCH 6/6] demo/cyclictest: fix time delta calculation
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>

Otherwise, weird results could be seen when the second wraps, leading
to t1.nsec < t2.nsec, e.g.:

T: 0 ( 1107) P:98 I:1000 C:1886710 Min:      0 Act:    4 Avg:2147483647 Max:      -1
---
 demo/posix/cyclictest/cyclictest.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/demo/posix/cyclictest/cyclictest.c b/demo/posix/cyclictest/cyclictest.c
index 87f313836..ebe5461db 100644
--- a/demo/posix/cyclictest/cyclictest.c
+++ b/demo/posix/cyclictest/cyclictest.c
@@ -340,20 +340,23 @@ static inline int tsgreater(struct timespec *a, struct timespec *b)
 		(a->tv_sec == b->tv_sec && a->tv_nsec > b->tv_nsec));
 }
 
-static inline int64_t calcdiff(struct timespec t1, struct timespec t2)
+static inline int64_t calcdiff_ns(struct timespec t1, struct timespec t2)
 {
-	int64_t diff;
-	diff = USEC_PER_SEC * (long long)(t1.tv_sec - t2.tv_sec);
-	diff += (t1.tv_nsec - t2.tv_nsec) / 1000;
-	return diff;
+	struct timespec r;
+	
+	r.tv_sec = t1.tv_sec - t2.tv_sec;
+	r.tv_nsec = t1.tv_nsec - t2.tv_nsec;
+	if (r.tv_nsec < 0) {
+		r.tv_sec--;
+		r.tv_nsec += NSEC_PER_SEC;
+	}
+
+	return r.tv_sec * NSEC_PER_SEC + r.tv_nsec;
 }
 
-static inline int64_t calcdiff_ns(struct timespec t1, struct timespec t2)
+static inline int64_t calcdiff(struct timespec t1, struct timespec t2)
 {
-	int64_t diff;
-	diff = NSEC_PER_SEC * (int64_t)(t1.tv_sec - t2.tv_sec);
-	diff += (t1.tv_nsec - t2.tv_nsec);
-	return diff;
+	return calcdiff_ns(t1, t2) / 1000;
 }
 
 void traceopt(char *option)
-- 
2.14.4


