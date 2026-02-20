Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F1931A556
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 09:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771578539; cv=none; b=j8h1levqlVVJrN7VnD3pLobquK0aw8AzLlraj0XVua7WBvWdH7UTHgecxSJwYYzzNCdpdWBjXxykdbLIEhiW9IKkhDniw0no3LD7Oz86xQqfLyBJ4Sqgzso4Qej3+jtsY8PdutLlANFQ826W7MKnkSt0H8h4pcM+PQsUtawK3X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771578539; c=relaxed/simple;
	bh=Ua/Ev28Es8B8MNRz2RRPpcdkDWPppqA5l0PlNDITu3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sfWnRM7nvozzDqxZtJUidyntaaVl/X3tQjAWvBSCXwe99TNYTfaUqUhbLkzNY2CUzSXeb/fg8Tj7wdj7UO39T7gWF1dTlDgKAtemBxnCAC/2+R0TFzC3LFD8ISxO0NEWrUB5IqWTp7rilbB8GVkNn1aXdjH41C8BwLTlTba+Rv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=SlahIUIC; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="SlahIUIC"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202602200908464daa67b88f000207ae
        for <xenomai@lists.linux.dev>;
        Fri, 20 Feb 2026 10:08:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=SVTZcicH1EN27Y5nx6ZHg9V72VbPWWp/vszgLqKdUEU=;
 b=SlahIUIC/NluSSPtHBgUvV6caWO+XboxCCViEKA55D8ba2faD3b2Gmr9kJQDoHqE8t+HQl
 EBypGeUGLKiYzXUvD+vR+6TX9y5V3ortS+vy+tzwFSqygWccZ74Z1kmZ2Bdi991Unbve9Zzu
 Ox0V1mLpXlKH0algLDTZa6QFUfVdi/zExXY1IOqRKXUMjzSgtLfNHPvlrtKYdxrwrIIFrJxL
 d6aXLuSJMVjGHIsHWR1jlcRisDp0GlyBkUl9gCP3M15Ud04SEzLrDVFK23D+v1V0h8OW6k0d
 6tNcc+5sPvsYU4TcbvqFekBAYyQN5mSTDMH/J3lNNjbspsH1/3CP3TbQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 20 Feb 2026 10:08:48 +0100
Subject: [PATCH 05/20] lib/cobalt: Introduce wrappers_time64.c
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-wip-flo-fix-time64-32bit-native-v1-5-731c773e72cc@siemens.com>
References: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
In-Reply-To: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

All COBALT_IMPL_TIME64() services will be moved afterwards - step by
step - into the newly introduced wrappers_time64.c. At the end that
should allow us to compile libcobalt with time64_t support leaving
the native time_t services in place.

Currently, all native time_t services are replaced by the 64 bit
variants. That is OK as long as applications are rebuild after
libcobalt, but we try to remove this limitation now.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/Makefile.am       | 3 ++-
 lib/cobalt/wrappers_time64.c | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/cobalt/Makefile.am b/lib/cobalt/Makefile.am
index f461e570ed42a0d5cbc43eabb373c3c9edd83bad..17e203f9015fe2bb5306609e4d51c62f3a725780 100644
--- a/lib/cobalt/Makefile.am
+++ b/lib/cobalt/Makefile.am
@@ -43,7 +43,8 @@ libcobalt_la_SOURCES =		\
 	timerfd.c		\
 	trace.c			\
 	umm.c			\
-	wrappers.c
+	wrappers.c		\
+	wrappers_time64.c
 
 libcobalt_la_CPPFLAGS =			\
 	@XENO_COBALT_CFLAGS@		\
diff --git a/lib/cobalt/wrappers_time64.c b/lib/cobalt/wrappers_time64.c
new file mode 100644
index 0000000000000000000000000000000000000000..4c4e0db0650b49f46cbd6d9ecf7cd656bb04bbe4
--- /dev/null
+++ b/lib/cobalt/wrappers_time64.c
@@ -0,0 +1,6 @@
+/*
+ * Magic ahead:
+ * This file is compiled twice in case y2038/time64_t support is necessary
+ * and requested. The first time with time64_t and a second time with native
+ * time_t.
+ */

-- 
2.53.0

