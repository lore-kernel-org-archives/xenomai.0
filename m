Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF231DEFF5
	for <xenomai@lists.linux.dev>; Wed, 13 Nov 2024 14:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731508408; cv=none; b=mPJJXDoCj31rFD19djPOxy2lRlQdJU1ljRoE1qv7pZ5DWgwDo/zOnSmLHgqbegdjcmskCIlRWo8GH5+aNQbGT3Ki/qWaI7vnsoS1WUVjH/qCfn4adOHqgCMU6Ok8jXVhP18t2wm7d/voIC8yo/2satBSk5NlqqchQOh79d9fyxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731508408; c=relaxed/simple;
	bh=OlY7anIPe1DOhS1Gw8mITBVtYTfGl7trMT8S8yoR0SE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QvMRXx/TYVkSlNqBOMA3xCuqjMVx5rf1tyX6cXdxkreIeFhpry5IlJ0WJpgsP4JO6Tap3ayhlJOA4VFavuWk0EidYIkVxkMr/nP+DsaRahBbiZOCMICno0C4PObG1UfFoKLR4gEdTH/0x0Mao4HPZzZQK0wUW31fxeeKNWBRcT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=Gc3GqWEo; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="Gc3GqWEo"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20241113143314f5a2fac8055976d1d5
        for <xenomai@lists.linux.dev>;
        Wed, 13 Nov 2024 15:33:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=IWMxQENtv+hFsy/CV6xuILiy/56nOVJtOMDhwgcGQM8=;
 b=Gc3GqWEoLw6nzb4MaWRsQ8ONmvWlawzUIvbZZpsPKllKJeTw9Eo6dA+Kjca+69qfHJ8AqQ
 2E/W5EVmD0Du72ZFEEmorBSTUZE0Lpf5mv6ogq51FQ71hTjeBbwZkjsEcWc/vDQga5gBmv6z
 iTMTl5yshRL2/bSyZVR1cysBMm//CJCPRjOhIYNr/nm8zKSxyQRAy/yAeLvV4aSIa5ArLACZ
 hKUr7pDkQ8xajYooTiCPxJToMoSsCM8bxASdQOnvAuVhrwrxttGbqqBELokypV3r0pH3Bn4P
 VHhG5v59t39o4L0t1PitMn7YrWjS0NzCx7akHdIBFhaA6UfYRx1QOwIw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [xenomai-images][PATCH 0/2] Switch to self-built container images for lava test jobs
Date: Wed, 13 Nov 2024 15:33:11 +0100
Message-ID: <cover.1731508393.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

Saves bits (and money), speeds up test job starts, avoids current
snapshot.d.o issues.

Jan

Jan Kiszka (2):
  ci: Add scheduled job to build lavacli container
  ci: Switch test job container to self-built one

 .gitlab-ci.yml             | 14 +++++++++++++-
 ci/Dockerfile.lavacli      | 17 +++++++++++++++++
 ci/gitlab-ci-base.yml      |  2 +-
 scripts/install-lavacli.sh | 23 -----------------------
 4 files changed, 31 insertions(+), 25 deletions(-)
 create mode 100644 ci/Dockerfile.lavacli
 delete mode 100755 scripts/install-lavacli.sh

-- 
2.43.0

