Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773F46FB8
	for <xenomai@lists.linux.dev>; Wed, 10 Jan 2024 04:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="BsPdKJuc"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240110044602726a13b7040d89d9af
        for <xenomai@lists.linux.dev>;
        Wed, 10 Jan 2024 05:46:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=Q7BpogRLnIGyGRMB7J792poNaXWHzdJapO1bodpAhdI=;
 b=BsPdKJucAx3DG3cKGG+98S2evUTcEXsuk64BMq7/nNWCOtuUiIV5khIY/i8boHSPiOnsPB
 /MSDT/COV583bd0bzH9CgSp334GXtatbJPGV9LuOkd7cLTYjb37MNfsTqPEzMEnMw3t33oMg
 8zp3Bp7AiHd9sAdGFhfStid6jtGio=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [xenomai-images][PATCH v3 00/10] Add evl support to xenomai-images
Date: Wed, 10 Jan 2024 05:45:52 +0100
Message-Id: <cover.1704861962.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

I've picked up Clara's patches and massaged them a bit to fit them even
more smoothly into xenomai-images. The result now also works on ARM and
ARM64. It also comes with some cleanups for the existing code base.

Jan


CC: Clara Kowalsky <clara.kowalsky@siemens.com>

Clara Kowalsky (7):
  linux-xenomai: Rename linux-xenomai to linux-xenomai-3
  xenomai-3: Mark xenomai 3 specific configs
  xenomai-4: Enable kernel build
  xenomai-4: Add evl userspace
  kconfig: Add build options for evl
  ci: Rename xenomai 3 files
  ci: Prepare for xenomai-4 test cases

