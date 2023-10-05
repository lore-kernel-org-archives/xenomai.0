Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BE615C5
	for <xenomai@lists.linux.dev>; Thu,  5 Oct 2023 09:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="dHmObyt7"
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2023100508500501661c18abdfdb0ef7
        for <xenomai@lists.linux.dev>;
        Thu, 05 Oct 2023 10:50:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=J9M7VipjajkTKpFhPa4kH6RURaR2ztdy7ElrE+AQSqY=;
 b=dHmObyt7V/f5y2vLPpXPyXx3CNLmKvE8Z2GN2D2R07eP9h3fUBGOFiviBXHasiK37HcKsL
 QBWy/Sw9ucDkkQmoHsRamq+NMj5GJU+YavTdywPJM7DHUbDhuVwj9dhLCs+wIKWs4ZxyVxiJ
 G309aOTd3qC4p0eCZLqTsdygZhcv0=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 05 Oct 2023 10:50:04 +0200
Subject: [PATCH 2/2] ci: Add build test for older glibc where y2038 support
 is not available
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231005-flo-ci-to-bookworm-v1-2-c0455488879a@siemens.com>
References: <20231005-flo-ci-to-bookworm-v1-0-c0455488879a@siemens.com>
In-Reply-To: <20231005-flo-ci-to-bookworm-v1-0-c0455488879a@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

With updating the CI builds from Debian bullseye to bookworm we get
a newer glibc version that provides y2038 support. To still cover
building against older libc versions we need an additional build job.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 .gitlab-ci.yml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index cc7e0b0ea..f8f6d47ec 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -257,6 +257,10 @@ i386-userland:
     - make -j $(nproc)
     - ccache -s
 
+i386-userland-y2038-unavailable:
+  extends: i386-userland
+  image: debian:bullseye
+
 trigger-xenomai-images:
   stage: test
   variables:

-- 
2.39.2

