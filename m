Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C165A29
	for <xenomai@lists.linux.dev>; Tue, 28 Feb 2023 10:44:43 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20230228104435b4c8ce06f706dd5d4a
        for <xenomai@lists.linux.dev>;
        Tue, 28 Feb 2023 11:44:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=S3Gp/Hi54q8ZzeKDhnHP+Vkb04ajovz4F5jVcJfuPCc=;
 b=kiTgykFAO4Gg7SF8CboGwBjjJ0l/ijinIMc3LHFh2W9VPXpcdjYG4prKJDCSGO+qBx/bF3
 VmlYItNu/nw0+AIPyhzh2GJsSLJajPt4prsjk8WpqwX4+781cHFUGVzMOBb+de8wdt6xRBgY
 5yOu/srwzqsJXXK/bSZ5G3hM7IXfo=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [xenomai-images][PATCH 1/2] ci: Run qemu jobs only for the latest supported kernel version
Date: Tue, 28 Feb 2023 11:44:33 +0100
Message-Id: <20230228104434.15829-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Each branch (represented by the xenomai_<branch>.yml files) can now
define the latest kernel version that is supported by this branch. The
qemu build and test jobs will only be run for this kernel version.

Note: The stable/v3.0.x and stable/v3.1.x branches do not define a
latest kernel version. For those branches no qemu build and test jobs
will be scheduled. For stable/v3.0.x the situation is unchanged,
for stable/v3.1.x no qemu tasks will be scheduled anymore.

All qemu jobs can be re-enabled on pipeline creation time when the env
variale named ALL_QEMU_JOBS is set to "true". CI documentation has been
updated.

ALL_QEMU_JOBS and LAVA_TESTS_ENABLED might be feeded in by the gitlab UI
to limit the number of CI jobs.

We have to forward this variables to the downstream pipelines. Previously
they were defined with their default values in downstream pipelines which
made it impossible to overwrite the default from outside.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 .gitlab-ci.yml        |  7 +++++++
 ci/gitlab-ci-base.yml | 25 ++++++++++++++++++-------
 ci/xenomai_3_2_x.yml  |  1 +
 ci/xenomai_next.yml   |  1 +
 tests/README.md       |  4 ++++
 5 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 58398fc..58d61b1 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -9,6 +9,10 @@
 # SPDX-License-Identifier: MIT
 #
 
+variables:
+  LAVA_TESTS_ENABLED: "true"
+  ALL_QEMU_JOBS: "false"
+
 stages:
   - parent
 
@@ -16,6 +20,9 @@ stages:
   stage: parent
   trigger:
     strategy: depend
+  variables:
+    LAVA_TESTS_ENABLED: "${LAVA_TESTS_ENABLED}" 
+    ALL_QEMU_JOBS: "${ALL_QEMU_JOBS}"
   rules:
     - if: '$ONLY_RUN == null || $ONLY_RUN == $CI_JOB_NAME'
 
diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index ee71ea3..f1980b6 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -20,7 +20,6 @@ variables:
   no_proxy: "$NO_PROXY"
   ISAR_IMAGE: demo-image
   ISAR_DISTRIBUTION: xenomai-demo
-  LAVA_TESTS_ENABLED: "true"
   BUILD_IDENTIFIER: "xenomai-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
 
 default:
@@ -45,6 +44,12 @@ default:
     - kas build kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}:opt-ci.yml
     - if [ -n "${USE_S3_BUCKET}" ]; then scripts/deploy_to_aws.sh ${TARGET}; fi
 
+.build-qemu:
+  extends: .build
+  rules:
+    - if: '$KERNEL_VERSION == $LATEST_KERNEL_VERSION'
+    - if: '$ALL_QEMU_JOBS == "true"'
+
 .test:
   extends: .common-config
   stage: test
@@ -62,33 +67,39 @@ default:
   rules:
     - if: '$LAVA_TESTS_ENABLED == "true"'
 
+.test-qemu:
+  extends: .test
+  rules:
+    - if: '$KERNEL_VERSION == $LATEST_KERNEL_VERSION'
+    - if: '$ALL_QEMU_JOBS == "true"'
+
 .build:qemu-amd64:
-  extends: .build
+  extends: .build-qemu
   variables:
     TARGET: qemu-amd64
 
 .lava-test:qemu-amd64:
-  extends: .test
+  extends: .test-qemu
   variables:
     TARGET: qemu-amd64
 
 .build:qemu-armhf:
-  extends: .build
+  extends: .build-qemu
   variables:
     TARGET: qemu-armhf
 
 .lava-test:qemu-armhf:
-  extends: .test
+  extends: .test-qemu
   variables:
     TARGET: qemu-armhf
 
 .build:qemu-arm64:
-  extends: .build
+  extends: .build-qemu
   variables:
     TARGET: qemu-arm64
 
 .lava-test:qemu-arm64:
-  extends: .test
+  extends: .test-qemu
   variables:
     TARGET: qemu-arm64
 
diff --git a/ci/xenomai_3_2_x.yml b/ci/xenomai_3_2_x.yml
index 3ee0b7d..781eec8 100644
--- a/ci/xenomai_3_2_x.yml
+++ b/ci/xenomai_3_2_x.yml
@@ -20,3 +20,4 @@ include:
 variables:
   XENOMAI_BUILD_OPTION: ":opt-xenomai-3.2.x.yml"
   XENOMAI_VERSION: "3.2.x"
+  LATEST_KERNEL_VERSION: "5.15"
diff --git a/ci/xenomai_next.yml b/ci/xenomai_next.yml
index 3e4d513..b611e60 100644
--- a/ci/xenomai_next.yml
+++ b/ci/xenomai_next.yml
@@ -19,3 +19,4 @@ include:
 variables:
   XENOMAI_BUILD_OPTION: ":opt-xenomai-next.yml"
   XENOMAI_VERSION: "next"
+  LATEST_KERNEL_VERSION: "6.1"
diff --git a/tests/README.md b/tests/README.md
index 50942df..c092d54 100644
--- a/tests/README.md
+++ b/tests/README.md
@@ -106,6 +106,10 @@ The following variables are used and set by the ci system:
   - `ALT_DNS_SERVER`: optional, can be set to something like "8.8.8.8" to use a specific DNS server
   - `DISTRO_APT_PREMIRRORS`: optional, can be set to something like "deb\.debian\.org cdn-aws.deb.debian.org\n" to use a specific Debian mirror
 
+- CI job "filers":
+  - `ALL_QEMU_JOBS`: Default is false. Set to true to enable all qemu based jobs
+  - `LAVA_TESTS_ENABLED`: Default is true. Set to false to disable all LAVA jobs
+
 - LAVA settings:
   - `LAVA_MASTER_ACCOUNT`: lava master account name to register lavacli for test execution
   - `LAVA_MASTER_TOKEN`: token to connect with the lava master
-- 
2.39.2

