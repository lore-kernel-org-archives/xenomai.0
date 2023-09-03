Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA27567D
	for <xenomai@lists.linux.dev>; Sun,  3 Sep 2023 15:05:11 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2023090315050116f13531b7bde4ff42
        for <xenomai@lists.linux.dev>;
        Sun, 03 Sep 2023 17:05:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=MnEqSlUdmeT2COH3Fz0STziT366tTbmpSs9c3PqNrRw=;
 b=AX2+GZo7nxqDrcPtVgwBxTIQLqtM5msSYjkL6ZSpPBdej5rqZ+syj82tzbVd98aT16NHvn
 iMgNNJz7uYmXij9pOYj5o5YRB6kjjtbd6Z32EwtM9PqYe0zt5aCNft3Pm6wcflRc+e43ocK3
 JRifK7LG/EPBFBfdJ4mDbuyspqpWo=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 17/20] scripts/Kconfig.frag: Switch to I-pipe only
Date: Sun,  3 Sep 2023 17:04:54 +0200
Message-Id: <da4bec53d14a791516e7ef5104bb5e2dbaef7391.1693753497.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1693753497.git.jan.kiszka@siemens.com>
References: <cover.1693753497.git.jan.kiszka@siemens.com>
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
 scripts/Kconfig.frag | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/scripts/Kconfig.frag b/scripts/Kconfig.frag
index 7921286638..b76d25e535 100644
--- a/scripts/Kconfig.frag
+++ b/scripts/Kconfig.frag
@@ -1,10 +1,8 @@
 menuconfig XENOMAI
 	depends on X86_TSC || !X86
 	bool "Xenomai/cobalt"
-	select IPIPE if HAVE_IPIPE_SUPPORT
-	select IPIPE_WANT_APIREV_2 if IPIPE
-	select DOVETAIL if HAVE_DOVETAIL
-	select DOVETAIL_LEGACY_SYSCALL_RANGE if HAVE_DOVETAIL
+	select DOVETAIL
+	select DOVETAIL_LEGACY_SYSCALL_RANGE
 	default y
 	help
 	  Xenomai's Cobalt core is a real-time extension to the Linux
-- 
2.35.3

