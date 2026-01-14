Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783FB3816F1
	for <xenomai@lists.linux.dev>; Wed, 14 Jan 2026 09:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768384640; cv=none; b=KQBW61uGQv4KUqVYwH1ozSZHdZOswUXdks1e8BJjrmBPsKdch+ua3P7TALdn+/v5XPR3mFnlnhz9UOfRBzPDz/cnE4W4AQFyYOBgBqMRSlTw2fcGzhz9xAOB8ELShM30vZwmVum+lQck7FKGtCVRzbnvAXpvUwza6aeuHUWx1qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768384640; c=relaxed/simple;
	bh=yXZSC6/X+LZzaVpgtWrMTEk4rMtDVzBQaoLfQ2E/nQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Adyz5rlPgRB2EpFJiI5mtP5VKRD6psu+KHaXtOge7CcQSGHJCLEESUM3wYYJVxOVWRst4MW0MQVwVkvX/0TOxvA2RWcO11+2rG4UABYwoZ3r89E+lUTou681Sdyl1hMG0Noe6/HZoFMUVs6N2C44K4BTL0ZFORNGMjNralTR+Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=ZhMscSWE; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="ZhMscSWE"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202601140957122af0f585e400020728
        for <xenomai@lists.linux.dev>;
        Wed, 14 Jan 2026 10:57:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=7m9/fxqSLMTObOKqhVNUm6qsG46uXqsN7lbMDHmzyS0=;
 b=ZhMscSWEkmTZ7G1yJKXXcIs4xWxbABmIe/A+yAt+54HdU+uQnu3zfWCjDN6+c+VBopXlDY
 TsPxbtJ53bEyDGk7WLGehNf6Cglm6XendNR798WA/eQw9RYivafcI9OMbwp4CuRwtT/WRLvY
 TAihgKFBy2gJ8W81Q57aVXatPa6YO2qCNqZvPcF/mZC3qn9otc6dmGZ2HReTkgwH1HtoUKiy
 Y2wvgByeKFhViKp6gZklB1VaJRuKsdH6bt8+Ax72gNQpkaZruBVTEIXQ3uX09GiMmfaUEMWY
 0xAJaqVRVbQvPmw+/ophPDZiV5Yn4QB13NUMBIOVw1IfVhTmBHzf4/+w==;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [xenomai-images][PATCH 2/3] README: describe CI trigger structure
Date: Wed, 14 Jan 2026 10:56:56 +0100
Message-ID: <20260114095657.2440127-2-clara.kowalsky@siemens.com>
In-Reply-To: <20260114095657.2440127-1-clara.kowalsky@siemens.com>
References: <20260114095657.2440127-1-clara.kowalsky@siemens.com>
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
 README.md | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/README.md b/README.md
index 95350cc..ca602d4 100644
--- a/README.md
+++ b/README.md
@@ -49,6 +49,22 @@ Unpack it and follow its `README.sdk`.
 
 ## CI Build
 
+This repository utilizes GitLab CI for automated building and testing of Xenomai images.
+
+### Xenomai 3 CI
+
+Pushes to the [Xenomai 3](https://gitlab.com/Xenomai/xenomai3/xenomai) repository on the `next` branch or any branch starting with `stable/` trigger a pipeline in this repository.
+Have a look at the `trigger-xenomai-images` job in the Xenomai 3 repository's [`.gitlab-ci.yml`](https://gitlab.com/Xenomai/xenomai3/xenomai/-/blob/master/.gitlab-ci.yml).
+The pipeline triggered will then build and test images for the corresponding Xenomai 3 branch.
+
+### Linux-dovetail CI
+
+For the [linux-dovetail](https://gitlab.com/Xenomai/linux-dovetail) repository, pushes to branches that have a corresponding kernel file in [`ci`](ci) trigger a pipeline in this repository.
+The GitLab CI configuration for linux-dovetail is located in this repository under [ci/ci-dovetail.yml](ci/ci-dovetail.yml).
+In the triggered pipeline, images for the corresponding linux-dovetail branch are built and tested.
+
+### Local CI Execution
+
 The CI build can be executed locally by
 [installing the GitLab Runner](https://docs.gitlab.com/runner/install/).
 
-- 
2.52.0

