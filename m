Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29979330311
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 11:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771586875; cv=none; b=WaVNMDcpQAwskKK9wAZ7ZzY2yM2Lu+YlKZxHJhDqWMS4vKAwW9i2hJO4PQoWWUwThS+fqw4/VvIRMuCOj7OpTeYeJ+Ae9+GIy8M8U+HnSxklA7AK/PhRXfj/KiXCYVXux+dQOdeCutJiSHWhA6B1jftaIgDvIcX7ZrXeaGYMNJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771586875; c=relaxed/simple;
	bh=Mn9qkonJI1IGMMpZ7dE5Lzs5DhR5eb2oOoAyA/3vwww=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NfoFCFDQ3bB+uUilFQ4MrKsXdrcg9zhvML4+uqA+g4u4qL1YAZFruydjogZv4i+cu8i33p+RcZbKE0R6LBZq709ZJbdou8I4YLiV2nBf698JOcvmyDlWc2i8MQAuaNwDSIie33Hv0vQjLf383306y6pfB4gUsLbYBATO14ha+lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=X8PopPg8; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="X8PopPg8"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202602201127484b53f73d18000207f2
        for <xenomai@lists.linux.dev>;
        Fri, 20 Feb 2026 12:27:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=qUjmbFUt4GAi00xhBDgDwoRSBVCzG+UVqwATxopSR+c=;
 b=X8PopPg8cKvkPUwvJqhJAQNTuDUUDHqcO6IkfxxAkCcHOFHqXRg0C/HhmVrHlr/+eoTHRY
 tKiCJMyXa+ooBzp4pFhMs5L1MnPoBHvaAjjYJeBHZt4wY8MRnIP1uGQErqFMYHvcoyW1exXU
 dSObsIhx5k6Ge+D4hr7ZDoM4G9tlU6WFTAthb+JHSRUli+bX3Rf723fSqSO6S1siUqIxVv41
 azR0s/BADOXOG8Tuqoq39oEBKQicB2iEe7qyhDaqBN69gCO7qfIL0Odougf8nM/6IfTA8oK5
 EIEjBlWmLNkhYSIM87JVemL9iOFqvxs9NdQY2QUlBP0vZ3YEWgSxWUZw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v2 0/3] Prepare for Dovetail 6.19
Date: Fri, 20 Feb 2026 12:27:47 +0100
Message-Id: <20260220-wip-flo-prepare-for-6-19-v2-0-222effb01976@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADNFmGkC/3WNwQ6CMBBEf4Xs2TV0kYqc/A/DAdutbCK0aQ1qC
 P9uJfHo8U1m3iyQOAonaIsFIs+SxE8ZaFeAGfrpxig2M1BJuiRF+JSA7u4xRA59ZHQ+okZ1wsb
 Zqz2YuiGqIc9zwclrU1+6zIOkh4/v7WlW3/Qn1f+ls8IS3bHSZKyluqJzEh55SnvjR+jWdf0A1
 abo48IAAAA=
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
Changes in v2:
- Rework patch 1, switch to cobalt specific API for newer kernels 
- Link to v1: https://lore.kernel.org/r/20260216-wip-flo-prepare-for-6-19-v1-0-f7362cdd2532@siemens.com

---
Florian Bezdeka (3):
      cobalt: Prepare for new signature of __request_percpu_irq() in 6.19
      cobalt/rtdm: Prepare for new signature of mm_get_unmapped_area() in 6.19
      testsuite/switchtest: Add support for Dovetail >= 6.19

 include/cobalt/kernel/dovetail/pipeline/irq.h      |  6 +++
 include/cobalt/kernel/dovetail/pipeline/pipeline.h |  9 ++---
 include/cobalt/kernel/dovetail/pipeline/sirq.h     |  9 ++---
 .../cobalt/arch/arm/include/asm/xenomai/fptest.h   | 26 ++++---------
 .../cobalt/arch/arm64/include/asm/xenomai/fptest.h | 43 ++++++++++++++++++----
 .../cobalt/arch/x86/include/asm/xenomai/fptest.h   | 41 ++++++++++++---------
 kernel/cobalt/dovetail/tick.c                      |  8 ++--
 kernel/cobalt/rtdm/drvlib.c                        |  8 +++-
 kernel/drivers/testing/switchtest.c                | 19 +++-------
 9 files changed, 94 insertions(+), 75 deletions(-)
---
base-commit: 363115d15682076ea0766a55c3c5b1eed87e1225
change-id: 20260212-wip-flo-prepare-for-6-19-8fdbd4c58225

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

