Resent-To: Philippe Gerum <rpm@xenomai.org>
Resent-Message-Id: <4ADDA26D.3040004@domain.hid>
From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Tue, 20 Oct 2009 13:37:26 +0200
Message-ID: <20091020113725.9069.72976.stgit@domain.hid>
In-Reply-To: <20091020113724.9069.23594.stgit@domain.hid>
References: <20091020113724.9069.23594.stgit@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH v3 7/9] native: Do not requeue on
	auto-cleanup errors
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Migrating an object to the global queue in case of an error during
deletion is racy and may paper over potential bugs. Now that the main
reason for this approach is no longer existing (rt_heap/queue_delete
will not return EBUSY anymore), replace the requeueing with basic
consistency checks.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 include/native/ppd.h |   16 ++++------------
 1 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/include/native/ppd.h b/include/native/ppd.h
index 3dbda6a..c6e7479 100644
--- a/include/native/ppd.h
+++ b/include/native/ppd.h
@@ -101,19 +101,11 @@ static inline xeno_rholder_t *xeno_get_rholder(void)
 			xnlock_put_irqrestore(&nklock, s);		\
 			obj = rlink2##__name(holder);			\
 			err = rt_##__name##_delete(obj);		\
+			XENO_ASSERT(NATIVE, !err || err == -EIDRM, );	\
 			__xeno_trace_release(#__name, obj, err);	\
-			if (unlikely(err)) {				\
-				if ((__rq) != &__native_global_rholder.__name##q) { \
-					xnlock_get_irqsave(&nklock, s);	\
-					nholder = popq((rq), holder);	\
-					appendq(&__native_global_rholder.__name##q, holder); \
-					obj->rqueue = &__native_global_rholder.__name##q; \
-				}					\
-			} else {					\
-				if (__release)				\
-					__xeno_release_obj(obj);	\
-				xnlock_get_irqsave(&nklock, s);		\
-			}						\
+			if (!err && __release)				\
+				__xeno_release_obj(obj);		\
+			xnlock_get_irqsave(&nklock, s);			\
 		}							\
 		xnlock_put_irqrestore(&nklock, s);			\
 	} while(0)


