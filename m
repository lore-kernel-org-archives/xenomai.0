Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3274313D58
	for <xenomai@lists.linux.dev>; Thu, 18 Sep 2025 15:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210978; cv=none; b=YpViUmwjj0jOp+8hRBedhXmSq9cNMdefnKhi3FPTmHfvDDLYCZwab3/RhUF0SFBiiaM+N0gEWRc/vwPHFZfnVvIuCPPgrmTqFiO4MZCLCrrtdauMR/Pr1lHprOzHFRTlsvtIqW65O4cR2SUah9jG2v6dESccmAalrSjHEHetWCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210978; c=relaxed/simple;
	bh=wK5Aushq2Lrdr5C57oa2ydF5kcAQmqSctRHw5kSfuIk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9Bg6dIaJLkCvoLPqZGNF3zKIVWshzcOlS3zZluQgFymuAbu0SgeBznEmU5qIOaCboQv3GlmU9XVLauustW8FZaIa4twFpatkKHUb6fHbPv9sgsxLOKcLqTGcdKYVfDY+hqrXOvlD/EbtZ47J8vZeQRoORs6+xX4GWvm1eSSas0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=OrNDP218; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="OrNDP218"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2025091815561477d1c758040002070c
        for <xenomai@lists.linux.dev>;
        Thu, 18 Sep 2025 17:56:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=TXrdjbK+oO8GOMobKEqdn6v5dn0d5fa3rLwM262u620=;
 b=OrNDP218Br/mBzB4LbFUFJb0gnDnLRE0ZvKaFD3zNFEI8/02GfGqA6psVgFRP9Z5j+hZRv
 DDFv3C6U9redEJb9AJy0ns/4JBmj49bqbx5cQzXiXhcfkElCw4LqZZnB4wlI2aBuliG49V26
 3mbpkSiE4ea1AAfbCNro6UCGs8S1DMwBEP5JZcViYnxsNFxGuWL9Ov/ggmZcZgRDIpMHhhYj
 nJz51AGMg2phYmq8VWKU1qYnhaJ0qHpnuEe28+Jzlb3d2egDCzFNq0wEqlz5OEcFbK8ZvxWN
 /Ufuz5morFpDJm6cl+6sMIIKjwlvRz8bKSDeOSnY1EgG0WNJWdB82a0w==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 09/13] Add missing options and menu entries for stable 3.x releases
Date: Thu, 18 Sep 2025 17:55:51 +0200
Message-ID: <0081c121e99c7b8ce9ee7a439b075f44d32dcea2.1758210955.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1758210955.git.jan.kiszka@siemens.com>
References: <cover.1758210955.git.jan.kiszka@siemens.com>
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

We already had the menu entry for "latest 3.2.x release", but that was
no longer working since the introduction of 3.3. Furthermore, we were
missing this for 3.1.x. Fix both.

Also add an option file for the latest 3.3.x release even if that is
currently the default, just for consistency and to avoid future issues.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig               |  8 +++++++-
 opt-xenomai-3.1.x.yml | 20 ++++++++++++++++++++
 opt-xenomai-3.2.x.yml | 20 ++++++++++++++++++++
 opt-xenomai-3.3.x.yml | 20 ++++++++++++++++++++
 4 files changed, 67 insertions(+), 1 deletion(-)
 create mode 100644 opt-xenomai-3.1.x.yml
 create mode 100644 opt-xenomai-3.2.x.yml
 create mode 100644 opt-xenomai-3.3.x.yml

diff --git a/Kconfig b/Kconfig
index a155c45..8846b1c 100644
--- a/Kconfig
+++ b/Kconfig
@@ -98,14 +98,20 @@ config XENOMAI_3_1_HEAD
 	bool "Head of stable/v3.1.x branch"
 	depends on !TARGET_RPI4
 
+config XENOMAI_3_1
+	bool "Latest 3.1.x release"
+
 endchoice
 
 config KAS_INCLUDE_XENOMAI
 	string
 	default "opt-xenomai-next.yml" if XENOMAI_HEAD
 	default "opt-xenomai-3.3.x-head.yml" if XENOMAI_3_3_HEAD
+	default "opt-xenomai-3.3.x.yml" if XENOMAI_3_3
 	default "opt-xenomai-3.2.x-head.yml" if XENOMAI_3_2_HEAD
-	default "opt-xenomai-3.1.x.head.yml" if XENOMAI_3_1_HEAD
+	default "opt-xenomai-3.2.x.yml" if XENOMAI_3_2
+	default "opt-xenomai-3.1.x-head.yml" if XENOMAI_3_1_HEAD
+	default "opt-xenomai-3.1.x.yml" if XENOMAI_3_1
 
 choice
 	prompt "Kernel version"
diff --git a/opt-xenomai-3.1.x.yml b/opt-xenomai-3.1.x.yml
new file mode 100644
index 0000000..8a7f593
--- /dev/null
+++ b/opt-xenomai-3.1.x.yml
@@ -0,0 +1,20 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2025
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 14
+
+local_conf_header:
+  debian-release: |
+    DEBIAN_RELEASE = "bookworm"
+  xenomai-version: |
+    PREFERRED_VERSION_xenomai = "3.1%"
+    PREFERRED_VERSION_xenomai-compat = "3.1%"
diff --git a/opt-xenomai-3.2.x.yml b/opt-xenomai-3.2.x.yml
new file mode 100644
index 0000000..56c29f7
--- /dev/null
+++ b/opt-xenomai-3.2.x.yml
@@ -0,0 +1,20 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2025
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 14
+
+local_conf_header:
+  debian-release: |
+    DEBIAN_RELEASE = "bookworm"
+  xenomai-version: |
+    PREFERRED_VERSION_xenomai = "3.2%"
+    PREFERRED_VERSION_xenomai-compat = "3.2%"
diff --git a/opt-xenomai-3.3.x.yml b/opt-xenomai-3.3.x.yml
new file mode 100644
index 0000000..a33a3f9
--- /dev/null
+++ b/opt-xenomai-3.3.x.yml
@@ -0,0 +1,20 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2025
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 14
+
+local_conf_header:
+  debian-release: |
+    DEBIAN_RELEASE = "bookworm"
+  xenomai-version: |
+    PREFERRED_VERSION_xenomai = "3.3%"
+    PREFERRED_VERSION_xenomai-compat = "3.3%"
-- 
2.51.0

