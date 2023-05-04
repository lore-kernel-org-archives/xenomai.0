Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE414A2E
	for <xenomai@lists.linux.dev>; Thu,  4 May 2023 08:08:55 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20230504075844ab5d70d57b507c750c
        for <xenomai@lists.linux.dev>;
        Thu, 04 May 2023 09:58:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=OEzWT/rCoJQLhkBOkPA46+6pkAQYWC4un95Z+z7KI4A=;
 b=T+FXvUa+zF0S/WnEqNcusbBVIM4RWnmGWeKGWKkGz/X7aQzgrLr3zVoOdSM/FnfEnzexh3
 v5bPpsyHmCKRag2r2t2CzmvSSshx2s1SroQJn79k2nvULejjbRcS0CLvvDWbw9DVxjVYo16H
 amr4K40TUhn9PqqhAfzWNtsXPDbDU=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH xenomai-images v2 0/4] Lift the base distribution to Debian
 bookworm
Date: Thu, 04 May 2023 09:58:38 +0200
Message-Id: <20230503-flo-debian-bookworm-update-v2-0-f859df1417e6@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK5lU2QC/42OQQ6CMBREr0K69hss0Igr72FY/NIP/Ehb0gJiC
 He34QQu581kZnYRKTBF8ch2EWjlyN4lIS+ZaAd0PQGbpIXMZZFXeQHd6MGQZnSgvX9/fLCwTAZ
 nglKqu8JKUauUSAUaI4EO6NohVbhlHBOcAnW8nYsvsZHzFhnYYp9Qk/yB4+zD9zy03s7UP9vrD
 XJQWCLWVJq66p6RyZKL19Zb0RzH8QNeX32r6wAAAA==
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
Changes in v2:
- Flipped order of patches 2 and 3
- Link to v1: https://lore.kernel.org/r/20230503-flo-debian-bookworm-update-v1-0-6a4aa9e4d95f@siemens.com

---
Florian Bezdeka (4):
      ci: Update kas to 3.2.3
      customizations: Mask systemd-network-generator service
      xenomai-demo: Switch base distribution to Debian bookworm
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

