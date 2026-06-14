Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1EB4317D
	for <xenomai@lists.linux.dev>; Sun, 14 Jun 2026 09:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781428668; cv=none; b=PyLbkml3nj+yyidHLncxJDvUVbjLYey3qIDRoKFGg190I3Ys/KBHTqO+ThyrKFgUnJzhT9vUKYM5BYrWIpqFbl/Yvu1hKV7TLEczs6MFkAQxEIVxuNy0tLdrrPWCKeS6o2ItQaWQRlqTBL29yiEtyK1hFSfUic/jqJLUJDbAV7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781428668; c=relaxed/simple;
	bh=Fq8jdrZnQDKHYOm5+wnNLGdY/GrlUqAVmjEzV1RJBXc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LcEBUsxduaooTcljSu/RLI7Wo7VDUHWbvOMWU3fSeYAsbW4eIZ5+QfmzlG82wcb+li9ozb3Bqwa58rvYLFuNIg0RJhOM43kK31sb5zZKJTKICoW22iJTs1Rugh5LsFTOdyYFtAMOr6mPbb0uCuuUlrOaevTQADDIPBUL6uF/EaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=g0XJILxv; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="g0XJILxv"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260614091735a2f669b8790002077b
        for <xenomai@lists.linux.dev>;
        Sun, 14 Jun 2026 11:17:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=1Z3XEDRCd+i1soTa3u+JV/zpESsyDzCDQ5M5m2mwOJc=;
 b=g0XJILxv5vQjihH2zUhqvK9o1x0biEHWhLgnTgW1GNGHtJ44m6okPXoInsAFEWmT2fky2x
 3ydJyYhDrcZnwHfjN6nmxrqZNbUXGBp4dsumHFvLz1s/PvKM6InEUs+ShKea1uhTdT0pvlGA
 Tmfuyf4OEge/RGpyJra6Sb1sBdVgO/e7fC6S6nmlWAn9M9DkHP561YsSkl2mQDZNgE5xpjEP
 XlAiGvfocGKqcRzn8VxuL6E49j0BaPFayamBHIwwCHyGhVnJEmSauPFG8LxVuHSbW5By/5nC
 hi8PcjzRUZctBpGAOU2N/sKF8AkMXWO3IMwvBTPnjps2BSEeK4KB5/Eg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 3/6] linux-xenomai: Limit latest branch selection to official ones
Date: Sun, 14 Jun 2026 11:17:31 +0200
Message-ID: <943e743c29ba75c8a2ed18ea99931c7cdd7d1561.1781428654.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1781428654.git.jan.kiszka@siemens.com>
References: <cover.1781428654.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

This was matching also pre-release branches like
wip/flo/v7.1-dovetail-rebase or wip/flo/v7.1-evl-rebase.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-xenomai-3_latest.bb | 2 +-
 recipes-kernel/linux/linux-xenomai-4_latest.bb | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-kernel/linux/linux-xenomai-3_latest.bb b/recipes-kernel/linux/linux-xenomai-3_latest.bb
index 188b842..f526008 100644
--- a/recipes-kernel/linux/linux-xenomai-3_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_latest.bb
@@ -23,7 +23,7 @@ python () {
     if is_kernel(d, 'latest'):
         cmd = 'git ls-remote --tags --head --refs https://gitlab.com/xenomai/linux-dovetail.git | ' \
               'sed -e "s/.*[[:space:]]refs\/\(tags\|heads\)\///" | ' \
-              'grep "v7\.[0-9].*-dovetail-rebase" | ' \
+              'grep "^v7\.[0-9].*-dovetail-rebase" | ' \
               'sort -r -n -k 1.4 | head -1'
         (ret, out) = subprocess.getstatusoutput(cmd)
         d.setVar('LATEST_KERNEL_BRANCH', out)
diff --git a/recipes-kernel/linux/linux-xenomai-4_latest.bb b/recipes-kernel/linux/linux-xenomai-4_latest.bb
index e3c93fe..9d479cd 100644
--- a/recipes-kernel/linux/linux-xenomai-4_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai-4_latest.bb
@@ -22,7 +22,7 @@ python () {
     if is_kernel(d, 'latest'):
         cmd = 'git ls-remote --tags --head --refs https://gitlab.com/Xenomai/xenomai4/linux-evl.git | ' \
               'sed -e "s/.*[[:space:]]refs\/\(tags\|heads\)\///" | ' \
-              'grep "v7\.[0-9].*-evl-rebase" | ' \
+              'grep "^v7\.[0-9].*-evl-rebase" | ' \
               'sort -r -n -k 1.4 | head -1'
         (ret, out) = subprocess.getstatusoutput(cmd)
         d.setVar('LATEST_KERNEL_BRANCH', out)
-- 
2.47.3

