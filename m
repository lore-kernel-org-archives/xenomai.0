Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3BDBA53
	for <xenomai@lists.linux.dev>; Wed, 22 Mar 2023 23:59:47 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202303222359390bd3eb1e0106279b4f
        for <xenomai@lists.linux.dev>;
        Thu, 23 Mar 2023 00:59:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Ikm2vG/hSo72f8QQ3eUaKy1c3gtCyV9CyJXV7psJIEo=;
 b=ZXacdtVZtIExbJgaOGTPwr/lz9nc2qFthT5uTi6kEdjbsxB3W/jU5JLLF6EiIxanoZunUk
 0/Aj2yZnkCNLsRM8IK2dEPsXVHOQKnnTI25q3rxVhzSYmU9bEtAmpjeXjpVfD0wfqNdTLr+v
 V5D6eoaUyyUaCqhE93CO4F+Ghxmz0=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 2/2] ci: Limit ci jobs, remove qemu compat jobs
Date: Thu, 23 Mar 2023 00:59:34 +0100
Message-Id: <20230322235936.1300665-2-florian.bezdeka@siemens.com>
In-Reply-To: <20230322235936.1300665-1-florian.bezdeka@siemens.com>
References: <20230322235936.1300665-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

One more optimization to narrow down the number of CI jobs that we spawn
for each CI run.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 ci/compat_jobs.yml | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/ci/compat_jobs.yml b/ci/compat_jobs.yml
index 9308679..d8ee86b 100644
--- a/ci/compat_jobs.yml
+++ b/ci/compat_jobs.yml
@@ -9,22 +9,6 @@
 # SPDX-License-Identifier: MIT
 #
 
-build-5.15-compat:qemu-amd64:
-  extends:
-    - .build:qemu-amd64
-    - .compat-vars
-  variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
-    KERNEL_VERSION: "5.15"
-
-lava-test-5.15-compat:qemu-amd64:
-  needs: [ "build-5.15-compat:qemu-amd64" ]
-  extends:
-    - .lava-test:qemu-amd64
-    - .compat-vars
-  variables:
-    KERNEL_VERSION: "5.15"
-
 build-5.15-compat:x86-64-efi:
   extends:
     - .build:x86-64-efi
-- 
2.39.2

