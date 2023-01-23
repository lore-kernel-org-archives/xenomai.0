Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3041C01
	for <xenomai@lists.linux.dev>; Mon, 23 Jan 2023 12:49:22 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20230123120903e071a82a950515a58c
        for <xenomai@lists.linux.dev>;
        Mon, 23 Jan 2023 13:09:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=uV6pCPFxi6Fd15uq0qh7Q7mGF0zstkkd7gG35mODxbM=;
 b=SXSJRXoXQz587PJm09VpzuSA07dS428qDuyWzXsyqb2TiEb0RDuol5a0YoPziMRHqigJs8
 CWqNRBPZ8iYJx9D1ZIhiYQQ+RXO5quPOm/zt5cQ3q4D3M7Oq0aiy+0p7ZIxqWpQ4ZpjY9CGf
 Jbs/MQeW6JTNu1cXbhKO7t6LXx/ZM=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [xenomai-images][PATCH] Update to kas 3.2
Date: Mon, 23 Jan 2023 13:08:46 +0100
Message-Id: <20230123120846.2253996-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 README.md             | 2 +-
 ci/gitlab-ci-base.yml | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/README.md b/README.md
index 392865a..589b24f 100644
--- a/README.md
+++ b/README.md
@@ -13,7 +13,7 @@ from scratch.
 
 Install `kas-container` from the [kas project](https://github.com/siemens/kas):
 
-    wget https://raw.githubusercontent.com/siemens/kas/3.1/kas-container -P ~/bin/
+    wget https://raw.githubusercontent.com/siemens/kas/3.2/kas-container -P ~/bin/
     chmod a+x ~/bin/kas-container
 
 Furthermore, install docker and make sure you have required permissions to
diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index ee71ea3..40a0437 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019 - 2022
+# Copyright (c) Siemens AG, 2019 - 2023
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -24,7 +24,7 @@ variables:
   BUILD_IDENTIFIER: "xenomai-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
 
 default:
-  image: ghcr.io/siemens/kas/kas-isar:3.1
+  image: ghcr.io/siemens/kas/kas-isar:3.2
 
 .common-config:
   before_script:
-- 
2.39.0

