Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7C51F8901
	for <xenomai@lists.linux.dev>; Thu, 14 Nov 2024 12:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731586406; cv=none; b=aI1LPP9XKY5LzwP21XRRkWhvXEiB7AuisQpPEtll/kIFS2+1mqE1zYiazG8yVZtS9EpnabVv0XUEdT00Ht2IRJSosP5NgcvjhAZ+6cMSopG2sDlzusMMrkk4znPh2XXdgdb55epZMJp9YEaj9r1g+aJb/vRIJpIuv2PxVgQrags=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731586406; c=relaxed/simple;
	bh=GHSYlJuwpVOa6ml/52IqBlScnvkzbr+HYGusJNhy+IY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EoU1OFFa+zhI5ak3moJBfnTJlAJ/6mDId21P7EhtqBHNf66Yp9MxkopGITfPYaHqdcEBOaPlxpLFQkQucJL4J26CaU6z2j8y4VAbvJnUcX5mqkDBOGT48hj3EZVjnC+369w34Z4W8oJufdkbFBMu2L1dBSF2o+X13Xq/ys5dDGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=bP7mxFmr; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="bP7mxFmr"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202411141213161f068e8db004530b3f
        for <xenomai@lists.linux.dev>;
        Thu, 14 Nov 2024 13:13:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Q5u+cZtr2/2EHqxnNuU8u+5Q3h5fPKClglxtLAfDbXQ=;
 b=bP7mxFmrLhceh89HSKvXcBDo3hxqtL8UyXU6xjSRpXzECV9PrGlccrUkWagBgNvzVaAF4J
 FplPVB48904bv8VMpwQJZxDBje7q1H8D4tOw9SucmH86MCJULmf65zaqq7IFNo09OQTxrpQf
 YbL/Y1YLt9lGV70tDHc6WyPWk824rHwqi+lsk8ywpHWnUywsR4i1gHtuRDiHZanxiqH/cLWm
 BSmGt4LLVLGHO8Glwacjx8fHnxCmlC7cUHtCo0ArCrQEzBtUGEYLFbZreMvScRxx+/fiDKvj
 2ADqVZQh9BFkUO+PCCWyQlBEqwTpLcQmMrzrK51IZolG+ZcWq2FNBwcg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [xenomai-images][PATCH v2 1/2] ci: Add scheduled job to build lavacli container
Date: Thu, 14 Nov 2024 13:13:13 +0100
Message-ID: <499d32b8181f40c94f0a95448e6c01ea0f29ad7d.1731586394.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1731586394.git.jan.kiszka@siemens.com>
References: <cover.1731586394.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

We want to switch to self-built Debian containers with lavacli
pre-installed. That will speed-up the start of test jobs and avoid the
manual installation of lavacli in each of them. To keep that container
up to date, prepare a pipeline job that will be scheduled once a month
to perform a build and deployment to gitlab.com (source.denx.de lacks
a container registry).

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml        | 15 ++++++++++++++-
 ci/Dockerfile.lavacli | 17 +++++++++++++++++
 tests/README.md       |  5 +++++
 3 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100644 ci/Dockerfile.lavacli

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index b8945bc..6f9bcd6 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -12,9 +12,11 @@
 variables:
   LAVA_TESTS_ENABLED: "true"
   ALL_QEMU_JOBS: "false"
+  CONTAINER_REGISTRY: "registry.gitlab.com"
 
 stages:
   - parent
+  - build
 
 .parent:
   stage: parent
@@ -56,4 +58,15 @@ xenomai-3/next-long-term:
     include:
       - local: '/ci/xenomai_3_next_long_term.yml'
   rules:
-  - if: $CI_PIPELINE_SOURCE == "schedule"
+    - if: '$CI_PIPELINE_SOURCE == "schedule" && $ONLY_RUN == $CI_JOB_NAME'
+
+lavacli-container:
+  image: quay.io/buildah/stable
+  stage: build
+  before_script:
+    - buildah login -u "$CONTAINER_DEPLOY_TOKEN_USER" --password $CONTAINER_DEPLOY_TOKEN_PWD $CONTAINER_REGISTRY
+  script:
+    - buildah build -f ci/Dockerfile.lavacli -t $CONTAINER_REGISTRY/xenomai/xenomai-lava-container/lavacli .
+    - buildah push $CONTAINER_REGISTRY/xenomai/xenomai-lava-container/lavacli
+  rules:
+    - if: '$CI_PIPELINE_SOURCE == "schedule" && $ONLY_RUN == $CI_JOB_NAME'
diff --git a/ci/Dockerfile.lavacli b/ci/Dockerfile.lavacli
new file mode 100644
index 0000000..b3daa2a
--- /dev/null
+++ b/ci/Dockerfile.lavacli
@@ -0,0 +1,17 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2024
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+FROM debian:stable
+
+ARG DEBIAN_FRONTEND=noninteractive
+
+RUN apt-get update && \
+    apt-get install -y sudo gettext-base curl jq xmlstarlet lavacli
diff --git a/tests/README.md b/tests/README.md
index c3f05cd..b6421b4 100644
--- a/tests/README.md
+++ b/tests/README.md
@@ -110,6 +110,7 @@ The following variables are used and set by the ci system:
   - `LAVA_MASTER_TOKEN`: token to connect with the lava master
   - `LAVA_ARTIFACTS_URL`: optional variable where to get the artifacts for testing
   - `LAVA_MASTER_URL`: URL to the LAVA Master
+  - `CONTAINER_REGISTRY`: Container registry server to pull lavacli base image from. Uses registry.gitlab.com if unset.
 
 - Image deployment settings:
   - `USE_S3_BUCKET`: Set to `1` in order to upload build artifacts to AWS S3
@@ -120,6 +121,10 @@ The following variables are used and set by the ci system:
 - Build settings:
   - `BUILD_OPTIONS` : optional parameter. Used for triggers. Overwrite to build the newest ipipe together with xenomai or other combinations.
 
+- Scheduled lavacli container build (not needed if using official container):
+  - `CONTAINER_DEPLOY_TOKEN_USER`: Username of deploy token for uploading lavacli container to `CONTAINER_REGISTRY`
+  - `CONTAINER_DEPLOY_TOKEN_PWD`: Password of deploy token for uploading lavacli container to `CONTAINER_REGISTRY`
+
 ## LAVA Template variable
 
 - `TARGET`: Name of the target in the LAVA Lab
-- 
2.43.0

