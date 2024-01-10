Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D268579F2
	for <xenomai@lists.linux.dev>; Wed, 10 Jan 2024 04:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="UvuEoYq9"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240110044604b02839beee34b58bf3
        for <xenomai@lists.linux.dev>;
        Wed, 10 Jan 2024 05:46:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=Zqk4yCLEQ7NAqQID97q0CwEad1y4pAhjCXz4trzNwkk=;
 b=UvuEoYq90VzMIO0lQ2LnpctqREtIN2u8EfDXbZj4S5LTGsOS5cQuiSnTvqd3usZv3tUDO1
 Lnjwpqofpl/4DfDEpiMw7mRdsgi09NdAcXxou5cq2LzCKCyRSM6iscNpfV11z/cx28UlmXCB
 fAIp3GFXl/cXcrkpZKSUGwSWt3u7c=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH v3 08/10] kconfig: Add build options for evl
Date: Wed, 10 Jan 2024 05:46:00 +0100
Message-Id: <302bdf8c12a05a1a41bb866ae7833633f9251f73.1704861962.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1704861962.git.jan.kiszka@siemens.com>
References: <cover.1704861962.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Clara Kowalsky <clara.kowalsky@siemens.com>

Options are included to build the linux-evl kernel v6.1 and v6.6.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
[Jan: adjusted to renamed options, more kernel options, less libevl]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/Kconfig b/Kconfig
index 0f4855c..669ea65 100644
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
+config XENOMAI4
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
@@ -193,3 +207,55 @@ config COMPAT
 config KAS_INCLUDE_COMPAT
 	string
 	default "opt-compat.yml" if COMPAT
+
+endif	# if XENOMAI3
+
+if XENOMAI4
+
+choice
+	prompt "Kernel version"
+	default EVL_KERNEL_6_6
+
+config EVL_KERNEL_LATEST
+	bool "Head of latest EVL branch"
+
+config EVL_KERNEL_6_6_LATEST
+	bool "Head of 6.6 EVL branch"
+
+config EVL_KERNEL_6_6
+	bool "Latest 6.6 EVL release"
+
+config EVL_KERNEL_6_1_LATEST
+	bool "Head of 6.1 EVL branch"
+
+config EVL_KERNEL_6_1
+	bool "Latest 6.1 EVL release"
+
+endchoice
+
+config KAS_INCLUDE_EVL_KERNEL
+	string
+	default "opt-linux-latest.yml" if EVL_KERNEL_LATEST
+	default "opt-linux-latest-6.6.yml" if EVL_KERNEL_6_6_LATEST
+	default "opt-linux-6.6.yml" if EVL_KERNEL_6_6
+	default "opt-linux-latest-6.1.yml" if EVL_KERNEL_6_1_LATEST
+	default "opt-linux-6.1.yml" if EVL_KERNEL_6_1
+
+choice
+	prompt "libevl version"
+	default LIBEVL_NEXT
+
+config LIBEVL_NEXT
+	bool "Head of next branch"
+
+config LIBEVL_RELEASE
+	bool "Latest release"
+
+endchoice
+
+config KAS_INCLUDE_LIBEVL
+	string
+	default "opt-libevl-next.yml" if LIBEVL_NEXT
+	default "opt-libevl-latest-release.yml" if LIBEVL_RELEASE
+
+endif	# if XENOMAI4
-- 
2.35.3

