Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E425635C18A
	for <xenomai@lists.linux.dev>; Wed, 11 Feb 2026 13:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770815465; cv=none; b=eckdWPD+cOI+XXl/rHTnfCmOMclYyEhKW7IVFMqDnvozWmC9vgbsJQ4X/91p7lyUx4RenF9o5yTFOC+FOxxYp5h0v4vkZ8UdL+mj5ktmAv+kct1aLxXJj2KiGzuNRT9K/PS1GR7B8zKb9W8ymib8nGFYOqMk23AHMGG1sXKD54I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770815465; c=relaxed/simple;
	bh=5Gxc6OnX7Ow1pxK4SL5bq61AbdnVDyDuUv0QgQEWDkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+pa7yZBxne1kZpYHT5IXP6REBbaFw5AHVayJV7c/ZJEVKsehmJSinn+AHyoqGIQwXltsD//xrKYBtDNL7JhNmPo4ESbifvIQxtOiOI4Zp61Xx2fsoTwd96v3GdatKgzx0F3og7CiAM66sgfMTOYlkgk9hS2x+NPnXgpiDCxZGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=SFjh9XYQ; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="SFjh9XYQ"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2026021113105358e2bc79af00020754
        for <xenomai@lists.linux.dev>;
        Wed, 11 Feb 2026 14:10:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=FPNQHRV8CxrCo1g+LC9K5UwDE+Lb38UOVWw/7sncyxE=;
 b=SFjh9XYQ8kNotIpOChTEWXNTRFyCbZhJL745CwwIF42rKTTBT3rLCaTsvFBSkWNHnVDZxh
 LDh33BtITp7XV5DZCbaVF1aGfhlBs59NshZ7BKucnHd6Ohxc4fTINyBTQ6fQJm8R1CFTcNK7
 KHDWc/9JUs9YCxk0ytCoGYdqO8w5UfKFTX9E9tL6d597E2HwXaD4MaJvfitgfVlAhO03lo/s
 Cm+lebgJQyEDTajLwWjbzY641FkEMDT/yxeXqufnHpRHHyuOcCyKRplUlDI7k4Zlzsm1pYce
 WsXUJ26ui5pHyl8f5B1QprtuvNzpuYCFZHqquYbVeFMCl2eYLfYokVzA==;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [xenomai-images][PATCH v2 1/5] ci: Move third-party config files into separate folder
Date: Wed, 11 Feb 2026 14:10:38 +0100
Message-ID: <20260211131043.1185863-2-clara.kowalsky@siemens.com>
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

The trigger folder contains the yml files that are consumed by
third-party repositories that trigger the CI of xenomai-images.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 README.md                                    | 12 +++++++-----
 ci/{ci-dovetail.yml => trigger/dovetail.yml} |  0
 2 files changed, 7 insertions(+), 5 deletions(-)
 rename ci/{ci-dovetail.yml => trigger/dovetail.yml} (100%)

diff --git a/README.md b/README.md
index cfe1cf4..00a62e4 100644
--- a/README.md
+++ b/README.md
@@ -53,6 +53,8 @@ This repository utilizes GitLab CI for automated building and testing of Xenomai
 
 ### Xenomai 3 CI
 
+#### Xenomai 3
+
 Pushes to the [Xenomai 3](https://gitlab.com/Xenomai/xenomai3/xenomai)
 repository on the `next` branch or any branch starting with `stable/` trigger a
 pipeline in this repository. Have a look at the `trigger-xenomai-images` job in
@@ -60,14 +62,14 @@ the Xenomai 3 repository's [`.gitlab-ci.yml`](https://gitlab.com/Xenomai/xenomai
 The pipeline triggered will then build and test images for the corresponding
 Xenomai 3 branch.
 
-### Linux-dovetail CI
+#### Linux-dovetail
 
 For the [linux-dovetail](https://gitlab.com/Xenomai/linux-dovetail) repository,
 pushes to branches that have a corresponding kernel file in [`ci`](ci) trigger
-a pipeline in this repository. The GitLab CI configuration for linux-dovetail
-is located in this repository under [ci/ci-dovetail.yml](ci/ci-dovetail.yml)
-and need to be set as external gitlab-ci configuration, e.g.
-`ci/ci-dovetail.yml@Xenomai/xenomai-images:next`. In the triggered pipeline,
+a pipeline in this repository. The GitLab CI/CD configuration file for linux-dovetail
+is located in this repository under [ci/trigger/dovetail.yml](ci/trigger/dovetail.yml),
+as specified in the settings of linux-dovetail via
+`ci/trigger/dovetail.yml@Xenomai/xenomai-images:next`. In the triggered pipeline,
 images for the corresponding linux-dovetail branch are built and tested.
 
 ### Local CI Execution
diff --git a/ci/ci-dovetail.yml b/ci/trigger/dovetail.yml
similarity index 100%
rename from ci/ci-dovetail.yml
rename to ci/trigger/dovetail.yml
-- 
2.52.0

