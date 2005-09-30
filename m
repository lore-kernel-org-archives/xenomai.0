Message-ID: <433D1E21.70005@domain.hid>
Date: Fri, 30 Sep 2005 19:14:41 +0800
From: Wen-chien Jesse Sung <jesse@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090302020403090802080505"
Subject: [Adeos-main] PATCH: fail to compile with CONFIG_IPIPE=n
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

This is a multi-part message in MIME format.
--------------090302020403090802080505
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 7bit

Hi,

When ipipe is disabled, ipipe_reset_stats() is not defined, but it is
still referenced in init/main.c:rest_init().

  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
init/built-in.o: In function `rest_init':
: undefined reference to `ipipe_reset_stats'
make: *** [.tmp_vmlinux1] Error 1

-- 
Best Regards,
Wen-chien Jesse Sung

--------------090302020403090802080505
Content-Type: text/x-patch;
	name="31_adeos-compilation-with-ipipe-disabled.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="31_adeos-compilation-with-ipipe-disabled.patch"

Index: linux-2.6.13-js1/include/linux/ipipe.h
===================================================================
--- linux-2.6.13-js1.orig/include/linux/ipipe.h	2005-09-30 14:53:01.000000000 +0800
+++ linux-2.6.13-js1/include/linux/ipipe.h	2005-09-30 18:56:32.000000000 +0800
@@ -702,6 +702,8 @@
 #define ipipe_irq_lock(irq)	do { } while(0)
 #define ipipe_irq_unlock(irq)	do { } while(0)
 
+#define ipipe_reset_stats()	do { } while(0)
+
 #endif	/* CONFIG_IPIPE */
 
 #endif	/* !__LINUX_IPIPE_H */

--------------090302020403090802080505--

