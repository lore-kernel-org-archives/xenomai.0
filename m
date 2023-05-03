Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9C1D2F2
	for <xenomai@lists.linux.dev>; Wed,  3 May 2023 12:10:17 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20230503121008e60aeba196f872f99a
        for <xenomai@lists.linux.dev>;
        Wed, 03 May 2023 14:10:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=i9bcb5TeXr4HVtzKZ7CzJn56lZmIe1VyQV8sq3JvpAs=;
 b=hfzOpMJJlB4cLSft2A6kXGWGjJ9YMm2E1nB+f97VPBL3TxQMkg+jxkH0RELr7vD69C7FPL
 TUfqAIT0KcEu+QukGB4u8GLWBtMj2q1vOsAlTzsA3JcEVaO0Hiz11zKloAA0jjs+g7Km6KfZ
 jjGKgbzTjzgBkaCOJCHsbgdfQe3bw=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH xenomai-images 0/4] Lift the base distribution to Debian
 bookworm
Date: Wed, 03 May 2023 14:10:01 +0200
Message-Id: <20230503-flo-debian-bookworm-update-v1-0-6a4aa9e4d95f@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABlPUmQC/x2Nyw6CMBAAf4Xs2U1qkcb4K8bDtl1gYx+kBSUh/
 LuNx5nDzAGVi3CFR3dA4Y9UyanB9dKBmylNjOIbg1a6V4PqcQwZPVuhhDbn9zeXiNviaWW8aXM
 3NBh2xkALWKqMtlByc0ukLYQml8Kj7P/jE3ZOOZKgRJqaep3nD+9LjvmRAAAA
To: jan.kiszka@siemens.com, xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Debian 12, code name Bookworm, will be released on June 10th 2023. 
See [1] for the official announcement.

I tested xenomai-images on bookworm for several months now. The main
reason was a recent glibc in bookworm which allows me to enable y2038
support in applications. This is a pre-condition for testing and
enabling y2038 support for Xenomai itself.

The remaining y2038 stuff is currently waiting in [2]. With this series
applied we have reached another mile stone: Prepare the test environment
(xenomai-images) for y2038 enablement.

[1] https://lists.debian.org/debian-devel-announce/2023/04/msg00007.html
[2] https://gitlab.com/Xenomai/xenomai-hacker-space/-/tree/florian/y2038

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Florian Bezdeka (4):
      ci: Update kas to 3.2.3
      xenomai-demo: Switch base distribution to Debian bookworm
      customizations: Mask systemd-network-generator service
      customizations: Migrate from ifup to systemd-networkd

 README.md                                         |  2 +-
 ci/gitlab-ci-base.yml                             |  4 ++--
 conf/distro/xenomai-demo.conf                     |  6 +++---
 recipes-core/customizations/customizations.bb     |  8 ++++----
 recipes-core/customizations/files/ethernet        | 19 -------------------
 recipes-core/customizations/files/postinst        |  2 ++
 recipes-core/customizations/files/primary.network |  5 +++++
 7 files changed, 17 insertions(+), 29 deletions(-)
---
base-commit: f20791525153c50c16b598127e7fc9d577c8e679
change-id: 20230503-flo-debian-bookworm-update-42686a56ec66

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

