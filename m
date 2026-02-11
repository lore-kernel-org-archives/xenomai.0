Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEE934EF06
	for <xenomai@lists.linux.dev>; Wed, 11 Feb 2026 13:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770815463; cv=none; b=mrhL5b2g1pKMF5DBuXT4ehk5h5pt0dDuk/WMT4iXRfWOZPwmk1e99bymOvbXELutQQ1rZ8tJOW7fiTs44TNX5t30ALf3jbt1tE4HG95Q0yk/vAIB826GaizScqgR5ak91gFnJUzrkAyFSICuB5v4J/1CWbkrZEGfabu/eN6ocwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770815463; c=relaxed/simple;
	bh=UJdzZ/BMBaeUW00Qu7rc9zZgble6rrZZPbLMOEvNmrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VNCesUdMlC3p7aE7jVe5uw/lViQyhCEiPp0VkN/JHWO2xJeotqcJK2j2hqw0x3k4M5q+UiTRHSpi2pCKeS0w6wmjt3+L/KclTB4p57xG5e6gOYeiArsXJDKQEQ4tobY+tW3wlNz7iPai7Zi4+N6ox+0Q/ieRT6LAKyNiA8+ECrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=R+McJa8S; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="R+McJa8S"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202602111311007f36342eb60002071d
        for <xenomai@lists.linux.dev>;
        Wed, 11 Feb 2026 14:11:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=kAeg249xWevCgoWrFnJiVx4uX2PujK1fDuN6y/npYv4=;
 b=R+McJa8S6kkRW8ipxZyJG2azVYlCIi9LLt/QR6dQxIB2e9wVZ5/3/4OI0yFchVrlfLZBPR
 cQI7MpYQNikwGiz2QprRT2+EjVp5fi3psEfzbaUQIDd4IlwNt1nU+1kXDSvZgK68rF6NnDLa
 f+H4Z7ah1dxawbwir1u17zvUJBMeUUF4L+/Iybbrtx9yLYeqU9SsEGa7TwB4gk7uFZdI6R7z
 sVJYbqGoqd9q+I9PPd/6vpwBDwLnYEAc/kQGE8bMiITJoNq6pX7k8N3dHXmItLMkjM2jJN1V
 2thhx6QLzcSefdNJ50Jb8Xm+Xp6v2pMa41dzbPq/KiIwNcWKHsOWyuLg==;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [xenomai-images][PATCH v2 4/5] ci: Add CI for libevl
Date: Wed, 11 Feb 2026 14:10:41 +0100
Message-ID: <20260211131043.1185863-5-clara.kowalsky@siemens.com>
In-Reply-To: <20260211131043.1185863-1-clara.kowalsky@siemens.com>
References: <20260211131043.1185863-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

The libevl repo uses this CI/CD configuration file, as configured in its
settings. If new commits are pushed to the libevl next branch, a CI job
is started that triggers the xenomai-images CI in combination with the
linux-evl head branch. Build jobs on the physical targets as well as in
QEMU are run.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 README.md             |  9 +++++++++
 ci/trigger/libevl.yml | 28 ++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)
 create mode 100644 ci/trigger/libevl.yml

diff --git a/README.md b/README.md
index 00a62e4..e6535be 100644
--- a/README.md
+++ b/README.md
@@ -72,6 +72,15 @@ as specified in the settings of linux-dovetail via
 `ci/trigger/dovetail.yml@Xenomai/xenomai-images:next`. In the triggered pipeline,
 images for the corresponding linux-dovetail branch are built and tested.
 
+### Xenomai 4 CI
+
+#### Libevl
+
+Pushes to the [libevl](https://gitlab.com/Xenomai/xenomai4/libevl) repository
+on the `next` branch trigger a pipeline in this repository. The GitLab CI/CD
+configuration file for libevl is located in this repository under [ci/trigger/libevl.yml](ci/trigger/libevl.yml),
+as specified in the libevl settings via `ci/trigger/libevl.yml@Xenomai/xenomai-images:next`.
+
 ### Local CI Execution
 
 The CI build can be executed locally by
diff --git a/ci/trigger/libevl.yml b/ci/trigger/libevl.yml
new file mode 100644
index 0000000..bbd4e13
--- /dev/null
+++ b/ci/trigger/libevl.yml
@@ -0,0 +1,28 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Clara Kowalsky <clara.kowalsky@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+# This is the CI/CD configuration file of the libevl repository,
+# as configured in its CI/CD settings
+#
+
+stages:
+  - trigger_xenomai_images
+
+trigger-xenomai-images:
+  stage: trigger_xenomai_images
+  variables:
+    ONLY_RUN: xenomai-4/evl
+    KERNEL_VERSION: head
+    KERNEL_VERSION_WITH_QEMU: head
+  trigger:
+    project: xenomai/xenomai-images
+    branch: next
+  rules:
+    - if: '$CI_COMMIT_BRANCH == "next"'
-- 
2.52.0

