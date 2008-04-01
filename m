Date: Tue, 1 Apr 2008 12:45:45 +0200
From: Robert Schwebel <r.schwebel@domain.hid>
Message-ID: <20080401104545.GW13814@domain.hid>
References: <20080401103647.GR13814@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20080401103647.GR13814@domain.hid>
Subject: [Xenomai-core] [PATCH][SOLO] sparse: include panic header file
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Sparse warns about this one:

panic.c:31:6: warning: symbol 'warning' was not declared. Should it be static?
panic.c:40:6: warning: symbol 'panic' was not declared. Should it be static?

Include the declarations.

Signed-off-by: Robert Schwebel <r.schwebel@domain.hid>

---
 base/panic.c |    1 +
 1 file changed, 1 insertion(+)

Index: xenomai-solo/base/panic.c
===================================================================
--- xenomai-solo.orig/base/panic.c	2008-03-30 20:51:06.000000000 +0200
+++ xenomai-solo/base/panic.c	2008-03-30 20:51:20.000000000 +0200
@@ -19,6 +19,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdarg.h>
+#include <xenomai/panic.h>
 
 static void __warning(const char *fmt, va_list ap)
 {
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9


