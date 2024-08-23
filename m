Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EFC55894
	for <xenomai@lists.linux.dev>; Fri, 23 Aug 2024 06:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724395977; cv=none; b=XV/ummSQaBeJM6n65lJRefPCpoBV+0fWoOZNYxReOJ6AvjlZ2byxE+uhpj+lICmmY566hwEARjY0hbmYuELX+3OQgkuExfyWznc4e3pBV+HHDh6x/348NhBgyJnbMGcXcklLjxX9w5t7jCraRA2yTAqGqNORo/PC307mENK4kTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724395977; c=relaxed/simple;
	bh=uURYduC3JFeZayNR+xAhcdwlUsH8cKLTWDpvA9W0m9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N36yRLB15E9tM3HQmrpuK0zuJ5tRCo7lCWFV/ktbdHOzwqrjlaAtjnCwpNNmsceUJ/aAqg5F2naLEtbHUU4kSuu01mppSVyHnfOF6/ngHT0fnAZHyQkqrPZJNuLLk4ItR2aI69n1PQMXVOFJmAVyuhSKYqphiXqibEOr51awTj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=Q/dIGkbq; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="Q/dIGkbq"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4281ca54fd3so12748725e9.2
        for <xenomai@lists.linux.dev>; Thu, 22 Aug 2024 23:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1724395972; x=1725000772; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NM7H0OPuDG/sGY6qamcv1zTupu2595Lz/BrKIRpi0VI=;
        b=Q/dIGkbqz1lLUQGFcDX4VvULwxEjZk8BpOEYGVtU61MrT2yJEGAVCWCRywh4HQ4KEc
         2uu8WVHCgkzb/9uxIs1oyfanlxb+UNF9zj+LN/ygq2WSawiwU6cs6ytgYKbC3AL/sEE/
         WbD5+9umreRQwBHeQTpWK6n1fA8TPQ1lf6iVP+OTUu/K4z+OtJuUu9xV5chqmKcTiQov
         CAPW124ZuSoLOToB9Ak0JGqrIaL4+NRizsaUo60Vs6GPtLPjE7zEtIesOXq0VYXxFxkh
         xsnzbdlL/buNtOHHOY09N5LtgzElOnji9jM8XFiz2wcIYhSzapfLB7cXTU/ua4pV5vec
         PwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724395972; x=1725000772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NM7H0OPuDG/sGY6qamcv1zTupu2595Lz/BrKIRpi0VI=;
        b=oZLxtBwIbyMM1H2jp4LLf8Psy5fZG6l82ACz41CEUj3dG3ZCnUW5b1sejTve2sBPA2
         shj4cc0gGMKkUz/ONfJsuCisvboBcV8f0B/VZYSnTuxo6QZw0rWrUKFIEghwhlZ7tfzt
         XdWeM7v9wIk5lRuQcyeW9SmEuhnonGdUf3nFn1/VfsCx3zGmS0eZXmcAVuaWdb0kyjFx
         KdrQA2phkpb19yUVV5exbO9Gc3/9ah5Mzuzm86aWEa5EVPCx5Dq4UIAfXOwzRNSst6zW
         mI7Lkm03eQpwdGLbSt4IiY2jPLgob/5xO8v+3ORp/kPjqAU2JYO00IjPB1N7vcd9Evjc
         SwYQ==
X-Gm-Message-State: AOJu0YzA0hkbnF6XUpODM17AurRNVxRpZiafUYFeM1L0objrAQn+cPfc
	FOiIIKxrBFEf6ROuu1ECRBtCrgoapMwPZHUyC17X/VNafvuXOnbv+cFy+y9b6ww6GPXkexNz12E
	9vgA=
X-Google-Smtp-Source: AGHT+IF9rv7o9vYZGVd7IxzN4uyCVtXnEpPLTMLkBsQQDHtgVQ7ArxOIZ4nkp65v/c7YX3azDKqYHg==
X-Received: by 2002:adf:f40e:0:b0:36c:ff0c:36d3 with SMTP id ffacd0b85a97d-3731186839dmr896896f8f.29.1724395972159;
        Thu, 22 Aug 2024 23:52:52 -0700 (PDT)
