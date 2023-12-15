Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E4F2DB7C
	for <xenomai@lists.linux.dev>; Fri, 15 Dec 2023 11:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="gmmW5zzm"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202312151145010b43547026f8968526
        for <xenomai@lists.linux.dev>;
        Fri, 15 Dec 2023 12:45:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=+/lQ+aXbCurKIRryz8n9mR3BgmESgXkg+us2BIxHRK4=;
 b=gmmW5zzmb7os5ZlyHulL/OI7+/ODrthE+eX2pWNeb63oNF65k7DUzcP/1W/YhQWx3LqZpN
 WUvJSVzuAQICo4MxlpLQELdN9gRb7OHmhDdO/5vnkYVvnShQ9yjhfszA5EBa97RMnDesi+dV
 FnB1aP1qPCYIy0FuTtVQLzdXJmV7I=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev,
	rpm@xenomai.org
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [xenomai-images][PATCH v1 5/5] kconfig: Add build options for evl
Date: Fri, 15 Dec 2023 12:43:49 +0100
Message-Id: <20231215114349.2913803-6-clara.kowalsky@siemens.com>
In-Reply-To: <20231215114349.2913803-1-clara.kowalsky@siemens.com>
References: <20231215114349.2913803-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

Options are included to build the linux-evl kernel v6.1 and v6.6
together with the libevl branches master and next.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 Kconfig | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/Kconfig b/Kconfig
index 953634e..dea7d4d 100644
--- a/Kconfig
+++ b/Kconfig
@@ -58,6 +58,20 @@ config KAS_INCLUDE_TARGET
 
 choice
 	prompt "Xenomai version"
+	default XENOMAI3
+
+config XENOMAI3
+	bool "Xenomai 3"
+
+config EVL
+	bool "Xenomai 4 / EVL"
+
+endchoice
+
+if XENOMAI3
+
+choice
+	prompt "Xenomai 3 subversion"
 	default XENOMAI_3_2
 
 config XENOMAI_LATEST
@@ -183,3 +197,43 @@ config COMPAT
 config KAS_INCLUDE_COMPAT
 	string
 	default "opt-compat.yml" if COMPAT
+
+endif	# if XENOMAI3
+
+if EVL
+
+choice
+	prompt "Linux-evl kernel version"
+	default LINUXEVL_6_1_LATEST
+
+config LINUXEVL_6_1_LATEST
+	bool "Head of 6.1 Linux-evl branch"
+
+config LINUXEVL_6_6_LATEST
+	bool "Head of 6.6 Linux-evl branch"
+
+endchoice
+
+config KAS_INCLUDE_LINUXEVL
+	string
+	default "opt-linuxevl-latest-6.1.yml" if LINUXEVL_6_1_LATEST
+	default "opt-linuxevl-latest-6.6.yml" if LINUXEVL_6_6_LATEST
+
+choice
+	prompt "Libevl version"
+	default LIBEVL_MASTER
+
+config LIBEVL_MASTER
+	bool "Head of master branch"
+
+config LIBEVL_NEXT
+	bool "Head of next branch"
+
+endchoice
+
+config KAS_INCLUDE_LIBEVL
+	string
+	default "opt-libevl-master.yml" if LIBEVL_MASTER
+	default "opt-libevl-next.yml" if LIBEVL_NEXT
+
+endif	# if EVL
-- 
2.39.2

