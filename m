Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDCD35502A
	for <xenomai@lists.linux.dev>; Tue, 21 Oct 2025 12:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761049404; cv=none; b=dmbMBr8zKErHhjhksgynHv0m6zcoIBmn7NsJa8H1v9VEJB0J6PDTj1CoHNH7HHDvdpufuh3SO29mcOcEY2k3l4UY4NJG7b3LcyjL7w11ejsm44aV4/e86E5U4k0ePZDo4ZormCv9NVRNwjqul0aWQ2si2ncwYT1kIbLFfEOH658=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761049404; c=relaxed/simple;
	bh=UnRB8W8hd2u750QYKhkYjS9zrhXN/C0PndnY7cInZhM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZfduZseiCyO8xEUJDiJz7ExWB2U0kBF7iGipW5up7rRV0enVEFblErNSliqZUrcwtrb6ZN1NSn103Q3Q4mUzr5auGAM+6ds/y648F9X4Q17OJAXaA/MqLEl8HRs+9Us+im7RTivs3nkRsQijk3mxbirLHoex0zMrk1DXA6jiu70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=SDcaKBiU; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="SDcaKBiU"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2025102112231206b422703d0002078e
        for <xenomai@lists.linux.dev>;
        Tue, 21 Oct 2025 14:23:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=TrN0m0t8JjCxL5Qevr+g5rKpWLLsPYHxaBDzvEn7xmo=;
 b=SDcaKBiUAACoCv7whP6K7LaPxIsGG85jwqNGkv846X51KwtjIJZPOdjRR7ifH/5mdKOmtN
 Nmyo3a+aOxxUFhmdrrhuoHLvsaEV5g5GhIGDO915Ufb0pl/iJ/g7Ha9+I3npOx7exygeHOru
 6rgrWT6C1F8roDTjXBKjdOqKKx6OYN8I/f8k18KNcyzywiqMFeu/zlh0OXEZbHegEy11gOi9
 JYEAbt1GiqvT876al1yY7DgzJUbxn8Eb6KmMabBSbvwF+TJGMQ+f6wCEEbyPxKSc/HHYDgzd
 VMJ1lZftQYVC37nJ3MLaTzWDnep6KFu3aPO22aOx6m+C+BDG1Ayzfb9g==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH Dovetail 6.17 v3 0/4] dovetail: Add support for hyper-v as
 hypervisor
Date: Tue, 21 Oct 2025 14:23:10 +0200
Message-Id: <20250602-flo-add-hyperv-support-for-6-15-v3-0-f3b45eaed2e8@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC5792gC/5XNTQ6CMBCG4auQrh3SHyjoyoW3MC5aOpUmQEmLj
 YRwdxt27nT5ZSbPu5GIwWEkl2IjAZOLzk95iFNBul5NTwRn8iac8ppKysEOHpQx0K8zhgTxNc8
 +LGB9AAmsBtGIptVGCouMZGUOaN37KNzJzSdclBsKWbKGPPK5d3HxYT36iR1PP6cSAwpVdUbZc
 WpQm2t0OOIUy86Ph574nyLPomVdS7lmSivxLe77/gHGrv49MQEAAA==
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

with this series applied dovetail is successfully booting up on a
Windows host using the Hyper-V hypervisor as virtualization platform.

You won't get any RT guarantees - that's clear - but it helps to test
non-RT stuff using a dovetail enabled kernel on such a platform.

The following config knobs were turned on during testing:
  - CONFIG_HYPERV
  - CONFIG_HYPERV_NET
  - CONFIG_HYPERV_KEYBOARD
  - CONFIG_HYPERV_TIMER
  - CONFIG_HYPERV_UTILS
  - CONFIG_HYPERV_BALLOON
  - CONFIG_HYPERV_IOMMU
  - CONFIG_HYPERV_STORAGE

Best regards,
Florian

Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Philippe Gerum <rpm@xenomai.org>

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Changes in v3:
- Rebased on top of Dovetail 6.17 rc
- Set patch prefix to 6.17
- Adress review comments from Philippe, basically git log update of
  patch 1
- Link to v2: https://lore.kernel.org/r/20250602-flo-add-hyperv-support-for-6-15-v2-0-f1c802b1aba3@siemens.com

Changes in v2:
- Added correct "Dovetail 6.16" prefix
- Updated Cc list
- Link to v1: https://lore.kernel.org/r/20250602-flo-add-hyperv-support-for-6-15-v1-0-449e6c20debd@siemens.com

---
Florian Bezdeka (4):
      clocksource/hyper-v: irq_pipeline: Enable pipelined clock events
      x86: irq_pipeline: Implement inband handler for hyper-v specific vectors
      hyper-v: x86: dovetail: Close race window in PV spinlocks
      x86: irq_pipeline: Allow CONFIG_HYPERV in combination with CONFIG_DOVETAIL

 arch/x86/hyperv/hv_spinlock.c      |  4 ++--
 arch/x86/kernel/irq_pipeline.c     |  9 +++++++++
 drivers/clocksource/hyperv_timer.c | 34 +++++++++++++++++++++++++++++++++-
 drivers/hv/Kconfig                 |  2 +-
 4 files changed, 45 insertions(+), 4 deletions(-)
---
base-commit: e978823786e09bd5842045153f99af39ffebbcfc
change-id: 20250602-flo-add-hyperv-support-for-6-15-37378bd63fe1

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

