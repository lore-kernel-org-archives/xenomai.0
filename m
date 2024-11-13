Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C220F13B298
	for <xenomai@lists.linux.dev>; Wed, 13 Nov 2024 15:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731510819; cv=none; b=iKYLI4WI4RozKHgH3BTknFn5SoocpfM8RXi7XYj5vk3vz7UjOsGi4UgG2O3dmAR+cgZjUpa1O1/uYp5Q8mkqjnepePj9G6b1vzZvZffqlnPy0tLDTv9XIntNTWNGo1PjuNzbUSIbh7ZBR0TBhV4R8ZijB5RAW5Lp5k0zwQrhLjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731510819; c=relaxed/simple;
	bh=RtCRtENojDj6kizWIq51DLgEUZosLUznsXXLcX5AXSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AkVr0r8jgckPYCD+R190hlJ4Jf9bBNEKeUKvQC3OjAY9oyTkxDZPmRZQae9mSsfIiI5hJl/0lWiSvWU6I8I9qJLoyW/x91VB3Vtwi+gum6kJxZz3JECZlV07Tp/9VmSkNsddgmjU3BeZBGomnSMWQBzMB8qB9LK1ko3Kt/RkC7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=gfDBiHcs; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="gfDBiHcs"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20241113143314b581c53718c934b53c
        for <xenomai@lists.linux.dev>;
        Wed, 13 Nov 2024 15:33:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=+lfTAlk7bJt8kAab5c5+3Ysr9J3WAbfZzGEJNNKF5p0=;
 b=gfDBiHcszvMni6LPAz/OGPYoHDKAGt8SZyyjyjLw0hdcSs4aiJxEjD6zj7cNrFx3X2Mfbm
 6TimLGDqQqtWnc3RwXyxIhSTEBWCBcrUmmAP2hgXiEZeLVam6pVVc3POZ0/rwQafBgghIuH/
 5s9513VITSzg6fv8cFeveD2HXw+/GKZKjbl1Xnd25G/6WEwDDtcIoxDPbs2YekfKmjjDIhNT
 FXReGDN8I7TOI0uTjLg5BLLA5fbs7ldAguAfV6sg6QWqszOcrYK3kscMcK5pRVEcvAJkktAV
 1Dg9F59/Obws8YP+NiN56+OD0JsiTlIqgBgMJz4orerdDNHSHY62E1fQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [xenomai-images][PATCH 1/2] ci: Add scheduled job to build lavacli container
Date: Wed, 13 Nov 2024 15:33:12 +0100
Message-ID: <f1e1d2111b007f20009485359b45482d09934429.1731508393.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1731508393.git.jan.kiszka@siemens.com>
References: <cover.1731508393.git.jan.kiszka@siemens.com>
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
 .gitlab-ci.yml        | 14 +++++++++++++-
 ci/Dockerfile.lavacli | 17 +++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)
 create mode 100644 ci/Dockerfile.lavacli

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index b8945bc..37d2a6d 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -15,6 +15,7 @@ variables:
 
 stages:
   - parent
+  - build
 
 .parent:
   stage: parent
@@ -56,4 +57,15 @@ xenomai-3/next-long-term:
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
index 0000000..5d5725b
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
+    apt-get install -y sudo gettext-base jq xmlstarlet lavacli
-- 
2.43.0

