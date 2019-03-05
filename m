From: roman.stratiienko@globallogic.com
Subject: [PATCH 7/7] travis: append v5.0 to the matrix
Date: Tue,  5 Mar 2019 16:45:21 +0200
Message-Id: <20190305144521.2567-7-roman.stratiienko@globallogic.com>
In-Reply-To: <20190305144521.2567-1-roman.stratiienko@globallogic.com>
References: <20190305144521.2567-1-roman.stratiienko@globallogic.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Roman Stratiienko <roman.stratiienko@globallogic.com>

From: Roman Stratiienko <roman.stratiienko@globallogic.com>

Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
---
 .travis.yml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 0807760f4..ab23b745d 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -46,6 +46,11 @@ script:
 
 matrix:
   include:
+    - env:
+      - ARCH: arm
+        KERNEL_VERSION: 5.0
+        KERNEL_DEFCONFIG: multi_v7_defconfig
+        IPIPE_URL: https://github.com/devel-opi/linux-ipipe-arm-porting/releases/download/v5.0-draft1/ipipe-arm-v5.0-draft.patch
     - env:
       - ARCH: arm
         KERNEL_VERSION: 4.20.7
-- 
2.17.1


