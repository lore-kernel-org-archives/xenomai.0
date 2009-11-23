From: Sebastian Smolorz <smolorz@domain.hid>
Date: Mon, 23 Nov 2009 15:21:32 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_sppCLwdYIf77sLz"
Message-Id: <200911231521.32461.smolorz@domain.hid>
Subject: [Xenomai-core] [PATCH] can: Free I/O region when unloading the
	xeno_can_isa.ko driver
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

--Boundary-00=_sppCLwdYIf77sLz
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

can: Free I/O region when unloading the xeno_can_isa.ko driver

Signed-off-by: Sebastian Smolorz <smolorz@domain.hid>


--Boundary-00=_sppCLwdYIf77sLz
Content-Type: text/x-patch;
  charset="us-ascii";
  name="rtcan_isa.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="rtcan_isa.diff"

diff --git a/ksrc/drivers/can/sja1000/rtcan_isa.c b/ksrc/drivers/can/sja1000/rtcan_isa.c
index 6debb16..ec32393 100644
--- a/ksrc/drivers/can/sja1000/rtcan_isa.c
+++ b/ksrc/drivers/can/sja1000/rtcan_isa.c
@@ -1,8 +1,8 @@
 /*
  * Copyright (C) 2006 Wolfgang Grandegger <wg@domain.hid>
  *
- * Copyright (C) 2005, 2006 Sebastian Smolorz
- *                          <Sebastian.Smolorz@domain.hid>
+ * Copyright (C) 2005, 2006, 2009 Sebastian Smolorz
+ *                               <smolorz@domain.hid>
  *
  *
  * This program is free software; you can redistribute it and/or modify it
@@ -189,6 +189,7 @@ static void rtcan_isa_exit(void)
 		if (!dev)
 			continue;
 		rtcan_sja1000_unregister(dev);
+		release_region(io[i], RTCAN_ISA_PORT_SIZE);
 		rtcan_dev_free(dev);
 	}
 }

--Boundary-00=_sppCLwdYIf77sLz--

