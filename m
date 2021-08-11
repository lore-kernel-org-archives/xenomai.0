From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v3 2/3] y2038: lib/cobalt/internal: dispatch event_wait
Date: Wed, 11 Aug 2021 15:50:25 +0200
Message-Id: <20210811135026.44400-3-florian.bezdeka@siemens.com>
In-Reply-To: <20210811135026.44400-1-florian.bezdeka@siemens.com>
References: <20210811135026.44400-1-florian.bezdeka@siemens.com>
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
64bit timespec, go to event_wait64.

otherwise, go to original event_wait.

Signed-off-by: Song Chen <chensong_2000@189.cn>
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/internal.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/cobalt/internal.c b/lib/cobalt/internal.c
index 75933a830..bf1e940b7 100644
--- a/lib/cobalt/internal.c
+++ b/lib/cobalt/internal.c
@@ -483,8 +483,13 @@ int cobalt_event_wait(cobalt_event_t *event,
 
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
+#ifdef __USE_TIME_BITS64
+	ret = XENOMAI_SYSCALL5(sc_cobalt_event_wait64,
+			       event, bits, bits_r, mode, timeout);
+#else
 	ret = XENOMAI_SYSCALL5(sc_cobalt_event_wait,
 			       event, bits, bits_r, mode, timeout);
+#endif
 
 	pthread_setcanceltype(oldtype, NULL);
 
-- 
2.30.2


