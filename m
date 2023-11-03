Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250801BDD8
	for <xenomai@lists.linux.dev>; Fri,  3 Nov 2023 15:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="AZrP4ux0"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20231103152333a64a91c3f1e7227d54
        for <xenomai@lists.linux.dev>;
        Fri, 03 Nov 2023 16:23:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=xdQTQs0xE5QHowKPg0GdBvR11GFerPBIYdzx8c6xwJs=;
 b=AZrP4ux0KeIqctnbf0D1qf4XiWqwJz6lLBSCJspy5ayX5kgogyWD5fb+lMLtu8duHjFtwa
 z8/DOAPge5JqqaleFdbL857Kv6jJphhJlH3eGePjSa/JpL2wsIoZq6QS43DQA618fKF6xy5W
 GUIXwbFts5VT/YQ/wqYyaq5D5f9BQ=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 0/4] Testsuite cleanup - continued
Date: Fri, 03 Nov 2023 16:23:29 +0100
Message-Id: <20231103-flo-cleanup-testsuite-v1-0-628287f21b8d@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHEQRWUC/x2NSQrDMAwAvxJ0rsCyD12+UnpwHKURGCdYdimE/
 D0ixxkYZgflKqzwGnao/BOVtRjQbYC0xPJllMkYvPOByAWc84opcyx9w8batEtjTIEezj/ZT3Q
 Ha8eojGONJS1Wl56zya3yLP9r9v4cxwk1+B/cfAAAAA==
To: jan.kiszka@siemens.com, xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

Jan had some further comments / ideas for cleanups relating the last
testsuite cleanup series. Here we go with some further stuff that
jumped at me while working on that.

Feel free to drop patch 2.

Nice weekend!

Best regards,
Florian

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Florian Bezdeka (4):
      boilerplate: Define ARRAY_LEN once inside ancillaries.h
      boilerplate: Rename ARRAY_LEN to ARRAY_SIZE
      testsuite: alchemytests: Try loading the xeno_rtipc module
      utils/analogy: Cleanup of unused includes

 include/boilerplate/ancillaries.h            |  2 ++
 lib/analogy/calibration.c                    |  5 ++---
 testsuite/smokey/alchemytests/alchemytests.c | 14 +++++++++-----
 testsuite/smokey/psostests/psostests.c       |  2 +-
 testsuite/smokey/vxworkstests/vxworkstests.c |  2 +-
 utils/analogy/analogy_calibrate.c            |  4 ----
 utils/analogy/analogy_calibrate.h            |  2 --
 utils/analogy/analogy_config.c               |  1 -
 utils/analogy/calibration_ni_m.c             |  8 +++++---
 utils/analogy/cmd_bits.c                     |  2 --
 utils/analogy/cmd_read.c                     |  1 -
 utils/analogy/cmd_write.c                    |  2 --
 utils/analogy/insn_bits.c                    |  2 --
 utils/analogy/insn_read.c                    |  1 -
 utils/analogy/insn_write.c                   |  1 -
 utils/analogy/wf_facilities.c                |  2 +-
 16 files changed, 21 insertions(+), 30 deletions(-)
---
base-commit: e66b97f8d02d0fdc3f5f8da7197d895df95dafcb
change-id: 20231103-flo-cleanup-testsuite-c318029e2d17

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

