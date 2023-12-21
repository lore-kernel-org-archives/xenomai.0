Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA2555E4D
	for <xenomai@lists.linux.dev>; Thu, 21 Dec 2023 16:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="YkWRxnLM"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20231221163833d4224a65e2bef3f92f
        for <xenomai@lists.linux.dev>;
        Thu, 21 Dec 2023 17:38:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=SREjMuxd3+gGlf6GvG+YZEFlaSJUkQhHK4vMDsird9A=;
 b=YkWRxnLMhb0wFSxXnHfP8I31AItiIuKqfhol3S3w0dNXpOEfWvXd/+hi2mKLd66fIxDgTG
 rwCuYqFCRkAFzzL0tE5D5I+CTJdSbNvoRNSIZ9bJrjTvFy8DLurZDRPoZsaXthgKk68Xoz7i
 chBTbK5pOgiCeyHVaJDqn7M3KoT80=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev,
	rpm@xenomai.org
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [xenomai-images][PATCH v2 7/7] kconfig: Add build options for evl
Date: Thu, 21 Dec 2023 17:37:43 +0100
Message-Id: <20231221163743.2923801-8-clara.kowalsky@siemens.com>
In-Reply-To: <20231221163743.2923801-1-clara.kowalsky@siemens.com>
References: <20231221163743.2923801-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

Options are included to build the linux-evl kernel v6.1 and v6.6.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 Kconfig | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/Kconfig b/Kconfig
index 953634e..65a9c2f 100644
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
@@ -183,3 +197,51 @@ config COMPAT
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
+	default LINUX_XEN4_6_1_LATEST
+
+config LINUX_XEN4_6_1_LATEST
+	bool "Head of 6.1 Linux-evl branch"
+
+config LINUX_XEN4_6_6_LATEST
+	bool "Head of 6.6 Linux-evl branch"
+
+endchoice
+
+config KAS_INCLUDE_LINUX_XEN4
+	string
+	default "opt-xen4-linux-latest-6.1.yml" if LINUX_XEN4_6_1_LATEST
+	default "opt-xen4-linux-latest-6.6.yml" if LINUX_XEN4_6_6_LATEST
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
+config LIBEVL_STABLE
+	bool "Latest tag"
+
+config LIBEVL_R46
+	bool "Latest release"
+
+endchoice
+
+config KAS_INCLUDE_LIBEVL
+	string
+	default "opt-libevl-master.yml" if LIBEVL_MASTER
+	default "opt-libevl-next.yml" if LIBEVL_NEXT
+	default "opt-libevl-stable.yml" if LIBEVL_STABLE
+	default "opt-libevl-r46.yml" if LIBEVL_R46
+
+endif	# if XENOMAI4
-- 
2.39.2

