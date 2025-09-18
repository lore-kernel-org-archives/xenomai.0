Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E618A30CD83
	for <xenomai@lists.linux.dev>; Thu, 18 Sep 2025 15:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210975; cv=none; b=nXhJ4lhz8k56GB6IQBQ/BE1u9r+LzKWMVVS+9WqYzjnQeiaEbCQS3ZdgEPXvmkfOQGrn0ACXHeYmUU658LTz71PMa/5DhrmX0cMjbsCyF2Pp0qVMakZWZaJlUSXks9CDqFn5RNDamjB1TwE0xqPVP/9OwT0AQPh6J7vCXEP2kmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210975; c=relaxed/simple;
	bh=7UllEtamLXNbDxtMCn9kM6LX32LdsCzojk6X9a53I8M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pko6v+YZ7oIilSX633kP6P1ACj5Y2pWVAjAxE3tU/jVNbEkbXmWA3LDaulfp5h1+MytchfVtrPwKNyDmo+bbn3D1j7kqNqv7K2/bucwOiD3Jr3vqs1TqMcpXQeMU0MDKiX3ty/8LuVg6XjO2oAeoSf4eYUV+Lj94AdBYV/UxuaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=rQNE2OlI; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="rQNE2OlI"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250918155610ec4f523f7200020794
        for <xenomai@lists.linux.dev>;
        Thu, 18 Sep 2025 17:56:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=+x0u7DpGYqWpbXOjVkdt7jKggO7xvajczGal6EUQAYE=;
 b=rQNE2OlIvxOoMwW/tVYZHSM6sBS2M4aQMCUVe4ABPTX1MyojNY58/SCs5CFbYn6W20lDAi
 6ZcruIsZ76hchssBXA27kD3ABWca5TcjaVyB/pOD/Xha6dsMPprGMcrsWxfUbFIPETjl2LTW
 2SZrYjAVT199eSOvufrmTkRgSUmdX03pPddIPk6F6COcDla3k7blGFHVQEzh4U6bFTMLhBJ6
 A9+YKc3htMbHF3TTtTFz7S5SfgZoI0Yc+2310QS82GmOApLVAFMOHlBtHlLJLDleQR2qhi2H
 Jciy5b4RBCyzhkX6z06QO/T92gkyBH/KH4Muom1Hz33eAONkUalidhlQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 03/13] xenomai: Update to latest Xenomai 3 and libevl releases
Date: Thu, 18 Sep 2025 17:55:45 +0200
Message-ID: <5ad676b354d38b058a9e21281156827045ca2797.1758210955.git.jan.kiszka@siemens.com>
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

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/distro/xenomai-demo.conf                                  | 2 +-
 recipes-xenomai/libevl/{libevl_50.bb => libevl_55.bb}          | 0
 recipes-xenomai/xenomai/{xenomai_3.1.5.bb => xenomai_3.1.7.bb} | 0
 recipes-xenomai/xenomai/{xenomai_3.2.6.bb => xenomai_3.2.8.bb} | 0
 recipes-xenomai/xenomai/{xenomai_3.3.bb => xenomai_3.3.2.bb}   | 2 +-
 5 files changed, 2 insertions(+), 2 deletions(-)
 rename recipes-xenomai/libevl/{libevl_50.bb => libevl_55.bb} (100%)
 rename recipes-xenomai/xenomai/{xenomai_3.1.5.bb => xenomai_3.1.7.bb} (100%)
 rename recipes-xenomai/xenomai/{xenomai_3.2.6.bb => xenomai_3.2.8.bb} (100%)
 rename recipes-xenomai/xenomai/{xenomai_3.3.bb => xenomai_3.3.2.bb} (90%)

diff --git a/conf/distro/xenomai-demo.conf b/conf/distro/xenomai-demo.conf
index 8377732..617f8bd 100644
--- a/conf/distro/xenomai-demo.conf
+++ b/conf/distro/xenomai-demo.conf
@@ -19,7 +19,7 @@ PREFERRED_VERSION_xenomai ?= "3.3%"
 PREFERRED_VERSION_xenomai-compat ?= "3.3%"
 include conf/distro/include/xenomai-version.inc
 
-PREFERRED_VERSION_libevl ?= "4%"
+PREFERRED_VERSION_libevl ?= "5%"
 
 KERNEL_NAME = "xenomai-${XENOMAI_MAJOR_VERSION}"
 
diff --git a/recipes-xenomai/libevl/libevl_50.bb b/recipes-xenomai/libevl/libevl_55.bb
similarity index 100%
rename from recipes-xenomai/libevl/libevl_50.bb
rename to recipes-xenomai/libevl/libevl_55.bb
diff --git a/recipes-xenomai/xenomai/xenomai_3.1.5.bb b/recipes-xenomai/xenomai/xenomai_3.1.7.bb
similarity index 100%
rename from recipes-xenomai/xenomai/xenomai_3.1.5.bb
rename to recipes-xenomai/xenomai/xenomai_3.1.7.bb
diff --git a/recipes-xenomai/xenomai/xenomai_3.2.6.bb b/recipes-xenomai/xenomai/xenomai_3.2.8.bb
similarity index 100%
rename from recipes-xenomai/xenomai/xenomai_3.2.6.bb
rename to recipes-xenomai/xenomai/xenomai_3.2.8.bb
diff --git a/recipes-xenomai/xenomai/xenomai_3.3.bb b/recipes-xenomai/xenomai/xenomai_3.3.2.bb
similarity index 90%
rename from recipes-xenomai/xenomai/xenomai_3.3.bb
rename to recipes-xenomai/xenomai/xenomai_3.3.2.bb
index 5ccd8e2..65e38b8 100644
--- a/recipes-xenomai/xenomai/xenomai_3.3.bb
+++ b/recipes-xenomai/xenomai/xenomai_3.3.2.bb
@@ -14,4 +14,4 @@ require xenomai.inc
 # Note: When updating PV, also update conf/distro/include/xenomai-version.inc!
 
 SRC_URI = " \
-    git://gitlab.com/Xenomai/xenomai3/xenomai.git;protocol=https;branch=master;tag=v${PV}"
+    git://gitlab.com/Xenomai/xenomai3/xenomai.git;protocol=https;branch=stable/v3.3.x;tag=v${PV}"
-- 
2.51.0