Received: from localhost.localdomain ([144.208.200.160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac500e119sm49558525e9.0.2024.08.22.23.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 23:52:51 -0700 (PDT)
From: Simon Graber <simon.graber@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Simon Graber <simon.graber@sigma-star.at>
Subject: [PATCH 1/2] doc: Fix typos
Date: Fri, 23 Aug 2024 08:52:46 +0200
Message-ID: <20240823065247.4884-2-simon.graber@sigma-star.at>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240823065247.4884-1-simon.graber@sigma-star.at>
References: <20240823065247.4884-1-simon.graber@sigma-star.at>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Simon Graber <simon.graber@sigma-star.at>
---
 doc/asciidoc/README.INSTALL.adoc         | 10 +++++-----
 doc/asciidoc/TROUBLESHOOTING.COBALT.adoc |  6 +++---
 doc/asciidoc/man1/gpiobench.adoc         |  4 ++--
 doc/asciidoc/man1/slackspot.adoc         |  2 +-
 doc/doxygen/xeno3prm-common.conf.in      |  8 ++++----
 doc/doxygen/xeno3prm-html.conf.in        |  4 ++--
 doc/doxygen/xeno3prm-latex.conf.in       |  2 +-
 7 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/doc/asciidoc/README.INSTALL.adoc b/doc/asciidoc/README.INSTALL.adoc
index d2b7e6f78..677c2d593 100644
--- a/doc/asciidoc/README.INSTALL.adoc
+++ b/doc/asciidoc/README.INSTALL.adoc
@@ -68,7 +68,7 @@ $ scripts/prepare-kernel.sh [--linux=<linux-srctree>]
     kernel tree may be already configured or not, indifferently. This
     path defaults to $PWD.
 
-`--dovetil`:: specifies the path of the interrupt pipeline (aka Dovetail)
+`--dovetail`:: specifies the path of the interrupt pipeline (aka Dovetail)
     patch to apply against the kernel tree. Suitable patches are
     available from the project's link:/downloads/dovetail/[download
     area].  This parameter can be omitted if the Dovetail has already
@@ -425,7 +425,7 @@ Generic configuration options (both cores)
 	CONFIG_FUSE_FS must be enabled in the target kernel.
 
 [normal]
-When this option is enabled, the system creates a file hierachy at
+When this option is enabled, the system creates a file hierarchy at
 `<user>/<session>/<pid>` under the registry root path, where you
 can access the internal state of the active real-time objects. The
 session label is obtained from the --session runtime switch. If no
@@ -550,7 +550,7 @@ client applications are running over a SMP-capable kernel.
 
 	Turns off the sanity checks performed at application startup
 	by the Xenomai libraries. This option sets a default, which
-	can later be overriden using the --[no-]sanity options passed
+	can later be overridden using the --[no-]sanity options passed
 	to a Copperplate-based Xenomai application. Sanity checks are
 	enabled by default when configuring.
 
@@ -695,7 +695,7 @@ $ make install
 ------------------------------------------------------------------------------
 
 After installing the build tree (i.e. using "make install"), the
-installation root should be populated with the librairies, programs
+installation root should be populated with the libraries, programs
 and header files you can use to build Xenomai-based real-time
 applications.  This directory path defaults to `/usr/xenomai`.
 
@@ -723,7 +723,7 @@ expected to pass them using the CFLAGS and LDFLAGS variables as
 demonstrated above, where the AT91RM9200 is based on the ARM920T core,
 implementing the `armv4` architecture. The following table summarizes
 the CFLAGS and options which were automatically passed in previous
-revisions and which now need to be explicitely passed to configure,
+revisions and which now need to be explicitly passed to configure,
 for the supported SOCs:
 
 .ARM configure options and compilation flags
diff --git a/doc/asciidoc/TROUBLESHOOTING.COBALT.adoc b/doc/asciidoc/TROUBLESHOOTING.COBALT.adoc
index 14a4d53c6..2e1760aeb 100644
--- a/doc/asciidoc/TROUBLESHOOTING.COBALT.adoc
+++ b/doc/asciidoc/TROUBLESHOOTING.COBALT.adoc
@@ -286,7 +286,7 @@ placeholder such as _i586_, for which _rdtsc_ is not available.
 
 If your processor does not provide the _rdtsc_ instruction, you have
 to pass +--disable-x86-tsc+ option to the configure script for
-building the user librairies. In this case, Xenomai will provide a
+building the user libraries. In this case, Xenomai will provide a
 (much slower) emulation of the hardware TSC.
 
 [NOTE]
@@ -540,7 +540,7 @@ USB legacy mode if set in the same move.
 hardware acceleration in the X-window server file. With recent
 versions of X-window, try using the 'fbdev' driver. Install it
 (Debian package named 'xserver-xorg-video-fbdev' for instance), then
-modifiy the +Device+ section to use this driver in
+modify the +Device+ section to use this driver in
 '/etc/X11/xorg.conf', as in:
 -------------------------------------------------------------------------------
 Section "Device"
@@ -548,7 +548,7 @@ Section "Device"
 	Driver      "fbdev"
 EndSection
 -------------------------------------------------------------------------------
-With olders versions of X-window, keep the existing driver, but
+With older versions of X-window, keep the existing driver, but
 add the following line to the +Device+ section:
 -------------------------------------------------------------------------------
 	Option "NoAccel"
diff --git a/doc/asciidoc/man1/gpiobench.adoc b/doc/asciidoc/man1/gpiobench.adoc
index bd32ea8ad..44079067b 100644
--- a/doc/asciidoc/man1/gpiobench.adoc
+++ b/doc/asciidoc/man1/gpiobench.adoc
@@ -54,12 +54,12 @@ name of pin controller
 number of gpio pin as output
 
 *-i <interrupt-pin>*::
-number of gpin pin as interrupt
+number of gpio pin as interrupt
 
 *-p <priority>*::
 default = 99, task priority
 
-*-b <bracktrace>*::
+*-b <breaktrace>*::
 default = 1000, send break trace command when latency > breaktrace
 
 
diff --git a/doc/asciidoc/man1/slackspot.adoc b/doc/asciidoc/man1/slackspot.adoc
index b59b992a2..3701e2e54 100644
--- a/doc/asciidoc/man1/slackspot.adoc
+++ b/doc/asciidoc/man1/slackspot.adoc
@@ -48,7 +48,7 @@ for +stdin+.
 
 *--path <dir[:dir...]>*::
 Search directory list for executables and dynamic
-libraries. Directories are separatared by a semi-colon within the
+libraries. Directories are separated by a semi-colon within the
 list.  Each directory may be scanned for binary executables when
 resolving symbols found in stack backtraces.
 
diff --git a/doc/doxygen/xeno3prm-common.conf.in b/doc/doxygen/xeno3prm-common.conf.in
index cd7765053..1becf3dc5 100644
--- a/doc/doxygen/xeno3prm-common.conf.in
+++ b/doc/doxygen/xeno3prm-common.conf.in
@@ -504,7 +504,7 @@ COMPACT_RTF            = NO
 RTF_HYPERLINKS         = NO
 
 # Load stylesheet definitions from file. Syntax is similar to doxygen's 
-# config file, i.e. a series of assigments. You only have to provide 
+# config file, i.e. a series of assignments. You only have to provide
 # replacements, missing definitions are set to their default value.
 
 RTF_STYLESHEET_FILE    = 
@@ -673,7 +673,7 @@ EXPAND_AS_DEFINED      =
 SKIP_FUNCTION_MACROS   = YES
 
 #---------------------------------------------------------------------------
-# Configuration::addtions related to external references   
+# Configuration::additions related to external references
 #---------------------------------------------------------------------------
 
 # The TAGFILES option can be used to specify one or more tagfiles. 
@@ -717,7 +717,7 @@ EXTERNAL_GROUPS        = YES
 # If the CLASS_DIAGRAMS tag is set to YES (the default) Doxygen will 
 # generate a inheritance diagram (in HTML, RTF and LaTeX) for classes with base or 
 # super classes. Setting the tag to NO turns the diagrams off. Note that this 
-# option is superceded by the HAVE_DOT option below. This is only a fallback. It is 
+# option is superseded by the HAVE_DOT option below. This is only a fallback. It is
 # recommended to install and use dot, since it yields more powerful graphs.
 
 CLASS_DIAGRAMS         = YES
@@ -750,7 +750,7 @@ CLASS_GRAPH            = YES
 COLLABORATION_GRAPH    = YES
 
 # If the UML_LOOK tag is set to YES doxygen will generate inheritance and 
-# collaboration diagrams in a style similiar to the OMG's Unified Modeling 
+# collaboration diagrams in a style similar to the OMG's Unified Modeling
 # Language.
 
 UML_LOOK               = NO
diff --git a/doc/doxygen/xeno3prm-html.conf.in b/doc/doxygen/xeno3prm-html.conf.in
index 3936a13aa..d9907b99d 100644
--- a/doc/doxygen/xeno3prm-html.conf.in
+++ b/doc/doxygen/xeno3prm-html.conf.in
@@ -101,7 +101,7 @@ GENERATE_TREEVIEW      = YES
 TREEVIEW_WIDTH         = 250
 
 #---------------------------------------------------------------------------
-# Configuration::addtions related to the search engine
+# Configuration::additions related to the search engine
 #---------------------------------------------------------------------------
 
 # The SEARCHENGINE tag specifies whether or not a search engine should be
@@ -114,7 +114,7 @@ SEARCHENGINE           = YES
 # using Javascript. Doxygen will generate the search PHP script and index
 # file to put on the web server. The advantage of the server
 # based approach is that it scales better to large projects and allows
-# full text search. The disadvances is that it is more difficult to setup
+# full text search. The disadvantage is that it is more difficult to setup
 # and does not have live searching capabilities.
 
 SERVER_BASED_SEARCH    = YES
diff --git a/doc/doxygen/xeno3prm-latex.conf.in b/doc/doxygen/xeno3prm-latex.conf.in
index 6a25bf714..a7611080c 100644
--- a/doc/doxygen/xeno3prm-latex.conf.in
+++ b/doc/doxygen/xeno3prm-latex.conf.in
@@ -101,7 +101,7 @@ GENERATE_TREEVIEW      = YES
 TREEVIEW_WIDTH         = 250
 
 #---------------------------------------------------------------------------
-# Configuration::addtions related to the search engine  
+# Configuration::additions related to the search engine
 #---------------------------------------------------------------------------
 
 # The SEARCHENGINE tag specifies whether or not a search engine should be
-- 
2.46.0

