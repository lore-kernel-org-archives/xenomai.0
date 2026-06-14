Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C25D26ED37
	for <xenomai@lists.linux.dev>; Sun, 14 Jun 2026 09:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781429270; cv=none; b=O/fGIhFWxEBuN63KCBJHAc1SNpQExhllJkzWdzmBsajHafLEhuID3/otVhrzDquy5blcsMXdmv9ht+PNecFNKKFUYG5J0I9JikSOjuUHgcs/L/QdmDtXleKV6G7X+AYPtw8HcM2iJYDkb92N5Et7kFzMGnJV4afDcgD0GvfAG4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781429270; c=relaxed/simple;
	bh=j/sWRxBZVOm53eCdQzgjWRr89n9YGIAYKZnL5muy948=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QmyaM7aT8fCdT6os8j/m5WKF+LxrAmUQMEklXRYQiF70UZhAxNJQCkQhfRCg/Tu70Xbchp+h6SJl/6JBdBvInV5IV2VQM343oUT7aRe8aqaiArY/P+Rlu9Sgm6mrwmWcDchg+iX9powKKHOR9t+IhHReOVtAyWRrCxHVoN5yVyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=Gzor8lWi; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="Gzor8lWi"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202606140917344f8342d7f700020796
        for <xenomai@lists.linux.dev>;
        Sun, 14 Jun 2026 11:17:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=lyztwKCIc6BxuPkgwVnrxSc0pH2VK616t4BkX5UjFeY=;
 b=Gzor8lWirr0AC7PcQyEZ24mzEhTv+iO9GrE5jzHfV+JPpDFIzU9F6lL/S0PmMX51Mdoixn
 j+NPBClmnQgVsCmJV9X8KiBeXIqBa29iXIUSWXvojdCCgASWyrBpW0G6/ibNBkQbRaMyDNUC
 vgqTACGGjryA/Sf074Xplpy01Oa6UmZrslDVtZh8vsXHmewN0tJRfbWAg8Rz+ICXCLj37nQe
 /M5gmTeEpPRoHj0hCFjRKXS+nM/Mo43USCdMaf4amfT5oLiS95S03805jVagaivEYB/eiInS
 KV/jgAryE964zbOTrnUM+VmzanekUtghg6yPJmzuIfCqO9bl9bLaHefQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 0/6] Xenomai 4 fixes and debug mode, fix for head kernel selection
Date: Sun, 14 Jun 2026 11:17:28 +0200
Message-ID: <cover.1781428654.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

See patches.

Jan

Jan Kiszka (6):
  Kconfig: Permit to enable debug mode for Xenomai 4
  Add trace-cmd to debug images
  linux-xenomai: Limit latest branch selection to official ones
  ci: Drop 6.1 from xenomai-4 pipelines
  linux-xenomai: Renovate xenomai-4 kernel versions
  linux-xenomai: Switch riscv branch to latest integration

 Kconfig                                       | 61 ++++++++-----------
 ci/xenomai_4_next.yml                         |  1 -
 recipes-core/images/demo-image.bb             |  1 +
 .../linux/linux-xenomai-3_latest.bb           |  2 +-
 recipes-kernel/linux/linux-xenomai-4_6.1.bb   | 14 -----
 recipes-kernel/linux/linux-xenomai-4_6.12.bb  |  2 +-
 recipes-kernel/linux/linux-xenomai-4_6.18.bb  |  2 +-
 .../linux/linux-xenomai-4_latest.bb           |  9 ++-
 8 files changed, 34 insertions(+), 58 deletions(-)
 delete mode 100644 recipes-kernel/linux/linux-xenomai-4_6.1.bb

-- 
2.47.3

