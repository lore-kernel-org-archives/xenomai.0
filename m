Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C02C1DD865
	for <xenomai@lists.linux.dev>; Mon, 28 Oct 2024 13:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730123092; cv=none; b=tVWGhlt3cXjH0jeBQAqw2ve6xqwQxIzOm5m2A75e6YHVoUT6ZfqQKnvajFgVRDA0P/1La6zqEflph/nWU+UWOG+JDyXyftywVc9eOw6i9EVks0RC1/dl02j9ahcFgR/nUgluGi2PJZh/RIA/tgPBYITWP8VmP4FOnTfWfJkiLdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730123092; c=relaxed/simple;
	bh=bVJqhuqR5USWNgEVS4yOGsDafcp/AWsqrpQCLFSlyoY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=rZGVqjLMc5Y/XflhKNhrQJdnNwoeTrsXS2fs3t2hUpL6vlWcz//SCF4COjjZjqNCZ29Tbx+AWCNBs6QIrPnyAxd1KvQnJqkub1bp8JYw62Baqe0K33DOaFpOZa/TxPo4xQagVX+XvaQ6dRjJAZNcN6c4I9xGjvTOE201HB/nPuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=eCDnmDMt; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="eCDnmDMt"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20241028134445549eea5076b216aa60
        for <xenomai@lists.linux.dev>;
        Mon, 28 Oct 2024 14:44:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=X0j3QX5peFLsc73xSg7TsywSYBP/cvQb9tdtLRn7x6w=;
 b=eCDnmDMtKHdff9srWz802eFxPAifAEHdj5fsmV/dOuo0o2LHu049YN6VV2J/f2ik5WLCsI
 HiENskwQy1dxZphiqi0HRbVhp+DhW7BWmHuyM7Qe5yi3o/r9HRqzBQptPsFHB6OsG2vlFHHy
 +oCP8ozVW8IDxqyCHxtjRDRAqkqssWKX5LcOTb6sNamJ4GM54f76zORxjiBNBwHFZ+6nKtkS
 Kea6XCIJuG1lvOnr2WOClf+wrXGnvyW8IQmMm/sjDDBFfTo/SmJJlarctJKexyS8x1Ew6V2L
 wWSXZ4ts8p/RufmELeF+tE7Os3O5Voc5RIoFhBgc6mNezM2Qg2MNG5vw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 0/6] Various houskeeping changes
Date: Mon, 28 Oct 2024 14:44:38 +0100
Message-ID: <cover.1730123084.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

See patches for details.

Jan

Jan Kiszka (6):
  layer.conf: Fix sstate cachability issue
  Update to kas 4.5
  Update isar revision
  xenomai: Pull common definition of S into shared include
  xenomai: Update stable releases
  Add Xenomai 3.3 support

 Kconfig                                       | 25 +++++++++++--------
 ci/gitlab-ci-base.yml                         |  2 +-
 conf/distro/include/xenomai-version.inc       |  8 +++---
 conf/distro/xenomai-demo.conf                 |  4 +--
 conf/layer.conf                               |  3 ++-
 kas-container                                 | 25 +++++++++++++------
 kas.yml                                       |  4 +--
 recipes-xenomai/xenomai/xenomai.inc           |  2 ++
 .../{xenomai_3.0.14.bb => xenomai_3.0.15.bb}  |  1 -
 .../{xenomai_3.1.4.bb => xenomai_3.1.5.bb}    |  2 --
 .../{xenomai_3.2.4.bb => xenomai_3.2.6.bb}    |  2 --
 .../{xenomai_3.1.4.bb => xenomai_3.3.bb}      |  6 ++---
 recipes-xenomai/xenomai/xenomai_master.bb     |  2 --
 .../xenomai/xenomai_stable-3.0.x.bb           |  2 --
 14 files changed, 47 insertions(+), 41 deletions(-)
 rename recipes-xenomai/xenomai/{xenomai_3.0.14.bb => xenomai_3.0.15.bb} (94%)
 copy recipes-xenomai/xenomai/{xenomai_3.1.4.bb => xenomai_3.1.5.bb} (94%)
 rename recipes-xenomai/xenomai/{xenomai_3.2.4.bb => xenomai_3.2.6.bb} (94%)
 rename recipes-xenomai/xenomai/{xenomai_3.1.4.bb => xenomai_3.3.bb} (77%)

-- 
2.43.0

