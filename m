Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871E61DD544
	for <xenomai@lists.linux.dev>; Mon, 28 Oct 2024 13:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730123091; cv=none; b=f+yHvzgGmfkvj3ftKpcde00RK/2dBLZNujQEUMA54X8V1j682iiPV/DQSiaIDmh5OQmBDIORZyAwjb/D4KOw/4O51SL61P9MWRw9EVjN3lnfJ3bfWn9OoIy67rM/3+eqcae/sl2Ce8WCa/s5bI8k/xj7j8YvdvI7eqzsCj2IuAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730123091; c=relaxed/simple;
	bh=i0PIVrRTyPPLNaqmgyN/7ErEYpslGSWFxOPd7kJkNHQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IraLYYPsAfxadfEH4e35+SOL40iklOD7MzqBojy0AATN2LhEmwHLnAknNIoLslpJDKGUbOsDp4AKRpDyrmdkk+ETUlu4VMhiXg6hJsM2vfohbTTGZQCEFuv326jHnonaPG1NWlWXZGdUHcO/3F1NGYZZ0PRFNuES/EJ+9TFXsLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=QbxPsEPl; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="QbxPsEPl"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20241028134446583c10feeeff1e1d0d
        for <xenomai@lists.linux.dev>;
        Mon, 28 Oct 2024 14:44:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=iTctn31iWxL5uOR58bKHzgwrhBQwkbrIZx2cO07Uq2Q=;
 b=QbxPsEPlKod8deLUwx7Aac49oRMVctWjH+0W8Tp9HYpiwRxpxzt3yyZxfcJw28PBUWUZh3
 HSC0cw8/N43z6v8rsnIvxP2CTc/o2TgoSdiLl0irVg1fiXftn5R3lf7gMWRg3kIZzzuq+su+
 HaVOshx7ztqoK2k9s0ApaTGPQADNhz7ARZUxtFqdO75zG6Tw0oAIZH0kcgcgL3rEIxa6Rfe+
 myIuxy3lPHM+WevwBU7pJJg8a5H7b4CvThY7gTkFX76t3e5azHLZZWXOIQkW3WYaDgtIwvl/
 7pR32Jmspwbp1rTywUn36XhATy0w+GdfndViYoc6ozPULHNF9dSGRjhQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 4/6] xenomai: Pull common definition of S into shared include
Date: Mon, 28 Oct 2024 14:44:42 +0100
Message-ID: <3c105e3e7043983e2ea5847187434b0ca3f65f15.1730123084.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1730123084.git.jan.kiszka@siemens.com>
References: <cover.1730123084.git.jan.kiszka@siemens.com>
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
 recipes-xenomai/xenomai/xenomai.inc             | 2 ++
 recipes-xenomai/xenomai/xenomai_3.0.14.bb       | 1 -
 recipes-xenomai/xenomai/xenomai_3.1.4.bb        | 2 --
 recipes-xenomai/xenomai/xenomai_3.2.4.bb        | 2 --
 recipes-xenomai/xenomai/xenomai_master.bb       | 2 --
 recipes-xenomai/xenomai/xenomai_stable-3.0.x.bb | 2 --
 6 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/recipes-xenomai/xenomai/xenomai.inc b/recipes-xenomai/xenomai/xenomai.inc
index efb92ad..6366b6f 100644
--- a/recipes-xenomai/xenomai/xenomai.inc
+++ b/recipes-xenomai/xenomai/xenomai.inc
@@ -21,6 +21,8 @@ PROVIDES += "libxenomai1"
 PROVIDES += "libxenomai-dev"
 PROVIDES += "libxenomai1-dbgsym"
 
+S = "${WORKDIR}/git"
+
 do_prepare_build() {
     # Xenomai currently does not maintain its changelog, plus we want the
     # actual package version in there.
diff --git a/recipes-xenomai/xenomai/xenomai_3.0.14.bb b/recipes-xenomai/xenomai/xenomai_3.0.14.bb
index afc1920..2c0debd 100644
--- a/recipes-xenomai/xenomai/xenomai_3.0.14.bb
+++ b/recipes-xenomai/xenomai/xenomai_3.0.14.bb
@@ -16,4 +16,3 @@ require xenomai.inc
 SRC_URI = " \
     git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=stable/v3.0.x;tag=v${PV} \
     "
-S = "${WORKDIR}/git"
diff --git a/recipes-xenomai/xenomai/xenomai_3.1.4.bb b/recipes-xenomai/xenomai/xenomai_3.1.4.bb
index e501e41..8cfe184 100644
--- a/recipes-xenomai/xenomai/xenomai_3.1.4.bb
+++ b/recipes-xenomai/xenomai/xenomai_3.1.4.bb
@@ -15,5 +15,3 @@ require xenomai.inc
 
 SRC_URI = " \
     git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=stable/v3.1.x;tag=v${PV}"
-
-S = "${WORKDIR}/git"
diff --git a/recipes-xenomai/xenomai/xenomai_3.2.4.bb b/recipes-xenomai/xenomai/xenomai_3.2.4.bb
index 0cd1cd9..0bd7007 100644
--- a/recipes-xenomai/xenomai/xenomai_3.2.4.bb
+++ b/recipes-xenomai/xenomai/xenomai_3.2.4.bb
@@ -15,5 +15,3 @@ require xenomai.inc
 
 SRC_URI = " \
     git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=stable/v3.2.x;tag=v${PV}"
-
-S = "${WORKDIR}/git"
diff --git a/recipes-xenomai/xenomai/xenomai_master.bb b/recipes-xenomai/xenomai/xenomai_master.bb
index a2e8802..708ddb3 100644
--- a/recipes-xenomai/xenomai/xenomai_master.bb
+++ b/recipes-xenomai/xenomai/xenomai_master.bb
@@ -17,5 +17,3 @@ CHANGELOG_V = "9999-${PV}"
 SRC_URI = " \
     git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=${PV}"
 SRCREV = "${AUTOREV}"
-
-S = "${WORKDIR}/git"
diff --git a/recipes-xenomai/xenomai/xenomai_stable-3.0.x.bb b/recipes-xenomai/xenomai/xenomai_stable-3.0.x.bb
index 6231e9e..bca3eb2 100644
--- a/recipes-xenomai/xenomai/xenomai_stable-3.0.x.bb
+++ b/recipes-xenomai/xenomai/xenomai_stable-3.0.x.bb
@@ -18,5 +18,3 @@ CHANGELOG_V = "${XENOMAI_VERSION}-head"
 SRC_URI = " \
     git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=stable/v${XENOMAI_VERSION}"
 SRCREV = "${AUTOREV}"
-
-S = "${WORKDIR}/git"
-- 
2.43.0

