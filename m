Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA741FB6
	for <xenomai@lists.linux.dev>; Mon, 13 Feb 2023 07:41:37 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20230213070117bcb91b01ec53ff5a15
        for <xenomai@lists.linux.dev>;
        Mon, 13 Feb 2023 08:01:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=rDpaoMWOBGsd+jCFGQzB4dWBYHgilNHg/aQFI3tIw9I=;
 b=ObYLPt7WCxfbPEkky7OidmMwu9nE6qcquIK+a6ARnTSVYmoDeompiTotz5oUF1o6QCRDi+
 Gff2PCIC5QcqiFs7ZWu5/R2sS6KxJe4PvJvsTTAccp1jMwztqiL29sRfiUrXIyMYWLO4ssb+
 jJB3jcWYUIldgp+RsRSg+Iq6rjbrc=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 0/7] LTS kernel 6.1, kernel 5.2 for 3.2.x, Isar update to bitbake 2.0
Date: Mon, 13 Feb 2023 08:01:09 +0100
Message-Id: <cover.1676271676.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

This adds the now available dovetail LTS branch for kernel 6.1 to the
xenomai-next builds. Furthermore, it enables 5.15 for 3.2-head which
just gained support for it. And finally, Isar is updated and the layer
is adjusted to bitbake 2.0 syntax changes.

Jan

Jan Kiszka (7):
  linux-xenomai: Move S assignment into common include
  linux-xenomai: Factor out linux-xenomai-dovetail.inc
  Add kernel 6.1 recipe and kas files
  ci: Hook up kernel 6.1
  Kconfig: Enable kernel 5.15 for xenomai 3.2 head
  ci: Add kernel 5.15 to Xenomai 3.2 pipeline
  Update Isar after bitbake 2 switch

 Kconfig                                       | 14 +++-
 ci/kernel_6_1.yml                             | 82 +++++++++++++++++++
 ci/xenomai_3_2_x.yml                          |  3 +-
 ci/xenomai_next.yml                           |  1 +
 conf/machine/hikey.conf                       |  2 +-
 conf/machine/qemu-machine.inc                 |  2 +-
 kas.yml                                       |  2 +-
 opt-ci.yml                                    |  6 +-
 opt-linux-6.1.yml                             | 17 ++++
 opt-linux-latest-6.1.yml                      | 18 ++++
 ...mai_5.15.bb => linux-xenomai-dovetail.inc} |  3 -
 recipes-kernel/linux/linux-xenomai.inc        |  4 +-
 recipes-kernel/linux/linux-xenomai_4.19.bb    | 14 ++--
 recipes-kernel/linux/linux-xenomai_4.4.bb     | 12 ++-
 recipes-kernel/linux/linux-xenomai_5.10.bb    |  7 +-
 recipes-kernel/linux/linux-xenomai_5.15.bb    |  7 +-
 recipes-kernel/linux/linux-xenomai_5.4.bb     | 14 ++--
 recipes-kernel/linux/linux-xenomai_6.1.bb     | 14 ++++
 recipes-kernel/linux/linux-xenomai_latest.bb  | 17 ++--
 recipes-xenomai/xenomai/xenomai.inc           |  2 +-
 20 files changed, 184 insertions(+), 57 deletions(-)
 create mode 100644 ci/kernel_6_1.yml
 create mode 100644 opt-linux-6.1.yml
 create mode 100644 opt-linux-latest-6.1.yml
 copy recipes-kernel/linux/{linux-xenomai_5.15.bb => linux-xenomai-dovetail.inc} (86%)
 create mode 100644 recipes-kernel/linux/linux-xenomai_6.1.bb

-- 
2.35.3

