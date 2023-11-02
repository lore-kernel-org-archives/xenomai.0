Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DF714265
	for <xenomai@lists.linux.dev>; Thu,  2 Nov 2023 14:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="NRklf3gE"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20231102144143984058b25a89b7eb06
        for <xenomai@lists.linux.dev>;
        Thu, 02 Nov 2023 15:41:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=giER/SZMS6AgaAciURBMqE+TtSYhalFNAlJibh7uliM=;
 b=NRklf3gEhfU6KArJ67ik9gdy9C0Fyf6cCTXkymAM7kniChH3ySlZ49k3+lUlds4fUZowIX
 FRK1Exdg+Je+LwDuW5vwSrXf4zpAwBL6vMqMxaniNiAmY0c602HwWsvuTcKoCWyOSw09rpYT
 I0p+othpV8BFuSVCj43MItKHJngaE=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 0/6] Minor testsuite cleanups
Date: Thu, 02 Nov 2023 15:41:41 +0100
Message-Id: <20231030-flo-cleanup-testsuite-v1-0-0fb7bbd2d45f@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACW1Q2UC/x2N0QqDMAwAf0XyvEBrwcF+Zeyh1lQDJUrTjoH47
 ws+3sFxJyhVJoXXcEKlLyvvYuAfA6QtykrIizGMbgzeBYe57JgKRekHNtKmnRvhnCaKzzwtKXi
 wdo5qskZJm9XSSzF5VMr8u2fvz3X9AWPW77V8AAAA
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all, 

this is the result of the analysis of our recent CI logs. Seems that we
did not properly report failing tests and continued with test execution,
hiding some real (but still minor) issues.

Best regards,
Florian

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Florian Bezdeka (6):
      testsuite: vxworkstests: Do not try to call nonexistent binary
      testsuite: smokey: Refactor smokey_run_extprog()
      testsuite: smokey/spitest: Fix --keep-going in combination with --verbose
      testsuite: alchemytests: Skip pipe test if kernel support is missing
      testsuite: vxworkstests: Skip tests if low resolution clock not enabled
      testsuite: psostests: Skip tests if low resolution clock not enabled

 include/smokey/smokey.h                      |   3 +-
 lib/smokey/helpers.c                         |  14 +++-
 testsuite/smokey/alchemytests/alchemytests.c |  74 +++++++++---------
 testsuite/smokey/alchemytests/pipe-1.c       |   8 +-
 testsuite/smokey/main.c                      |   5 +-
 testsuite/smokey/psostests/psostests.c       | 109 +++++++++++++--------------
 testsuite/smokey/vxworkstests/vxworkstests.c |  64 ++++++++--------
 testsuite/spitest/spitest.c                  |   5 +-
 8 files changed, 142 insertions(+), 140 deletions(-)
---
base-commit: 14470d7d58dbfe7210cfa93f03e241a38d9fa798
change-id: 20231030-flo-cleanup-testsuite-bc6ea7f6dc31

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

