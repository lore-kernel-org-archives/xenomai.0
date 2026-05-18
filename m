Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC9F3E023E
	for <xenomai@lists.linux.dev>; Mon, 18 May 2026 09:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779094969; cv=none; b=sew5JL1bgv9lla5MW8rKIznpYynevZ2IMIqLKd0fBrCFPC+bJ90zfLD8V9AyrJN+Oc1m9Rrr2wlYvDqb8LwhUq7Hp5qTMh4jvnXEd5MeEhWTMhTn1qXOcbXeFzpqR8dHokyPBZ28V8cH941Mmy5W3ZedoPByTDn9BhmL3fDWZAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779094969; c=relaxed/simple;
	bh=C4wd+NyI+lGfQMVCxxxEZJ1d5FCyr1tvdKSO+emP7xg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AlewD6nvFMZJ38FLj8C99qde/QNxZFjbPbszwNwSHqb/SJ/InaSUBIfAZ686/h8LXJonHpiypv5wBbXm+9V+cW6SWZXwu/0V9ubkx19ZvU5lWQNXA+GuoyWz0ytl4KBdOlju6LQ1PuyRfZzUb7F5os/51M1yd5f9dlLnLhwSSXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=lDmel92x; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="lDmel92x"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202605180902435bbc010fc7000207cd
        for <xenomai@lists.linux.dev>;
        Mon, 18 May 2026 11:02:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=LrPfbHMOh2Ldcxcu4o3hUMDjDNa2dd5xKc/LKCkdQsE=;
 b=lDmel92x5SQ9NXBqYxV/LqxZgO541iQCg//Vb34+IpNTfkhBVk7Z/aUQ9isAJ/nMkm1plh
 w00BIsd/wvLTgg7ynzOmq3L6trJ0sUbFlKeo525vxOXSej6Y9WkklFFXeo+IYOzlqpwD2c2V
 tt+dPGFSS77FdNDzUSUInMEk5JBK0ff9/V3VRgrrRfDugNZnKSZ7JK/o73queRpkC0WxHMnT
 Zjv3AXJUEk7AK/Z0MV46yS57R0MHc1NVBIGpOHz3PyVFmIXWjsnJXlwAy7kSB6iseP9ncMCY
 r/oyn+NgUSHzSL5YzaMTOl/9vNosyZukoOELIx84kZ7htHq4hR7i83Zw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v2 0/4] Add support for gcc 16
Date: Mon, 18 May 2026 11:02:41 +0200
Message-Id: <20260518-wip-flo-gcc-16-v2-0-f93562624fb4@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALHVCmoC/x3MQQqAIBBA0avErBtQIcuuEi3UxhqIFIUKorsnL
 d/i/wcKZaYCY/NAppMLx6NCtQ34zR4rIS/VoITSohMDXpww7BFX71Fq1MrI4EzvjJVQo5Qp8P0
 Pp/l9P03aMmhgAAAA
X-Change-ID: 20260508-wip-flo-gcc-16-6291fb97b9a1
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

Trying to compile the codebase with gcc 16 revealed some minor issues /
compile failures. Fixing them up was quite easy, so here we go.

gcc 16 is the default compiler on Fefora 44 and available as package
for Debian 14 (forky).

Cc: Jan Kiszka <jan.kiszka@siemens.com>

Changes in v2:
  - Reworked patches 3 and 4, removed / migrated busy loops

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Florian Bezdeka (4):
      utils/autotune: Fix compile error seen with gcc 16
      testsuite/smokey/sched-tp: Fix compile error seen with gcc 16
      testsuite/smokey/vxworktests: Fix compile error seen with gcc 16
      testsuite/smokey/psostests: Fix compile error seen with gcc 16

 testsuite/smokey/psostests/rn-1.c      | 7 +++----
 testsuite/smokey/psostests/task-2.c    | 5 ++---
 testsuite/smokey/sched-tp/sched-tp.c   | 2 +-
 testsuite/smokey/vxworkstests/task-2.c | 4 ----
 utils/autotune/autotune.c              | 4 +---
 5 files changed, 7 insertions(+), 15 deletions(-)
---
base-commit: 9fed9de228841e7bc6e3f55fdb44374f15acddc5
change-id: 20260508-wip-flo-gcc-16-6291fb97b9a1

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

