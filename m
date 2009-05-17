From: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain
Date: Sun, 17 May 2009 16:54:57 +0200
Message-Id: <1242572097.17138.57.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Allow "break" statement in RTDM_EXECUTE_ATOMICALLY()
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>


Jan,

Would you consider allowing "break" for leaving an atomic code block as
illustrated below?

I understand this would create a potential issue with newer RTDM drivers
relying on this feature when backported to former RTDM implementations,
but only having if/else constructs to control the execution flow within
an atomic block may be painful sometimes and lead to uselessly hairy
code, especially for error handling.
Maybe adding another helper macro with the desired behavior, and
documenting it separately from RTDM_EXECUTE_ATOMICALLY() would mitigate
the portability issue?

Additionally, I would definitely shadow/hide the spl value from the code
block in a way or another, since using "s" as a socket identifier for
RTDM-based protocol drivers is not that unusual.

e.g.

diff --git a/include/rtdm/rtdm_driver.h b/include/rtdm/rtdm_driver.h
index 058a9f8..18b6001 100644
--- a/include/rtdm/rtdm_driver.h
+++ b/include/rtdm/rtdm_driver.h
@@ -595,14 +595,16 @@ int rtdm_select_bind(int fd, rtdm_selector_t *selector,
 	<LEAVE_ATOMIC_SECTION>			\
 }
 #else /* This is how it really works */
-#define RTDM_EXECUTE_ATOMICALLY(code_block)	\
-{						\
+#define RTDM_ATOMIC_BLOCK(code_block)		\
+do {						\
 	spl_t s;				\
-						\
 	xnlock_get_irqsave(&nklock, s);		\
-	code_block;				\
+	do {					\
+	  code_block;				\
+	} while(0);				\
 	xnlock_put_irqrestore(&nklock, s);	\
-}
+} while(0)
+#define RTDM_EXECUTE_ATOMICALLY(code_block)	RTDM_ATOMIC_BLOCK(code_block)
 #endif
 /** @} Global Lock across Scheduler Invocation */
 
-- 
Philippe.



