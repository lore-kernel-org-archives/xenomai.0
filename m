Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9944D2E8B94
	for <xenomai@lists.linux.dev>; Fri, 23 Jan 2026 11:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769168843; cv=none; b=kaDYZ/zwochF1sp9UrlfGJ/DTC0guuOIiftZe/lo/J0+uRnuLtbATa5BSEuZJgr5T8/CQPpHETqaOKDZjYqXJFXI9qqEm7s0+7MueVT7UoY5Hz1WLHPvSQfrjQYFdeG5NiS1LikBkcIdKqfufnWwMqcEh+MZ+6JObOMx0kqps+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769168843; c=relaxed/simple;
	bh=TG+6bKWLR7YE4PJbZqI+S/XvK6fn1kFg9d892Vo0pTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhWazXy6xf7MM4OpTKmhay4A8RZX49XuoHvs0gXnxyTEMGvk7r/GJzEY57Hq6SNyZfPGeuihsTMpx5SVees/Ljrbq17Ur9wVNuulDN9UdQ0MAIBaIXbqFG1agTMQLzW8rcDg+GfCVQ8oCClu1/XA+mZIjpyRhCWlE7YJSHEkRcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OZX9T1rp; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OZX9T1rp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769168841; x=1800704841;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TG+6bKWLR7YE4PJbZqI+S/XvK6fn1kFg9d892Vo0pTc=;
  b=OZX9T1rpnoZdefKG5cOwZ5tYXytPHUgiTJPdFpJMEzCseB2Z53Nyd13A
   LIJ/R/G+HeDnt5xlWrbJN63nVSTF6MDSg9yCKbIA/oEL19Sza/NqJV1QQ
   b/Uwqs2nUcu5eCoxS46wGvFrkwhTgamZT9IO6Pi4a/o08f/8++WzU1IyA
   on3GAXXABxQt8BeYUAr/Tt2kYLLOjP2ONjPMQyPtvMaG7mvQjsRtgv8n/
   7Na2ODleUvcG8/Upy5gZFeNPrUcxmuqfWNq5USfEv4MGnlGPGMQnBaLzz
   l6ZtxQGfGWbU90m/Z8n4Gw9QOKxNQFsdNx7t2WvlUYBr256Zjc2vzHpi1
   g==;
X-CSE-ConnectionGUID: 3EIkJMDqSbyMxG70yintNQ==
X-CSE-MsgGUID: Xlu5BysbT9aaVknbwfLcQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="69616604"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="69616604"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 03:47:21 -0800
X-CSE-ConnectionGUID: yv0tcv1STwmss1cdyy7/vA==
X-CSE-MsgGUID: C36UuJlGQfC2oNlerDdyHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="207349766"
Received: from junxiao.bj.intel.com ([10.238.152.69])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 03:47:20 -0800
From: Junxiao Chang <junxiao.chang@intel.com>
To: xenomai@lists.linux.dev
Cc: yuan1.wang@intel.com,
	junxiao.chang@intel.com
Subject: [PATCH libevl 2/2] tests: ptrace-sync: only integrate ptrace-sync in debug build
Date: Sat, 24 Jan 2026 19:42:32 +0800
Message-ID: <20260124114232.1186577-2-junxiao.chang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260124114232.1186577-1-junxiao.chang@intel.com>
References: <20260124114232.1186577-1-junxiao.chang@intel.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ptrace-sync test case needs to load debug symbol in gdb. There is
debug symbol in debug build. If buildtype is release, this case
should not be integrated because it doesn't have debug symbol.

Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
---
 tests/meson.build | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/meson.build b/tests/meson.build
index fb8b291..89e542f 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -64,7 +64,6 @@ test_programs = [
     'proxy-eventfd',
     'proxy-pipe',
     'proxy-poll',
-    'ptrace-sync',
     'rwlock-read',
     'rwlock-write',
     'sched-quota-accuracy',
@@ -80,6 +79,10 @@ test_programs = [
     'thread-mode-bits',
 ]
 
+if get_option('buildtype').startswith('debug')
+   test_programs += 'ptrace-sync'
+endif
+
 foreach t : test_programs
     x = executable(t, t + '.c',
     install : true,
-- 
2.43.0

