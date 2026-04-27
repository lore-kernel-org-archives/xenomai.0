Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9298932BF5C
	for <xenomai@lists.linux.dev>; Mon, 27 Apr 2026 15:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302802; cv=none; b=Tm+GJEOdww1ygks7sYEMmQw1bWSkNkBwlk9inYueYIGLHSpLpwe/fbXUNIxvfwFjU45uos2YV1HJymSLJs0xaZEMim6R7sBhV6XX9GlWyOUW3n/Hvm+hsneqpDLWsPTifIOzbxTxxVP9Uax3x3WI463MfoWnmRQGBNlXm9k7b7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302802; c=relaxed/simple;
	bh=O7ZvHjWT3NSzhOaHZ2aClCX585EedvU/UUzLtdepf3g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=f+arlllxwRW83OJJyw4e+TCuM21fZQ/cwFLkblwa8o9JURaue0n0eajZpvB9JSpBChCPS4Jrq7/kDDTV9TheCCV+AoHeeJA2lDu5NFDvoELHsPwMX/eRMt3K2s6mj4UV40TCT2esGdLw0482j+pdFGjYjNUcmk28vbdxn0IWUPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=PknNCKBz; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="PknNCKBz"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2026042715131513a7094881000207ee
        for <xenomai@lists.linux.dev>;
        Mon, 27 Apr 2026 17:13:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=DyXqluS3oCz6pjFezZsae8ZO9ewpSotlISXS/N/JWK8=;
 b=PknNCKBzVSt9Gxv/jUL2HPT8r5y/jLcUsgkt0tZkIEOOt8xtez0Lw2Apa/BbKFOGuAKCvF
 /iMb5eJfTQ0gXmV0dmsYf8psSNjioPvPCgJYkefAjzdwiWHztitV/CGYdLUrnU8G7zXeR7Ye
 ldchcNQr/U9BA43g15qUOrvaFocMvVmjmi56ttuwz1zWzEtZiE8vck8bdOU5O3Oha1F1pDPt
 Z5XaGVcNZgh6goPkRvk7bgQwPsCo/8Aa5mk3AMT523qeDhsweUbETY8QR4XgfK3pnMtIi8em
 bU39ixBkekTGgSkN2fdtuZDkPXFS9J+YJTpvSehZhmcV66TIKOwiLC1A==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 27 Apr 2026 17:13:14 +0200
Subject: [PATCH] Update the e-mail address of the Xenomai mailing list
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-wip-flo-update-ml-addr-v1-1-624b1c285126@siemens.com>
X-B4-Tracking: v=1; b=H4sIAAl972kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEyNz3fLMAt20nHzd0oKUxJJU3dwc3cSUlCJdY7PkNCMDU0uLFAMzJaD
 mgqLUtMwKsMHRsbW1APldcq5oAAAA
X-Change-ID: 20260427-wip-flo-update-ml-addr-36cf20598d06
To: xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

We have two working mail addresses for the Xenomai mailing list:

  - Historical: xenomai@xenomai.org, still working and forwarding
                mails to
  - Current:    xenomai@lists.linux.dev

The historical address is still working, yes, but we're not sure if
the forwarding is properly working in all cases. linux.dev has strict
anti-spam rules, SPF and friends. Moving to the lists.linux.dev
address should provide better reliability.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Cc: Jan Kiszka <jan.kiszka@siemens.com>
---
 configure.ac                             | 2 +-
 debian/control                           | 2 +-
 demo/alchemy/altency.c                   | 2 +-
 doc/asciidoc/TROUBLESHOOTING.COBALT.adoc | 2 +-
 doc/asciidoc/man1/xeno-config.adoc       | 2 +-
 include/rtdm/serial.h                    | 2 +-
 include/rtdm/testing.h                   | 2 +-
 kernel/drivers/can/README                | 2 +-
 lib/psos/README                          | 2 +-
 lib/vxworks/README                       | 2 +-
 testsuite/latency/latency.c              | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/configure.ac b/configure.ac
