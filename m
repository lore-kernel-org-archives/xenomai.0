Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF61F2BE644
	for <xenomai@lists.linux.dev>; Tue, 13 Jan 2026 11:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768304407; cv=none; b=Y4pYXv8XQLu/wj9Jrkin3bx4GYNbl3tJQlWgWuqG9lE6OImtaOtKtBR9BGCW2/433FhT4fciI/AsK4OMAjr6lCOJRGZE7o2vmd5R2SJeTGEAFbPRjWWS+AKYLqMXkwuVWFrav8A9y0ByOFtq524N8IwxVszCgON4CtCQKS+Ak+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768304407; c=relaxed/simple;
	bh=mXBiLlcQnr0qPEmTAqo/9f37HC4PHVjYRxgenwmWB/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PmF43cQ6kekRMyPEYGgSD+Yxy5EJyIm3te8gQNThmmD/WPzgqTTPFwR08uZdqrIQGWBt3EkWzWgeLrfoxSpFky7wJoWmIAuSFEf+10mMhiB/xKkq4IuCVUfCr3vHQFqIahHvmOxfPEc49kuayVrZ0EkB7msxi2nS5A52z1Cx2rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=fhL+kOfO; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="fhL+kOfO"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202601131139563a50dd3086000207b9
        for <xenomai@lists.linux.dev>;
        Tue, 13 Jan 2026 12:39:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=p3naH2ijl7hnj02n1srYLVR9I2etGh5hxfVi/LG5DJU=;
 b=fhL+kOfO8USJQ1Btp5L6DusmNvr7JMXWvPQdoZFosVnsb3eggMx9USKRUf6FqMvdbxZCSM
 lmaDTlnP5B5hzeb3Y6PcJLJ9CQhBxFmBdYk4f3hydFhs3YVdJAPvzAVz1hqYLLM6b7VL5Ohx
 Se5t6MWptqf/G2rM5v7603tod118g358kvmWVT0g6RZ4kO+HXJBXaAS1og3BJsOo1VytBCbC
 Z6M3+cVEk/d/62wtKiVE6aB6fEUsnqHg/+Cw7kzx1yX9aNAFRmgwXirtO22+lO0GmXy49tdY
 0E2uca7LkAL5xpZjULezICm4O0QAyCv/O43gddoq6WuuxxZbyC7Pjrsw==;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [xenomai-images][PATCH v4 1/3] ci: replace LATEST_KERNEL_VERSION by KERNEL_VERSION_WITH_QEMU
Date: Tue, 13 Jan 2026 12:39:42 +0100
Message-ID: <20260113113945.1038227-2-clara.kowalsky@siemens.com>
In-Reply-To: <20260113113945.1038227-1-clara.kowalsky@siemens.com>
References: <20260113113945.1038227-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

This name is more suitable for the variable that specifies for which
kernel QEMU is used as target.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 ci/gitlab-ci-base.yml           | 4 ++--
 ci/xenomai_3_3_x.yml            | 2 +-
 ci/xenomai_3_next.yml           | 2 +-
 ci/xenomai_3_next_long_term.yml | 2 +-
 ci/xenomai_4_next.yml           | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index bffc80c..186d1cb 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -88,7 +88,7 @@ default:
 .build-qemu:
   extends: .build
   rules:
-    - if: '$KERNEL_VERSION == $LATEST_KERNEL_VERSION'
+    - if: '$KERNEL_VERSION == $KERNEL_VERSION_WITH_QEMU'
     - if: '$ALL_QEMU_JOBS == "true"'
 
 .test:
@@ -121,7 +121,7 @@ default:
       when: never
     - if: '$LAVA_TESTS_ENABLED != "true"'
       when: never
-    - if: '$KERNEL_VERSION == $LATEST_KERNEL_VERSION'
+    - if: '$KERNEL_VERSION == $KERNEL_VERSION_WITH_QEMU'
     - if: '$ALL_QEMU_JOBS == "true"'
 
 .build:qemu-amd64:
diff --git a/ci/xenomai_3_3_x.yml b/ci/xenomai_3_3_x.yml
index 6e43add..71871b9 100644
--- a/ci/xenomai_3_3_x.yml
+++ b/ci/xenomai_3_3_x.yml
@@ -20,4 +20,4 @@ include:
 variables:
   XENOMAI_BUILD_OPTION: ":kas/opt/xenomai-3.3.x-head.yaml:kas/opt/debug.yaml"
   XENOMAI_VERSION: "3.3.x"
-  LATEST_KERNEL_VERSION: "6.12"
+  KERNEL_VERSION_WITH_QEMU: "6.12"
diff --git a/ci/xenomai_3_next.yml b/ci/xenomai_3_next.yml
index 6559357..837b121 100644
--- a/ci/xenomai_3_next.yml
+++ b/ci/xenomai_3_next.yml
@@ -18,4 +18,4 @@ include:
 variables:
   XENOMAI_BUILD_OPTION: ":kas/opt/xenomai-next.yaml:kas/opt/debug.yaml"
   XENOMAI_VERSION: "3-next"
-  LATEST_KERNEL_VERSION: "6.12"
+  KERNEL_VERSION_WITH_QEMU: "6.12"
diff --git a/ci/xenomai_3_next_long_term.yml b/ci/xenomai_3_next_long_term.yml
index 975bf34..ea720fc 100644
--- a/ci/xenomai_3_next_long_term.yml
+++ b/ci/xenomai_3_next_long_term.yml
@@ -16,6 +16,6 @@ include:
 variables:
   XENOMAI_BUILD_OPTION: ":kas/opt/xenomai-next.yaml"
   XENOMAI_VERSION: "3-next"
-  LATEST_KERNEL_VERSION: "6.12"
+  KERNEL_VERSION_WITH_QEMU: "6.12"
   TEST_RUNTIME_SECONDS: 3600
   TEST_COMMAND: "xeno-test -k -l 'dohell -m /tmp ${TEST_RUNTIME_SECONDS}' ${ADDITIONAL_XENO_TEST_ARGS} -- -m ${TEST_MAXIMUM_LATENCY}"
diff --git a/ci/xenomai_4_next.yml b/ci/xenomai_4_next.yml
index 5fe06a0..30ca9b1 100644
--- a/ci/xenomai_4_next.yml
+++ b/ci/xenomai_4_next.yml
@@ -17,6 +17,6 @@ include:
 variables:
   XENOMAI_BUILD_OPTION: ":kas/opt/libevl-next.yaml:kas/opt/debug.yaml"
   XENOMAI_VERSION: "4-next"
-  LATEST_KERNEL_VERSION: "6.12"
+  KERNEL_VERSION_WITH_QEMU: "6.12"
   BUILD_IDENTIFIER: "evl-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
   CACHE_KERNEL: evl
-- 
2.52.0

