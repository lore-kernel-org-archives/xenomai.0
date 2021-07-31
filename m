From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v4 4/5] y2038: lib/cobalt/mutex: dispatch mutex_timedlock
Date: Sat, 31 Jul 2021 09:08:25 +0200
Message-Id: <20210731070826.67908-5-florian.bezdeka@siemens.com>
In-Reply-To: <20210731070826.67908-1-florian.bezdeka@siemens.com>
References: <20210731070826.67908-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Song Chen <chensong_2000@189.cn>

In case the libc in use reports a 64 bit time_t dispacht
mutex_timedlock to the kernel entry point that accepts it.

Signed-off-by: Song Chen <chensong_2000@189.cn>
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/mutex.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/cobalt/mutex.c b/lib/cobalt/mutex.c
index 29236c75a..73e45a1c4 100644
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
2.30.2


