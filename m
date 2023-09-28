Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59948836
	for <xenomai@lists.linux.dev>; Thu, 28 Sep 2023 15:32:57 +0000 (UTC)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2023092815324873c5559462b2c9974d
        for <xenomai@lists.linux.dev>;
        Thu, 28 Sep 2023 17:32:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=H3E8OKO1p6TBaI5Dx5fDReFopzrx45ADds5asIr7VKk=;
 b=IXUoULyKV9pZogarPr2hQJrq5W3NamJVIMjIg0bncDymiwvA3VDtiq6dBys6LN1OkB9WsM
 2J1WyiFiEmLuPN1np1BrTtGOXtAq8eAViAW6XR3NY8ZhBK30NO7vSPJ9yy6plSs0GSYiQl0j
 JiiF5zRx4DBq/ZTYJPzm0WgQF5Ccc=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 0/4] Housekeeping
Date: Thu, 28 Sep 2023 17:32:44 +0200
Message-Id: <cover.1695915167.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

Version updates and some minor improvement of start-qemu.sh.

Jan

Jan Kiszka (4):
  Update to kas 4.0
  xenomai: Update to 3.2.4
  start-qemu: Pick up architecture from .config.yaml if left out
  Update Isar revision

 Kconfig                                       |  10 +-
 README.md                                     |  12 +-
 board-beagle-bone-black.yml                   |   2 +-
 board-hikey.yml                               |   2 +-
 board-qemu-amd64.yml                          |   2 +-
 board-qemu-arm64.yml                          |   2 +-
 board-qemu-armhf.yml                          |   2 +-
 board-x86-64-efi.yml                          |   2 +-
 ci/gitlab-ci-base.yml                         |   2 +-
 conf/distro/include/xenomai-version.inc       |   6 +-
 ...es-Fix-image-tarball-by-removing-fir.patch |  51 ++
 kas-container                                 | 562 ++++++++++++++++++
 kas.yml                                       |   8 +-
 opt-ci.yml                                    |   2 +-
 opt-compat.yml                                |   2 +-
 opt-debug.yml                                 |   2 +-
 opt-linux-4.19.yml                            |   2 +-
 opt-linux-4.4.yml                             |   2 +-
 opt-linux-5.10.yml                            |   2 +-
 opt-linux-5.15.yml                            |   2 +-
 opt-linux-5.4.yml                             |   2 +-
 opt-linux-6.1.yml                             |   2 +-
 opt-linux-latest-4.19.yml                     |   2 +-
 opt-linux-latest-4.4.yml                      |   2 +-
 opt-linux-latest-5.10.yml                     |   2 +-
 opt-linux-latest-5.15.yml                     |   2 +-
 opt-linux-latest-5.4.yml                      |   2 +-
 opt-linux-latest-6.1.yml                      |   2 +-
 opt-linux-latest.yml                          |   2 +-
 opt-xenomai-3.0.x.yml                         |   2 +-
 opt-xenomai-3.1.x.yml                         |   2 +-
 opt-xenomai-3.2.x.yml                         |   2 +-
 opt-xenomai-next.yml                          |   2 +-
 .../{xenomai_3.2.3.bb => xenomai_3.2.4.bb}    |   2 +-
 start-qemu.sh                                 |  19 +-
 35 files changed, 673 insertions(+), 51 deletions(-)
 create mode 100644 isar-patches/0001-classes-imagetypes-Fix-image-tarball-by-removing-fir.patch
 create mode 100755 kas-container
 rename recipes-xenomai/xenomai/{xenomai_3.2.3.bb => xenomai_3.2.4.bb} (90%)

-- 
2.35.3

