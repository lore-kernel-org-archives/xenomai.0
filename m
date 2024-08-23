Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552707D401
	for <xenomai@lists.linux.dev>; Fri, 23 Aug 2024 06:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724395978; cv=none; b=iVGC13xkg2iWPZMjCAjbiQ9KJPvoFzxGwwOGrvDRwrU5ngdf7DUY7Yg/trRblt4OBIl4l3/z3yRkgOv3wLo6FaJ+mWI6yJoZoglsL+zvGeyf9dP5TvarYrcqVMc8UpV+EeR5nIK8Tq4n4/zT4fwfSAbFbV0cvrClQmJs/lVnkJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724395978; c=relaxed/simple;
	bh=1jR02b4rEr6/hYt36P+3gJN87V6o6b3h9EakfO9381o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T7TS2sJBHRN3aP0qcxLt1gBFqD/4fJeYt8/1Z9bhoqWKs0/Xc+93bolyGMihrWMrhuEWvjwgzFSmyR5lsadFgfQUinV7dI29pHEFy2c5OVeT82iMYFim9hto4BITt4adDSqXdLg8K35SHUS1yvlOStLkd8hxFP24wkAxJIbFBNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=cq2ehT4g; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="cq2ehT4g"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4280c55e488so8235605e9.0
        for <xenomai@lists.linux.dev>; Thu, 22 Aug 2024 23:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1724395973; x=1725000773; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nyj9+iDqlBIOzRCObWzU1OR7+3AZ3GbCzz8o4/d9Mrw=;
        b=cq2ehT4gjtMIV7HZs4Njo6UVPBxloaMiF6aAXexVX9HbwXpI5cU7Q0mg4hwzBceyVN
         TkOTuBC0d/n7Rt1lDDUw6j69ZIOSQ9vfzuUuMdLZmMZeWkxA+D8LEMl0hcru0fe8hI0D
         ThMrwQk+mqk0cLH0qQ8vr2TuFkS/3GPPK0XxSXXiCatQ0vL35GOnTmtgMuLNsvhXACgV
         LyvVcOaoE7RPweiijNcZnPNn9H2OHM+TmqGTsld60aUcDI08+jzPSFHOVk4ozb1bkcPv
         3ELSoyw2ByWaqIJov6TXAo/ei4AN/g6uE/Q59QVxy0XfXQaAxkopuK6OiLtu7dXH6GC8
         TaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724395973; x=1725000773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nyj9+iDqlBIOzRCObWzU1OR7+3AZ3GbCzz8o4/d9Mrw=;
        b=bG4hGk1pyhc9rCMRvfM0dZ7jnOvN9T6NPpvS2cYZA9ntuVnU0N0zXpC6yu6gHNhLl2
         xxbPCzppdj3dfVd+CI3wVz5c3gzKjDu0Kz6N5gI4cLZr9jpfmtLJBcafXquIrFBWB3UD
         rhCVdlMcnpA7+E6OLtUkDd+ee6RyNb38D+s2jMntPT6iR09FBAQbgkmrMIoSus7IEMSC
         lUeUd5lL3D8JEw6rzJEoqHJHAtBHnunk50raPpMMdMcuQvHJLnpywsu7xW1+Gu7Kj/1v
         xdghEWdYVZN53TR/SWr0YW/QjAYtgWZY2baVKymDBMVhut4aDnO+bKdtiF0Jg+cLXsqX
         S2Hg==
X-Gm-Message-State: AOJu0Yxak2J/Fb67aQcwfcJj65wYoh61UNSh/IAdaM+3B3cWMmMTnMil
	vAltx5wIQlZqfVDyifoY/ZKk54Vhj6veSY/LNbT5ytpGuzu38iybP8IqrzcNWn3/h7Pa73ejtVY
	OAAk=
