Date: Wed, 26 Mar 2008 22:36:44 +0800
From: jserv@domain.hid
Message-ID: <20080326143644.GB11244@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Disposition: inline
Subject: [Xenomai-core] [SOLO] [PATCH] Obtain proper prefix for testsuite
	build
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hello list,

  Currently, Xenomai/SOLO comes with testsuite for VxWorks emulation.
The path to Xenomai/SOLO installation is fixed.  The patch attempts to
obtain the proper prefix during build process.

Regards,
-jserv

diff --git a/vxworks/testsuite/Makefile b/vxworks/testsuite/Makefile
index 62430ff..13ca9a0 100644
--- a/vxworks/testsuite/Makefile
+++ b/vxworks/testsuite/Makefile
@@ -1,4 +1,4 @@
-SOLO := /usr/local/solo
+SOLO := $(shell sed -n '/^prefix/'p ../Makefile | cut -c 9-)
 XENO_CONFIG=$(SOLO)/bin/xeno-config
 prefix := $(shell $(XENO_CONFIG) --prefix)

