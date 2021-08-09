From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH] customizations: Fix runtime dependencies
Message-ID: <9ed08d45-d672-ddc6-3b42-41f6ae0029ca@siemens.com>
Date: Mon, 9 Aug 2021 08:04:57 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

We modify sshd_config, so we need the server to be installed already.
passwd is no longer needed, though.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-core/customizations/customizations.bb | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-core/customizations/customizations.bb b/recipes-core/customizations/customizations.bb
index e35c0a5..0faaff8 100644
--- a/recipes-core/customizations/customizations.bb
+++ b/recipes-core/customizations/customizations.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2018
+# Copyright (c) Siemens AG, 2018-2021
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -18,7 +18,7 @@ SRC_URI = " \
     file://ethernet \
     file://99-silent-printk.conf"
 
-DEBIAN_DEPENDS = "passwd"
+DEBIAN_DEPENDS = "openssh-server"
 
 do_install() {
 	install -v -d ${D}/etc/network/interfaces.d
-- 
2.31.1

