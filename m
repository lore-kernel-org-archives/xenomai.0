Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9B730FC0F
	for <xenomai@lists.linux.dev>; Thu, 18 Sep 2025 15:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210978; cv=none; b=N2TcO8fTdrmUkubidv864DLOXlU2bqNx5Q17/pCwFZDEv9xrtnvNtYguENvRDscyZ2+3J4wsUVrc0v1qA0Ek5LHYL/JS+JRkY9qbgdD/WL56uXfkb+KJRWbd5BVyThr03IErIx/XfD2jyvEAWjnYzHk6nDC5DtzjppkFcIockYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210978; c=relaxed/simple;
	bh=F8pT0j09uqdYOWeHGFZLaPNGHb1ETbdQAXAX6U1FrzE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JqXCfsT/Ah00OuY3YK850pjmtYbYa+Sb9nQfqx4BGbjNY2ufAGZLVJcR/+Mf6tPHcea+x/P+wZDinZFhkk28gEIxokvSaTHoJYHoqpbOF3EWljifZg235p+ySiYEtnwIya4nPsBxfhXlQreAKGpX1eeH9jGXh3boy/JKwhivgLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=GHmffcOV; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="GHmffcOV"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202509181556169f784e3e34000207b7
        for <xenomai@lists.linux.dev>;
        Thu, 18 Sep 2025 17:56:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=dIT8hN9JvT9Jfs8hsw7Fj0k8137gocPnv/eYfDLmy1w=;
 b=GHmffcOVgT8E7eRFa0EXMvxEC81moa4aOcU6UEh02/sfe9GTLgLi1G37DaP8366YDPGEAz
 Up3cExRxqMVaU1cIQzdVy/tAol0uN7kK+JThf4/ooA3gSwwUXheJj6XNKJksY7tKyNwfNlsN
 dM/p3FhbqMa9uuBLej9DYY0giGiFxjR//ALrC/EGnKXB4aumHU29V9sMD+I7sTJjwtXXtjdy
 Cx2RKWEGTmRuSmTpVg0d+mLznP897cdl2ryCMsqrzePTVud/Z9zREJ8p5xX+MvdQHDlIvzsj
 XgsUt3Wplyo5VhKMA4MOrgz4BEvbs807uX/PvWUrSoLAXJa7+atqcKKA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 12/13] ci: Enabled build tests for Xenomai 4
Date: Thu, 18 Sep 2025 17:55:54 +0200
Message-ID: <8c63ef4c2f7b77c1bc1cc928573d2306abd0a135.1758210955.git.jan.kiszka@siemens.com>
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

---
 .gitlab-ci.yml                  | 6 ++++++
 ci/gitlab-ci-base.yml           | 4 ++++
 ci/xenomai_3_next.yml           | 2 +-
 ci/xenomai_3_next_long_term.yml | 2 +-
 ci/xenomai_4_next.yml           | 2 +-
 5 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index c22a46a..d95d441 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -59,6 +59,12 @@ xenomai-3/next-long-term:
   rules:
     - if: '$CI_PIPELINE_SOURCE == "schedule" && $ONLY_RUN == $CI_JOB_NAME'
 
+xenomai-4/next:
+  extends: .parent
+  trigger:
+    include:
+      - local: '/ci/xenomai_4_next.yml'
+
 lavacli-container:
   image: quay.io/buildah/stable
   stage: build
diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index f461999..31c9414 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -107,6 +107,8 @@ default:
         - report.xml
     expire_in: 1 week
   rules:
+    - if: '$XENOMAI_VERSION == "4-next"'
+      when: never
     - if: '$LAVA_TESTS_ENABLED == "true"'
 
 .test-qemu:
@@ -115,6 +117,8 @@ default:
     ADDITIONAL_XENO_TEST_ARGS: "--vm"
     ADDITIONAL_TEST_TIMEOUT_MINUTES: 25
   rules:
+    - if: '$XENOMAI_VERSION == "4-next"'
+      when: never
     - if: '$LAVA_TESTS_ENABLED != "true"'
       when: never
     - if: '$KERNEL_VERSION == $LATEST_KERNEL_VERSION'
diff --git a/ci/xenomai_3_next.yml b/ci/xenomai_3_next.yml
index 9c984ba..15095dd 100644
--- a/ci/xenomai_3_next.yml
+++ b/ci/xenomai_3_next.yml
@@ -19,5 +19,5 @@ include:
 
 variables:
   XENOMAI_BUILD_OPTION: ":kas/opt/xenomai-next.yaml:kas/opt/debug.yaml"
-  XENOMAI_VERSION: "next"
+  XENOMAI_VERSION: "3-next"
   LATEST_KERNEL_VERSION: "6.12"
diff --git a/ci/xenomai_3_next_long_term.yml b/ci/xenomai_3_next_long_term.yml
index e62fc71..975bf34 100644
--- a/ci/xenomai_3_next_long_term.yml
+++ b/ci/xenomai_3_next_long_term.yml
@@ -15,7 +15,7 @@ include:
 
 variables:
   XENOMAI_BUILD_OPTION: ":kas/opt/xenomai-next.yaml"
-  XENOMAI_VERSION: "next"
+  XENOMAI_VERSION: "3-next"
   LATEST_KERNEL_VERSION: "6.12"
   TEST_RUNTIME_SECONDS: 3600
   TEST_COMMAND: "xeno-test -k -l 'dohell -m /tmp ${TEST_RUNTIME_SECONDS}' ${ADDITIONAL_XENO_TEST_ARGS} -- -m ${TEST_MAXIMUM_LATENCY}"
diff --git a/ci/xenomai_4_next.yml b/ci/xenomai_4_next.yml
index 78edc77..5fe06a0 100644
--- a/ci/xenomai_4_next.yml
+++ b/ci/xenomai_4_next.yml
@@ -16,7 +16,7 @@ include:
 
 variables:
   XENOMAI_BUILD_OPTION: ":kas/opt/libevl-next.yaml:kas/opt/debug.yaml"
-  XENOMAI_VERSION: "next"
+  XENOMAI_VERSION: "4-next"
   LATEST_KERNEL_VERSION: "6.12"
   BUILD_IDENTIFIER: "evl-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
   CACHE_KERNEL: evl
-- 
2.51.0

