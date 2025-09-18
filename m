Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3A730FC30
	for <xenomai@lists.linux.dev>; Thu, 18 Sep 2025 15:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210976; cv=none; b=RdlymeVBI47ViUmUp8NZCENeQrhXlhcZbXgs7jC/qJKztUYDWeLynmKQWfuBkvguu/RIs+jBJCvWY2VrNjc59L5W2y/12Hs9j/QctPmffnzAAWy59qotf/5u1Krk1BsfwleFgv0q9UBQMN79VAusGy/1dyht4db2eXCkzMxCjwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210976; c=relaxed/simple;
	bh=p5ibyCHKz4rA47nvw5M8go6jM5rKwNjwte5lK7uD+kg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8mzDIjgF3LfsOx5pr7h2XB3CQvZWVvTHE5LgBZY6L0wsb1FFSrXb/lpeV2mIna8YOJBGYIVrmNlBJ45/pmKKqDSHFqKDaHc30mVO1/uJ2Fkww/+Q0vzqv0BS38zMmwskHyLNUeoUMLATnK8Xtbx1PinHXc3Ti8xA1rNenLWXvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=W3etatBR; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="W3etatBR"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20250918155611bdce2cc31200020780
        for <xenomai@lists.linux.dev>;
        Thu, 18 Sep 2025 17:56:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=kHYazaO1my1/kz5DGpqNt1ctKe/+TIOO/Wug4VYeteI=;
 b=W3etatBRFYhDvTwn7b9K9vCcmLEdeaCwsLpSClCcork4g8cPR2RhFC0j0WZWIBM2gbLjZY
 jeztU9WHHnGzJ0o9L9UgAPEb4M4H+F0wDDSYCr/6a94wJJXq/a4k2BFUaKlPADUSzQ64gUyt
 ipdgJjs2Yvd1gYH2Op27L/Q9qzqwy2Fxx+g+uMzk+TWmT8eK0VV8/5IPK5dyoXuVuDAsNtPS
 KkRyzxhJ8bF6PzQoVz1a+nnE8UDAK3afxJZWBvglR9RdN0/O6iBG/kfs9jJDq72Gbz5i4VXO
 9ieddQWTOPcL+ncF/xBVBi3DTyK2Bod/PEx31rgd4HCYw04OVRMJCfrA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 06/13] Switch demo images for next branch to Debian trixie (13)
Date: Thu, 18 Sep 2025 17:55:48 +0200
Message-ID: <90219b98240cbec4724a3d338c9222774c231989.1758210955.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1758210955.git.jan.kiszka@siemens.com>
References: <cover.1758210955.git.jan.kiszka@siemens.com>
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

Debian trixie enforces 64-bit time_t for some archs now. This is only
supported by Xenomai 3.3 and newer, so we need to keep the rest on
bookworm. In addition, a vDSO parser update which is needed now with
6.12 and gcc-14 from trixie is not yet in a stable 3.3 release, forcing
us to keep that version on bookworm as well for now.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/distro/xenomai-demo.conf | 4 +++-
 opt-xenomai-3.1.x.yml         | 4 +++-
 opt-xenomai-3.2.x.yml         | 4 +++-
 opt-xenomai-3.3.x.yml         | 2 ++
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/conf/distro/xenomai-demo.conf b/conf/distro/xenomai-demo.conf
index 617f8bd..1a58054 100644
--- a/conf/distro/xenomai-demo.conf
+++ b/conf/distro/xenomai-demo.conf
@@ -9,7 +9,9 @@
 # SPDX-License-Identifier: MIT
 #
 
-require conf/distro/debian-bookworm.conf
+DEBIAN_RELEASE ?= "trixie"
+
+require conf/distro/debian-${DEBIAN_RELEASE}.conf
 
 XENOMAI_MAJOR_VERSION ?= "3"
 
diff --git a/opt-xenomai-3.1.x.yml b/opt-xenomai-3.1.x.yml
index 91c097f..622b217 100644
--- a/opt-xenomai-3.1.x.yml
+++ b/opt-xenomai-3.1.x.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2020-2024
+# Copyright (c) Siemens AG, 2020-2025
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -13,6 +13,8 @@ header:
   version: 14
 
 local_conf_header:
+  debian-release: |
+    DEBIAN_RELEASE = "bookworm"
   xenomai-3-1-x: |
     PREFERRED_VERSION_xenomai = "stable-3.1.x"
     PREFERRED_VERSION_xenomai-compat = "stable-3.1.x"
diff --git a/opt-xenomai-3.2.x.yml b/opt-xenomai-3.2.x.yml
index 117161e..24098ef 100644
--- a/opt-xenomai-3.2.x.yml
+++ b/opt-xenomai-3.2.x.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2021-2024
+# Copyright (c) Siemens AG, 2021-2025
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -13,6 +13,8 @@ header:
   version: 14
 
 local_conf_header:
+  debian-release: |
+    DEBIAN_RELEASE = "bookworm"
   xenomai-3-2-x: |
     PREFERRED_VERSION_xenomai = "stable-3.2.x"
     PREFERRED_VERSION_xenomai-compat = "stable-3.2.x"
diff --git a/opt-xenomai-3.3.x.yml b/opt-xenomai-3.3.x.yml
index cd7b477..c65ce1f 100644
--- a/opt-xenomai-3.3.x.yml
+++ b/opt-xenomai-3.3.x.yml
@@ -13,6 +13,8 @@ header:
   version: 14
 
 local_conf_header:
+  debian-release: |
+    DEBIAN_RELEASE = "bookworm"
   xenomai-3-3-x: |
     PREFERRED_VERSION_xenomai = "stable-3.3.x"
     PREFERRED_VERSION_xenomai-compat = "stable-3.3.x"
-- 
2.51.0

