Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B391A57
	for <xenomai@lists.linux.dev>; Wed,  4 Jan 2023 11:47:34 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20230104113718eb68db1f9287081696
        for <xenomai@lists.linux.dev>;
        Wed, 04 Jan 2023 12:37:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=MuFCtsjK/Ufs8yq7yDGH6s7JlJz8rxuJGF2X+E3KYRk=;
 b=NvEmW5/u98ERPPblxEwK6NzKr0qSoQd6j9kp0RX1hhSr5nUYwfeGe2nP9k6z5SZb+I5hMe
 tBc9ZkwO3F5cqJuVpClr8ekx7/wZYwiHle6bJAkeiUTwzOGFW1n52xSrf5rhfr3i1Mo5DzLr
 xIX3GdTS2lORyszTNo61jaliNnYSc=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [xenomai-images][PATCH 2/2] ci: Update documentation for build environment specific settings
Date: Wed,  4 Jan 2023 12:37:15 +0100
Message-Id: <20230104113715.2872917-3-florian.bezdeka@siemens.com>
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

Document some variables that might be of interest for tuning the CI
setup for different gitlab instances/ci runners.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 tests/README.md | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/README.md b/tests/README.md
index 0767192..50942df 100644
--- a/tests/README.md
+++ b/tests/README.md
@@ -102,6 +102,10 @@ The following variables are used and set by the ci system:
   - `FTP_PROXY`     : ftp proxy
   - `NO_PROXY`      : no proxy
 
+- Build environment specific settings:
+  - `ALT_DNS_SERVER`: optional, can be set to something like "8.8.8.8" to use a specific DNS server
+  - `DISTRO_APT_PREMIRRORS`: optional, can be set to something like "deb\.debian\.org cdn-aws.deb.debian.org\n" to use a specific Debian mirror
+
 - LAVA settings:
   - `LAVA_MASTER_ACCOUNT`: lava master account name to register lavacli for test execution
   - `LAVA_MASTER_TOKEN`: token to connect with the lava master
-- 
2.39.0

