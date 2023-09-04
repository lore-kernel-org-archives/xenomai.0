Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBCE79D5
	for <xenomai@lists.linux.dev>; Mon,  4 Sep 2023 13:05:15 +0000 (UTC)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202309041305103c94fcbebcca1779d9
        for <xenomai@lists.linux.dev>;
        Mon, 04 Sep 2023 15:05:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=iUlQp0UlBoEMqD1S/li7XHaqMn9UjQ7fkWsEG1BWagY=;
 b=GT2WUl7yQ0X88JWY8w6gVYa2rFUSyKYUFUfW9/SbAyerny/ztI9rOohpU2N7Ssn4AJE+JF
 Zm80pz14FzvE6Idy8AwmvjVKhQXxT6Hu9EKsuRNMTLfeSVQiWlsAOmCGJ5ACR+ATHDBBSGxc
 k6AMvWuW9YfundQTzNUHg2jCAk00w=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH][xenomai-images] ci: Add kernel 6.1 tests to xenomai stable 3.2.x branch
Date: Mon,  4 Sep 2023 15:04:04 +0200
Message-Id: <20230904130404.3838872-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---

Hi all,

once 6.1 is supported by the Xenomai stable 3.2.x series we should
enable CI tests accordingly.

Related to 
https://lore.kernel.org/xenomai/20230828-florian-enable-stable-3-2-for-6-1-v2-0-5189cfb05a62@siemens.com/T/#t

Best regards,
Florian

 ci/xenomai_3_2_x.yml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ci/xenomai_3_2_x.yml b/ci/xenomai_3_2_x.yml
index 781eec8..a0e777c 100644
--- a/ci/xenomai_3_2_x.yml
+++ b/ci/xenomai_3_2_x.yml
@@ -15,9 +15,10 @@ include:
   - local: '/ci/kernel_5_4.yml'
   - local: '/ci/kernel_5_10.yml'
   - local: '/ci/kernel_5_15.yml'
+  - local: '/ci/kernel_6_1.yml'
   - local: '/ci/xenomai_3_2_x_compat.yml'
 
 variables:
   XENOMAI_BUILD_OPTION: ":opt-xenomai-3.2.x.yml"
   XENOMAI_VERSION: "3.2.x"
-  LATEST_KERNEL_VERSION: "5.15"
+  LATEST_KERNEL_VERSION: "6.1"
-- 
2.39.2

