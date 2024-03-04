Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBCA17C62
	for <xenomai@lists.linux.dev>; Mon,  4 Mar 2024 13:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709557274; cv=none; b=eSuX1p4Sxj5Kjk/TKjW50QkMxRVWLZ1h7kyvVmtYSr6tYAdn67Obkwp7N7ewXNSO/KgIXv3Pflq7LSzVLSC8jRJ+N1OPV+7u6LHEP/f9XFLKEWP2j4BUmkuPP5Rq+POSVro3vlqnsOxqV1f0UPMtSrTEQxAvPjGSOk/JwlTZMis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709557274; c=relaxed/simple;
	bh=3LjjgVa0LO8L3d/L8CQrfIsVHK/4SU11QPc4P1qCqJE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YfdnHxZDIpm9afA01jbM4bsI2J+mCJiOu3Acx+4esj6HwCGfrOrxTTnlDOa9gh+qLiqdtyFPKrVHMqO+AVnlEm8lbeFAKVAFqScCccdF+ypAu2uqH79mwhwkKYi4YjVqj0SWiIE6XbHI3JLLMoXxiJBRyEvn9Nc82J5qUsHSGKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=aeUrgpek; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="aeUrgpek"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20240304130101ba38e7c4852c7bdf54
        for <xenomai@lists.linux.dev>;
        Mon, 04 Mar 2024 14:01:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=qIvQmwr/bhfxLl4I2c6K2bUFQ77eG3LhZLBcTsYygtU=;
 b=aeUrgpeke0o1YO9Xa+9NcTxbuP0WiNv4oN/FMCQybWaGpj/zvds2NkmdXZOO7bzTHVN6iP
 2NQfyS0vhNtRTXEQQnA7t5X+17qZE9ELgnONCYVD6vt8ZGAsefP9a6+DK+6ap6zn0KDxeKjM
 zIXjI1/UPkaANBpZRrT2LrpTj0zig=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH dovetail 5.15-5.10 0/2] dovetail: x86: Backports for recent
 compat fixes
Date: Mon, 04 Mar 2024 14:00:46 +0100
Message-Id: <20240304-v5-10-y-dovetail-rebase-v1-0-e8010867dbbe@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP7F5WUC/zWNwQrCMBBEfyXs2ZUkTRT8FfGQJlu7EFJJalBK/
 92l4GXgDbyZDRpVpgY3tUGlzo2XImBOCuIcypOQkzBYbZ0etMPu0Wj8Ylo6rYEzVhpDI3RDDNM
 1XYIlC2If5VhDibP45Z2zlK9KE3+Ouzv8F5Q/G48SGh77/gN93IkMkgAAAA==
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi Philippe, Hi Jan, Hi all,

here are the backports of recent compat fixes targeting the 5.15 and 5.10 
branches.

The original series that made it into recent development branches was
published here:

Link: https://lore.kernel.org/xenomai/878r2yfi2j.fsf@xenomai.org/T/

@Philippe: I think Jan is still waiting for some clarifications about
maintenance topics. Would be nice if we could sort that out. The
maintenance state of some branches is currently unclear - at least to
me.

CC: Jan Kiszka <jan.kiszka@siemens.com>
CC: Philippe Gerum <rpm@xenomai.org>

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Florian Bezdeka (2):
      dovetail: x86: Fix detection of prctl based compat syscalls
      dovetail: arch: Fix fetching of the first syscall argument from compat tasks

 arch/arm/include/asm/syscall.h   | 3 ++-
 arch/arm64/include/asm/syscall.h | 3 ++-
 arch/x86/include/asm/dovetail.h  | 9 +++++++++
 arch/x86/include/asm/syscall.h   | 7 ++++++-
 kernel/dovetail.c                | 5 ++++-
 5 files changed, 23 insertions(+), 4 deletions(-)
---
base-commit: d7226e2eecda5b73a4c8fea85226ea4444038b00
change-id: 20240304-v5-10-y-dovetail-rebase-43caf7d6a2e2

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

