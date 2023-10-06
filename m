Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B88DE540
	for <xenomai@lists.linux.dev>; Fri,  6 Oct 2023 10:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="ilaPqvxm"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2023100610431241d7c5268748b9c75c
        for <xenomai@lists.linux.dev>;
        Fri, 06 Oct 2023 12:43:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=epiBuwvRau98nh5EVEmCjogFEw/unmUVW5nsRDIP8ro=;
 b=ilaPqvxmdcE4nzBacRNee9eYllVMf2GV/GV61Ii3kN+BDoUvvRBZunZz9Db1vjVDMnbqDp
 e1EVjHjnOmYbuj/vkyGgWqxgwGSTkX32j4JFNq2Om5kwY4+6/CeHwHJ2U/rs0pGteVLRS3sA
 5qBb/sAXEEzK/f+yjbV9cC2m0YMC0=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	florian.bezdeka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [RFC PATCH v2 0/2] Fix trap related handling
Date: Fri,  6 Oct 2023 12:43:02 +0200
Message-Id: <20231006104304.3813326-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

Hi all,

the series provides a fix for the issue discussed in:
Link: https://lore.kernel.org/xenomai/87edjiuifo.fsf@xenomai.org/T/#mbe75bcddd368954dbdb7bbcc00e9fcfa71f7ea8a

It does two things:
- Fix the break trap handling in the undefined instruction trap
- Add a notification before the emulation of the armv8 SWP{B} instruction

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
Clara Kowalsky (2):
  arm64: dovetail: Fix undefinstr/break trap handling
  arm64: dovetail: Fix armv8 SWP{B} instruction handling

 arch/arm64/include/asm/dovetail.h    | 1 +
 arch/arm64/kernel/armv8_deprecated.c | 8 +++++++-
 arch/arm64/kernel/debug-monitors.c   | 2 ++
 arch/arm64/kernel/traps.c            | 7 -------
 4 files changed, 10 insertions(+), 8 deletions(-)

-- 
2.39.2

