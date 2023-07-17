Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF44883A
	for <xenomai@lists.linux.dev>; Mon, 17 Jul 2023 12:53:17 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20230717125315ba9e99e634f7dbfc93
        for <xenomai@lists.linux.dev>;
        Mon, 17 Jul 2023 14:53:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=Vu1dZS5WrX1j9p4KA6QHTCDzvku5n5/z7BLN16RIU64=;
 b=kgI5/LgNkUe9EdyNuVgf8M9Oju6fQAp8j2HPhIEIDyV6RvH+cvxyG7IUYg9ICgpCRjAJ5T
 vKo/KXWQ4dJZtM6NIBLE3Y/BsOEf+pWsBe9ByGnoBOMolVNAXwRUn/aWSqYo8LNjhJlo8MAA
 RX0CLA17ikDBFBtdLPqTCwCNulP8A=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [xenomai-images][PATCH] xenomai: Update xenomai 3.2 branch to stable
Date: Mon, 17 Jul 2023 14:53:09 +0200
Message-Id: <20230717125309.1423429-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

Stable tags like 3.2.2 cannot be found in the master branch. 

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 recipes-xenomai/xenomai/xenomai_3.2.2.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-xenomai/xenomai/xenomai_3.2.2.bb b/recipes-xenomai/xenomai/xenomai_3.2.2.bb
index e99d7fe..f32cd06 100644
--- a/recipes-xenomai/xenomai/xenomai_3.2.2.bb
+++ b/recipes-xenomai/xenomai/xenomai_3.2.2.bb
@@ -14,6 +14,6 @@ require xenomai.inc
 # Note: When updating PV, also update conf/distro/include/xenomai-version.inc!
 
 SRC_URI = " \
-    git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=master;tag=v${PV}"
+    git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=stable/v3.2.x;tag=v${PV}"
 
 S = "${WORKDIR}/git"
-- 
2.39.2

