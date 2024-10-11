Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290BE20A5E2
	for <xenomai@lists.linux.dev>; Fri, 11 Oct 2024 08:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728636682; cv=none; b=QUf5I2YeCCp1OjRHVrrkSyv++zQcbKEU6+a/aY9ft4yQoX8ZR1BaaRFjZNNDZKoBdcQfgZiPda4gBePySezON6GkoQl+n8YTo7VTMZANzHc1CCuZZo/KzxHOFQEo47WthN5NYoNVO80Dil86GNtWByfUK5f9YUeWzqDw2a0fDVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728636682; c=relaxed/simple;
	bh=Nhw3+rFzYehUKw3ARjpzxzx4VqYU10dNUxWqUHbiJnY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hOY7ihf4KuqZpZQoLmmaWXpfNifpQ4NAg002Dv/vPsvHFrY43KliCssmWMjGHpQTCq2SNzrCCgf9KNCmophgU9GO4YKUOS/gDbYCuWIVhvukh6X1id3PKINNWKtESrQqL0YezKN4NjNzq2FwZg1psErVsZyx7WQ1vTuEvxhsLzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=FSfhoMTY; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="FSfhoMTY"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2024101108511620971c311b217ffca8
        for <xenomai@lists.linux.dev>;
        Fri, 11 Oct 2024 10:51:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=O9ZQhEQhWEF3fAhorqyVXFpYnK2o1l8g3c/Ko3RD89I=;
 b=FSfhoMTYa4KUmlj9muSgYRHCnqsg3uqf4nG9LsCdge8V3gNcCJjGpuuVv7EYlk5rQdUn8i
 fnPnS7MS6a0Ie4CSHpIQGbo7eHIcbbrwfixwrK6RwR/YT5qcIwj2C2tfDXYu8N/6QdpYd/Kl
 tEj21OrZj1zNQ5Hwqg/w1441pXXqQBpPsu/Uxb8CgZz9ipzFr9yxVJ6EBztqElgI3OU0KhBo
 +jsiQHATCZNWO74dXa9u+LFLKJoGVI5hv67d8DXcwcK06Gf07bksLxFUssI98fisgIKVYXAT
 MJA96/sw+5RsyEgLr+aAfxGbHSVhE5Wdc9kyrmSuXbP7y7l1/bSQ4Fgw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v3 0/4] Preparations for Debian 13 / Trixie
Date: Fri, 11 Oct 2024 10:51:14 +0200
Message-Id: <20241011-flo-cleanup-y2038-v3-0-2657330fad19@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAALnCGcC/4WNyw7CIBQFf6VhLeYCfenK/zAugF4sSQsNWGLT9
 N+l3bnR5ZzkzKwkYrAYybVYScBko/UugzgVRPfSPZHaLjPhwEsGjFEzeKoHlG6e6MJBtLRGIUy
 jZQ21JPmnZESqgnS6z083D0Mep4DGvo/Q/ZG5t/Hlw3J0E9vXX4nEKNBSVQqgaU0u3aLFEV08a
 z+S3Zf4XwfPDkADXcW1uWj27di27QMx/KT5DQEAAA==
To: xenomai@lists.linux.dev
Cc: Jan Kisza <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

as we are already in the preparation phase for a new release I took the
task to clarify that the upcoming release is in a good shape regarding
the upcoming Debian 13 next year.

As it turned out a couple of minor issues had to be addressed to make
the upcoming release ready for glibc and compilers shipped by Debian 13.

The y2038 implementation needs a couple of fixes due to changes made in
glibc. For some reason they decided to change __USE_TIME_BITS64 macro.
The commit that introduced the change is linked in the following
patches.

Testing on Debian 13 was done manually so far, Debian 12 was covered by
internal CI runs.

Best regards,
Florian

Cc: Jan Kisza <jan.kiszka@siemens.com>

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Changes in v3:
- Integrated review comments, harmonized libc macro usage
- Link to v2: https://lore.kernel.org/r/20241011-flo-cleanup-y2038-v2-0-0ef0d52cf9c1@siemens.com

Changes in v2:
- Seems it's too late for configuring b4 correctly... Lost one patch...
- Link to v1: https://lore.kernel.org/r/20241011-flo-cleanup-y2038-v1-0-4b5b0078fa60@siemens.com

---
Florian Bezdeka (4):
      y2038: lib/cobalt: select: Fix compile failure observed on Debian 13
      y2038: lib/cobalt: Fix link failure observed on Debian 13
      y2038: lib/cobalt: vdso: Fix runtime error detected on Debian 13
      y2038: testsuite/clocktest: Fix link compile error observed on Debian 13

 configure.ac                                   | 3 ++-
 include/cobalt/wrappers.h                      | 3 ++-
 lib/cobalt/arch/x86/include/asm/xenomai/time.h | 2 +-
 lib/cobalt/select.c                            | 7 ++++++-
 testsuite/clocktest/clocktest.c                | 2 +-
 5 files changed, 12 insertions(+), 5 deletions(-)
---
base-commit: 86c4592bee073d6bcd21b16dbd13b0d60af202dc
change-id: 20241011-flo-cleanup-y2038-6e33f7ca606a

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

