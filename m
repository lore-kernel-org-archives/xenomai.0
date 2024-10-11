Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E482628E7
	for <xenomai@lists.linux.dev>; Fri, 11 Oct 2024 13:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728653877; cv=none; b=odi8wz0rjIc7nvzfLBK/A5XpSCAZ1pdlt5zCgz6TwiYOXh0OokMCS3aP0WcRwLZ2ueZJYw6t8M0Aqha/ohJHLG/C7I/UgpKIGFStfI87FNWHjEHS0zlkwKLLgtRKluAaOj4bCOfZKhb9+oz6+3sgUbIHqz5go9axNGMVvYUt6hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728653877; c=relaxed/simple;
	bh=xIhCGx1pRsxAn5ZAGaekj9WrVy5ITkUV/t4PVq1ZNJ4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rE6057rubfLjYS5HSZqvQsXyAX4PyNmhA76jOb8/PqZhgD5ehLCqRhUgNN9aMWQ8x7HtmzccPqPQuP/jB+51xNSgojYOyHCgvHE24ky0QBwP5wwHKFtMIlBfUpdrVF0rWSlPPTXwVhuQNe3RVUyP0mMa/YAyvUOlA6MMMjc4wmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=YiS852XH; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="YiS852XH"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20241011133749901e676c828def7c91
        for <xenomai@lists.linux.dev>;
        Fri, 11 Oct 2024 15:37:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=2A/9CGMB5bphwiVGxehQt3r9JvVtcgZgNZpbbfq7Jpk=;
 b=YiS852XH7eu2Xw73FYpSr0hMZpos4bETfn4ak1VGlE9S4JRoz8h3aMJrMO5+we5VV60szo
 L08bWhYrwkpys3shfVdj0DSRZawkRusBhOfDmnURJJWFFGY1XKxbJZsg2KLLsdEuy7Sq5glQ
 69vreibX7bX9vJLKEG0662fSukyz0XjerKgIjlUR57BhpAqinK39OypTGmQzPJ+EW86bIS8G
 7dIG51Ltuxc6YFcGBA7QwxnB3uNsUOmJw/dkb83mET5KStmzQ21UTfAjEnT4VjL6+FZM5y15
 H41dO/y/2x932gXejndCy9tvDU4yWBn166cKStct64uk9v1x9KElJHug==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v4 0/4] Preparations for Debian 13 / Trixie
Date: Fri, 11 Oct 2024 15:37:48 +0200
Message-Id: <20241011-flo-cleanup-y2038-v4-0-788b3a4bf3cc@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACwqCWcC/4WNyw6CMBBFf4V0bc205aUr/8O4KGUqTaCQVoiE8
 O8O7IyJLM9N7jkLixgcRnZNFhZwctH1niA9Jcw02j+Ru5qYSZCpACG4bXtuWtR+HPgsQZU8R6V
 sYXQOuWb0q3REXgXtTUNPP7YtjUNA69576P4gblx89WHeu5PY1n+JSXDgaZVVAEVpqXSLDjv08
 Wz6jm2+SR46JDkALdSZNPZixK9DHToUOWSeFUqB1bW4fDvWdf0AeE1kelEBAAA=
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
Changes in v4:
- Slightly adjusted patch descriptions
- Removed probing for __select() in Patch 1, replaced by proper libc
  macro usage.
- Link to v3: https://lore.kernel.org/r/20241011-flo-cleanup-y2038-v3-0-2657330fad19@siemens.com

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

 include/cobalt/wrappers.h                      | 3 ++-
 lib/cobalt/arch/x86/include/asm/xenomai/time.h | 2 +-
 lib/cobalt/select.c                            | 2 +-
 testsuite/clocktest/clocktest.c                | 2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)
---
base-commit: 86c4592bee073d6bcd21b16dbd13b0d60af202dc
change-id: 20241011-flo-cleanup-y2038-6e33f7ca606a

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

