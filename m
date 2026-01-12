Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E3E25A334
	for <xenomai@lists.linux.dev>; Mon, 12 Jan 2026 12:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768219755; cv=none; b=FfEFnuF8WUvbm24gq76p/KwwvD3w2VsSNrs/9qoZ0/BxxHrCT1QPYph/evGNpbI8Gox7HVy0g8hdQ5++xz/hxa5DZVRCe7737nM+Skp3vGDSHqYVwLrQtC++3W0kstVWOJRm7NbUmavh17dZzYiYnf5V2NE4anfzf4fKIq2MoMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768219755; c=relaxed/simple;
	bh=vWkLagodg8uT7HhRuJhbtFlOm3iGurX2bo/0b9lcyjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uwWjU74F3Q+wtoHzO8HdUmdUQz0Zhz9UmCrpKDjhTDud+uFllrVALYrnh4jqtGWOvCNyFWoBrEQCZHLcXFr/0HdsqxODqkB/ALbpNBc7UEoaj9UXmttNVDVelQXtZMYv8TgZgKrTOX1qbHsltFA/n+qy1QE3Fn1x3ievCSmHVsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=Wh8+3Y2R; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="Wh8+3Y2R"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202601121209029002fdc99700020755
        for <xenomai@lists.linux.dev>;
        Mon, 12 Jan 2026 13:09:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=UDwUAdFQfZNw7fpiiah5gOQ0DauycaLDXb2S8dubkqs=;
 b=Wh8+3Y2Rrff/zVkvrfyZ7xxuDEUoJY+eOQp5eGn/vxrsk50OpihxSxo82andE5TOkACynk
 J/bxUczttORcaGf+qSoiv6ls2ku1iK91E+GQaoR4ORiZ8H6N0n+ahP72geBfH7+4iup9gzM3
 8oRrUbX2Mw3bD0IPHbl9tI1GBojMbaYTrRRsN3MWDSW0GX4TVWyCBhO88rideoYgdi3tbJnu
 WmNR8BOOhoEoc9J45W3gw/CQMdfqo5YrqoCDpC3XfbC5dxqA2HTaVhbvzqFWbXYOnUi/tGd7
 IQpxump4cLt2lQkxWWffNqjuavq49AMneX+ediCSfFjP1HYtla/9b22g==;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [xenomai-images][PATCH v2 0/3] Trigger CI job for dovetail
Date: Mon, 12 Jan 2026 13:08:53 +0100
Message-ID: <20260112120856.3912990-1-clara.kowalsky@siemens.com>
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

