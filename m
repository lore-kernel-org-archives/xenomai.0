Date: Tue, 1 Apr 2008 12:46:36 +0200
From: Robert Schwebel <r.schwebel@domain.hid>
Message-ID: <20080401104636.GX13814@domain.hid>
References: <20080401103647.GR13814@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20080401103647.GR13814@domain.hid>
Subject: [Xenomai-core] [PATCH][SOLO] sparse: include sysClkRateGet
	declaration
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

sysLib.c:22:5: warning: symbol 'sysClkRateGet' was not declared. Should it be static?
sysLib.c:28:8: warning: symbol 'sysClkRateSet' was not declared. Should it be static?

Signed-off-by: Robert Schwebel <r.schwebel@domain.hid>

---
 vxworks/sysLib.c |    1 +
 1 file changed, 1 insertion(+)

Index: xenomai-solo/vxworks/sysLib.c
===================================================================
--- xenomai-solo.orig/vxworks/sysLib.c	2008-03-30 21:14:49.000000000 +0200
+++ xenomai-solo/vxworks/sysLib.c	2008-03-30 21:14:54.000000000 +0200
@@ -18,6 +18,7 @@
 
 #include "tickLib.h"
 #include <vxworks/errnoLib.h>
+#include <vxworks/sysLib.h>
 
 int sysClkRateGet(void)
 {
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9


