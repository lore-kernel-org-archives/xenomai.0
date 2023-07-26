Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80754AD4F
	for <xenomai@lists.linux.dev>; Wed, 26 Jul 2023 09:13:52 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20230726091343b0ad79a91b3ef447a6
        for <xenomai@lists.linux.dev>;
        Wed, 26 Jul 2023 11:13:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=ohvEG8659vB3LuspDqg88z//ahrlv9BtGBU+SpeeiPw=;
 b=Awt0xP5qL9zXMPJ/0dM+qED4Tkc8qgQ5OcUQV42p7pALDt/4abmFCuQnpf2PTsy/rlcoIN
 ao2LXVYPEUSYdAjprt2gmaHXkqnFA6M2vxxjtLoBaJ/Q8YOTL7lXVKF41gqVMHmSKwjaq2ag
 b8fsefpIk8+5NFZJRjNpwa5Xh5qg4=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [xenomai-images][PATCH] xenomai: Update to latest releases
Date: Wed, 26 Jul 2023 11:13:32 +0200
Message-Id: <20230726091332.182910-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 conf/distro/include/xenomai-version.inc                     | 6 +++---
 .../xenomai/{xenomai_3.0.13.bb => xenomai_3.0.14.bb}        | 0
 .../xenomai/{xenomai_3.1.3.bb => xenomai_3.1.4.bb}          | 0
 .../xenomai/{xenomai_3.2.2.bb => xenomai_3.2.3.bb}          | 0
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename recipes-xenomai/xenomai/{xenomai_3.0.13.bb => xenomai_3.0.14.bb} (100%)
 rename recipes-xenomai/xenomai/{xenomai_3.1.3.bb => xenomai_3.1.4.bb} (100%)
 rename recipes-xenomai/xenomai/{xenomai_3.2.2.bb => xenomai_3.2.3.bb} (100%)

diff --git a/conf/distro/include/xenomai-version.inc b/conf/distro/include/xenomai-version.inc
index 61e86f7..a8d40ed 100644
--- a/conf/distro/include/xenomai-version.inc
+++ b/conf/distro/include/xenomai-version.inc
@@ -11,13 +11,13 @@
 
 XENOMAI_DEFAULT_KERNEL_VERSION = "5.15%"
 
-XENOMAI_3_0_VERSION_LIST = "3.0 3.0% 3.0.% 3.0.13 stable-3.0.x"
+XENOMAI_3_0_VERSION_LIST = "3.0 3.0% 3.0.% 3.0.14 stable-3.0.x"
 XENOMAI_3_0_KERNEL_VERSION = "4.4%"
 
-XENOMAI_3_1_VERSION_LIST = "3.1 3.1% 3.1.% 3.1.3 stable-3.1.x"
+XENOMAI_3_1_VERSION_LIST = "3.1 3.1% 3.1.% 3.1.4 stable-3.1.x"
 XENOMAI_3_1_KERNEL_VERSION = "5.4%"
 
-XENOMAI_3_2_VERSION_LIST = "3.2 3.2% 3.2.% 3.2.2 stable-3.2.x"
+XENOMAI_3_2_VERSION_LIST = "3.2 3.2% 3.2.% 3.2.3 stable-3.2.x"
 XENOMAI_3_2_KERNEL_VERSION = "5.10%"
 
 # If PREFERRED_VERSION_xenomai contains any item from XENOMAI_3_0_VERSION_LIST use
diff --git a/recipes-xenomai/xenomai/xenomai_3.0.13.bb b/recipes-xenomai/xenomai/xenomai_3.0.14.bb
similarity index 100%
rename from recipes-xenomai/xenomai/xenomai_3.0.13.bb
rename to recipes-xenomai/xenomai/xenomai_3.0.14.bb
diff --git a/recipes-xenomai/xenomai/xenomai_3.1.3.bb b/recipes-xenomai/xenomai/xenomai_3.1.4.bb
similarity index 100%
rename from recipes-xenomai/xenomai/xenomai_3.1.3.bb
rename to recipes-xenomai/xenomai/xenomai_3.1.4.bb
diff --git a/recipes-xenomai/xenomai/xenomai_3.2.2.bb b/recipes-xenomai/xenomai/xenomai_3.2.3.bb
similarity index 100%
rename from recipes-xenomai/xenomai/xenomai_3.2.2.bb
rename to recipes-xenomai/xenomai/xenomai_3.2.3.bb
-- 
2.39.2

