From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [xenomai-images PATCH] tests: restrict realtime cpu
Date: Wed, 23 Jun 2021 01:31:36 -0400
Message-Id: <20210623053136.22521-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, jan.kiszka@siemens.com

If there is no CPU restriction on the bootargs, smokey cpu_affinity
test would be skipped reporting with "no kernel support".

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>

diff --git a/tests/jobs/xenomai-beagle-bone-black.yml b/tests/jobs/xenomai-beagle-bone-black.yml
index 034ac99..8117f29 100644
--- a/tests/jobs/xenomai-beagle-bone-black.yml
+++ b/tests/jobs/xenomai-beagle-bone-black.yml
@@ -71,3 +71,5 @@ actions:
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
+context:
+  extra_kernel_args: xenomai.supported_cpus=1
diff --git a/tests/jobs/xenomai-hikey.yml b/tests/jobs/xenomai-hikey.yml
index f6eb4a4..5987c94 100644
--- a/tests/jobs/xenomai-hikey.yml
+++ b/tests/jobs/xenomai-hikey.yml
@@ -70,3 +70,5 @@ actions:
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
+context:
+  extra_kernel_args: xenomai.supported_cpus=1
diff --git a/tests/jobs/xenomai-ipc227e.yml b/tests/jobs/xenomai-ipc227e.yml
index a5a181c..7f3600d 100644
--- a/tests/jobs/xenomai-ipc227e.yml
+++ b/tests/jobs/xenomai-ipc227e.yml
@@ -72,3 +72,5 @@ actions:
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
+context:
+  extra_kernel_args: xenomai.supported_cpus=1
diff --git a/tests/jobs/xenomai-minnow.yml b/tests/jobs/xenomai-minnow.yml
index d5292ff..98c3eac 100644
--- a/tests/jobs/xenomai-minnow.yml
+++ b/tests/jobs/xenomai-minnow.yml
@@ -71,3 +71,5 @@ actions:
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
+context:
+  extra_kernel_args: xenomai.supported_cpus=1
diff --git a/tests/jobs/xenomai-qemu-amd64.yml b/tests/jobs/xenomai-qemu-amd64.yml
index c335292..b35a1a5 100644
--- a/tests/jobs/xenomai-qemu-amd64.yml
+++ b/tests/jobs/xenomai-qemu-amd64.yml
@@ -87,3 +87,5 @@ actions:
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
+context:
+  extra_kernel_args: xenomai.supported_cpus=1
diff --git a/tests/jobs/xenomai-qemu-arm64.yml b/tests/jobs/xenomai-qemu-arm64.yml
index 88fb880..27418ff 100644
--- a/tests/jobs/xenomai-qemu-arm64.yml
+++ b/tests/jobs/xenomai-qemu-arm64.yml
@@ -93,3 +93,5 @@ actions:
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
+context:
+  extra_kernel_args: xenomai.supported_cpus=1
diff --git a/tests/jobs/xenomai-qemu-armhf.yml b/tests/jobs/xenomai-qemu-armhf.yml
index 3e3a8ab..14501b7 100644
--- a/tests/jobs/xenomai-qemu-armhf.yml
+++ b/tests/jobs/xenomai-qemu-armhf.yml
@@ -87,3 +87,5 @@ actions:
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
+context:
+  extra_kernel_args: xenomai.supported_cpus=1
diff --git a/tests/jobs/xenomai-x86-64-efi.yml b/tests/jobs/xenomai-x86-64-efi.yml
index bc71b75..95b2288 100644
--- a/tests/jobs/xenomai-x86-64-efi.yml
+++ b/tests/jobs/xenomai-x86-64-efi.yml
@@ -72,3 +72,5 @@ actions:
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
+context:
+  extra_kernel_args: xenomai.supported_cpus=1
-- 
2.17.1


