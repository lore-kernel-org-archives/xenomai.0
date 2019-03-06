From: roman.stratiienko@globallogic.com
Subject: [PATCH v2 10/10] travis: append i-pipe arm-v4.20.7 and arm-v5.0 to
 the matrix
Date: Wed,  6 Mar 2019 19:53:31 +0200
Message-Id: <20190306175331.25444-10-roman.stratiienko@globallogic.com>
In-Reply-To: <20190306175331.25444-1-roman.stratiienko@globallogic.com>
References: <20190306175331.25444-1-roman.stratiienko@globallogic.com>
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
 .travis.yml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 24889ca5f..ab23b745d 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -46,6 +46,16 @@ script:
 
 matrix:
   include:
+    - env:
+      - ARCH: arm
+        KERNEL_VERSION: 5.0
+        KERNEL_DEFCONFIG: multi_v7_defconfig
+        IPIPE_URL: https://github.com/devel-opi/linux-ipipe-arm-porting/releases/download/v5.0-draft1/ipipe-arm-v5.0-draft.patch
+    - env:
+      - ARCH: arm
+        KERNEL_VERSION: 4.20.7
+        KERNEL_DEFCONFIG: multi_v7_defconfig
+        IPIPE_URL: https://github.com/devel-opi/linux-ipipe-arm-porting/releases/download/draft-v4.20.7/0001-Draft-version-of-ipipe-arm-ported-on-v4.20.7.patch
     - env:
       - ARCH: arm
         KERNEL_VERSION: 4.14.85
-- 
2.17.1


