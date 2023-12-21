Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699B055E77
	for <xenomai@lists.linux.dev>; Thu, 21 Dec 2023 16:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="HGm4/roW"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2023122116381930b87015cd8e779b1e
        for <xenomai@lists.linux.dev>;
        Thu, 21 Dec 2023 17:38:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=EIA5gWw6pZwl0EvoA9CTQRraOADgJ/jPctQop8Fms7w=;
 b=HGm4/roWhUtH68lbV1TwqoONyxEQ3l+pXd6LP0f5JZyNkfddJHjNevBFMIubK+rcfEhyCn
 zAfYL2/FK7vxaLfPnvGuYsqlTK6UGAM5Lsv9D3o2iywRjD4/OWc+wV580IWg56XzFMcTQDrp
 phU8DDn9CsSoUalnJ/CyTdE/cidGw=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev,
	rpm@xenomai.org
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [xenomai-images][PATCH v2 0/7] Add evl support to xenomai-images
Date: Thu, 21 Dec 2023 17:37:36 +0100
Message-Id: <20231221163743.2923801-1-clara.kowalsky@siemens.com>
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

this is the second version of the series for adding xenomai-4/evl build support to xenomai-images.
Thank you Jan for your comments so far.

Best regards,
Clara

Clara Kowalsky (7):
  linux-xenomai: Rename linux-xenomai to linux-xenomai-3
  xenomai-3: Mark xenomai 3 specific configs
  xenomai-4: Enable kernel build
  xenomai-4: Add evl userspace
  ci: Rename xenomai 3 files
  ci: Add xenomai-4 test cases
  kconfig: Add build options for evl

 .gitlab-ci.yml                                | 14 ++++-
 Kconfig                                       | 62 +++++++++++++++++++
 ci/xenomai_3_1_x.yml                          |  2 +-
 ci/xenomai_3_2_x.yml                          |  8 +--
 ...nel_4_19.yml => xenomai_3_kernel_4_19.yml} |  0
 ...nel_5_10.yml => xenomai_3_kernel_5_10.yml} |  0
 ...nel_5_15.yml => xenomai_3_kernel_5_15.yml} |  0
 ...ernel_5_4.yml => xenomai_3_kernel_5_4.yml} |  0
 ...ernel_6_1.yml => xenomai_3_kernel_6_1.yml} |  0
 ci/{xenomai_next.yml => xenomai_3_next.yml}   |  8 +--
 ...t_compat.yml => xenomai_3_next_compat.yml} |  0
 ci/xenomai_4_kernel_6_1.yml                   | 17 +++++
 ci/xenomai_4_kernel_6_6.yml                   | 17 +++++
 ci/xenomai_4_master.yml                       | 20 ++++++
 ci/xenomai_4_next.yml                         | 20 ++++++
 ci/xenomai_4_r46.yml                          | 20 ++++++
 ci/xenomai_4_stable.yml                       | 20 ++++++
 conf/distro/include/xenomai-version.inc       |  2 +-
 conf/distro/xenomai-demo.conf                 |  3 +-
 opt-libevl-master.yml                         | 19 ++++++
 opt-libevl-next.yml                           | 20 ++++++
 opt-libevl-r46.yml                            | 19 ++++++
 opt-libevl-stable.yml                         | 19 ++++++
 opt-linux-4.19.yml                            |  2 +-
 opt-linux-4.4.yml                             |  2 +-
 opt-linux-5.10.yml                            |  2 +-
 opt-linux-5.15.yml                            |  2 +-
 opt-linux-5.4.yml                             |  2 +-
 opt-linux-6.1.yml                             |  2 +-
 opt-linux-latest-4.19.yml                     |  2 +-
 opt-linux-latest-4.4.yml                      |  2 +-
 opt-linux-latest-5.10.yml                     |  2 +-
 opt-linux-latest-5.15.yml                     |  2 +-
 opt-linux-latest-5.4.yml                      |  2 +-
 opt-linux-latest-6.1.yml                      |  2 +-
 opt-linux-latest.yml                          |  2 +-
 opt-xen4-linux-latest-6.1.yml                 | 18 ++++++
 opt-xen4-linux-latest-6.6.yml                 | 18 ++++++
 opt-xenomai-3.0.x.yml                         |  2 +
 opt-xenomai-3.1.x.yml                         |  2 +
 opt-xenomai-3.2.x.yml                         |  2 +
 opt-xenomai-next.yml                          |  2 +
 recipes-core/images/demo-image.bb             | 10 +--
 recipes-kernel/linux/files/xen4.cfg           |  3 +
 ...etail.inc => linux-xenomai-3-dovetail.inc} |  2 +-
 recipes-kernel/linux/linux-xenomai-3.inc      | 33 ++++++++++
 ...enomai_4.19.bb => linux-xenomai-3_4.19.bb} |  2 +-
 ...-xenomai_4.4.bb => linux-xenomai-3_4.4.bb} |  2 +-
 ...enomai_5.10.bb => linux-xenomai-3_5.10.bb} |  2 +-
 ...enomai_5.15.bb => linux-xenomai-3_5.15.bb} |  2 +-
 ...-xenomai_5.4.bb => linux-xenomai-3_5.4.bb} |  2 +-
 ...-xenomai_6.1.bb => linux-xenomai-3_6.1.bb} |  2 +-
 ...ai_latest.bb => linux-xenomai-3_latest.bb} |  4 +-
 recipes-kernel/linux/linux-xenomai-4.inc      | 24 +++++++
 recipes-kernel/linux/linux-xenomai-4_6.1.bb   | 14 +++++
 recipes-kernel/linux/linux-xenomai-4_6.6.bb   | 14 +++++
 recipes-kernel/linux/linux-xenomai.inc        | 19 ------
 recipes-xenomai/libevl/files/debian/compat    |  1 +
 .../libevl/files/debian/control.tmpl          | 10 +++
 recipes-xenomai/libevl/files/debian/rules     |  7 +++
 recipes-xenomai/libevl/libevl_master.bb       | 47 ++++++++++++++
 recipes-xenomai/libevl/libevl_next.bb         |  1 +
 recipes-xenomai/libevl/libevl_r46.bb          | 46 ++++++++++++++
 recipes-xenomai/libevl/libevl_r47.bb          |  1 +
 64 files changed, 551 insertions(+), 57 deletions(-)
 rename ci/{kernel_4_19.yml => xenomai_3_kernel_4_19.yml} (100%)
 rename ci/{kernel_5_10.yml => xenomai_3_kernel_5_10.yml} (100%)
 rename ci/{kernel_5_15.yml => xenomai_3_kernel_5_15.yml} (100%)
 rename ci/{kernel_5_4.yml => xenomai_3_kernel_5_4.yml} (100%)
 rename ci/{kernel_6_1.yml => xenomai_3_kernel_6_1.yml} (100%)
 rename ci/{xenomai_next.yml => xenomai_3_next.yml} (66%)
 rename ci/{xenomai_next_compat.yml => xenomai_3_next_compat.yml} (100%)
 create mode 100644 ci/xenomai_4_kernel_6_1.yml
 create mode 100644 ci/xenomai_4_kernel_6_6.yml
 create mode 100644 ci/xenomai_4_master.yml
 create mode 100644 ci/xenomai_4_next.yml
 create mode 100644 ci/xenomai_4_r46.yml
 create mode 100644 ci/xenomai_4_stable.yml
 create mode 100644 opt-libevl-master.yml
 create mode 100644 opt-libevl-next.yml
 create mode 100644 opt-libevl-r46.yml
 create mode 100644 opt-libevl-stable.yml
 create mode 100644 opt-xen4-linux-latest-6.1.yml
 create mode 100644 opt-xen4-linux-latest-6.6.yml
 create mode 100644 recipes-kernel/linux/files/xen4.cfg
 rename recipes-kernel/linux/{linux-xenomai-dovetail.inc => linux-xenomai-3-dovetail.inc} (86%)
 create mode 100644 recipes-kernel/linux/linux-xenomai-3.inc
 rename recipes-kernel/linux/{linux-xenomai_4.19.bb => linux-xenomai-3_4.19.bb} (93%)
 rename recipes-kernel/linux/{linux-xenomai_4.4.bb => linux-xenomai-3_4.4.bb} (92%)
 rename recipes-kernel/linux/{linux-xenomai_5.10.bb => linux-xenomai-3_5.10.bb} (76%)
 rename recipes-kernel/linux/{linux-xenomai_5.15.bb => linux-xenomai-3_5.15.bb} (76%)
 rename recipes-kernel/linux/{linux-xenomai_5.4.bb => linux-xenomai-3_5.4.bb} (92%)
 rename recipes-kernel/linux/{linux-xenomai_6.1.bb => linux-xenomai-3_6.1.bb} (76%)
 rename recipes-kernel/linux/{linux-xenomai_latest.bb => linux-xenomai-3_latest.bb} (97%)
 create mode 100644 recipes-kernel/linux/linux-xenomai-4.inc
 create mode 100644 recipes-kernel/linux/linux-xenomai-4_6.1.bb
 create mode 100644 recipes-kernel/linux/linux-xenomai-4_6.6.bb
 create mode 100644 recipes-xenomai/libevl/files/debian/compat
 create mode 100644 recipes-xenomai/libevl/files/debian/control.tmpl
 create mode 100755 recipes-xenomai/libevl/files/debian/rules
 create mode 100644 recipes-xenomai/libevl/libevl_master.bb
 create mode 120000 recipes-xenomai/libevl/libevl_next.bb
 create mode 100644 recipes-xenomai/libevl/libevl_r46.bb
 create mode 120000 recipes-xenomai/libevl/libevl_r47.bb

-- 
2.39.2

