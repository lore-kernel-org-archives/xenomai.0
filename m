Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AAC810
	for <xenomai@lists.linux.dev>; Wed,  4 Jan 2023 11:47:34 +0000 (UTC)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20230104113718d10a9991e46d809662
        for <xenomai@lists.linux.dev>;
        Wed, 04 Jan 2023 12:37:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=BDuyV0x2EjzEzQUrnKu0+7yVj7sgzAg205j3YFOXXYY=;
 b=fDeaShkMHj2XzaxZD+jKFcu4wl77bTr6lA3KQfMCHI4twevoAQaB2MvJpuJY7dhllVcZUf
 p63WrU+OaMOkW+fb0YIxziBw+uYNFABvfDRFdDoZ+DcZE2xRp4wyERd+lWUBm+7ItQAbcfyl
 jdbHYlxqB7mDMJaXv63n+gQcC5vvE=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [xenomai-images][PATCH 1/2] ci: Variables block cleanup
Date: Wed,  4 Jan 2023 12:37:14 +0100
Message-Id: <20230104113715.2872917-2-florian.bezdeka@siemens.com>
In-Reply-To: <20230104113715.2872917-1-florian.bezdeka@siemens.com>
References: <20230104113715.2872917-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Variables set in the gitlab UI are available as environment variables
inside the build container, so no need to re-assign them in the
variables block.

Especially when DISTRO_APT_PREMIRRORS was not set at gitlab UI level,
the variable got "$DISTRO_APT_PREMIRRORS" as value. That broke builds
on our internal CI where we do not need/set this variable.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 ci/gitlab-ci-base.yml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index b85eecb..ee71ea3 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -18,12 +18,10 @@ variables:
   https_proxy: "$HTTPS_PROXY"
   ftp_proxy: "$FTP_PROXY"
   no_proxy: "$NO_PROXY"
-  DISTRO_APT_PREMIRRORS: "$DISTRO_APT_PREMIRRORS"
   ISAR_IMAGE: demo-image
   ISAR_DISTRIBUTION: xenomai-demo
   LAVA_TESTS_ENABLED: "true"
   BUILD_IDENTIFIER: "xenomai-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
-  ALT_DNS_SERVER: ""
 
 default:
   image: ghcr.io/siemens/kas/kas-isar:3.1
-- 
2.39.0

