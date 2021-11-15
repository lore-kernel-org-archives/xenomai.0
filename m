From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [xenomai-images][PATCH v3 8/8] xenomai-demo: Switch to Debian bullseye
Date: Mon, 15 Nov 2021 11:13:46 +0100
Message-Id: <20211115101346.3566075-9-florian.bezdeka@siemens.com>
In-Reply-To: <20211115101346.3566075-1-florian.bezdeka@siemens.com>
References: <20211115101346.3566075-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Switching from Debian buster to Debian bullseye as base for or xenomai-demo
distribution.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 conf/distro/xenomai-demo.conf | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/conf/distro/xenomai-demo.conf b/conf/distro/xenomai-demo.conf
index 1c9209d..4794584 100644
--- a/conf/distro/xenomai-demo.conf
+++ b/conf/distro/xenomai-demo.conf
@@ -9,12 +9,12 @@
 # SPDX-License-Identifier: MIT
 #
 
-require conf/distro/debian-buster.conf
+require conf/distro/debian-bullseye.conf
 
 PREFERRED_VERSION_xenomai ?= "3.1%"
 include conf/distro/include/xenomai-version.inc
 
-HOST_DISTRO ?= "debian-buster"
+HOST_DISTRO ?= "debian-bullseye"
 
 KERNEL_NAME = "xenomai"
 
-- 
2.30.2