Jan Kiszka (3):
  Add Isar patch to permit linux-libc-dev upgrades in the sbuild
    environment
  Replace incorrect string strip method with replace
  Factor out print-revision class

 .gitlab-ci.yml                                |   6 +-
 Kconfig                                       |  66 +++++++
 ci/{xenomai_next.yml => xenomai_3_next.yml}   |   2 +-
 ...t_compat.yml => xenomai_3_next_compat.yml} |   1 -
 ci/{xenomai_next.yml => xenomai_4_next.yml}   |  10 +-
 classes/print-revision.bbclass                |  23 +++
 conf/distro/include/xenomai-version.inc       |   2 +-
 conf/distro/xenomai-demo.conf                 |   8 +-
 ...port-for-replacing-pre-installed-pac.patch | 168 ++++++++++++++++++
 kas.yml                                       |   6 +-
 opt-linux-6.6.yml => opt-evl.yml              |   4 +-
 opt-libevl-latest-release.yml                 |  19 ++
 opt-libevl-next.yml                           |  19 ++
 opt-linux-4.19.yml                            |   2 +-
 opt-linux-4.4.yml                             |   2 +-
 opt-linux-5.10.yml                            |   2 +-
 opt-linux-5.15.yml                            |   2 +-
 opt-linux-5.4.yml                             |   2 +-
 opt-linux-6.1.yml                             |   2 +-
 opt-linux-6.6.yml                             |   2 +-
 opt-linux-latest-4.19.yml                     |   2 +-
 opt-linux-latest-4.4.yml                      |   2 +-
 opt-linux-latest-5.10.yml                     |   2 +-
 opt-linux-latest-5.15.yml                     |   2 +-
 opt-linux-latest-5.4.yml                      |   2 +-
 opt-linux-latest-6.1.yml                      |   3 +-
 opt-linux-latest-6.6.yml                      |   3 +-
 opt-linux-latest.yml                          |   2 +-
 recipes-core/images/demo-image.bb             |  10 +-
 recipes-kernel/linux/files/evl.cfg            |   3 +
 ...etail.inc => linux-xenomai-3-dovetail.inc} |   2 +-
 recipes-kernel/linux/linux-xenomai-3.inc      |  25 +++
 ...enomai_4.19.bb => linux-xenomai-3_4.19.bb} |   2 +-
 ...-xenomai_4.4.bb => linux-xenomai-3_4.4.bb} |   2 +-
 ...enomai_5.10.bb => linux-xenomai-3_5.10.bb} |   2 +-
 ...enomai_5.15.bb => linux-xenomai-3_5.15.bb} |   2 +-
 ...-xenomai_5.4.bb => linux-xenomai-3_5.4.bb} |   2 +-
 ...-xenomai_6.1.bb => linux-xenomai-3_6.1.bb} |   2 +-
 ...-xenomai_6.6.bb => linux-xenomai-3_6.6.bb} |   2 +-
 ...ai_latest.bb => linux-xenomai-3_latest.bb} |   4 +-
 ...i-dovetail.inc => linux-xenomai-4-evl.inc} |   6 +-
 recipes-kernel/linux/linux-xenomai-4.inc      |  16 ++
 recipes-kernel/linux/linux-xenomai-4_6.1.bb   |  14 ++
 recipes-kernel/linux/linux-xenomai-4_6.6.bb   |  14 ++
 .../linux/linux-xenomai-4_latest.bb           |  39 ++++
 recipes-kernel/linux/linux-xenomai.inc        |  26 +--
 ...i-Take-Debian-multiarch-into-account.patch |  40 +++++
 recipes-xenomai/libevl/files/debian/compat    |   1 +
 .../libevl/files/debian/control.tmpl          |  11 ++
 recipes-xenomai/libevl/files/debian/rules     |  19 ++
 recipes-xenomai/libevl/libevl.inc             |  31 ++++
 recipes-xenomai/libevl/libevl_47.bb           |  15 ++
 recipes-xenomai/libevl/libevl_latest.bb       |  25 +++
 recipes-xenomai/libevl/libevl_master.bb       |  17 ++
 recipes-xenomai/libevl/libevl_next.bb         |   1 +
 recipes-xenomai/xenomai/xenomai.inc           |  13 +-
 56 files changed, 627 insertions(+), 85 deletions(-)
 copy ci/{xenomai_next.yml => xenomai_3_next.yml} (91%)
 rename ci/{xenomai_next_compat.yml => xenomai_3_next_compat.yml} (99%)
 rename ci/{xenomai_next.yml => xenomai_4_next.yml} (51%)
 create mode 100644 classes/print-revision.bbclass
 create mode 100644 isar-patches/0001-dpkg-Restore-support-for-replacing-pre-installed-pac.patch
 copy opt-linux-6.6.yml => opt-evl.yml (72%)
 create mode 100644 opt-libevl-latest-release.yml
 create mode 100644 opt-libevl-next.yml
 create mode 100644 recipes-kernel/linux/files/evl.cfg
 copy recipes-kernel/linux/{linux-xenomai-dovetail.inc => linux-xenomai-3-dovetail.inc} (86%)
 create mode 100644 recipes-kernel/linux/linux-xenomai-3.inc
 rename recipes-kernel/linux/{linux-xenomai_4.19.bb => linux-xenomai-3_4.19.bb} (93%)
 rename recipes-kernel/linux/{linux-xenomai_4.4.bb => linux-xenomai-3_4.4.bb} (92%)
 rename recipes-kernel/linux/{linux-xenomai_5.10.bb => linux-xenomai-3_5.10.bb} (76%)
 rename recipes-kernel/linux/{linux-xenomai_5.15.bb => linux-xenomai-3_5.15.bb} (76%)
 rename recipes-kernel/linux/{linux-xenomai_5.4.bb => linux-xenomai-3_5.4.bb} (92%)
 rename recipes-kernel/linux/{linux-xenomai_6.1.bb => linux-xenomai-3_6.1.bb} (76%)
 rename recipes-kernel/linux/{linux-xenomai_6.6.bb => linux-xenomai-3_6.6.bb} (75%)
 rename recipes-kernel/linux/{linux-xenomai_latest.bb => linux-xenomai-3_latest.bb} (97%)
 rename recipes-kernel/linux/{linux-xenomai-dovetail.inc => linux-xenomai-4-evl.inc} (50%)
 create mode 100644 recipes-kernel/linux/linux-xenomai-4.inc
 create mode 100644 recipes-kernel/linux/linux-xenomai-4_6.1.bb
 create mode 100644 recipes-kernel/linux/linux-xenomai-4_6.6.bb
 create mode 100644 recipes-kernel/linux/linux-xenomai-4_latest.bb
 create mode 100644 recipes-xenomai/libevl/files/0001-meson-setup-uapi-Take-Debian-multiarch-into-account.patch
 create mode 100644 recipes-xenomai/libevl/files/debian/compat
 create mode 100644 recipes-xenomai/libevl/files/debian/control.tmpl
 create mode 100755 recipes-xenomai/libevl/files/debian/rules
 create mode 100644 recipes-xenomai/libevl/libevl.inc
 create mode 100644 recipes-xenomai/libevl/libevl_47.bb
 create mode 100644 recipes-xenomai/libevl/libevl_latest.bb
 create mode 100644 recipes-xenomai/libevl/libevl_master.bb
 create mode 120000 recipes-xenomai/libevl/libevl_next.bb

-- 
2.35.3

