From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH 2/3] ci: Add new boards to ci
Date: Tue, 27 Aug 2019 11:07:51 +0200
Message-Id: <20190827090752.13072-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20190827090752.13072-1-Quirin.Gylstorff@siemens.com>
References: <20190827090752.13072-1-Quirin.Gylstorff@siemens.com>
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

To build the new boards add them to the ci configuration.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 89d2b29..deecfb1 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -5,23 +5,33 @@ variables:
   https_proxy: "$HTTPS_PROXY"
   ftp_proxy: "$FTP_PROXY"
   no_proxy: "$NO_PROXY"
-build:amd64:
+build:qemu-amd64:
   stage: build
   image: kasproject/kas-isar:latest
   script:
     - kas build kas.yml:board-qemu-amd64.yml
-build:armhf:
+build:qemu-armhf:
   stage: build
   image: kasproject/kas-isar:latest
   script:
     - kas build kas.yml:board-qemu-armhf.yml
-build:arm64:
+build:qemu-arm64:
   stage: build
   image: kasproject/kas-isar:latest
   script:
     - kas build kas.yml:board-qemu-arm64.yml
-build:hikey:
+build:board-hikey:
   stage: build
   image: kasproject/kas-isar:latest
   script:
     - kas build kas.yml:board-hikey.yml
+build:board-beaglebone:
+  stage: build
+  image: kasproject/kas-isar:latest
+  script:
+    - kas build kas.yml:board-beagle-bone-black.yml
+build:board-x86-64-efi:
+  stage: build
+  image: kasproject/kas-isar:latest
+  script:
+    - kas build kas.yml:board-x86-64-efi.yml
-- 
2.20.1


