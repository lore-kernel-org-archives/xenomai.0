Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F87301717
	for <xenomai@lists.linux.dev>; Mon, 16 Feb 2026 10:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771239542; cv=none; b=lRwj2PsIRKyc3SYsEdoaMQL+RWmPr7/RbT7EBiIHXcOC2lyX66h0va22NZ6iPzWcmxm+y7JCHX98aYafdUcgsbJgCpDYGHX26nE3Ip1r/gEohScLzOyl/9K18reUcRYY5WiAmMJU1NFZZfkAXPEyx3RzGmfBoyZO6ceNWHA8+L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771239542; c=relaxed/simple;
	bh=G20pmAXMJb+Uabh0A9indpyRvn/AZikbvW1tT5iE+B0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uj2y8KtP+ZkjJ6ZFCYy1hFULMQ2LW5Q/MS0xmRPkhLHi6J5NfmBunpO6S5P+gsknFbQHAeB2AwDqInyAJqVZoTHbLiK528SzPPggRvSFOZ4U3/Wz4ALqBrQMktvihLdCrKPgj6iBUuTj+KBxs6SK/C0+s+yDHAITB2GiSWj1rQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=JZ3u8qKA; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="JZ3u8qKA"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202602161058568d9aec9004000207a8
        for <xenomai@lists.linux.dev>;
        Mon, 16 Feb 2026 11:58:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=ltqRTd9SmxPtU090DwnlKMQ8OZNQF1YsYA50fScG3Ws=;
 b=JZ3u8qKAqw7kCKAVUWwXTPIAUF8SwWD9YbMElACpbab63XMYFWoHULCmoYnVUQjpLHF7tI
 spzqOQHKeLoAv6dg1/dwvyl020qbWDpu4ryc7carbrCF3yhD9xOLwO6EhXM3VtcPP/dYr8ah
 2XidF17NgQ9bwdGDMHcCl/pm1IT1KiJBh88UzctLsopMiqH6GrjhJ/wZL1pQQAsOnXlNomXE
 JzotVxB3mz1ZwFINR4SccRCjJy3UyTdneuP4CW9OZUchvgH4rUMabxmOFaLHq9cHris/mHmd
 VJ35Xfy5w3uFCWnTple03IoQMZM0XxghuNV5O/sTNzy/lO59BLgS4rLw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 0/3] Prepare for Dovetail 6.19
Date: Mon, 16 Feb 2026 11:58:50 +0100
Message-Id: <20260216-wip-flo-prepare-for-6-19-v1-0-f7362cdd2532@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGr4kmkC/x2MQQqAMAzAviI9W3BFRf2KeJiu04K40YEK4t8dH
 gNJHkiswgmG4gHlU5KEI4MpC1g2e6yM4jIDVdRWZAgviej3gFE5WmX0QbFF02Pn3ezqpemIGsh
 5Frzc/3qc3vcDeFo6y2oAAAA=
X-Change-ID: 20260212-wip-flo-prepare-for-6-19-8fdbd4c58225
To: Xenomai <xenomai@lists.linux.dev>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

This are the necessary changes required for being able to build Xenomai
against the latest Linux / Dovetail versions.

Dovetail 6.19 is currently in the making and already build / tested
against this series. Without this changes the build will simply fail.

To: Xenomai <xenomai@lists.linux.dev>
Cc: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Florian Bezdeka (3):
      cobalt: Prepare for new signature of __request_percpu_irq() in 6.19
      cobalt/rtdm: Prepare for new signature of mm_get_unmapped_area() in 6.19
      testsuite/switchtest: Add support for Dovetail >= 6.19

 include/cobalt/kernel/dovetail/pipeline/irq.h      | 20 ++++++++++
 include/cobalt/kernel/dovetail/pipeline/pipeline.h | 10 ++---
 include/cobalt/kernel/dovetail/pipeline/sirq.h     |  8 ++--
 .../cobalt/arch/arm/include/asm/xenomai/fptest.h   | 26 ++++---------
 .../cobalt/arch/arm64/include/asm/xenomai/fptest.h | 43 ++++++++++++++++++----
 .../cobalt/arch/x86/include/asm/xenomai/fptest.h   | 41 ++++++++++++---------
 kernel/cobalt/dovetail/tick.c                      |  8 ++--
 kernel/cobalt/rtdm/drvlib.c                        |  8 +++-
 kernel/drivers/testing/switchtest.c                | 19 +++-------
 9 files changed, 108 insertions(+), 75 deletions(-)
---
base-commit: 17c4af4566be4e6313036251e2c2973348537393
change-id: 20260212-wip-flo-prepare-for-6-19-8fdbd4c58225

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

