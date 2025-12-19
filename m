Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0C386341
	for <xenomai@lists.linux.dev>; Fri, 19 Dec 2025 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766163122; cv=none; b=ImOsWgCbLuzU6DKpT2wmxkoHDjQXfEWGMqd5m/92ioyI+47ttPdBfLuuJINyzUC3QIdDePN3YF/w8JyvFMKLVgJ3yuh8c0X2xLiSeBnROt0BZ/4put2g/lNDx6LJPrOb0IOe4fWjJRbLLG61k3rtsogVI/LJlh5omDv41T+UrBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766163122; c=relaxed/simple;
	bh=QzhCV5E7HkLW/PnHkqvTColDZM9+rjw+nkiP2U+IZmY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VYoBUp+fo9zFONr9276GujxLRZlKsYx4IAuFix7LeN+kstiSRhiNHMQl41wFCuW1FIUNfQeKMJESbtpc5258voC9y7RdWCsKAQwj0E6pCXYrRDpb8dNFUqa3awf8mbbxn4ZDOkUwvh+ewVLpETXBuieDyO9VFcb6dC66Jg5HadA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=ksekZeoA; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="ksekZeoA"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2025121916515574b9e4a8e800020720
        for <xenomai@lists.linux.dev>;
        Fri, 19 Dec 2025 17:51:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=Qoh0yXGrHIgLB2psgedhBLbPE1qtZcuXiUUNXTrL6BU=;
 b=ksekZeoAxCJmWMg0zTd2wf0YUf9WNoCOXFR6nQlkKQFe+JCBkHI7jwlqB2B3GgiVOoDlpE
 CrfKztU345SZuGLvBkQKc+nOS5JEcDm7Mr3eVXSOND6mVHc5td26QN2rQVmY1OJRDB0DnBkd
 lMOX9CS+QeotnKDRXkkiisX4fe/pmovKTD/jtElXa6iWf8fIPBCLkJ3Rqp0Kl9HwMeqA3hDD
 EVtrGKrkUCHNZjRWbOd174WmWNm2bNOUKka7nIB2J/uoST2MY8WJysmYH28W/X82Nbi166d9
 7Q3fv8PbTkOgLmqhRouCqEJDpn7M+wwe9DRbpg70BHykgyRqOw5T+lpQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 3/5] Account for reduced kernel support for Xenomai 3 head
Date: Fri, 19 Dec 2025 17:51:52 +0100
Message-ID: <611eb9a31c3ecad2945599b12bc6750b3de54cb4.1766163114.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1766163114.git.jan.kiszka@siemens.com>
References: <cover.1766163114.git.jan.kiszka@siemens.com>
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

Next major Xenomai 3 release will require kernel 6.1 or newer.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig               | 8 ++++----
 ci/xenomai_3_next.yml | 2 --
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/Kconfig b/Kconfig
index 56b1ebe..178db97 100644
--- a/Kconfig
+++ b/Kconfig
@@ -139,19 +139,19 @@ config KERNEL_6_1
 
 config KERNEL_5_15_HEAD
 	bool "Head of 5.15 Dovetail branch"
-	depends on XENOMAI_HEAD || XENOMAI_3_3_HEAD || XENOMAI_3_3 || XENOMAI_3_2_HEAD || XENOMAI_3_2
+	depends on XENOMAI_3_3_HEAD || XENOMAI_3_3 || XENOMAI_3_2_HEAD || XENOMAI_3_2
 
 config KERNEL_5_15
 	bool "Latest 5.15 Dovetail release"
-	depends on XENOMAI_HEAD || XENOMAI_3_3_HEAD || XENOMAI_3_3 || XENOMAI_3_2_HEAD || XENOMAI_3_2
+	depends on XENOMAI_3_3_HEAD || XENOMAI_3_3 || XENOMAI_3_2_HEAD || XENOMAI_3_2
 
 config KERNEL_5_10_HEAD
 	bool "Head of 5.10 Dovetail branch"
-	depends on XENOMAI_HEAD || XENOMAI_3_3_HEAD || XENOMAI_3_3 || XENOMAI_3_2_HEAD || XENOMAI_3_2
+	depends on XENOMAI_3_3_HEAD || XENOMAI_3_3 || XENOMAI_3_2_HEAD || XENOMAI_3_2
 
 config KERNEL_5_10
 	bool "Latest 5.10 Dovetail release"
-	depends on XENOMAI_HEAD || XENOMAI_3_3_HEAD || XENOMAI_3_3 || XENOMAI_3_2_HEAD || XENOMAI_3_2
+	depends on XENOMAI_3_3_HEAD || XENOMAI_3_3 || XENOMAI_3_2_HEAD || XENOMAI_3_2
 
 config KERNEL_4_19_HEAD
 	bool "Head of 4.19-cip I-pipe branch"
diff --git a/ci/xenomai_3_next.yml b/ci/xenomai_3_next.yml
index 15095dd..6559357 100644
--- a/ci/xenomai_3_next.yml
+++ b/ci/xenomai_3_next.yml
@@ -11,8 +11,6 @@
 
 include:
   - local: '/ci/gitlab-ci-base.yml'
-  - local: '/ci/kernel_5_10.yml'
-  - local: '/ci/kernel_5_15.yml'
   - local: '/ci/kernel_6_1.yml'
   - local: '/ci/kernel_6_12.yml'
   - local: '/ci/xenomai_3_next_compat.yml'
-- 
2.51.0

