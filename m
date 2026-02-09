Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971A83793BF
	for <xenomai@lists.linux.dev>; Mon,  9 Feb 2026 14:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648237; cv=none; b=TBlDkZfW3q4bQY2j4oJq+328LwTTPziKpBa+NIaN7rMS09+wInAIchM78z5hSp2xri/IHcQaAU4EeHVMiwWI7pjX1IZXjStTSPyT9t4CtyOrpvb4NwHyBq/mRwaXKw0P3QxFMK5qxqzKAymhLpJ9vQjlj8OBba9MLc3kWHuCvGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648237; c=relaxed/simple;
	bh=0Nb73/GGWdDg5W9+6QILdp7kz18PnK/fRgxdU0X/Zy0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fAbtY1joZA6vV4TxqL4on0w3hPKNZKHjRIREPJeoB+qdcOXB9jGMkqRuO0dVXoqUMeUGXz/cue/+Bol/KjX5SSjwDAOsIwmNRwI9S3IjwxqZd7yktgyrNjLVZC740QlcJqYgZ+ZUPCgIdW4v2OWCJLqyMPgH6s4eiPp7bRr9yvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=R6X4Skfk; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="R6X4Skfk"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2026020914435240e2127a37000207dc
        for <xenomai@lists.linux.dev>;
        Mon, 09 Feb 2026 15:43:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=BGeGcOpFJ8hpSSRMwHLX4MkeLI6tSZoBlLr8x2xDDbs=;
 b=R6X4SkfkswdsUp9OdqP5F/QFcB1m4giWE5PADNO2JaiUN1N+cyG4p0QADuAsxsImva94l8
 glyB3aOdn2W7RM0oOKaDWD61RzzZ7q5hqrQV9ieJRFkw+oaoXAy9ra2NfxHS19zpPPPT4P1L
 siiXzPr7VwWXS2E1ZqbPVUuftR+iklGvRvEoluvghswr+bMX4jJXg1DqbfvWcurwnxhSsLXW
 E5YUxc7duIZ1v/bwhmvy19I3AVSrADrMqkfs7RTP7dzxJ8xG+raggQ9gthbrgPu4xDZdTYBx
 ynieoKghRat7myP9fiqDLSnNsfitD9wVpEg0WAj1G91ebdjVlromxbNA==;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [xenomai-images][PATCH 0/4] Trigger xenomai-images CI for linux-evl and libevl
Date: Mon,  9 Feb 2026 15:43:42 +0100
Message-ID: <20260209144346.487179-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

This brings support for triggering the xenomai-images CI for pushes to:
- linux-evl branches: head (6.18), 6.12, 6.1, in combination with libevl next
- libevl branch: next, in combination with linux-evl head

I noticed that the case that a branch matches the rule
"$CI_COMMIT_BRANCH =~ /^v6\.[0-9]+\.y(-cip)?-evl-rebase$/", but is not
the head branch (6.18) or a xenomai-images supported branch (6.1/6.12)
was not covered yet (this would be e.g., v6.6.y-evl-rebase /
v6.6.y-dovetail-rebase).
To cover this, as GitLab rules are evaluated once at job creation, I
introduced a dynamic child pipeline that triggers xenomai-images in
case of a valid branch. If the branch should not trigger xenomai-images,
the child runs a dummy job to fulfill the GitLab requirement that the
resulting pipeline of the trigger job cannot be empty.

I tested the patches for:
- linux-evl branches: 6.1.y, 6.6.y, 6.12.y, 6.17, 6.18.y
- linux-dovetail: 6.6.y
- libevl branch: next

Best regards,
Clara Kowalsky

Clara Kowalsky (4):
  ci(xenomai-images): Add build job for pipeline triggered by libevl or
    linux-evl
  ci: Add CI for libevl
  ci: Add CI for linux-evl
  ci(dovetail): Trigger CI only for head and supported branches

 .gitlab-ci.yml       |  8 +++++
 ci/ci-child.yml      | 27 ++++++++++++++++
 ci/ci-dovetail.yml   | 35 ++++++++++++++-------
 ci/ci-evl.yml        | 74 ++++++++++++++++++++++++++++++++++++++++++++
 ci/ci-libevl.yml     | 28 +++++++++++++++++
 ci/evl_xenomai_4.yml | 29 +++++++++++++++++
 6 files changed, 189 insertions(+), 12 deletions(-)
 create mode 100644 ci/ci-child.yml
 create mode 100644 ci/ci-evl.yml
 create mode 100644 ci/ci-libevl.yml
 create mode 100644 ci/evl_xenomai_4.yml

-- 
2.52.0