index a9da072877658382cdd54a5ecb42cff4c5d0e018..22823756dfe907c3b0df4dd8f6cef88d22854088 100644
--- a/configure.ac
+++ b/configure.ac
@@ -7,7 +7,7 @@ AC_PREREQ([2.69])
 # implement (which actually expresses the revision level of the
 # Copperplate library).  The kernel ABI is Cobalt-specific and is
 # defined for each architecture in the asm/features.h file.
-AC_INIT([Xenomai],[m4_normalize(m4_include([config/version-label]))],[xenomai@xenomai.org])
+AC_INIT([Xenomai],[m4_normalize(m4_include([config/version-label]))],[xenomai@lists.linux.dev])
 
 AC_CONFIG_HEADERS(include/xeno_config.h)
 AC_CONFIG_AUX_DIR(config)
diff --git a/debian/control b/debian/control
index 9855de1982008ce4b7707cb60f16504a25a67940..fb54392e206ef39742a321b2b3970ca4573e902d 100644
--- a/debian/control
+++ b/debian/control
@@ -1,7 +1,7 @@
 Source: xenomai
 Section: devel
 Priority: extra
-Maintainer: Xenomai <xenomai@xenomai.org>
+Maintainer: Xenomai <xenomai@lists.linux.dev>
 Build-Depends: debhelper (>= 8), findutils (>= 4.2.28), autotools-dev, autoconf, automake, libtool, pkg-config, libltdl-dev
 Standards-Version: 3.9.3
 Homepage: http://www.xenomai.org/
diff --git a/demo/alchemy/altency.c b/demo/alchemy/altency.c
index 072d68f8e86bfe66d407b42bd450e8045707932d..43ce8ea4a890ef0446dde1a02e9208af00d7fe6a 100644
--- a/demo/alchemy/altency.c
+++ b/demo/alchemy/altency.c
@@ -423,7 +423,7 @@ static void cleanup(void)
 	if (max_relaxed > 0)
 		printf(
 "Warning! some latency peaks may have been due to involuntary mode switches.\n"
-"Please contact xenomai@xenomai.org\n");
+"Please contact xenomai@lists.linux.dev\n");
 
 	if (histogram_avg)
 		free(histogram_avg);
diff --git a/doc/asciidoc/TROUBLESHOOTING.COBALT.adoc b/doc/asciidoc/TROUBLESHOOTING.COBALT.adoc
index 6e9550aadfae5b64380a3dff67e220eb0a8f7e35..fb11f7f3f45f9a2a14350cedd05abb8ac6f50080 100644
--- a/doc/asciidoc/TROUBLESHOOTING.COBALT.adoc
+++ b/doc/asciidoc/TROUBLESHOOTING.COBALT.adoc
@@ -59,7 +59,7 @@ first.
 
 If nothing seems wrong there, try capturing the OOPS information using
 a _serial console_ or _netconsole_, then post it to the
-mailto:xenomai@xenomai.org[xenomai mailing list], along with the
+mailto:xenomai@lists.linux.dev[xenomai mailing list], along with the
 kernel configuration file (aka `.config`) matching the kernel build.
 
 === Kernel boots but does not print any message
diff --git a/doc/asciidoc/man1/xeno-config.adoc b/doc/asciidoc/man1/xeno-config.adoc
index 0416a7fa5f34ca7a2c46aaab4231ea36560c7079..79474db156320a8255fd74f7164bb6476be2c319 100644
--- a/doc/asciidoc/man1/xeno-config.adoc
+++ b/doc/asciidoc/man1/xeno-config.adoc
@@ -175,7 +175,7 @@ Dump information about the running Xenomai-enabled system. Unlike most
 other options, *--info* is aimed at being used on the target system
 running Xenomai, for retrieving the current setup information. The
 output of such command is valuable information when reporting any
