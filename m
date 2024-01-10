Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E244CD2E0
	for <xenomai@lists.linux.dev>; Wed, 10 Jan 2024 04:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="iZhTHMYJ"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20240110044604f5a958ee8c62f0a3dd
        for <xenomai@lists.linux.dev>;
        Wed, 10 Jan 2024 05:46:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=I9qEY6ZX0pgZZtyhONnSBgpPRpQEgtVHpZdQnRzo0H8=;
 b=iZhTHMYJe86q7saBsF8n1bCwbjDQknucdua5OSM319MJ7GrlV2JEnb5kICsS5bfa7ndvqj
 zYJby6E2/5QLCgGPI6IudJvaoYc3vABWhf6IEvS5iaj2Najr0bNHmPMaCIlsn6QGjyO4LA83
 ZCalxiIu+R6NISoHa92P95mO/hPBE=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH v3 09/10] ci: Rename xenomai 3 files
Date: Wed, 10 Jan 2024 05:46:01 +0100
Message-Id: <39a3472355382bfc5019aa9c84065a7d0c4083c8.1704861962.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1704861962.git.jan.kiszka@siemens.com>
References: <cover.1704861962.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Clara Kowalsky <clara.kowalsky@siemens.com>

The files for xenomai 3 obtain a corresponding name change.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
[Jan: keep kernel CI files untouched, postpone xenomai 4 hook-up]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml                                            | 6 +++---
 ci/{xenomai_next.yml => xenomai_3_next.yml}               | 2 +-
 ci/{xenomai_next_compat.yml => xenomai_3_next_compat.yml} | 1 -
 3 files changed, 4 insertions(+), 5 deletions(-)
 rename ci/{xenomai_next.yml => xenomai_3_next.yml} (91%)
 rename ci/{xenomai_next_compat.yml => xenomai_3_next_compat.yml} (99%)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 6e4f1df..4c20c53 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019 - 2021
+# Copyright (c) Siemens AG, 2019 - 2024
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -44,8 +44,8 @@ stable/v3.2.x:
     include:
       - local: '/ci/xenomai_3_2_x.yml'
 
-next:
+xenomai-3/next:
   extends: .parent
   trigger:
     include:
-      - local: '/ci/xenomai_next.yml'
+      - local: '/ci/xenomai_3_next.yml'
diff --git a/ci/xenomai_next.yml b/ci/xenomai_3_next.yml
similarity index 91%
rename from ci/xenomai_next.yml
rename to ci/xenomai_3_next.yml
index b0338c6..afd45cb 100644
--- a/ci/xenomai_next.yml
+++ b/ci/xenomai_3_next.yml
@@ -15,7 +15,7 @@ include:
   - local: '/ci/kernel_5_15.yml'
   - local: '/ci/kernel_6_1.yml'
   - local: '/ci/kernel_6_6.yml'
-  - local: '/ci/xenomai_next_compat.yml'
+  - local: '/ci/xenomai_3_next_compat.yml'
 
 variables:
   XENOMAI_BUILD_OPTION: ":opt-xenomai-next.yml"
diff --git a/ci/xenomai_next_compat.yml b/ci/xenomai_3_next_compat.yml
similarity index 99%
rename from ci/xenomai_next_compat.yml
rename to ci/xenomai_3_next_compat.yml
index f7e3146..5ccc832 100644
--- a/ci/xenomai_next_compat.yml
+++ b/ci/xenomai_3_next_compat.yml
@@ -16,4 +16,3 @@
 
 include:
   - local: '/ci/compat_jobs.yml'
-
-- 
2.35.3

