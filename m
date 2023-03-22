Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA825C945
	for <xenomai@lists.linux.dev>; Wed, 22 Mar 2023 23:59:49 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20230322235940c55ab592613c4dab4e
        for <xenomai@lists.linux.dev>;
        Thu, 23 Mar 2023 00:59:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=pcdQtOpdqIOZctfZ57mfmrHDrqZsBdnHT6zSEVQigMc=;
 b=d+85CI4ymWzRvHESl8STBaF3EOUr1HVj9Tua/jMI6m3IlXblqOszMaLHh9NsLxoDlWyvFV
 ITPbytyePQkse2ZP4kcD1NGFOsfOifPRvgo1F9bySyvmr99YVxuwnT8iU6d8S+4nLQTCmVVW
 rboJTY/qBRztkd+9dGmNy0Sn+rH8A=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [xenomai-images][PATCH v2 2/2] ci: Limit ci jobs, remove qemu compat jobs
Date: Thu, 23 Mar 2023 00:59:36 +0100
Message-Id: <20230322235936.1300665-4-florian.bezdeka@siemens.com>
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

v2:
  - No changes, resending to keep the patch posting consistent

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

