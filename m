Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864222F44
	for <xenomai@lists.linux.dev>; Thu, 27 Apr 2023 14:32:17 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202304271432140272471db63abc0906
        for <xenomai@lists.linux.dev>;
        Thu, 27 Apr 2023 16:32:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=QubP26bNTGIvUBOJvDEA1izu67krlhH1Zl6O4z1HEOE=;
 b=VaMsjBdpIOgk0VRGJXMkEoOKRd5v8KPiYbamqPfPLymbRkTexVYY9aGyKbdaF0WFv8Ibis
 cpkEL3opi0ix/JKm4HKcRh8YFrm/J+8SfmLVy9MdbFSz4Wyb2eh3SJ6VraTHghJYT/QDKYUG
 zgzgikM84b0V7UGidOhOvEfniLENo=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 0/2] debian: Move testsuite (smokey) into a separate
 package
Date: Thu, 27 Apr 2023 16:32:09 +0200
Message-Id: <20230426-florian-debianization-extract-testsuite-v1-0-0a957cde7b74@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGmHSmQC/52OzW7CMBCEXwX53K1sk4TCqe9RcfDPhKwUHOQ1E
 RDl3Wu49VhOq2+k/WYWJcgMUYfNojJmFp5SBfOxUWFw6QTiWFlZbbe6sR3145TZJYrw9fDDlfp
 BuJXsQqECKXLlAtqHoFvYztudVtXmnYB8dikM1Zeu41jDS0bPt1f9z7HywFKmfH+tmc0z/X/xb
 EhT0zVbmBhD0+JbGGck+QzT+bnkPSM6o+Puq98j+D/G47quv2BhHRBHAQAA
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Moving the testsuite into its own package allows to minimize the xenomai
footprint on production systems. Previously the testsuite was part of the 
xenomai-runtime package which had some limitations. For example the gdb
dependency was skipped to keep production systems clean.

With that series applied the xenomai-images build for next/master will
fail. Necessary patches will follow soon and need to be applied in
lockstep with this series.

Note: I'm now using b4 to keep track of patch series versioning, cover
letter creation and sending out patches. Especially the layout/content
of the cover letter is now slightly different. Let me know if there is a
problem somewhere.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Florian Bezdeka (2):
      lib/boilerplate: Do not remove $(DESTDIR)$(libdir)/xenomai on uninstall
      debian: Extract xenomai tests into separate package (xenomai-testsuite)

 debian/control                   | 18 +++++++++++++++---
 debian/libxenomai-dev.install    |  1 +
 debian/rules                     |  2 --
 debian/xenomai-runtime.install   |  8 ++++++--
 debian/xenomai-testsuite.install |  2 ++
 lib/boilerplate/init/Makefile.am |  2 +-
 6 files changed, 25 insertions(+), 8 deletions(-)
---
base-commit: f06a2e785900ba0d5da170636b2abf2364eacc15
change-id: 20230426-florian-debianization-extract-testsuite-9cc05e26b270

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

