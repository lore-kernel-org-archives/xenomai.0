Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751CD37BE75
	for <xenomai@lists.linux.dev>; Mon,  9 Feb 2026 14:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648241; cv=none; b=nQKgvIPPxFJxxlw/TNxZcmF5z4D31apAgGSJvKV7jAN0q7+3Q/eWO8lD1vQyxC8hUZU7HVTLxa3oENawqlue93n7TuPcnno/r0FYWEaZ5G7QKL22XIXJ/amtsAcRr4ufw4lu0XeBup+yu1vweCjdZcOnE/22FU5iQSyV9Dhgj8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648241; c=relaxed/simple;
	bh=fVG2k+IT8kGgeHBuhnn88szDUNCFkF2j3XCqs34hdDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lb16Od1Ov+irdnAQIgAWp2WVUq82jqPS5VOhF54OdSsGEMFDw5AM0V/efjRlv3n/DhyZAAsRLtEHRzTA1TEc1pthPN0DZrVKESeRdY05wkdmO4k4ijheASdnBMFViDXExN1ja14AZKN9SXDM9fCCZ1E7BSiSJ833DgZGlbHD8LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=G9DEO9xO; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="G9DEO9xO"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202602091444003faf338e860002078f
        for <xenomai@lists.linux.dev>;
        Mon, 09 Feb 2026 15:44:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=IgaZTz+ZXm22X4PRg61ai5D2Bnbr9rfv90XMjXirZ3E=;
 b=G9DEO9xOd0OVpJkUkMbT3ZtzoofLS//X6QY231jb8zRAT9fymIaHnZVU+tMzYsUUbc/UMo
 vycLhw6fcLiuwdktMMB1102uKJFQL7PYQIE9E5Y2dgpPPhrU/85dXHENHjGqfJ7zFLiMfzPK
 f33goOpSwItGbYlwCNbAxLRtYe1TJJsCJh17A9cbXLmC8rE0YBxgc6FQYPFKLUHjY0r6zFqu
 Ilr3/vbm+ez4KuYFKV5O+SRHBgNPxNREDJuFBXWNusxYi/IzMC39no6WJZyIfvyoUymMfTNg
 9RLAO6/sUgdk4x1IbdThm8EoYzwDShwdX+lAif9hcQrlgIkOgU/J1+QA==;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [xenomai-images][PATCH 4/4] ci(dovetail): Trigger CI only for head and supported branches
Date: Mon,  9 Feb 2026 15:43:46 +0100
Message-ID: <20260209144346.487179-5-clara.kowalsky@siemens.com>
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

Use the same structure with dynamic child pipeline as in linux-evl to
make sure that no pipeline is triggered in xenomai-images for 6.x
branches that are LTS, but not supported by xenomai-images.
For these branches, the rule
$CI_COMMIT_BRANCH =~ /^v6\.[0-9]+\.y(-cip)?-dovetail-rebase$/
is matched, but as KERNEL_VERSION remains empty, no CI in xenomai-images
is triggered. A dummy job is needed to make sure that the CI does not
fail with the error "The resulting pipeline would have been empty".

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 ci/ci-child.yml    |  2 +-
 ci/ci-dovetail.yml | 35 +++++++++++++++++++++++------------
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/ci/ci-child.yml b/ci/ci-child.yml
index 6871b5d..3b8c05e 100644
--- a/ci/ci-child.yml
+++ b/ci/ci-child.yml
@@ -8,7 +8,7 @@
 #
 # SPDX-License-Identifier: MIT
 #
-# This is used by the CI of linux-evl
+# This is used by the CI of linux-evl and linux-dovetail
 #
 
 stages:
diff --git a/ci/ci-dovetail.yml b/ci/ci-dovetail.yml
index 633ebc4..9de9568 100644
--- a/ci/ci-dovetail.yml
+++ b/ci/ci-dovetail.yml
@@ -19,7 +19,7 @@ workflow:
 
 stages:
   - set_vars
-  - trigger_xenomai_images
+  - trigger_child
 
 set-vars:
   stage: set_vars
@@ -42,22 +42,33 @@ set-vars:
       fi
       echo "KERNEL_VERSION: $KERNEL_VERSION"
       { echo "KERNEL_VERSION=$KERNEL_VERSION"; } > vars.env
+      if [ "$KERNEL_VERSION" != "" ]; then
+          git clone --depth 1 --branch next https://gitlab.com/Xenomai/xenomai-images.git /tmp/xenomai-images
+          cp /tmp/xenomai-images/ci/ci-child.yml .
+      else
+          cat <<EOF > ci-child.yml
+          stages:
+            - dummy_stage
+          dummy_job:
+            stage: dummy_stage
+            script:
+              - echo "This is a dummy job."
+      EOF
+      fi
   artifacts:
+    paths:
+      - vars.env
+      - ci-child.yml
     reports:
       dotenv: vars.env
 
-trigger-xenomai-images:
-  stage: trigger_xenomai_images
-  needs:
-    - set-vars
+trigger-child-pipeline:
+  stage: trigger_child
   trigger:
-    project: xenomai/xenomai-images
-    branch: next
-    forward:
-      pipeline_variables: true
+    include:
+      - artifact: ci-child.yml
+        job: set-vars
+    strategy: depend
   variables:
     KERNEL_VERSION: $KERNEL_VERSION
-    KERNEL_VERSION_WITH_QEMU: $KERNEL_VERSION
     ONLY_RUN: xenomai-3/dovetail
-  rules:
-    - if: '$KERNEL_VERSION != ""'
-- 
2.52.0

