Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563A737BE69
	for <xenomai@lists.linux.dev>; Mon,  9 Feb 2026 15:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770649348; cv=none; b=Bqkc/4l53dfcTJ4nbH5oOPpPFqW07cGhJ0kP6nIp7OnkLDmxjDU0je3U4BGIweNDo4Y4sR1lUapSZESCV2W4EDFNKSHcNHIvvSgDcULsMFrOOuG7LSM+Q9MVWLTeAG66QCg0UIpGw8D5X0DnDDll2cr7M7UrOKWVHJ64emMyyy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770649348; c=relaxed/simple;
	bh=8nKdPwKLb81gCX7C4xawO/bmX3TKomugGxtbqn9xVbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j/5ZUgdnKnCv4bUc7NqcS2zexLGFnnR5ghJBxX+hzyB/zL/9WP1GknB0Cw0w4J/jja+ti5IwZyaQljME0AxkRAwQwCaZPWEXoT+Q+qsQ8LOq/9QvfxOKw5u8uMPpBiZG9udcqnqBsNIN6IITONP0LOIHooq5l4hrlV42fdZ6F4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=OIeob7MS; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="OIeob7MS"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260209150223feafa98092000207a9
        for <xenomai@lists.linux.dev>;
        Mon, 09 Feb 2026 16:02:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=hcRu3WxeyY0542U5/p/Eko41HKaJvwLte0AJUcylOxk=;
 b=OIeob7MSnuyZVw5+XAoDy2jIwSf+eZVu5CvC9ULdaZny7P+0CAaVB0XdGCMvm6JuQvqSPW
 ewIfx3RLc1SPAKfz0Frvb/rj3QOcFpEyTkJ4ve+jtTMgvcNBqYB57AuDVXQ1yhh1G8FdgQh2
 tFdyAeV8Rt/aznYduGC5QefG/KkyTKGvtk5lsn3tB3D3qJUM4IJc0PW+KykvVschXaK5zyI7
 /SgB26mmIGBLoHgktZV6uHSEDLwCmgfshgZX9VoiozTuauWGwfmRz4C58RkTSyNlHl92ogm9
 OTlcuTvzid/qT4Tik20qQVoDI6dtbaPo6NDme3tPvPGl5PcolhS1GrYQ==;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [PATCH] README: Describe CI trigger structure for Xenomai 4
Date: Mon,  9 Feb 2026 16:02:19 +0100
Message-ID: <20260209150219.506245-1-clara.kowalsky@siemens.com>
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
 README.md | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/README.md b/README.md
index cfe1cf4..cd7e2d5 100644
--- a/README.md
+++ b/README.md
@@ -53,6 +53,8 @@ This repository utilizes GitLab CI for automated building and testing of Xenomai
 
 ### Xenomai 3 CI
 
+#### Xenomai 3
+
 Pushes to the [Xenomai 3](https://gitlab.com/Xenomai/xenomai3/xenomai)
 repository on the `next` branch or any branch starting with `stable/` trigger a
 pipeline in this repository. Have a look at the `trigger-xenomai-images` job in
@@ -60,16 +62,35 @@ the Xenomai 3 repository's [`.gitlab-ci.yml`](https://gitlab.com/Xenomai/xenomai
 The pipeline triggered will then build and test images for the corresponding
 Xenomai 3 branch.
 
-### Linux-dovetail CI
+#### Linux-dovetail
 
 For the [linux-dovetail](https://gitlab.com/Xenomai/linux-dovetail) repository,
 pushes to branches that have a corresponding kernel file in [`ci`](ci) trigger
-a pipeline in this repository. The GitLab CI configuration for linux-dovetail
-is located in this repository under [ci/ci-dovetail.yml](ci/ci-dovetail.yml)
-and need to be set as external gitlab-ci configuration, e.g.
+a pipeline in this repository. The GitLab CI/CD configuration file for linux-dovetail
+is located in this repository under [ci/ci-dovetail.yml](ci/ci-dovetail.yml),
+as specified in the settings of linux-dovetail via
 `ci/ci-dovetail.yml@Xenomai/xenomai-images:next`. In the triggered pipeline,
 images for the corresponding linux-dovetail branch are built and tested.
 
+### Xenomai 4 CI
+
+#### Libevl
+
+Pushes to the [libevl](https://gitlab.com/Xenomai/xenomai4/libevl) repository
+on the `next` branch trigger a pipeline in this repository. The GitLab CI/CD
+configuration file for libevl is located in this repository under [ci/ci-libevl.yml](ci/ci-libevl.yml),
+as specified in the libevl settings via `ci/ci-libevl.yml@Xenomai/xenomai-images:next`.
+
+#### Linux-evl
+
+For the [linux-evl](https://gitlab.com/Xenomai/xenomai4/linux-evl) repository,
+pushes to branches that have a corresponding kernel file in [`ci`](ci) trigger
+a pipeline in this repository. The GitLab CI configuration for linux-evl is
+located in this repository under [ci/ci-evl.yml](ci/ci-evl.yml), as specified
+in the libevl settings via
+`ci/ci-evl.yml@Xenomai/xenomai-images:next`. In the triggered pipeline,
+images for the corresponding linux-evl branch are built and tested.
+
 ### Local CI Execution
 
 The CI build can be executed locally by
-- 
2.52.0

