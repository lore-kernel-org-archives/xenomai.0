From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] ci: Trigger xenomai-images child pipeline corresponding to
 main branches
Message-ID: <68880373-ea2c-1751-d611-8ffd39b84c7f@siemens.com>
Date: Wed, 12 May 2021 10:35:37 +0200
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

This couples pushing to next and stable branches with running
xenomai-images, and then only the affected child pipeline. Precondition
is setting XENOMAI_IMAGES_TOKEN as protected CI/CD variable.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index d8dc67f682..f6d2ee8843 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -10,6 +10,7 @@
 
 stages:
   - build
+  - test
 
 default:
   image: debian:buster
@@ -26,6 +27,7 @@ variables:
   PACKAGES_arm64: "gcc-8-aarch64-linux-gnu libc6-dev-arm64-cross"
   PACKAGES_powerpc: "gcc-8-powerpc-linux-gnu libc6-dev-powerpc-cross"
   PACKAGES_x86: ""
+  XENOMAI_IMAGES_BRANCH: "master"
 
 .build:
   stage: build
@@ -231,3 +233,14 @@ powerpc-4.19-release:
     PIPELINE_REV: ipipe-core-4.19..*-ppc32-.*
     PIPELINE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-ppc32.git
     KERNEL_DEFCONFIG: mpc5200_defconfig
+
+trigger-xenomai-images:
+  stage: test
+  image: curlimages/curl
+  script:
+    - curl -X POST -F "token=${XENOMAI_IMAGES_TOKEN}"
+           -F "ref=${XENOMAI_IMAGES_BRANCH}"
+           -F "variables[ONLY_RUN]=${CI_COMMIT_BRANCH}"
+           https://source.denx.de/api/v4/projects/479/trigger/pipeline
+  rules:
+    - if: '$XENOMAI_IMAGES_TOKEN != "" && ($CI_COMMIT_BRANCH == "next" || $CI_COMMIT_BRANCH =~ /stable\/.*/)'
-- 
2.26.2

