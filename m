Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913482E62C4
	for <xenomai@lists.linux.dev>; Mon, 26 Jan 2026 16:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769444102; cv=none; b=TSxjWlsNF5JVG1Ua79UmxWCKskJDRvSutRGRYJuazKVmC5pMrpBqxDZSK3RH6GOgPwry6eWS4bMMKsg554p+BG9QbLWCp5LtR5CfTcY/SKspfVVwNceVN/tguTziiPyMU0SIpgAySrRcPd0LCa/CfoDW/2f/cvOQCmBvY7BSGBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769444102; c=relaxed/simple;
	bh=nGqL9imupQ0XIImvLxooCSAwBA82VYjCSRp8pAkaMKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MbPADkH8GHEZlcrVhPG3HxT4I/i1Re0uF/hoJ8AOwBls1MLGjcaqNdUORC/gGipkP3IwH/8aCqJWfHbHZLfhg2x4X88BrIO0h5JhJQadHOVHTJbATXZvXV+NzUkutas5/73mxeo9gCqyOm2VEOR3+yKHchx5+0YwCfFCaiRQMeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=Fdg34JDk; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="Fdg34JDk"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202601261614571668f5ebd6000207e5
        for <xenomai@lists.linux.dev>;
        Mon, 26 Jan 2026 17:14:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=BxXj9Ai8Y9gg+Ouej22bdYNK5DTG4p+wScQnWjPjsJ4=;
 b=Fdg34JDkfalj3hcwO5qTAqfVkzEHNTog3+LfFKU5c5yZAE58Dn9PnGeejXKrKX65gI05BF
 /S3cef3/SkErY7duJUQGI1AhyR7QSde1JvlLZopyvS8rEXCdJRB/F0w5i6BPv7jNzNAHhDKP
 O3/e4wxVtzYgORAQAm6vL8uPy1/DvObztSyyMZbz2qCS81JlDlP0PeEJjyMtqEoxcFN54DXS
 WhozYgr780cRjyQgkfKAj4Zz1n0Oac2gr7GjqBA25uOpNsh1+Vdc0kzYumYY1totowNKd9zV
 oTgPkDCIeMdDoz2wg8OM6SuHbupRFpgOAkJ3DUW+zF9P0WtFmjlAZMbQ==;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [xenomai-images][PATCH 1/3] ci(dovetail): Put rules into workflow section
Date: Mon, 26 Jan 2026 17:14:43 +0100
Message-ID: <20260126161445.349483-2-clara.kowalsky@siemens.com>
In-Reply-To: <20260126161445.349483-1-clara.kowalsky@siemens.com>
References: <20260126161445.349483-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

This avoids duplicating the rules. The trigger job runs under the same
conditions as the set-vars job.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 ci/ci-dovetail.yml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/ci/ci-dovetail.yml b/ci/ci-dovetail.yml
index 7b4d20b..77fa02b 100644
--- a/ci/ci-dovetail.yml
+++ b/ci/ci-dovetail.yml
@@ -12,6 +12,10 @@
 # as configured in its CI/CD settings
 #
 
+workflow:
+  rules:
+    - if: '$CI_COMMIT_BRANCH =~ /^v(5\.(10|15)|6\.(1|12))(\.y)?(-cip)?-dovetail-rebase$/'
+
 stages:
   - set_vars
   - trigger_xenomai_images
@@ -29,8 +33,6 @@ set-vars:
   artifacts:
     reports:
       dotenv: vars.env
-  rules:
-    - if: '$CI_COMMIT_BRANCH =~ /^v(5\.(10|15)|6\.(1|12))(\.y)?(-cip)?-dovetail-rebase$/'
 
 trigger-xenomai-images:
   stage: trigger_xenomai_images
@@ -45,5 +47,3 @@ trigger-xenomai-images:
     KERNEL_VERSION: $KERNEL_VERSION
     KERNEL_VERSION_WITH_QEMU: $KERNEL_VERSION
     ONLY_RUN: xenomai-3/dovetail
-  rules:
-    - if: '$CI_COMMIT_BRANCH =~ /^v(5\.(10|15)|6\.(1|12))(\.y)?(-cip)?-dovetail-rebase$/'
-- 
2.52.0