-runtime issue to mailto:xenomai@xenomai.org[the Xenomai mailing
+runtime issue to mailto:xenomai@lists.linux.dev[the Xenomai mailing
 list]. The command exits immediately after completion.
 
 ENVIRONMENT VARIABLES
diff --git a/include/rtdm/serial.h b/include/rtdm/serial.h
index 232e96dcc10c519a760f2c30de5851b632fc4b4d..2068bc9ddb8ac43ef93f68c74a20f50c61ac68f3 100644
--- a/include/rtdm/serial.h
+++ b/include/rtdm/serial.h
@@ -30,7 +30,7 @@
  *
  * This is the common interface a RTDM-compliant serial device has to
  * provide.  Feel free to comment on this profile via the Xenomai
- * mailing list <xenomai@xenomai.org> or directly to the author
+ * mailing list <xenomai@lists.linux.dev> or directly to the author
  * <jan.kiszka@web.de>.
  *
  * @b Profile @b Revision: 3
diff --git a/include/rtdm/testing.h b/include/rtdm/testing.h
index 2eb813555fb5e10c993cbb790b1175818b7c0522..be629f4fa0f326e8fe2fd1162f8e738b4e2217cf 100644
--- a/include/rtdm/testing.h
+++ b/include/rtdm/testing.h
@@ -30,7 +30,7 @@
  *
  * This group of devices is intended to provide in-kernel testing
  * results.  Feel free to comment on this profile via the Xenomai
- * mailing list <xenomai@xenomai.org> or directly to the author
+ * mailing list <xenomai@lists.linux.dev> or directly to the author
  * <jan.kiszka@web.de>.
  *
  * @b Profile @b Revision: 2
diff --git a/kernel/drivers/can/README b/kernel/drivers/can/README
index 44aff9b1cde5c00f09b2ecfa92c3216b2d993fa9..54a9d5bba84ad08f2dca15a2eb71901ae26f25dc 100644
--- a/kernel/drivers/can/README
+++ b/kernel/drivers/can/README
@@ -122,7 +122,7 @@ Feedback:
 --------
 
 Please report Xenomai related bugs and comments to the Xenomai mailing 
-list (xenomai@xenomai.org).
+list (xenomai@lists.linux.dev).
 
 Please report CAN related bugs and comments to the "Socketcan" mailing 
 list (Socketcan-users@lists.berlios.de) or directly to the main authors 
diff --git a/lib/psos/README b/lib/psos/README
index a76170e83ed4a888730aba17aa590f907d04b62d..d548a822485f83557099ab8f2afe7419f12b768b 100644
--- a/lib/psos/README
+++ b/lib/psos/README
@@ -10,7 +10,7 @@ Known variations from pSOS
 
 You may observe some variations from pSOS. If you find such a
 variation and you think it would be easy to correct, please mail to
-the Xenomai mailing list at <xenomai@xenomai.org>.  Here are the known
+the Xenomai mailing list at <xenomai@lists.linux.dev>.  Here are the known
 variations:
 
 - pSOS task priorities are restricted to [1..97] in the current
diff --git a/lib/vxworks/README b/lib/vxworks/README
index 0d0dcefe7a692f531b41f40730240cb0ab32a556..4b018a49050fa2bff420e8097c47de46eb726391 100644
--- a/lib/vxworks/README
+++ b/lib/vxworks/README
@@ -9,7 +9,7 @@ Known variations from VxWorks/WIND
 
 You may observe some variations from VxWorks. If you find such a
 variation and you think it would be easy to correct, please mail to
-the Xenomai mailing list at <xenomai@xenomai.org>.  Here are the known
+the Xenomai mailing list at <xenomai@lists.linux.dev>.  Here are the known
 variations:
 
 - VxWorks task priorities are restricted to [97..0] in the current
diff --git a/testsuite/latency/latency.c b/testsuite/latency/latency.c
index 0b6964bb97bd79d140a96458a8bb48ee4d6f8737..bb97711a42db212f761b6cc02bebb51ea69d2366 100644
--- a/testsuite/latency/latency.c
+++ b/testsuite/latency/latency.c
@@ -529,7 +529,7 @@ static void cleanup(void)
 	if (max_relaxed > 0)
 		printf(
 "Warning! some latency peaks may have been due to involuntary mode switches.\n"
-"Please contact xenomai@xenomai.org\n");
+"Please contact xenomai@lists.linux.dev\n");
 
 	if (histogram_avg)
 		free(histogram_avg);

---
base-commit: d4929cf0ee285dea62ba697f2729c6d3a2ab1639
change-id: 20260427-wip-flo-update-ml-addr-36cf20598d06

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

