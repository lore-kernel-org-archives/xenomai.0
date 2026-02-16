Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDACE571
	for <xenomai@lists.linux.dev>; Mon, 16 Feb 2026 07:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771228416; cv=none; b=T5JcVoB7QxOZsZgixYeTtartBGVe/2wm3ibaVO9c7bkgkhG5YN8xoXAgpTY8FF3M/BL89Qz124k6jXznuzrBV4gcuohuk7h8I+wE/bd0wWWC2S5ICd/dSpVgozmV1HwGDphuyMdMf3Eze1dpVPkoabEJhORwOm5YMhnm22CNbhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771228416; c=relaxed/simple;
	bh=FobFtjrwcoRWZr2KjiH2i5sXsnUJ98ahxf/XBxranoU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f9VQAwuAKcz5tZG+fl2UJQsb58DfWz/l0TJCRpsHNX73LsphvgTRk1XhdinHY/U/MyUq8Xj4Qb4/8SZ7Ts8knlf+HPb3Ld7sUczLRx6kTISRWtyi5+Vsd6BUaEFr7xUo7X0GnowjfiW6Iz2k717zWlltc+4pNnFIkVDfyViNBCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=RfWI/3ZI; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="RfWI/3ZI"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2026021607532100078fa5260002075a
        for <xenomai@lists.linux.dev>;
        Mon, 16 Feb 2026 08:53:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=RUfC8q6ULWi2AQFSrH8T5KuBiAvkOh0CHHb5DxJuzTE=;
 b=RfWI/3ZIioISU/PBWN9RpKYyrW09F1FzvQmOh7ou1wececlh0ThGNPow/wwk7dB4RBYEbx
 UCpwMbLG4N5t2pgzu691whaRNfNuf78m93XY34Yi2ckBOmab/RwLWvdhm3Lf28pskP4IANZa
 NETFQCsFTYGXHFp/4NZCH5nSdzVWiWhhq1dQjgbqaeL8miZYmwaMH9U/B2haR4fscVPJTkms
 W8aWbgDDP5fYVPsgdRqlw7qV40lY18LkW4n0YDmSpHGoKyUXwvw/i3XAoUxP/xDOOjRyUqYQ
 yifzaH9fGj/b+i216fo5GqLFW+qvJUc3hqAebNTh3DVxETc9FhpghtMQ==;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [xenomai-images][PATCH v2] ci(libevl): Trigger more kernel combinations
Date: Mon, 16 Feb 2026 08:53:09 +0100
Message-ID: <20260216075310.3106961-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

The libevl next branch triggers a pipeline in xenomai-images in
combination with all available kernels (6.1, 6.12 and head). The
physical targets are built for all kernels, the QEMU targets just for
the head.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 ci/trigger/libevl.yml | 3 +--
 ci/xenomai_4_next.yml | 1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/ci/trigger/libevl.yml b/ci/trigger/libevl.yml
index bbd4e13..706303b 100644
--- a/ci/trigger/libevl.yml
+++ b/ci/trigger/libevl.yml
@@ -18,8 +18,7 @@ stages:
 trigger-xenomai-images:
   stage: trigger_xenomai_images
   variables:
-    ONLY_RUN: xenomai-4/evl
-    KERNEL_VERSION: head
+    ONLY_RUN: xenomai-4/${CI_COMMIT_BRANCH}
     KERNEL_VERSION_WITH_QEMU: head
   trigger:
     project: xenomai/xenomai-images
diff --git a/ci/xenomai_4_next.yml b/ci/xenomai_4_next.yml
index 5c1c7f4..42d913c 100644
--- a/ci/xenomai_4_next.yml
+++ b/ci/xenomai_4_next.yml
@@ -13,6 +13,7 @@ include:
   - local: '/ci/lib/gitlab-ci-base.yml'
   - local: '/ci/lib/kernel/6_1.yml'
   - local: '/ci/lib/kernel/6_12.yml'
+  - local: '/ci/lib/kernel/head.yml'
 
 variables:
   XENOMAI_BUILD_OPTION: ":kas/opt/libevl-next.yaml:kas/opt/debug.yaml"
-- 
2.52.0

