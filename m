Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355BA2EBBB7
	for <xenomai@lists.linux.dev>; Mon, 16 Feb 2026 08:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771229812; cv=none; b=qqypwUaXODosnhEAlNGrrXIxl+2GdvhvPadI5u3wiChLeEpfmTRoSirfe8rV5dvvGWqz61PQ1rZqeQ96S1MomIns2tJfOfYU6YOqxnpaFhPd8jZtYpH/06OUIefgjSj9dY+Pl2KeGiXD236Cg6q8iLLwWMsiSmfg86CVqCQ26AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771229812; c=relaxed/simple;
	bh=NP68qi0bvVF78U3vVKe9m+3EXW0YwV5KaKjlrpBQMwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fNGlyovmTRfI9EgdrPHLrTOajeVZq67Y+IENOj7lxPgBKM6BrMvRbl8edE+I/8TgjJRRBCEvWgOb6CxA3lG/MilP0Ni77k/bepJwioIvkCM8H610pKbkw6YZzXuaMrQQ2FYJNgfwP7xg6PcpHpqJMm8TknDhf4LPblVHSkKcKp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=b/Jeaosg; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="b/Jeaosg"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260216081638cd5a5c75c500020774
        for <xenomai@lists.linux.dev>;
        Mon, 16 Feb 2026 09:16:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=91xpivm+DEqigEsnPWIWDYnnYHTtVOvOOUdlWo+Ptc8=;
 b=b/JeaosgF4jkXrqWzQx9uYhHyfOwHVxsvGGQRTMy0i8JQXk2p8y7d2Dv82eizbM3JDAnPC
 QRV1TU3GbPaODO/iGSXkZhy2PhMh5cRf7Ib5ydDgWbQJdvPPzPTR5UvGPD31P2YRk+uH20oF
 gBbZpLrbR2gOjfmizjo/bKVwFIjbLE4lM5/CI0YKe/6FfSrCzkZCkjFbdsf8XZi9iLWAZzOW
 n//C3HG8tjBaq1DCWzJFBW5V1irm5Em5XBHN2jZlXGLtWSXUEmKJ55NwOPInzEkYUyue+qgt
 +LZgrfmjBOjpsH2Sc2nwjzwbf86NwKXx5w6g0vkVCk+k96vv1u/oG3rA==;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [xenomai-images][PATCH v3 1/2] ci: Build kernel head for xenomai-4/next
Date: Mon, 16 Feb 2026 09:16:28 +0100
Message-ID: <20260216081629.3163713-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

Also build the latest kernel in combination with libevl/next. QEMU
targets are only built for the latest kernel.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 ci/xenomai_4_next.yml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ci/xenomai_4_next.yml b/ci/xenomai_4_next.yml
index 5c1c7f4..5a248e5 100644
--- a/ci/xenomai_4_next.yml
+++ b/ci/xenomai_4_next.yml
@@ -13,11 +13,12 @@ include:
   - local: '/ci/lib/gitlab-ci-base.yml'
   - local: '/ci/lib/kernel/6_1.yml'
   - local: '/ci/lib/kernel/6_12.yml'
+  - local: '/ci/lib/kernel/head.yml'
 
 variables:
   XENOMAI_BUILD_OPTION: ":kas/opt/libevl-next.yaml:kas/opt/debug.yaml"
   XENOMAI_VERSION: "4-next"
-  KERNEL_VERSION_WITH_QEMU: "6.12"
+  KERNEL_VERSION_WITH_QEMU: "head"
   BUILD_IDENTIFIER: "evl-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
   CACHE_KERNEL: evl
   TEST_COMMAND: "evl test -k $(evl test -l | grep -Ev \"${EVL_TESTS_SKIP_PATTERN}\")"
-- 
2.52.0

