From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH 4/9] beagle-bone-black: Add Devicetree and
 fake-hwclock
Date: Thu,  5 Sep 2019 17:44:20 +0200
Message-Id: <20190905154425.10007-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20190905154425.10007-1-Quirin.Gylstorff@siemens.com>
References: <20190905154425.10007-1-Quirin.Gylstorff@siemens.com>
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

To deploy the target with LAVA it is necessary to use a devicetree.
Isar extracts the tree from the kernel build and stores the tree
in the deploy-DIR

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 conf/machine/beagle-bone-black.conf | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/conf/machine/beagle-bone-black.conf b/conf/machine/beagle-bone-black.conf
index 73abe12..90b9f13 100644
--- a/conf/machine/beagle-bone-black.conf
+++ b/conf/machine/beagle-bone-black.conf
@@ -14,5 +14,6 @@ DISTRO_ARCH = "armhf"
 IMAGE_INSTALL += "u-boot-script"
 
 IMAGE_TYPE ?= "wic-img"
-
+DTB_FILE = "am335x-boneblack.dtb"
 IMAGER_INSTALL += "u-boot-omap"
+IMAGE_PREINSTALL += "fake-hwclock"
-- 
2.20.1


