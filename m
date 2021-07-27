Sender: chensong_2000@189.cn
From: Song Chen <chensong_2000@189.cn>
Subject: [PATCH 2/3] y2038: lib/cobalt/internal: dispatch event_wait
Date: Tue, 27 Jul 2021 14:55:44 +0800
Message-Id: <1627368944-12861-1-git-send-email-chensong_2000@189.cn>
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
64bit timespec, go to event_wait64.

otherwise, go to original event_wait.

Signed-off-by: Song Chen <chensong_2000@189.cn>
---
 lib/cobalt/internal.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/cobalt/internal.c b/lib/cobalt/internal.c
index eadb064..ef3f163 100644
--- a/lib/cobalt/internal.c
+++ b/lib/cobalt/internal.c
@@ -482,8 +482,13 @@ int cobalt_event_wait(cobalt_event_t *event,
 
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
+#ifdef __USE_TIME_BITS64
+	ret = XENOMAI_SYSCALL5(sc_cobalt_event_wait64,
+			       event, bits, bits_r, mode, timeout);
+#else
 	ret = XENOMAI_SYSCALL5(sc_cobalt_event_wait,
 			       event, bits, bits_r, mode, timeout);
+#endif
 
 	pthread_setcanceltype(oldtype, NULL);
 
@@ -579,4 +584,4 @@ void cobalt_features_init(struct cobalt_featinfo *f)
 
 	/* Trigger arch specific feature initialization */
 	cobalt_arch_check_features(f);
-}
\ No newline at end of file
+}
-- 
2.7.4


