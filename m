Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0F4356A0D
	for <xenomai@lists.linux.dev>; Mon, 12 Jan 2026 12:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768221243; cv=none; b=knPWim1hNRX/oUxymgXoNaMpX6J+qMuV5AAvMxM8/6HBcYTLI+MpJ5cEyHIJ5beiOrodjqfxhrMRImxgKO58sUCiutit5brrQVQjUWG515gU+8IR0LHftEgGVunN1g7OZfP51K/PFDrQ7kv+W2yxgRXuzS6QaLpIPwG5Va4hqJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768221243; c=relaxed/simple;
	bh=sJu9MRBdam6azVe6eTC0NzZzJMDpHFCQqnrh9G736ak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y7hlb+XhKjloJpU2awag9/5SoZTvqlFiPfiRMdba67/KX9w3uDPpE0F8VEjHDrbzH0c67soTk/z6Zz57LBVyz0lkPiuFhMwlHFmJ+d4lFlkAamnP9hwJcMqzGt7Ry3qLUfjPQpthazu/OYF+/KOXppIXzWbirmgNM5ZNr1f+h/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=ZV5n0zc/; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="ZV5n0zc/"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260112123356f3f868492300020755
        for <xenomai@lists.linux.dev>;
        Mon, 12 Jan 2026 13:33:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=Hli/9p9OAfuiBQaffte4asV8edBpjO01KbvWyStHtyE=;
 b=ZV5n0zc/QbMPLXSnSlCtpwObTo7FKmxJMJOEy9I6YFAFcvTr8scANxfNF47d2HpNBBonCf
 65rFZ1/4Vskabzecpwb5gFmeZ2CVK7aGawFCxb4W0ETRzbERjwZ/rce/NUPRLK4wtpOz7uv/
 yhxP9ryUk0uV1voKJ3t2sgWt8Vf11cORzhqCAaRGpo3d7uMjDX4dp83M1T6XzFODQfc7+N0S
 ETT54USWRMXHnJwI3u0g9hKuos997JnpJ0K8HKJ3LxhWjrJX3f/8//D1f8m+YAGYVQC+f6G0
 jMvm8qGNeNwQ14aD6n5+l8VxtfkIexh0u3coK6Oinp3mJ1NjPR/hq+6A==;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [xenomai-images][PATCH v3 0/3] Trigger CI job for dovetail
Date: Mon, 12 Jan 2026 13:33:46 +0100
Message-ID: <20260112123349.3945734-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

Hi,

this adds the functionality that if new commits are pushed to dovetail,
the corresponding kernel builds in xenomai-images are triggered.
I tested this for dovetail/v6.12.y-dovetail-rebase and
xenomai-images/next.
Thanks Jan and Florian for your comments in v1.

Changes in v2:
- removed 4.19 handling for now, as suggested
- in ci/ci-dovetail.yml, add a comment that this file is configured as
  CI/CD configuration file of the linux-dovetail repo
- in ci/ci-dovetail.yml, use a debian:trixie-slim image
- add commit to rename LATEST_KERNEL_VERSION to KERNEL_VERSION_WITH_QEMU
- in ci/xenomai_3_dovetail.yml, sort kernel versions and rename
  templates

There was also an issue that the QEMU jobs were not triggered in v1. 
KERNEL_VERSION_WITH_QEMU is now set as pipeline variable, in order to
make sure that the rules in the .build-qemu job are evaluated when
having the variable info available (by setting KERNEL_VERSION_WITH_QEMU
in a template previously, KERNEL_VERSION_WITH_QEMU in the .build-qemu
job was still empty and the QEMU jobs were not triggered).

Changes in v3:
- the v2 had my test branch in ci/ci-dovetail.yml

Best regards,
Clara

Clara Kowalsky (3):
  ci: replace LATEST_KERNEL_VERSION by KERNEL_VERSION_WITH_QEMU
  ci: Add build job for pipeline triggered by linux-dovetail
  ci: Add CI for linux-dovetail

 .gitlab-ci.yml                  |  8 ++++++
 ci/ci-dovetail.yml              | 47 +++++++++++++++++++++++++++++++++
 ci/gitlab-ci-base.yml           |  4 +--
 ci/xenomai_3_3_x.yml            |  2 +-
 ci/xenomai_3_dovetail.yml       | 39 +++++++++++++++++++++++++++
 ci/xenomai_3_next.yml           |  2 +-
 ci/xenomai_3_next_long_term.yml |  2 +-
 ci/xenomai_4_next.yml           |  2 +-
 8 files changed, 100 insertions(+), 6 deletions(-)
 create mode 100644 ci/ci-dovetail.yml
 create mode 100644 ci/xenomai_3_dovetail.yml

-- 
2.52.0

