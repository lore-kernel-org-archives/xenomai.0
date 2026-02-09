Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89B5378D84
	for <xenomai@lists.linux.dev>; Mon,  9 Feb 2026 14:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648239; cv=none; b=Bw73yht+Y46sb9LoDowb97uQkFJPcWvxjTV9SdfxHcPj9UYx5LustK3i3yfcjb1SR77GNLA0q5tj+8u2I76oteDeAzP5hHifu5WZe5bm5S14K4iYKEPFzFCGOJtZqygXinyYWxQqqBJxSEb6QbDHjD4QMyFgzdI56iAQ6xTisUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648239; c=relaxed/simple;
	bh=dir0uX0g706RxGgGxjbBegP8liFTpYQqLDrXnCckc7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=doz0me9nMLJhqKCxoK12xaOQ3oiQBBXg2zKemjdCY9p0kQ09qwAqiRAHabyEGYqo4sO1M4mh2ecPML9HiZpUhDR1dIrEsy6JrZQ44V4ZQrQ3/ShBkGaZiPYUcX4qbp3sZGNjfvhWU6yta1HgYr5pbLwUkcphXu3MswDJLtZ2/1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=WK/5wM8O; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="WK/5wM8O"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20260209144356f9045fd3900002075a
        for <xenomai@lists.linux.dev>;
        Mon, 09 Feb 2026 15:43:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Sr+Oav2Q+reSwFvoMe2NKhgkEZ6ax3onHHA5ETOiGMI=;
 b=WK/5wM8OheuaDOP7jqcYYtpP/9aP/Q3klfA/tsjG49CuXwKgaO/ctso1vx2UK/PhuxkVVW
 iaevvZ0ItZWq7HxKk/5NnAgjtbx+kKomg7/NJXASoU8y/QyXyA156OFHlWFNkSzQnOMpAFQp
 D7X5Jw8T+aXrGCww4djdJKB39mZm7uoGDzii4C5NWziXXSXwrlM9EdtrnNT/Wyy7aZZI5X1I
 Zs1HMeMZmFNO57c9GN0bUBpXqE1RDV4VeTPhewqCDcC9RRn7MgdNISw5nQTZVZ/Xkg4pHRyY
 keGOGWOyNQNmYaUmHDNiupVjV0E+/mSAEenU/jONbA/D0PxON5ckrf0A==;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [[xenomai-images]PATCH 2/4] ci: Add CI for libevl
Date: Mon,  9 Feb 2026 15:43:44 +0100
Message-ID: <20260209144346.487179-3-clara.kowalsky@siemens.com>
In-Reply-To: <20260209144346.487179-1-clara.kowalsky@siemens.com>
References: <20260209144346.487179-1-clara.kowalsky@siemens.com>
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
 ci/ci-libevl.yml | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 ci/ci-libevl.yml

diff --git a/ci/ci-libevl.yml b/ci/ci-libevl.yml
new file mode 100644
index 0000000..bbd4e13
--- /dev/null
+++ b/ci/ci-libevl.yml
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

