Date: Tue, 1 Apr 2008 12:44:11 +0200
From: Robert Schwebel <r.schwebel@domain.hid>
Message-ID: <20080401104411.GU13814@domain.hid>
References: <20080401103647.GR13814@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20080401103647.GR13814@domain.hid>
Subject: [Xenomai-core] [PATCH][SOLO] sparse: clockobj_unmap not declared
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

clockobj.c:245:5: warning: symbol 'clockobj_unmap' was not declared. Should it be static?

Looks like the declaration for clockobj_unmap is missing.

Signed-off-by: Robert Schwebel <r.schwebel@domain.hid>

---
 include/xenomai/clockobj.h |    2 ++
 1 file changed, 2 insertions(+)

Index: xenomai-solo/include/xenomai/clockobj.h
===================================================================
--- xenomai-solo.orig/include/xenomai/clockobj.h	2008-03-30 19:53:51.000000000 +0200
+++ xenomai-solo/include/xenomai/clockobj.h	2008-03-30 19:54:04.000000000 +0200
@@ -66,6 +66,8 @@
 
 int clockobj_destroy(struct clockobj *clkobj);
 
+int clockobj_unmap(struct clockobj *clkobj);
+
 #ifdef __cplusplus
 }
 #endif
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9


