Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DDC2233B
	for <xenomai@lists.linux.dev>; Mon, 24 Jun 2024 20:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719261244; cv=none; b=FZIDTL/nD3rrRgU44lgxa9Oun4QF/p50gyy8QxcsBT6Nm/ufMJhp7G/buj+DV/6hBDnAXC7TBOJLOp1aBM4h5frugSgiC7ysd+lHWrCazcgcZUY1aHe02UE/6WWXvtuSG7O4B3m5Mfm5LmBEsuNYHKdJQM24mrFRqkk9EtDMTyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719261244; c=relaxed/simple;
	bh=ryX6b06qIFqQNR605CGgrCmRi/o1vXipz1+eJIFy8gU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bJ1w66OkBafGQ7Dp+7nbguVDXH2ydBjyPBt+Q9lfvZ7JBLE/P1emdIhDekbfSVMKl2eEFtLkNYnHF9IyA7nXdLo9qT2Yfvfk5Ek3LfFJh2hhRCIG+/uWoRSlbBDwqQw/MY3T/47sLxugUKJbZ09/eZa9L+7NJgT9H9lHieHXp4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 6B2CD6343B2C;
	Mon, 24 Jun 2024 22:33:53 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id UCE-A7Zhmujy; Mon, 24 Jun 2024 22:33:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id C57F56195FD1;
	Mon, 24 Jun 2024 22:33:52 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xAqR2Otk9cLA; Mon, 24 Jun 2024 22:33:52 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 9652861966AF;
	Mon, 24 Jun 2024 22:33:52 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH v2 00/14] Assorted Cleanups For prepare-kernel.sh
Date: Mon, 24 Jun 2024 22:33:27 +0200
Message-Id: <20240624203341.6263-1-richard@nod.at>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series contains the following improvements and cleanups.

- Implement --reverse to undo the effects of the script
- Emit changes that work on any architecture, renders --arch=3D optional
- Switch from /bin/bash to /bin/sh
- Make shellcheck happy up to warning level, info level is still a lot of=
 work
- Convert the whole script to tabs
- Remove dead and in vain code
- Various fixes

Changes since v1[0]:
- Rebased to current next branch
- Reorganized patch series
- Worked in feedback from Jan and Florian

Richard Weinberger (14):
  prepare-kernel.sh: Convert to tabs
  prepare-kernel.sh: Add reverse mode
  prepare-kernel.sh: Emit architecture agnostic changes
  prepare-kernel.sh: Improve kernel tree check
  prepare-kernel.sh: Disable SC2115 warning around $linux_tree
  prepare-kernel.sh: Remove --filterkvers=3D and --filterarch=3D
  prepare-kernel.sh: Remove interactivity
  prepare-kernel.sh: Don't depend on bash
  prepare-kernel.sh: Remove --forcelink
  prepare-kernel.sh: Fix dovetail check
  prepare-kernel.sh: Define command line variables
  prepare-kernel.sh: Remove dead code
  prepare-kernel.sh: Don't allow uninitialized variables
  prepare-kernel.sh: Remove kernel version check

 scripts/Kconfig.frag      |   2 +-
 scripts/prepare-kernel.sh | 587 +++++++++++++++++---------------------
 2 files changed, 268 insertions(+), 321 deletions(-)

[0]: https://lore.kernel.org/xenomai/20240525115806.12101-1-richard@nod.a=
t/

--=20
2.35.3

