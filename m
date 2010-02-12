From: Andreas Glatz <andreasglatz@domain.hid>
Date: Fri, 12 Feb 2010 18:36:24 -0500
Message-ID: <1266017786-26290-2-git-send-email-andreasglatz@domain.hid>
In-Reply-To: <1266017786-26290-1-git-send-email-andreasglatz@domain.hid>
References: <1266017786-26290-1-git-send-email-andreasglatz@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Xenomai-help] [PATCH 1/3] native: Corrected spelling mistake in
	macro __xeno_flush_rq()
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

This spelling mistake causes the preprocessor not to substitute
a macro argument as it was originally intended by the author.

Signed-off-by: Andreas Glatz <andreasglatz@domain.hid>
---
 include/native/ppd.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/native/ppd.h b/include/native/ppd.h
index 3dbda6a..a02cc06 100644
--- a/include/native/ppd.h
+++ b/include/native/ppd.h
@@ -105,7 +105,7 @@ static inline xeno_rholder_t *xeno_get_rholder(void)
 			if (unlikely(err)) {				\
 				if ((__rq) != &__native_global_rholder.__name##q) { \
 					xnlock_get_irqsave(&nklock, s);	\
-					nholder = popq((rq), holder);	\
+					nholder = popq((__rq), holder);	\
 					appendq(&__native_global_rholder.__name##q, holder); \
 					obj->rqueue = &__native_global_rholder.__name##q; \
 				}					\
-- 
1.5.6.5


