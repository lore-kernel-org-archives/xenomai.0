Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D828356A28
	for <xenomai@lists.linux.dev>; Mon, 12 Jan 2026 12:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768221249; cv=none; b=ijjv5wXoyAfEOgr22+zsFNpLXW2tbAkrKSU9RfKLt6rQnArnTFu3gqqKkzvJrXpKJQsugYnR/4rNxbk7gSUXN6ryfCRii2+RG/GNFZ7WY5l/6+e1l6TuSTK5qe1RHSS43SFxtMHV0QZ1MJP4UKAgx06YKYXqZUgpzVeBvV289mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768221249; c=relaxed/simple;
	bh=8xne9Bh2DkJvHyrmTP4TSdQRCTI/rUlQX4d6R3/IM1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NnHlsi+VIwJ1j8f1LHzo2Axw0/iPbie3QqqgZ77CC0XouRA092QNXFRvp0VzXcCKYvBI2cfIYhv5ga5SNslr+3jlZeFwDh3TStPIwxDD6bMvVrwyPiyasEMb5jEAijVF3fPrVxkdJ/xMnwvevx7sWsTvQpstfxcbOvHIfvWjrTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=HCwo0eFo; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="HCwo0eFo"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202601121234067dcfa411b300020747
        for <xenomai@lists.linux.dev>;
        Mon, 12 Jan 2026 13:34:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=gu8kaIu4kGgEZ9JND+a5XjFKHIJBHUJ3CHPDx1QktuI=;
 b=HCwo0eFo5OY1LQlzItaiWpEZew1d3/I8SHjYMQ0GW0rFhrwLEVyCz7VgOEd8kt4g+jgvPH
 RXZ7lqzKIH3AqF5wLSLxi6H8jFqfqT89osoIcLDet4+clrNZCFAIpZfxJ+kdhpc5xfvIJtFv
 SXlRLmkQCo2qG3dwKc1vUSKtS2PucYQJudzCeCHURG7WTl2pNinv5gP/3mSui3JO9xIfF3jx
 mYzyBUTSfJaKlVJX2pMRqRmAvnGzGFmQFkhlxZQPNXXxAPOpVuEZvlVBFcfRqzP6wAivgbSO
 HE+5DGX/QnaGpp7Jp/lU+2yTcbI5WsPnldQCD5EgfryWA6yD/BBMBnqg==;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [xenomai-images][PATCH v3 2/3] ci: Add build job for pipeline triggered by linux-dovetail
Date: Mon, 12 Jan 2026 13:33:48 +0100
Message-ID: <20260112123349.3945734-3-clara.kowalsky@siemens.com>
In-Reply-To: <20260112123349.3945734-1-clara.kowalsky@siemens.com>
References: <20260112123349.3945734-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 .gitlab-ci.yml            |  8 ++++++++
 ci/xenomai_3_dovetail.yml | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)
 create mode 100644 ci/xenomai_3_dovetail.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 2f03fdd..c8f649f 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -59,6 +59,14 @@ xenomai-3/next-long-term:
   rules:
     - if: '$CI_PIPELINE_SOURCE == "schedule" && $ONLY_RUN == $CI_JOB_NAME'
 
+xenomai-3/dovetail:
+  extends: .parent
+  trigger:
+    include:
+      - local: '/ci/xenomai_3_dovetail.yml'
+  rules:
+    - if: '$ONLY_RUN == $CI_JOB_NAME'
+
 xenomai-4/next:
   extends: .parent
   trigger:
diff --git a/ci/xenomai_3_dovetail.yml b/ci/xenomai_3_dovetail.yml
new file mode 100644
index 0000000..23e848a
--- /dev/null
+++ b/ci/xenomai_3_dovetail.yml
@@ -0,0 +1,39 @@
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
+
+include:
+  - local: '/ci/gitlab-ci-base.yml'
+  - local: '/ci/kernel_5_10.yml'
+    rules:
+      - if: '$KERNEL_VERSION == "5.10"'
+  - local: '/ci/kernel_5_15.yml'
+    rules:
+      - if: '$KERNEL_VERSION == "5.15"'
+  - local: '/ci/kernel_6_1.yml'
+    rules:
+      - if: '$KERNEL_VERSION == "6.1"'
+  - local: '/ci/kernel_6_12.yml'
+    rules:
+      - if: '$KERNEL_VERSION == "6.12"'
+
+.v5.x-dovetail:
+  variables:
+    XENOMAI_VERSION: "3.3.x"
+    XENOMAI_BUILD_OPTION: ":kas/opt/xenomai-3.3.x-head.yaml:kas/opt/debug.yaml"
+  rules:
+    - if: '$KERNEL_VERSION == "5.10" || $KERNEL_VERSION == "5.15"'
+
+.v6.x-dovetail:
+  variables:
+    XENOMAI_VERSION: "3-next"
+    XENOMAI_BUILD_OPTION: ":kas/opt/xenomai-next.yaml:kas/opt/debug.yaml"
+  rules:
+    - if: '$KERNEL_VERSION == "6.1" || $KERNEL_VERSION == "6.12"'
-- 
2.52.0

