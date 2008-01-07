Message-ID: <4781EE0D.3060907@domain.hid>
Date: Mon, 07 Jan 2008 10:17:01 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050907050807090703050704"
Subject: [Adeos-main] [PATCH] 2.6.24-x86: fix mcount instrumentation
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

This is a multi-part message in MIME format.
--------------050907050807090703050704
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Refactorings of the top-level makefile broke mcount instrumentation for
ipipe. Fix it again.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

--------------050907050807090703050704
Content-Type: text/x-patch;
 name="fix-mcount.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-mcount.patch"

---
 Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.24-rc6-xeno_64/Makefile
===================================================================
--- linux-2.6.24-rc6-xeno_64.orig/Makefile
+++ linux-2.6.24-rc6-xeno_64/Makefile
@@ -510,7 +510,7 @@ endif
 include $(srctree)/arch/$(SRCARCH)/Makefile
 
 ifdef CONFIG_IPIPE_TRACE_MCOUNT
-CFLAGS          += -pg
+KBUILD_CFLAGS	+= -pg
 endif
 
 ifdef CONFIG_FRAME_POINTER

--------------050907050807090703050704--

