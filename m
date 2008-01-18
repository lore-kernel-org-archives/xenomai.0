Message-ID: <47908D51.9010800@domain.hid>
Date: Fri, 18 Jan 2008 12:28:17 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000308020805090400080904"
Subject: [Adeos-main] [PATCH] remove __ipipe_serial_debug from production
	setup
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
--------------000308020805090400080904
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

IMHO there is no need for __ipipe_serial_debug in a production kernel.
Let's make it depend on CONFIG_IPIPE_DEBUG.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

--------------000308020805090400080904
Content-Type: text/x-patch;
 name="avoid-serial-debug-bloat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="avoid-serial-debug-bloat.patch"

---
 drivers/serial/8250.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.24-rc8-xeno_64/drivers/serial/8250.c
===================================================================
--- linux-2.6.24-rc8-xeno_64.orig/drivers/serial/8250.c
+++ linux-2.6.24-rc8-xeno_64/drivers/serial/8250.c
@@ -2546,7 +2546,7 @@ static int serial8250_console_early_setu
 	return serial8250_find_port_for_earlycon();
 }
 
-#ifdef CONFIG_IPIPE
+#ifdef CONFIG_IPIPE_DEBUG
 
 #include <stdarg.h>
 

--------------000308020805090400080904--

