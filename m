Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B562D04C
	for <xenomai@lists.linux.dev>; Fri, 15 Dec 2023 11:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="FYJUSJ0d"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20231215114446d69b1b272be23855c8
        for <xenomai@lists.linux.dev>;
        Fri, 15 Dec 2023 12:44:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=vqCGZmDpq6DSkKBDjaBO5EB1pMAYlsDF+SVpc5bSy3Y=;
 b=FYJUSJ0d/bqyjbUm0sSiQorbZDY8W3LW9w0YcmN8LnjAWMy9oe0yBldBRBpRvSD/d6SsiG
 mxBI0n5PCV7V7nR0ZF5MtDadTPRyKt0O/HVvkYop8hFsxoAGi5e69Oo7S+WS9ahQI6Ez82S0
 iSYDCk+ljO73RLfYxaedPVW795loE=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev,
	rpm@xenomai.org
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [xenomai-images][PATCH v1 0/5] Add evl support to xenomai-images
Date: Fri, 15 Dec 2023 12:43:44 +0100
Message-Id: <20231215114349.2913803-1-clara.kowalsky@siemens.com>
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

this series adds the possibility to build evl images in xenomai-images based on 
linux-evl v6.1 and v6.6 and libevl.

Best regards,
Clara

Clara Kowalsky (5):
  linux-xenomai: Factor out base.inc
  libevl: Add libevl recipe
  evl: Enable evl image build
  ci: Add evl test
  kconfig: Add build options for evl

 .gitlab-ci.yml                                |    12 +
 Kconfig                                       |    54 +
 ci/evl_kernel_6_1.yml                         |    17 +
 ci/evl_kernel_6_6.yml                         |    17 +
 ci/evl_master.yml                             |    22 +
 ci/evl_next.yml                               |    22 +
 conf/distro/evl-demo.conf                     |    16 +
 opt-libevl-master.yml                         |    17 +
 opt-libevl-next.yml                           |    17 +
 opt-linuxevl-latest-6.1.yml                   |    21 +
 opt-linuxevl-latest-6.6.yml                   |    21 +
 recipes-core/images/base.inc                  |    20 +
 recipes-core/images/demo-image.bb             |    10 +-
 recipes-core/images/evl-image.bb              |    18 +
 recipes-core/libevl/files/debian/changelog    |     5 +
 recipes-core/libevl/files/debian/compat       |     1 +
 recipes-core/libevl/files/debian/control      |    12 +
 recipes-core/libevl/files/debian/rules        |    12 +
 recipes-core/libevl/libevl_0.1.bb             |    44 +
 recipes-kernel/linux/base.inc                 |    28 +
 .../linux/files/evl_amd64_defconfig           | 10618 ++++++++++++++++
 recipes-kernel/linux/linux-evl.inc            |    23 +
 recipes-kernel/linux/linux-evl_6.1.bb         |    14 +
 recipes-kernel/linux/linux-evl_6.6.bb         |    14 +
 recipes-kernel/linux/linux-xenomai.inc        |    16 +-
 25 files changed, 11048 insertions(+), 23 deletions(-)
 create mode 100644 ci/evl_kernel_6_1.yml
 create mode 100644 ci/evl_kernel_6_6.yml
 create mode 100644 ci/evl_master.yml
 create mode 100644 ci/evl_next.yml
 create mode 100644 conf/distro/evl-demo.conf
 create mode 100644 opt-libevl-master.yml
 create mode 100644 opt-libevl-next.yml
 create mode 100644 opt-linuxevl-latest-6.1.yml
 create mode 100644 opt-linuxevl-latest-6.6.yml
 create mode 100644 recipes-core/images/base.inc
 create mode 100644 recipes-core/images/evl-image.bb
 create mode 100644 recipes-core/libevl/files/debian/changelog
 create mode 100644 recipes-core/libevl/files/debian/compat
 create mode 100644 recipes-core/libevl/files/debian/control
 create mode 100755 recipes-core/libevl/files/debian/rules
 create mode 100644 recipes-core/libevl/libevl_0.1.bb
 create mode 100644 recipes-kernel/linux/base.inc
 create mode 100644 recipes-kernel/linux/files/evl_amd64_defconfig
 create mode 100644 recipes-kernel/linux/linux-evl.inc
 create mode 100644 recipes-kernel/linux/linux-evl_6.1.bb
 create mode 100644 recipes-kernel/linux/linux-evl_6.6.bb

-- 
2.39.2

