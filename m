Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D074218AC
	for <xenomai@lists.linux.dev>; Wed, 13 May 2026 12:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778676622; cv=none; b=ooHmJSQGSeEw2Bm208LVzSTrqttUF1nVGyMOwAxNUOClE+EdJj4kDsZPWr1zP57EZQ5++ZYs6jz7+arkrzwTdkC/fjuZcPPJUb8bJOej6QZk29akbsOQc/hg71NolqPiItZOzFzp1IdjTy1rX2oB8qJhFZzFORNLmKdesaOmtog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778676622; c=relaxed/simple;
	bh=yVOA3cxOI7Kjg2J8qKeIuf1laKZDoGEu1cPuE5+JiAk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hcU7Lq9dURxxZJnaNeFM9jpNvRAGneMr8EXhl9D5j5ohRUSz90LM1SywhWzoLdk8t0kEPqfTjCqMhvyrzsclu3d7LkOGy3O0igdjKQobQt11PajFGb6+vIzSEA77iqYecRb14x7tfXG/0A/QITASh706PFHL0PPDgTzHaH1taoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=V8Hob2mI; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="V8Hob2mI"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260513125011fcc75cda1e000207d2
        for <xenomai@lists.linux.dev>;
        Wed, 13 May 2026 14:50:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=hXC8m5aiqdWiy+Zf4WgpcQSSUgKpU7gtcW3XH0tuU8E=;
 b=V8Hob2mItgehuJphMjgHqPnB1mPz4QvewZ4D4h+0UcuggZtv0EmN7JBP8sMJe7qqpRUqup
 dhqPcMCUQ4I8lAmRcEf2V9UUxheI0iXEBp51kDz8gkigyLklR7zLgMT8cGwXC4gBEv360l1j
 JZeTe3hkcRU+ABeDhZskbaIy7SCrvOPabR2UhWs/D8JQvKBqWWtGYf7fddsfh0JwlAUK1d+H
 m7TIFSyM41ecaBuAivFiqq31x198qessAhswyjzBKMJhkQ2Ozk0zwqZlvt1kRWWFVhUYWdgw
 H1NuTe2mH9xBLZj+wmtddst7o5DDAoPeKzNmQwP2sWU55jN5JOlIrQmg==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 0/5] Add support for gcc 16
Date: Wed, 13 May 2026 14:50:07 +0200
Message-Id: <20260513-wip-flo-gcc-16-v1-0-120ae1287401@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH9zBGoC/x3MQQqAIBBA0avErBtQIcuuEi3UxhqIFIUKorsnL
 d/i/wcKZaYCY/NAppMLx6NCtg34zR4rIS/VoITSohMDXpww7BFX71Fq1MrI4EzvjJVQo5Qp8P0
 Pp/l9P7AoXkFgAAAA
X-Change-ID: 20260508-wip-flo-gcc-16-6291fb97b9a1
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

Trying to compile the codebase with gcc 16 revealed some minor issues /
compile failures. Fixing them up was quite easy, so here we go.

Cc: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Florian Bezdeka (5):
      utils/autotune: Fix compile error seen with gcc 16
      testsuite/smokey/sched-tp: Fix compile error seen with gcc 16
      testsuite/smokey/vxworktests: Fix compile error seen with gcc 16
      testsuite/smokey/psostests: Fix compile error seen with gcc 16
      clang-format: Squash empty loops into a single line

 .clang-format                          | 2 +-
 testsuite/smokey/psostests/rn-1.c      | 7 +++----
 testsuite/smokey/psostests/task-2.c    | 5 ++---
 testsuite/smokey/sched-tp/sched-tp.c   | 2 +-
 testsuite/smokey/vxworkstests/task-2.c | 5 ++---
 utils/autotune/autotune.c              | 4 +---
 6 files changed, 10 insertions(+), 15 deletions(-)
---
base-commit: 54e9c509863439614484b0bf939c32bfadb15423
change-id: 20260508-wip-flo-gcc-16-6291fb97b9a1

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

