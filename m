Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006A928CF54
	for <xenomai@lists.linux.dev>; Thu, 10 Apr 2025 14:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744294603; cv=none; b=HiSmFVHcce7HYF6TDAStAlUgV0pjRtck/ued57RiYDhjli2Rr+L/QgTq4iyGvRpH8TdscRc/rWUjfS/0OFgKGkchj6vzmTnGRT7mPDwjUBcoltyxqjlAHIhcpU+36OQC8tq84K6c0aFaDg1crOyE8Mju4YT+Zty39GkTFqjvsT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744294603; c=relaxed/simple;
	bh=cGinRtBbfNY/of5RfF6v69nI8AQksm4EQSMfdMdM184=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CYMsHM6gAaEQlQDG4M5AOGYeDi8zIzkg+MKSZxKndI2n1ngzYMOcyBsEb9VhWHSgsYz9mGN7TMEKI0sZmF6GLgMbO93tVSnr7LyivvZ0zSK39vEN9+mwlmt3PDghFYJ5wsrieTRTQCY0uSTiTh5S/6S/ZKJ+JbH5wZumVVAZ/4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=a4/qs4Ce; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="a4/qs4Ce"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20250410141631ae0f33c446399639ca
        for <xenomai@lists.linux.dev>;
        Thu, 10 Apr 2025 16:16:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=cZwDuxCSxd9icuQvWNSg8n9iC574KldV8r5U/WaUWYY=;
 b=a4/qs4CeI8nSUlTSUdHDh/GyN9waH1svJzyubjaA4jkVQ8ADMqsu2cV6Mr+RWLFfFfmVLz
 JwIoSPXPdz409kYKq1rLpVQ9zD4wFL9tvUGvMCQzt/PV5o0sAV4LUXfbzR2U9y8kWoMQ+HD8
 B+t4z+QREIoc50SH4sQAro1To7hmzUz/M9SFL1fggNOmve2haoZ1nJrdJDIokrlqCZ9SRQBM
 NEf7u9b84Tk9ZA6bWegjGlMITbx7uMpa0xedQZz8KMKSiCilDndXxARQVw8tk59IvzPCXE0O
 eg04dv1r8VdqBNAYQI4QbNggsD7Bl20K+C4clCtfzlnlCpw05RQiJOfA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 5/7] linux-xenomai-3: Update to latest releases
Date: Thu, 10 Apr 2025 16:16:28 +0200
Message-ID: <0117a8faec207da41fabf2dfc951ee0034fa36a3.1744294590.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1744294590.git.jan.kiszka@siemens.com>
References: <cover.1744294590.git.jan.kiszka@siemens.com>
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

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-xenomai-3_5.10.bb | 2 +-
 recipes-kernel/linux/linux-xenomai-3_5.15.bb | 2 +-
 recipes-kernel/linux/linux-xenomai-3_6.1.bb  | 2 +-
 recipes-kernel/linux/linux-xenomai-3_6.12.bb | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/recipes-kernel/linux/linux-xenomai-3_5.10.bb b/recipes-kernel/linux/linux-xenomai-3_5.10.bb
index 088d0d8..644f001 100644
--- a/recipes-kernel/linux/linux-xenomai-3_5.10.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_5.10.bb
@@ -11,4 +11,4 @@
 
 require recipes-kernel/linux/linux-xenomai-3-dovetail.inc
 
-SRCREV ?= "v5.10.229-cip54-dovetail1"
+SRCREV ?= "v5.10.234-cip57-dovetail1"
diff --git a/recipes-kernel/linux/linux-xenomai-3_5.15.bb b/recipes-kernel/linux/linux-xenomai-3_5.15.bb
index 286c64e..14dca06 100644
--- a/recipes-kernel/linux/linux-xenomai-3_5.15.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_5.15.bb
@@ -11,4 +11,4 @@
 
 require recipes-kernel/linux/linux-xenomai-3-dovetail.inc
 
-SRCREV ?= "v5.15.173-dovetail1"
+SRCREV ?= "v5.15.179-dovetail1"
diff --git a/recipes-kernel/linux/linux-xenomai-3_6.1.bb b/recipes-kernel/linux/linux-xenomai-3_6.1.bb
index f052b20..03b3800 100644
--- a/recipes-kernel/linux/linux-xenomai-3_6.1.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_6.1.bb
@@ -11,4 +11,4 @@
 
 require recipes-kernel/linux/linux-xenomai-3-dovetail.inc
 
-SRCREV ?= "v6.1.121-cip34-dovetail1"
+SRCREV ?= "v6.1.128-cip37-dovetail1"
diff --git a/recipes-kernel/linux/linux-xenomai-3_6.12.bb b/recipes-kernel/linux/linux-xenomai-3_6.12.bb
index 62fbe67..505aac4 100644
--- a/recipes-kernel/linux/linux-xenomai-3_6.12.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_6.12.bb
@@ -11,4 +11,4 @@
 
 require recipes-kernel/linux/linux-xenomai-3-dovetail.inc
 
-SRCREV ?= "v6.12.8-dovetail1"
+SRCREV ?= "v6.12.19-dovetail1"
-- 
2.43.0

