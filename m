Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A116A1E885D
	for <xenomai@lists.linux.dev>; Thu, 10 Oct 2024 22:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728599104; cv=none; b=Sty47Jf9theZwF2hw3fzPwLcQT9roLVFWJf8/aon0WxPnb4S8tmUPXhjo42wnw/BsewJque40gbIrPvbiXedykZBythHpTprCbS+/XcAOvmuMPZ4ze07mZoicjr2vC3eXHxobUAog8OpLJUqD/itwJ0SGwSWJ/5GzisHZcG6yxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728599104; c=relaxed/simple;
	bh=qGz6GAiyKrHIa7f6QxTe1leXGZqd2GVvDoknx0bfGIw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=o+Bs9qKF133qmgImHBm+/Z6EbtCprQp+GTPN1mkmw43+rsz/8woKgGC7MPaa6TyI8GGy9FHEQFETrYE7lJ0IZ7sm+RWwE0b61b5JTlawfwONGd054u6RLxuj2i7bQ5s7GmnWCyktROpwIP5CWL8Ze09nLZUOq2q+WhbQ8kpkrr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=SIoHNT3X; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="SIoHNT3X"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2024101022144899695f4f145f9b1371
        for <xenomai@lists.linux.dev>;
        Fri, 11 Oct 2024 00:14:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=BjP1MHDtWaDTpc+k1KhNavBgESjdYzLvKxsbHIeHHHI=;
 b=SIoHNT3XgL08ykZyhEGMk91waR8NHAMPMJ1D+GPrdPBTonu4Z5FP6scglw41vkY9/G7hm2
 QtrVIDQCmNrNQSHQxrRg1d/NdIWEp5n3NhQi+VbdcukFxvn1amx472c7JCaJnCitBULp4Nra
 ltmWA02rPRa2hY0SChVNQpxEVLmtHuJtDGfSetpsYXydAt1PSkmdNUqNKuHGxN+rYPGUWjVc
 mcNXhESTkA97dxXzUeaRxbTrqpteeiN3Pmd9WMD7Cwo48PByrwMVyeWVpL1giyF2ormYtc/w
 vsUJcHzI5lWFHzecULlOKJRd9Cm1vqYwqaeQhStbCIctvq639Vu0L82A==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 0/3] Preparations for Debian 13 / Trixie
Date: Fri, 11 Oct 2024 00:14:47 +0200
Message-Id: <20241011-flo-cleanup-y2038-v1-0-4b5b0078fa60@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANdRCGcC/x2NywrCMBAAf6Xs2YU8JIq/Ih626cYuhG1JqCil/
 +7S4wwMs0PnJtzhMezQ+CNdFjXwlwHyTPpmlMkYggtX77zHUhfMlUm3FX/BxTsmjrHcMiWXCKw
 bqTOOjTTPVupWq8m1cZHvOXq+juMPJ1wNOngAAAA=
To: xenomai@lists.linux.dev
Cc: Jan Kisza <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

as we are already in the preparation phase for a new release I took the
task to clarify that the upcoming release is in a good shape regarding
the upcoming Debian 13 next year.

As it turned out a couple of minor issues had to be addressed to make
the upcoming release ready for glibc and compilers shipped by Debian 13.

The y2038 implementation needs a couple of fixes due to changes made in
glibc. For some reason they decided to change __USE_TIME_BITS64 macro.
The commit that introduced the change is linked in the following
patches.

Testing on Debian 13 was done manually so far, Debian 12 was covered by
internal CI runs.

Best regards,
Florian

Cc: Jan Kisza <jan.kiszka@siemens.com>

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Florian Bezdeka (3):
      y2038: lib/cobalt: select: Fix compile failure observed on Debian 13
      y2038: lib/cobalt: Fix link failure observed on Debian 13
      y2038: testsuite/clocktest: Fix link compile error observed on Debian 13

 configure.ac                    | 3 ++-
 include/cobalt/wrappers.h       | 3 ++-
 lib/cobalt/select.c             | 7 ++++++-
 testsuite/clocktest/clocktest.c | 2 +-
 4 files changed, 11 insertions(+), 4 deletions(-)
---
base-commit: 86c4592bee073d6bcd21b16dbd13b0d60af202dc
change-id: 20241011-flo-cleanup-y2038-6e33f7ca606a

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