X-Google-Smtp-Source: AGHT+IGTdA0PSEJxeI43G29K4S6Nh7dLDexJI+tDhyhE5O27gxkzIGdzgIBBBTDqgdXXeB49j+EN8Q==
X-Received: by 2002:a05:600c:46ca:b0:426:5e32:4857 with SMTP id 5b1f17b1804b1-42acc8a60bamr6962135e9.0.1724395972989;
        Thu, 22 Aug 2024 23:52:52 -0700 (PDT)
Received: from localhost.localdomain ([144.208.200.160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac500e119sm49558525e9.0.2024.08.22.23.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 23:52:52 -0700 (PDT)
From: Simon Graber <simon.graber@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Simon Graber <simon.graber@sigma-star.at>
Subject: [PATCH 2/2] doc: Fix grammar
Date: Fri, 23 Aug 2024 08:52:47 +0200
Message-ID: <20240823065247.4884-3-simon.graber@sigma-star.at>
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
 doc/asciidoc/MIGRATION.adoc              | 14 +++++++-------
 doc/asciidoc/README.INSTALL.adoc         |  4 ++--
 doc/asciidoc/TROUBLESHOOTING.COBALT.adoc |  6 +++---
 doc/asciidoc/man1/xeno-config.adoc       |  2 +-
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/doc/asciidoc/MIGRATION.adoc b/doc/asciidoc/MIGRATION.adoc
index 2a46b43fe..8dc7c7a13 100644
--- a/doc/asciidoc/MIGRATION.adoc
+++ b/doc/asciidoc/MIGRATION.adoc
@@ -164,7 +164,7 @@ remains, periodic timing is now controlled locally from the Xenomai
 libraries in user-space.
 
 Xenomai {xenover} defines a built-in clock named _coreclk_, which has
-the same properties than the former _master_ time base available with
+the same properties as the former _master_ time base available with
 Xenomai 2.x (i.e. tickless with nanosecond resolution).
 
 The settings of existing clocks can be read from entries under the new
@@ -276,7 +276,7 @@ variables may be accessed from any code module.
 
 Any application linked against +libcobalt+ has its main thread
 attached to the real-time system automatically, this operation is
-called _auto-shadowing_. As a side-effect, the entire process's memory
+called _auto-shadowing_. As a side effect, the entire process's memory
 is locked, for current and future mappings
 (i.e. +mlockall(MCL_CURRENT|MCL_FUTURE)+).
 
@@ -664,7 +664,7 @@ mainly for the sake of consistency:
 .Rationale
 **********************************************************************
 Opening a device instance most often requires allocating resources
-managed by the Linux kernel (memory mappings, DMA etc), which is only
+managed by the Linux kernel (memory mappings, DMA etc.), which is only
 available to regular calling contexts.
 **********************************************************************
 
@@ -818,7 +818,7 @@ Recent evolutions of the Linux kernel with respect to IRQ management
 involve complex processing for basic operations
 (e.g. enabling/disabling the interrupt line) with some interrupt types
 like MSI. Such processing cannot be made dual-kernel safe at a
-reasonable cost, without encurring measurable latency or significant
+reasonable cost, without incurring measurable latency or significant
 code updates in the kernel.
 
 Since allocating, releasing, enabling or disabling real-time
@@ -1112,7 +1112,7 @@ unsigned int rtskb_pool_init(struct rtskb_pool *pool,
 			  void *lock_cookie);
 -----------------------------------------------------------------------
 
-  * for the typical case where an skb pool locks the containing
+  * for the typical case where a skb pool locks the containing
     module, the function rtskb_module_pool_init() was added which has
     the same interface as the old rtskb_poll_init() function. Its
     prototype is:
@@ -1226,7 +1226,7 @@ kernel Cobalt environment.
   This is a requirement for maintaining both the *glibc* and the
   Xenomai scheduler in sync, with respect to thread priorities, since
   the former maintains a process-local priority cache for the threads
-  it knows about. Therefore, an explicit call to the the regular
+  it knows about. Therefore, an explicit call to the regular
   `pthread_setschedparam(3)` shall be issued upon each priority change
   Xenomai-wise, for maintaining consistency.
 
@@ -1617,7 +1617,7 @@ rt_task_wait_period() may block the caller.
 
 [TIP]
 In the unusual case where you do need to have the current task wait
-for the initial release point outside of its periodic work loop, you
+for the initial release point outside its periodic work loop, you
 can issue a call to +rt_task_wait_period()+ separately, exclusively
 for this purpose, i.e.
 ---------------------------------------------------------------
diff --git a/doc/asciidoc/README.INSTALL.adoc b/doc/asciidoc/README.INSTALL.adoc
index 677c2d593..3fdb5a8cc 100644
--- a/doc/asciidoc/README.INSTALL.adoc
+++ b/doc/asciidoc/README.INSTALL.adoc
@@ -37,8 +37,8 @@ or the runtime target.
 The `kernel/` sub-tree which implements the in-kernel support code is
 seen as a built-in extension of the Linux kernel.  Therefore, the
 standard Linux kernel configuration process should be used to define
-the various settings for the Xenomai kernel components. All of the
-kernel code Xenomai currently introduces implements the _Cobalt_ core
+the various settings for the Xenomai kernel components. All the
+kernel code Xenomai currently introduces, implements the _Cobalt_ core
 (i.e. dual kernel configuration). As of today, the _Mercury_ core
 needs no Xenomai-specific code in kernel space.
 
diff --git a/doc/asciidoc/TROUBLESHOOTING.COBALT.adoc b/doc/asciidoc/TROUBLESHOOTING.COBALT.adoc
index 2e1760aeb..6e9550aad 100644
--- a/doc/asciidoc/TROUBLESHOOTING.COBALT.adoc
+++ b/doc/asciidoc/TROUBLESHOOTING.COBALT.adoc
@@ -23,7 +23,7 @@ When configuring the Linux kernel, some options should be avoided.
 CONFIG_CPU_FREQ:: This allows the CPU frequency to be modulated with
 workload, but many CPUs change the TSC counting frequency also, which
 makes it useless for accurate timing when the CPU clock can
-change. Also some CPUs can take several milliseconds to ramp up to
+change. Also, some CPUs can take several milliseconds to ramp up to
 full speed.
 
 CONFIG_CPU_IDLE:: Allows the CPU to enter deep sleep states,
@@ -443,7 +443,7 @@ threads, for which a large default amount of stack space memory is
 commonly reserved by the POSIX threading library (8MiB per thread by
 the _glibc_). Therefore, the kernel will commit as much as
 _8MiB{nbsp}*{nbsp}nr_threads_ bytes to RAM space for the application,
-as a side-effect of calling the +mlockall()+ service to lock the
+as a side effect of calling the +mlockall()+ service to lock the
 process memory, as Xenomai requires.
 
 This behaviour can be controlled in two ways:
@@ -495,7 +495,7 @@ the kernel to have been configured with the
 
 ==== the _latency_ test hangs
 
-The most common reason for this issues is a too short period passed
+The most common reason for these issues is a too short period passed
 with the +-p+ option, try increasing the period. If you enable the
 watchdog (option +CONFIG_XENO_OPT_WATCHDOG+, in your kernel
 configuration), you should see the <<short-period, "watchdog triggered
diff --git a/doc/asciidoc/man1/xeno-config.adoc b/doc/asciidoc/man1/xeno-config.adoc
index a537e189b..0416a7fa5 100644
--- a/doc/asciidoc/man1/xeno-config.adoc
+++ b/doc/asciidoc/man1/xeno-config.adoc
@@ -174,7 +174,7 @@ a set of source-level compatibility wrappers when present.
 Dump information about the running Xenomai-enabled system. Unlike most
 other options, *--info* is aimed at being used on the target system
 running Xenomai, for retrieving the current setup information. The
-output of such command is a valuable information when reporting any
+output of such command is valuable information when reporting any
 runtime issue to mailto:xenomai@xenomai.org[the Xenomai mailing
 list]. The command exits immediately after completion.
 
-- 
2.46.0

