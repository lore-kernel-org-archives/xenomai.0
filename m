Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2B95690
	for <xenomai@lists.linux.dev>; Thu,  5 Oct 2023 08:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="oJ3Mku9y"
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202310050850045fa4b4f64829bf87ca
        for <xenomai@lists.linux.dev>;
        Thu, 05 Oct 2023 10:50:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=okxqvqeSVZyoo+gE0BS+VzvE3WfTLh5AEF94ZbHNJzc=;
 b=oJ3Mku9yUoapNunxo3bOLwn8Fwk4mbiJU1LyhW5NaMn9K4ekLiTkU6xmC2NGRVKRAHike9
 S7mcYz9HCPPjlp0J/ikgohAawJm4cummwVKoMDxGqOEVlnIYOmtfDndIBbUFvWkDXI+hyM2P
 NgjWFCGDPVrQTk7xEbJzn1DZ/03Fc=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 05 Oct 2023 10:50:03 +0200
Subject: [PATCH 1/2] ci: Switch to Debian bookworm
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231005-flo-ci-to-bookworm-v1-1-c0455488879a@siemens.com>
References: <20231005-flo-ci-to-bookworm-v1-0-c0455488879a@siemens.com>
In-Reply-To: <20231005-flo-ci-to-bookworm-v1-0-c0455488879a@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Updating to bookworm will bring in a newer versions of the compiler
(gcc 12.2) and newer glibc (2.36).

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 .gitlab-ci.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index e2281c9e1..cc7e0b0ea 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -13,7 +13,7 @@ stages:
   - test
 
 default:
-  image: debian:bullseye
+  image: debian:bookworm
 
 variables:
   GIT_STRATEGY: clone

-- 
2.39.2

