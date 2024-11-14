Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321181F8915
	for <xenomai@lists.linux.dev>; Thu, 14 Nov 2024 12:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731586408; cv=none; b=MDD7GGqHbPlVvH3ABghbEMqWt/FhAFB2dgBRcoo5JBwazypQKupDqO+LKR0FFX9t+Ty97G/B+5eBnmFX4MOEDgNZlb8boEesg/4OEWEexRxlu487NQvg3mbOO7vsZAT2yRSNv9j0K0ihJimABeNmieqmg0PAXfzWDnbyqnTTkPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731586408; c=relaxed/simple;
	bh=GdGLBSTrG5ioXEdk+2iUpcpyQnuh0376tFtjeWcEHjw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X+KnLoXrn9ZYHicXXJ+wJGF0lhZvb/h/13pC4bJMGsd74U/F1GFOg31Feuiq8KrweaY/vCKHQ/LyFljn8vgzXf91xbJprWUcL+HSLKgHRFdyKcV/6oFm9mdzLCzojo91+tjBdf+5U+vtV3/kN0caFkOWPZPGsSudh7lBLFEcaXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=UZjq8MEK; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="UZjq8MEK"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202411141213151df604036afab90284
        for <xenomai@lists.linux.dev>;
        Thu, 14 Nov 2024 13:13:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=0T9XHadyl3bqqafAB1VPZ66tnVMph+GI5xaLoiphro0=;
 b=UZjq8MEKxrXbEeJMc67S88+KHOtefMF03FHTUWBjiibZvSPWwGs4jHtQVfw2eSiD58oZJs
 H8r2LXHllmV8OSxojhFS0lYXBGYeWiG2HwMMkHvK2JvDBcBqSNhSMcjGNbWpsdH1Fo5b0RDZ
 ak5kvd1bz5sARoodx+FylN1vyqyv5kfl4JMA2ca+4k6IhDjj2/+ZeLIw+q1Yx5fKg4bNDDE/
 ere4UNmXDpN3J1ayKlbiDF1AEzDiLaFLzDmLwqliZU/lo0EtNfceKgI+CfOPn1Iab8+F0Z+0
 4kKsc3j+pPzhkR00ZQSDqXyJjGdBD10mUod/P19s1tHviG59YGFn+LJQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [xenomai-images][PATCH v2 0/2] Switch to self-built container images for lava test jobs
Date: Thu, 14 Nov 2024 13:13:12 +0100
Message-ID: <cover.1731586394.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

Changes in v2:
 - add curl to container
 - set default for CONTAINER_REGISTRY
 - document new CI variables

Saves bits (and money), speeds up test job starts, avoids current
snapshot.d.o issues.

Jan

Jan Kiszka (2):
  ci: Add scheduled job to build lavacli container
  ci: Switch test job container to self-built one

 .gitlab-ci.yml             | 15 ++++++++++++++-
 ci/Dockerfile.lavacli      | 17 +++++++++++++++++
 ci/gitlab-ci-base.yml      |  2 +-
 scripts/install-lavacli.sh | 23 -----------------------
 tests/README.md            |  5 +++++
 5 files changed, 37 insertions(+), 25 deletions(-)
 create mode 100644 ci/Dockerfile.lavacli
 delete mode 100755 scripts/install-lavacli.sh

-- 
2.43.0

