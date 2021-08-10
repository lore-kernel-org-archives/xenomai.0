From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v2 2/3] y2038: lib/cobalt/signal: dispatch sigtimedwait
Date: Tue, 10 Aug 2021 17:27:10 +0200
Message-Id: <20210810152711.227714-3-florian.bezdeka@siemens.com>
In-Reply-To: <20210810152711.227714-1-florian.bezdeka@siemens.com>
References: <20210810152711.227714-1-florian.bezdeka@siemens.com>
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

If sizeof time_t bigger than 4, which means glibc supports
64bit timespec, go to sigtimedwait64.

otherwise, go to original sigtimedwait.

Signed-off-by: Song Chen <chensong_2000@189.cn>
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/signal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/cobalt/signal.c b/lib/cobalt/signal.c
index 7e033019a..40d315ebb 100644
--- a/lib/cobalt/signal.c
+++ b/lib/cobalt/signal.c
@@ -62,7 +62,11 @@ COBALT_IMPL(int, sigtimedwait, (const sigset_t *set, siginfo_t *si,
 
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
+#ifdef __USE_TIME_BITS64
+	ret = XENOMAI_SYSCALL3(sc_cobalt_sigtimedwait64, set, si, timeout);
+#else
 	ret = XENOMAI_SYSCALL3(sc_cobalt_sigtimedwait, set, si, timeout);
+#endif
 	if (ret < 0) {
 		errno = -ret;
 		ret = -1;
-- 
2.30.2


