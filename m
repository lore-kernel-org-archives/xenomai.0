Message-ID: <47B9551B.1070409@domain.hid>
Date: Mon, 18 Feb 2008 10:51:23 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [PATCH] fix ipipe_preempt_disable for !CONFIG_IPIPE
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

---
 include/linux/ipipe_base.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/include/linux/ipipe_base.h
===================================================================
--- a/include/linux/ipipe_base.h
+++ b/include/linux/ipipe_base.h
@@ -78,7 +78,7 @@ static inline void ipipe_check_context(s
 #define ipipe_preempt_disable(flags)	do { \
 						preempt_disable(); \
 						(void)(flags); \
-					while (0)
+					} while (0)
 #define ipipe_preempt_enable(flags)	preempt_enable()
 #define ipipe_check_context(ipd)	do { } while(0)
 #endif	/* CONFIG_IPIPE */

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

