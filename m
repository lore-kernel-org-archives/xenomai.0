Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1A430FC30
	for <xenomai@lists.linux.dev>; Thu, 18 Sep 2025 15:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210979; cv=none; b=ogB4pf1QIko0eQVRxnNPz90rYc5TVBcr4Ga4IwzFFphHR2SL6e7It+jxB+5SkWBF5VXs3Ixn+Loovfn2ebIGdSWK4H5oUKGtYZjmkSleyFk79UFxROONNGpit/pusfXOYch14TCB+bx3BKjjw8fkrI+o39s0hTwvOZxVOk1guyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210979; c=relaxed/simple;
	bh=+ICcYo2gez6tO7v00+wMBaVXNx1sd/iRNeXzVkJfNRY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qv4BzWZnMQg6i+Rh/cMjP6wPQteZ+DC2LOrOJJ4gPqgJesNXgtNZcRI88ftTsnIHUkkcmd0qCpWJ/3R+7fA03wXVGdND5dM4P9PwbNYltuVO/4AsHLvCUUeiPtLLawG6kf8ZUl0Q47pklMarIqG/Ct6vDswy8TNMmqVD4M8MUbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=tJl6vFXK; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="tJl6vFXK"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202509181556178bdb5ff4b20002072e
        for <xenomai@lists.linux.dev>;
        Thu, 18 Sep 2025 17:56:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=1mjm4L4034c7s2fFYLWCcXcyUmOUpzANwlyfNNccuc0=;
 b=tJl6vFXKtV88UYjuurUN4zKRBXI6MZBmSAZv5yS3gCGtG373C6slOXLWFQZg24AisOS5s6
 oHrFpdOzIcwAFaUq3Ppv2gmtkYYiOMQzoN/LaRq5eROZ2qcx5G6Yn5SDQhRwJ+V96Pe8A32G
 twnQirTRJmCLCJDmorBAF0wy1PwPvhwL0mIx+zxojFUL5/000SCLhKoxOyvceLKZ3vg3DEzy
 ctClTMR/W8j7Vq/WkbpZ/pS6OYdzl0NEMBXZ52TkqXpnqmrcIyzWtz+czGvJMzRSA63X7jKl
 vh5URmUFSoNBO86iKcueL/g48FIe4gf4EdgbTYHpl//0IKgMjrgiWuag==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 13/13] ci: Improve lavacli container generation
Date: Thu, 18 Sep 2025 17:55:55 +0200
Message-ID: <2c7c1342e3d6599a1809a5d75dad378af6eadc9c.1758210955.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1758210955.git.jan.kiszka@siemens.com>
References: <cover.1758210955.git.jan.kiszka@siemens.com>
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

We can use the CI variables for authentication and for identifying the
image name. We should use a pinned buildah container to avoid pulling
fishy versions automatically. And we can shrink the container a bit by
skipping recommended packages on installation. Finally, we should use a
tagged runner to be prepared for the case that our runners only accepts
tagged jobs.

These changes also align us with what was just adopted and tested by
isar-cip-core.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml        | 10 ++++++----
 ci/Dockerfile.lavacli |  2 +-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index d95d441..2f03fdd 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -66,12 +66,14 @@ xenomai-4/next:
       - local: '/ci/xenomai_4_next.yml'
 
 lavacli-container:
-  image: quay.io/buildah/stable
+  image: quay.io/buildah/stable:v1.41.4
   stage: build
+  tags:
+    - build
   before_script:
-    - buildah login -u "$CONTAINER_DEPLOY_TOKEN_USER" --password $CONTAINER_DEPLOY_TOKEN_PWD $CONTAINER_REGISTRY
+    - buildah login -u $CI_REGISTRY_USER --password $CI_REGISTRY_PASSWORD $CI_REGISTRY
   script:
-    - buildah build -f ci/Dockerfile.lavacli -t $CONTAINER_REGISTRY/xenomai/xenomai-images/lavacli .
-    - buildah push $CONTAINER_REGISTRY/xenomai/xenomai-images/lavacli
+    - buildah build -f ci/Dockerfile.lavacli -t $CI_REGISTRY_IMAGE/lavacli .
+    - buildah push $CI_REGISTRY_IMAGE/lavacli
   rules:
     - if: '$CI_PIPELINE_SOURCE == "schedule" && $ONLY_RUN == $CI_JOB_NAME'
diff --git a/ci/Dockerfile.lavacli b/ci/Dockerfile.lavacli
index b3daa2a..58f3cc2 100644
--- a/ci/Dockerfile.lavacli
+++ b/ci/Dockerfile.lavacli
@@ -14,4 +14,4 @@ FROM debian:stable
 ARG DEBIAN_FRONTEND=noninteractive
 
 RUN apt-get update && \
-    apt-get install -y sudo gettext-base curl jq xmlstarlet lavacli
+    apt-get install -y --no-install-recommends sudo gettext-base curl jq xmlstarlet lavacli
-- 
2.51.0

