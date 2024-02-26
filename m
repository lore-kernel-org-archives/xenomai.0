Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFF5135411
	for <xenomai@lists.linux.dev>; Mon, 26 Feb 2024 22:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708988032; cv=none; b=SiZmQuLc5IZqeRLK+lT9TWhgTAlA5MPBpeY8nTpVP1AcOCnSf+GgLIQS1BdO4+0HqdCyMzAhHZPGxnQ50tjDNHHLG1vB0Zk0fvt+il3/xF0sSwJGNJRAY7zqFZ0q8Ffv6SqpVDZ48pFl7wxA8Aq6wRlyj4pYF0QJLtIhqOdeAZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708988032; c=relaxed/simple;
	bh=1JyHH7Xu1MGsLIrzGzLwcCPEBnFLxEyBMDhhFPox37Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=B/P4UE7u0MJqJsPW0Nlia4FBVBHWbKDamMoUI+SDzIHOH/cLYC8lhCdJxQPU7VJ61alL6D+3WvYEN3mMIs+1BI7Sh7d6bXr+rn+6N6nXxZ76YHYDLMwbJQMHk9frakNDT65bNQFNfG36cT0J1T7lNorlepI7wlcJOfBOfLnsObk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=RFXn05FZ; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="RFXn05FZ"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2024022622534127dc44f2db7dcb32c4
        for <xenomai@lists.linux.dev>;
        Mon, 26 Feb 2024 23:53:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=s2XRxKcMVEXIWQZpLZUDW7XW8fsEgTRyzU2QNjkptxA=;
 b=RFXn05FZWZTe9IcI5p1Gnd5zppWBZ6zrqTcBF9JQlzplpQHUdGtOn09NaA5oUMmj8fa1Ce
 gNaAol2L8eZ5DcQ9ukjtit95Xj7jQUoy55RfR+JzUZoZyWasQPa39qKDN9r60cvll0UMBXY+
 jy0k07oQNSH7Hz/W1+iLpY0vEInXc=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH dovetail 6.7-6.1 v2 0/2] dovetail: x86: Fix handling of
 prctl based compat syscalls
Date: Mon, 26 Feb 2024 23:53:40 +0100
Message-Id: <20240226-v6-7-dovetail-rebase-v2-0-7d457d60d376@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHQW3WUC/32OwQ6CMBBEf4Xs2SXtCkU9+R+GQymrNIHWtNhoC
 P9u08Srx5nMm5kNIgfLES7VBoGTjda7LOhQgZm0ezDaMWsgQY0gUpgUdjj6xKu2MwYedGRkTdS
 2jRInIyCjxRyCdmbKsHvNczafge/2XbZu8GuoVN2hqiX0OTHZuPrwKWeSLLn/u0miQDorInkcW
 j6ba7S8sIu18Qv0+75/ATACWx/hAAAA
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi Philippe, Hi Jan, Hi all,

while switching to prctl based syscalls on Xenomai 3 I found some issues
in dovetail. Seems the compt support for x86 is not fully tested here.

The patches apply to the 6.7, 6.6 and 6.1 branches. 5.10 will need some
backporting. I think I can provide backports once this series was applied.

Best regards,
Florian

CC: Jan Kiszka <jan.kiszka@siemens.com>
CC: Philippe Gerum <rpm@xenomai.org>

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Changes in v2:
- Addressed review comments from Philippe 
- Link to v1: https://lore.kernel.org/r/20240226-v6-7-dovetail-rebase-v1-0-2962213b5e9c@siemens.com

---
Florian Bezdeka (2):
      dovetail: x86: Fix detection of prctl based compat syscalls
      dovetail: x86: Fix fetching of the first syscall argument from compat tasks

 arch/arm/include/asm/syscall.h   | 3 ++-
 arch/arm64/include/asm/syscall.h | 3 ++-
 arch/x86/include/asm/dovetail.h  | 9 +++++++++
 arch/x86/include/asm/syscall.h   | 7 ++++++-
 kernel/dovetail.c                | 5 ++++-
 5 files changed, 23 insertions(+), 4 deletions(-)
---
base-commit: 2e3ed248f02a47dba4e5077031d285ff5c397372
change-id: 20240226-v6-7-dovetail-rebase-ea22554608c0

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

