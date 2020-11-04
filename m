From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH 2/4] delete linux-xenomai_4.14
Date: Wed,  4 Nov 2020 17:11:52 +0100
Message-Id: <20201104161154.32366-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20201104161154.32366-1-Quirin.Gylstorff@siemens.com>
References: <20201104161154.32366-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, jan.kiszka@siemens.com

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Delete linux-xenomai_4.14 as it is no longer supported.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-kernel/linux/linux-xenomai_4.14.bb | 24 ----------------------
 1 file changed, 24 deletions(-)
 delete mode 100644 recipes-kernel/linux/linux-xenomai_4.14.bb

diff --git a/recipes-kernel/linux/linux-xenomai_4.14.bb b/recipes-kernel/linux/linux-xenomai_4.14.bb
deleted file mode 100644
index 8ffc66f..0000000
--- a/recipes-kernel/linux/linux-xenomai_4.14.bb
+++ /dev/null
@@ -1,24 +0,0 @@
-#
-# Xenomai Real-Time System
-#
-# Copyright (c) Siemens AG, 2018
-#
-# Authors:
-#  Jan Kiszka <jan.kiszka@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-require recipes-kernel/linux/linux-xenomai.inc
-
-SRC_URI_append_amd64 = " git://github.com/xenomai-ci/ipipe-x86.git;protocol=https;branch=ipipe-x86-4.14.y"
-SRCREV_amd64 = "fdfa1aff4578edf6a03e2e77ea20bf7f97863954"
-PV_amd64 = "4.14.134+"
-
-SRC_URI_append_arm64 = " git://github.com/xenomai-ci/ipipe-arm64.git;protocol=https;nobranch=1;tag=ipipe-core-4.14.78-arm64-2"
-PV_arm64 = "4.14.78+"
-
-SRC_URI_append_armhf = " git://github.com/xenomai-ci/ipipe-arm.git;protocol=https;nobranch=1;tag=ipipe-core-4.14.110-arm-7"
-PV_armhf = "4.14.110+"
-
-S = "${WORKDIR}/git"
-- 
2.20.1


