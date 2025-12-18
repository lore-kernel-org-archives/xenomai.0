Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0065022D7A1
	for <xenomai@lists.linux.dev>; Thu, 18 Dec 2025 20:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088139; cv=none; b=rbWC/oozCTYV4BW6zsY81Y6psbBSsMv4hN9EO0Cfv59M9jrhOlS0r5qW8hNcGsbsQmjF5Ornnl9lVh1/5WnQdtUq6g3tiAPNnizqAONEKjRB1PD12roZ32LJBvq4F1PqhzZ/oGSkS+t163qNNjKMF3i9r1fkp+tgr/xA57iT4Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088139; c=relaxed/simple;
	bh=hHOsga8ZJ+4D7fb6RJJAct/5fC+vyMvo+NLOZqMiSsc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sNMwVH/b3qmnZ4v1VrzrgSmExQtnaQxV3pT57hmOnPJaZRrfi9DfnA30zQh8VjOcyaV4hvYWG7lwD4bvQgwbqjnxGy0zECOHoFay/jVNqcRY9x+WjeR7c97yInK6YlsSOht1fASO/d9Tz5lPjFcuGhEZRQrIbhjDeSL4AopAybo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=al4Kc2dw; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="al4Kc2dw"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2025121820020524b98377b300020747
        for <xenomai@lists.linux.dev>;
        Thu, 18 Dec 2025 21:02:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=jNSbnBT8lcopRwC5r7ZAEYNprqQDhcQedtTJoffWZLE=;
 b=al4Kc2dwhJKkwOet8Qr7Rr+WdbviJs2+uVaBc25vc1tcVU88GM/rHr5MwYaCSjiMWLNzvt
 DgLHkieFO6fAgwg8eiwpAhTS64yeiBVCUk/yJ5ajkIpzlaScYfvj7mb//WuEChZk64qrztJX
 IYZTPuKoK4zKNkqy23CRJa5z9BNUpuRlFGiaCm3sm/1uDSkVVCiPEI2I2sviQ7IbzTs+gf9T
 pppj9oeV543Lz2rwRYqDlJmqj6PSFbxETytBOd3WUiLoBvzknCe+2zHcmnqsHtzBvhKD6JU1
 kHv2yulwTvDef3ckVGN9CMxL7h+f118GhitaEFMtKjlDVnCvcfPhQayw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v2 0/6] Some fixes for the select syscall
Date: Thu, 18 Dec 2025 21:02:00 +0100
Message-Id: <20251204-flo-fix-select-syscall-v2-0-f606e54e8d57@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALhdRGkC/4WNQQ6CMBAAv0J6dk1bKYon/2E4lHUrTUprukgkh
 L9b+YDHmWQyq2DKnlhcq1Vkmj37FAvoQyVwsPFJ4B+FhZbaKC1rcCGB8x9gCoQT8MJoQ4DeoVG
 XtpFOoShxb5mgzzbiUPL4DqHIV6aS7rd7V3jwPKW87PNZ/ezfz6xAwtm1aGpjmxPSjT2NFPmIa
 RTdtm1faiWzodMAAAA=
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Andreas Ziegler <ziegler.andreas@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi all,

This is the result of a short debug session triggered by Andreas, who
was staring at some strange select() behavior.

The issues were introduced while working at the y2038 support, so it's
kind of 3.3 only, but: We have a difference regarding the timeout
handling in Xenomai 3.2 and 3.3 now. In case someone is running a
testsuite against both versions the result might be different.

The testsuite has been extended so that we cover the missing case now as
well. CI test runs were based on dovetail 6.17, covering all supported
architectures, compat userland included.

Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Andreas Ziegler <ziegler.andreas@siemens.com>

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Changes in v2:
- Patch 2: Optimize timeout writeback code
- Patch 6: Address review comments from Jan, improved the test
- Link to v1: https://lore.kernel.org/r/20251204-flo-fix-select-syscall-v1-0-7f9c545a63ce@siemens.com

---
Florian Bezdeka (6):
      y2038: lib/cobalt: select: Normalize timeout value in the y2038 case
      y2038: lib/cobalt: select: Fix timeout writeback of the compat time64_t case
      cobalt/posix/select: Optimize cobalt_timeval_to_timespec64()
      cobalt/posix/select: Optimize cobalt_timespec64_to_timeval()
      testsuite/smokey/posix-select: Move message queue test into own function
      testsuite/smokey/posix-select: Extend the testsuite by invalid timeouts

 .../cobalt/include/asm-generic/xenomai/syscall.h   | 25 +++------
 kernel/cobalt/posix/io.c                           |  4 +-
 kernel/cobalt/posix/syscall32.c                    |  4 +-
 lib/cobalt/select.c                                | 16 +++++-
 testsuite/smokey/posix-select/posix-select.c       | 65 +++++++++++++++++++++-
 5 files changed, 90 insertions(+), 24 deletions(-)
---
base-commit: d557f120bf73a0e467196c99e9de210244b29774
change-id: 20251204-flo-fix-select-syscall-bfc518960f1c

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

