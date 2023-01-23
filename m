Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D75D7C
	for <xenomai@lists.linux.dev>; Mon, 23 Jan 2023 12:25:50 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20230123121540b6fd24f1f95b004401
        for <xenomai@lists.linux.dev>;
        Mon, 23 Jan 2023 13:15:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=9lMOYSmyyPwOdEJ4ZOcNslS4m/gnQm3D2DPKXGo2djA=;
 b=EDmnNuDPP00c6MiAb+Il4pH8yM0OD6psYjELbUOUZBMvH/eeMsNnjSwrHnKmSi5J7n+WU5
 nMZovJ0J5Bs0FQuCoG+5HgqvVjqQ1xI6geoPMR11mjNU84bPLD2QdO31uwOR6Vy1FiZUX9Ym
 /tnNgoUm9cHWQe7gbg4qPDzioMPRY=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [xenomai-images][PATCH 0/2] Update to latest Isar 
Date: Mon, 23 Jan 2023 13:15:36 +0100
Message-Id: <20230123121538.2256043-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

updating to latest Isar will allow us to base Xenomai images on Debian
bookworm. Debian bookworm will allow us to integrate and test remaining
y2038 stuff.

Best regards,
Florian

Florian Bezdeka (2):
  Mount rootfs for qemu based tests read-write
  Update Isar to latest next version - sbuild integration

 kas.yml                                |  4 +--
 recipes-kernel/linux/files/rules.tmpl  | 11 ++++++++
 recipes-kernel/linux/linux-xenomai.inc | 35 +++++++++-----------------
 recipes-xenomai/xenomai/xenomai.inc    |  8 ++----
 tests/jobs/xenomai-qemu-amd64.yml      |  4 +--
 tests/jobs/xenomai-qemu-arm64.yml      |  4 +--
 tests/jobs/xenomai-qemu-armhf.yml      |  4 +--
 7 files changed, 33 insertions(+), 37 deletions(-)
 create mode 100755 recipes-kernel/linux/files/rules.tmpl

-- 
2.39.0

