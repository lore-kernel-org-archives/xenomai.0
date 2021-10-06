From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v5 2/3] y2038: lib/cobalt/rtdm: dispatch recvmmg
Date: Wed,  6 Oct 2021 15:54:14 +0200
Message-Id: <20211006135415.223689-3-florian.bezdeka@siemens.com>
In-Reply-To: <20211006135415.223689-1-florian.bezdeka@siemens.com>
References: <20211006135415.223689-1-florian.bezdeka@siemens.com>
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

If libc reports time64_t support, recvmmsg is dispatched to the
time64_t based syscall.

Signed-off-by: Song Chen <chensong_2000@189.cn>
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/rtdm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/cobalt/rtdm.c b/lib/cobalt/rtdm.c
index f3fb5d411..82323104a 100644
--- a/lib/cobalt/rtdm.c
+++ b/lib/cobalt/rtdm.c
@@ -272,7 +272,12 @@ COBALT_IMPL(int, recvmmsg, (int fd, struct mmsghdr *msgvec, unsigned int vlen,
 
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
+#ifdef __USE_TIME_BITS64
+	ret = XENOMAI_SYSCALL5(sc_cobalt_recvmmsg64, fd, msgvec,
+				vlen, flags, timeout);
+#else
 	ret = XENOMAI_SYSCALL5(sc_cobalt_recvmmsg, fd, msgvec, vlen, flags, timeout);
+#endif
 
 	pthread_setcanceltype(oldtype, NULL);
 
-- 
2.31.1


