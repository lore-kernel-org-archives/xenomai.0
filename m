Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD7F28C5DD
	for <xenomai@lists.linux.dev>; Thu, 10 Apr 2025 14:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744294602; cv=none; b=D/lJki5vsLIuXp/+0OwXvZtrsB3SdB7l++OR8N/t3GZys9C4gVCDTpDuY1Yaa9edW/AG2WoohL48R62X04AbOql/2w//0nVhfU87L9WVlxBHDv1s2qYPMPu+ca/2eKR59ViKk+v24pnXd+Hi3pu8ZbqQPXpcvLPOsOn51rs4Q8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744294602; c=relaxed/simple;
	bh=uqVMdGrzy9HpbziZdyzloOnu4Y2/J4vzBJGMeZ0P0jU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XYYAnSMaqxjLs29kHq4cdnM0uIrPwr3Lx9uhCInYfUTrGl6+WQPb/zZaTf/vKfCShRDM2wfo9n/697ON9DkokOqhvrIxr55MZY7B9vj3HMTKrKCu5Mvl643IfsSQhE+QjPPJUmrdZsFaZMd0d3qEHmvg9VwqrI4c93Uqd4IzjfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=fFz1kSmM; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="fFz1kSmM"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20250410141631d4d189794b337fd15e
        for <xenomai@lists.linux.dev>;
        Thu, 10 Apr 2025 16:16:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=JLHB4ritvV8wFld1kS0svyw80+QEzUK4wZH2Rc5XbuA=;
 b=fFz1kSmMDtKsnDUz1rnsBoN8qzXrZsUaSRue5pxGCRvKvh8M9Kf7ZhHY72XaQi+la83/Aa
 srw3JjDUDE7dC5GHigZWDplw4XExvRLpnLnTuVvciprWPKkqdzOE85lho3nRybuYcmC+MKww
 CwjKjPKpfL78H65j6vhx3VnvLHoFA6JKB0R6/6dWQ4PT8gHC9hyEqiDbX8lfB0daB6bwjlRh
 +WtlrJNFqemHBMJnBFd8x5GBYcSjnAe6fpyMq8Dyw4cPSExvjPfJ57fwvpcy9o7uk2zVvbLb
 j74VVej2JcFX29JjuBhYweQ6lBkCaLC1Gk+B9B2Ixhqrl1PV5MxNOlMg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 4/7] linux-xenomai-4: Update to latest releases
Date: Thu, 10 Apr 2025 16:16:27 +0200
Message-ID: <b534a5cf9a81ee08b7651fb27ba1e874799fd07e.1744294590.git.jan.kiszka@siemens.com>
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
 recipes-kernel/linux/linux-xenomai-4_6.1.bb  | 2 +-
 recipes-kernel/linux/linux-xenomai-4_6.12.bb | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-kernel/linux/linux-xenomai-4_6.1.bb b/recipes-kernel/linux/linux-xenomai-4_6.1.bb
index 32e2131..1571ab6 100644
--- a/recipes-kernel/linux/linux-xenomai-4_6.1.bb
+++ b/recipes-kernel/linux/linux-xenomai-4_6.1.bb
@@ -11,4 +11,4 @@
 
 require recipes-kernel/linux/linux-xenomai-4-evl.inc
 
-SRCREV ?= "v6.1.121-cip34-evl1-rebase"
+SRCREV ?= "v6.1.128-cip37-evl1-rebase"
diff --git a/recipes-kernel/linux/linux-xenomai-4_6.12.bb b/recipes-kernel/linux/linux-xenomai-4_6.12.bb
index 75fa7ee..3e042a5 100644
--- a/recipes-kernel/linux/linux-xenomai-4_6.12.bb
+++ b/recipes-kernel/linux/linux-xenomai-4_6.12.bb
@@ -11,4 +11,4 @@
 
 require recipes-kernel/linux/linux-xenomai-4-evl.inc
 
-SRCREV ?= "v6.12.8-evl1-rebase"
+SRCREV ?= "v6.12.19-evl1-rebase"
-- 
2.43.0

