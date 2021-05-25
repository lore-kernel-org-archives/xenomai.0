Sender: chensong_2000@189.cn
From: Song Chen <chensong_2000@189.cn>
Subject: [PATCH 2/3] y2038: lib/cobalt/mutex: dispatch mutex_timedlock
Date: Tue, 25 May 2021 11:03:43 +0800
Message-Id: <1621911823-29031-1-git-send-email-chensong_2000@189.cn>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: florian.bezdeka@siemens.com, xenomai@xenomai.org

If sizeof time_t bigger than 4, which means glibc supports
64bit timespec, go to mutex_timedlock64.

otherwise, go to original mutex_timedlock.

Signed-off-by: Song Chen <chensong_2000@189.cn>
---
 lib/cobalt/mutex.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/cobalt/mutex.c b/lib/cobalt/mutex.c
index 29236c7..73e45a1 100644
--- a/lib/cobalt/mutex.c
+++ b/lib/cobalt/mutex.c
@@ -479,7 +479,11 @@ slow_path:
 	}
 
 	do {
+#ifdef __USE_TIME_BITS64
+		ret = XENOMAI_SYSCALL2(sc_cobalt_mutex_timedlock64, _mutex, to);
+#else
 		ret = XENOMAI_SYSCALL2(sc_cobalt_mutex_timedlock, _mutex, to);
+#endif
 	} while (ret == -EINTR);
 
 	if (ret == 0)
-- 
2.7.4


