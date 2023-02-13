Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905EF1FB3
	for <xenomai@lists.linux.dev>; Mon, 13 Feb 2023 07:11:29 +0000 (UTC)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202302130701196394274e7b67ac65d6
        for <xenomai@lists.linux.dev>;
        Mon, 13 Feb 2023 08:01:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=PqrZpRt/YFT1xhS1Omm1Xsgu6833fY4Nm3ecc+u0CkA=;
 b=NzhRh78T5IYCFDoRugW5gXe2TjeoEAqcT0Qt9NV52ZL142yCJ2g5JsrG7Yjf9AsNUWzPH8
 hmjEFGWldPtBuAxW8QTpkM7GfBSX8LT5tZ6y/X6/hRbhOvQy3i43UHrQ9GkYtR2HWNHCQcC2
 fHcDuthzX6OaK3i4fNa6USEbGWcmQ=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 6/7] ci: Add kernel 5.15 to Xenomai 3.2 pipeline
Date: Mon, 13 Feb 2023 08:01:15 +0100
Message-Id: <d1686b3bddb7b8e51339d48c44ea6db6df8a7d1a.1676271676.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1676271676.git.jan.kiszka@siemens.com>
References: <cover.1676271676.git.jan.kiszka@siemens.com>
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

Now supported.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ci/xenomai_3_2_x.yml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ci/xenomai_3_2_x.yml b/ci/xenomai_3_2_x.yml
index 7ca77a3..3a1d5e3 100644
--- a/ci/xenomai_3_2_x.yml
+++ b/ci/xenomai_3_2_x.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019 - 2022
+# Copyright (c) Siemens AG, 2019 - 2023
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -14,6 +14,7 @@ include:
   - local: '/ci/kernel_4_19.yml'
   - local: '/ci/kernel_5_4.yml'
   - local: '/ci/kernel_5_10.yml'
+  - local: '/ci/kernel_5_15.yml'
 
 variables:
   XENOMAI_BUILD_OPTION: ":opt-xenomai-3.2.x.yml"
-- 
2.35.3

