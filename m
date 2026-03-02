Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BB0379EE4
	for <xenomai@lists.linux.dev>; Mon,  2 Mar 2026 06:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772432265; cv=none; b=XdUz6oG6rj4/4000uqlSCFLLH5/bpNtKHr6WTsnvNlEYUI/oF58w7u1DXYdLij44t3YpPje5dMJkKLdvtzLJBxzgdOj1gT7Tjkl9/a5SguhWD6BniMuZpNqSXXzuwOQebnlKVEsAh5jMnL9q3krb7Mn8odpGE2l5wuopPvzE6IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772432265; c=relaxed/simple;
	bh=6aRNsZqQmk7WXNu+sl03cNiAjoKU7K7Vz6PWqrvYifE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ovNVc+PMrejRtWD4JM9fLk5Bz5fYdzbRY/KPs5lEJscvQqO2ppMRrOG/xMFz7BsRVlXdPQK79Gk8xQOzBhE803IwZhX+K/GDwS+2RAvbgEcm2FK6sFPmVpnVG9NHNrXwwFzX1pUFo54BM1L3/R5hKB11YHSlN/qQOdWndmFH/NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GtSK/wQJ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GtSK/wQJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772432258; x=1803968258;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6aRNsZqQmk7WXNu+sl03cNiAjoKU7K7Vz6PWqrvYifE=;
  b=GtSK/wQJI9nAKzzxr/TyeEIkAgPziJ5kr9ZKlJNSqX9ocYv2hmw5q8ik
   7GelS9jElEaJzAcKPOIf8cF3n1TySA99AAEkM55AUGrZ+dsvIacX/rfpC
   anpI547SeDFyLOXao8b7XVWPesh3WHoABhlYwBC8lbmlFNv5KAZpeTKja
   5dfZGkrsm7sQkfiG0sYKko/DgBHROY6NFNxVb8z776vvpvv3EXb411mBF
   GRXhvhoSdu5BCEStvp3R0xH3kAyG+OMYlZ3uranx09hqtQjOLoyGJLcGT
   uskH8qklmKyPCYo6xO7/uQq6EeRMzC0s705gOlE5UxhdoSw5v0RTnMOIe
   w==;
X-CSE-ConnectionGUID: aNayxa5oTU6LSdE6Rbjbuw==
X-CSE-MsgGUID: GIUCbmoeRjOkHhdN3AK7Lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="84069497"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="84069497"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2026 22:17:37 -0800
X-CSE-ConnectionGUID: U0fHbPESR3O6GXU8mbbwJg==
X-CSE-MsgGUID: j/ToklnYTaGrBs58mw4gvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="217664797"
Received: from ikt-nuc-sh-9.sh.intel.com ([10.67.103.86])
  by orviesa007.jf.intel.com with ESMTP; 01 Mar 2026 22:17:36 -0800
From: Yuan Wang <yuan1.wang@intel.com>
To: xenomai@lists.linux.dev
Cc: Yuan Wang <yuan1.wang@intel.com>,
	Junxiao Chang <junxiao.chang@intel.com>
Subject: [PATCH] tests: ptrace-sync: relax breakpoint pattern matching
Date: Mon,  2 Mar 2026 22:26:01 +0800
Message-Id: <20260302142601.83860-1-yuan1.wang@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some OS distributions, the gdb output of the break instruction
doesn't contain the function name where the breakpoint is set. This
is observed on Ubuntu 22.04.5. with GNU gdb
(Ubuntu 12.1-0ubuntu1~22.04.2) 12.1., causing pattern matching
failures and subsequent test failures.

Remove the ": bp\." suffix requirement to make the pattern
more robust across different gdb versions and configurations.

The original failed log (run with -v) -

"
-> {{ "b bp" }}
EXPECT {{ ^Breakpoint 1 at .*: bp\.}}
<- {{ "Breakpoint 1 at 0x28b9: file ../tests/ptrace-sync.c, line 59." }}
<- {{ "(gdb)" }}

<timeout waiting for gdb>
"

Signed-off-by: Yuan Wang <yuan1.wang@intel.com>
Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
---
 tests/ptrace-sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/ptrace-sync.c b/tests/ptrace-sync.c
index 4c56e73..556c7a6 100644
--- a/tests/ptrace-sync.c
+++ b/tests/ptrace-sync.c
@@ -147,7 +147,7 @@ static struct dialog {
 	{ "^Reading symbols from .*", "set prompt (gdb)\\n" },
 	{ ".*(gdb).*", "set env __EVL_DEBUGGEE__=1" },
 	{ "(gdb)", "b bp" },
-	{ "^Breakpoint 1 at .*: bp\\.", "r" },
+	{ "^Breakpoint 1 at .*", "r" },
 	{ "^Thread 1 .* hit Breakpoint 1.*, bp ().*", "c" },
 	{ "^Thread 3 .* hit Breakpoint 1.*, bp ().*", "c" },
 	{ "^Thread 2 .* hit Breakpoint 1.*, bp ().*", "c" },
-- 
2.34.1

