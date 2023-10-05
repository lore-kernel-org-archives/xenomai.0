Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6299D7479
	for <xenomai@lists.linux.dev>; Thu,  5 Oct 2023 08:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="DpHyzXOX"
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202310050850041c04d5904f572d6b11
        for <xenomai@lists.linux.dev>;
        Thu, 05 Oct 2023 10:50:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=uuXOv0/rHrF9cS1MU5yUy01tciqtfFxzv/RG4dq6G+w=;
 b=DpHyzXOXtZpju0viHEqR3zHh7FmkARxq6KCRK13XiqoHbVVT16RgTKYvIrOMJO1lyfNA98
 woMo/l15Kcmq0mzhme38CKHg4PzyyeCpW6rMdl/FUoDOqvDE9apyZSY/AAyz3yd/lhP8j4FG
 F1vgp7yuYe0PKcEuc1XPPXoymYuy0=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 0/2] Use Debian bookworm for CI build jobs
Date: Thu, 05 Oct 2023 10:50:02 +0200
Message-Id: <20231005-flo-ci-to-bookworm-v1-0-c0455488879a@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALp4HmUC/x2NywrCMBAAf6Xs2YU0aor+ivSQx8YuxqxsfEHpv
 xs8zsAwKzRSpgbnYQWlNzeW2mHcDRAXX6+EnDqDNXY/GnPEXAQj41MwiNw+onc8pclNNrnsDhZ
 6GHwjDOprXHpaX6V0+VDK/P2fLvO2/QACsMNceQAAAA==
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

Disclaimer: This series is completely untested. I have no infrastructure
at hand to test modifications to .gitlab-ci.yml. The Xenomai
hackerspace hosted on gitlab.com is unable to execute CI jobs
(currently).

The series does two things:
  - Move from Debian bullseye to Debian bookworm for all build jobs
  - Add one more build job to still cover building against libc versions 
    that do not provide y2038 support for 32 bit applications.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Florian Bezdeka (2):
      ci: Switch to Debian bookworm
      ci: Add build test for older glibc where y2038 support is not available

 .gitlab-ci.yml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)
---
base-commit: aaea684b95331336f0a04b9d15f8f24552e64d7d
change-id: 20231005-flo-ci-to-bookworm-9d7672d6f642

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

