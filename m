From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH] Update/pin to kas 2.3.3
Message-ID: <e7f0c8fa-a709-1167-07b3-0641b11342ca@siemens.com>
Date: Thu, 17 Dec 2020 18:23:29 +0100
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

Pinning gives us longer stability. We implicitly had that as we were
still pulling from dockerhub which was deprecated.

The change to kas 2.3.3 brings the renaming to kas-container and removes
the need to specify "--isar".

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

At the risk of posting what you may also have in your queue already, 
Quirin.

 README.md                   | 10 +++++-----
 board-beagle-bone-black.yml |  2 +-
 board-hikey.yml             |  2 +-
 board-qemu-amd64.yml        |  2 +-
 board-qemu-arm64.yml        |  2 +-
 board-qemu-armhf.yml        |  2 +-
 board-x86-64-efi.yml        |  2 +-
 ci/gitlab-ci-base.yml       |  2 +-
 kas.yml                     |  4 +++-
 opt-ext4-gz.yml             |  2 +-
 opt-lava-test.yml           |  2 +-
 opt-linux-4.19.yml          |  2 +-
 opt-linux-4.4.yml           |  2 +-
 opt-linux-latest-5.4.yml    |  2 +-
 opt-linux-latest.yml        |  2 +-
 opt-xenomai-3.0.x.yml       |  2 +-
 opt-xenomai-next.yml        |  2 +-
 17 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/README.md b/README.md
index 5b84983..19d39dd 100644
--- a/README.md
+++ b/README.md
@@ -11,18 +11,18 @@ from scratch.
 
 ## Building Target Images
 
-Install `kas-docker` from the [kas project](https://github.com/siemens/kas):
+Install `kas-container` from the [kas project](https://github.com/siemens/kas):
 
-    wget https://raw.githubusercontent.com/siemens/kas/master/kas-docker -P ~/bin/
-    chmod a+x ~/bin/kas-docker
+    wget https://raw.githubusercontent.com/siemens/kas/2.3.3/kas-container -P ~/bin/
+    chmod a+x ~/bin/kas-container
 
 Furthermore, install docker and make sure you have required permissions to
 start containers.
 
-To build, e.g., the QEMU AMD64 target inside Docker, invoke kas-docker like
+To build, e.g., the QEMU AMD64 target inside Docker, invoke kas-container like
 this:
 
-    kas-docker --isar build kas.yml:board-qemu-amd64.yml
+    kas-container build kas.yml:board-qemu-amd64.yml
 
 This image can be run using `start-qemu.sh x86`.
 
diff --git a/board-beagle-bone-black.yml b/board-beagle-bone-black.yml
index e82d786..2da2977 100644
--- a/board-beagle-bone-black.yml
+++ b/board-beagle-bone-black.yml
@@ -10,6 +10,6 @@
 #
 
 header:
-  version: 8
+  version: 10
 
 machine: beagle-bone-black
diff --git a/board-hikey.yml b/board-hikey.yml
index a7408be..761782e 100644
--- a/board-hikey.yml
+++ b/board-hikey.yml
@@ -10,6 +10,6 @@
 #
 
 header:
-  version: 8
+  version: 10
 
 machine: hikey
diff --git a/board-qemu-amd64.yml b/board-qemu-amd64.yml
index 84bbfd7..100bed8 100644
--- a/board-qemu-amd64.yml
+++ b/board-qemu-amd64.yml
@@ -10,6 +10,6 @@
 #
 
 header:
-  version: 8
+  version: 10
 
 machine: qemu-amd64
diff --git a/board-qemu-arm64.yml b/board-qemu-arm64.yml
index 23dcb24..07e142d 100644
--- a/board-qemu-arm64.yml
+++ b/board-qemu-arm64.yml
@@ -10,6 +10,6 @@
 #
 
 header:
-  version: 8
+  version: 10
 
 machine: qemu-arm64
diff --git a/board-qemu-armhf.yml b/board-qemu-armhf.yml
index 393bf9d..889dd0d 100644
--- a/board-qemu-armhf.yml
+++ b/board-qemu-armhf.yml
@@ -10,6 +10,6 @@
 #
 
 header:
-  version: 8
+  version: 10
 
 machine: qemu-armhf
diff --git a/board-x86-64-efi.yml b/board-x86-64-efi.yml
index e926d95..225b7f8 100644
--- a/board-x86-64-efi.yml
+++ b/board-x86-64-efi.yml
@@ -10,6 +10,6 @@
 #
 
 header:
-  version: 8
+  version: 10
 
 machine: x86-64-efi
diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index 15fd74a..f7a9f77 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -24,7 +24,7 @@ variables:
   ISAR_DISTRIBUTION: xenomai-demo
 
 default:
-  image: kasproject/kas-isar:latest
+  image: ghcr.io/siemens/kas/kas-isar:2.3.3
 
 # add lavacli to the container and install the ssh keys
 # for the test infrastructure
diff --git a/kas.yml b/kas.yml
index 21ed533..c8bafcd 100644
--- a/kas.yml
+++ b/kas.yml
@@ -10,7 +10,9 @@
 #
 
 header:
-  version: 8
+  version: 10
+
+build_system: isar
 
 distro: xenomai-demo
 target: demo-image
diff --git a/opt-ext4-gz.yml b/opt-ext4-gz.yml
index 1a6502f..409bf62 100644
--- a/opt-ext4-gz.yml
+++ b/opt-ext4-gz.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 8
+  version: 10
 
 repos:
   isar:
diff --git a/opt-lava-test.yml b/opt-lava-test.yml
index 206aea0..9c33da6 100644
--- a/opt-lava-test.yml
+++ b/opt-lava-test.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 8
+  version: 10
 
 # lava uses nfs to deploy the image. For this we need a tarball instead of
 # full image
diff --git a/opt-linux-4.19.yml b/opt-linux-4.19.yml
index 1613e1c..fb3657f 100644
--- a/opt-linux-4.19.yml
+++ b/opt-linux-4.19.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 8
+  version: 10
 
 local_conf_header:
   linux-xenomai-latest: |
diff --git a/opt-linux-4.4.yml b/opt-linux-4.4.yml
index bb24a04..c4afa68 100644
--- a/opt-linux-4.4.yml
+++ b/opt-linux-4.4.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 8
+  version: 10
 
 local_conf_header:
   linux-xenomai-latest: |
diff --git a/opt-linux-latest-5.4.yml b/opt-linux-latest-5.4.yml
index 663ebbb..7767be4 100644
--- a/opt-linux-latest-5.4.yml
+++ b/opt-linux-latest-5.4.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 8
+  version: 10
 
 local_conf_header:
   linux-xenomai-latest: |
diff --git a/opt-linux-latest.yml b/opt-linux-latest.yml
index 6ce3a3b..78f4a43 100644
--- a/opt-linux-latest.yml
+++ b/opt-linux-latest.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 8
+  version: 10
 
 local_conf_header:
   linux-xenomai-latest: |
diff --git a/opt-xenomai-3.0.x.yml b/opt-xenomai-3.0.x.yml
index 591f3fc..4559de8 100644
--- a/opt-xenomai-3.0.x.yml
+++ b/opt-xenomai-3.0.x.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 8
+  version: 10
 
 local_conf_header:
   xenomai-3-0-x: |
diff --git a/opt-xenomai-next.yml b/opt-xenomai-next.yml
index 6efaa71..ba0b2da 100644
--- a/opt-xenomai-next.yml
+++ b/opt-xenomai-next.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 8
+  version: 10
 
 local_conf_header:
   xenomai-latest: |
-- 
2.26.2

