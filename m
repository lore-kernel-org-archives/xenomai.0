From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH] distro/xenomai-demo: Update to Debian 10
Date: Wed, 14 Aug 2019 16:24:14 +0200
Message-Id: <20190814142414.25331-1-Quirin.Gylstorff@siemens.com>
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
To: xenomai@xenomai.org

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Debian 10 (Buster) was released and Stretch is now old stable, update
the distribution to the latest stable version.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 conf/distro/xenomai-demo.conf | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/conf/distro/xenomai-demo.conf b/conf/distro/xenomai-demo.conf
index 1fb7838..2610548 100644
--- a/conf/distro/xenomai-demo.conf
+++ b/conf/distro/xenomai-demo.conf
@@ -9,9 +9,9 @@
 # SPDX-License-Identifier: MIT
 #
 
-require conf/distro/debian-stretch.conf
+require conf/distro/debian-buster.conf
 
-HOST_DISTRO ?= "debian-stretch"
+HOST_DISTRO ?= "debian-buster"
 
 KERNEL_NAME = "xenomai"
 
-- 
2.20.1


