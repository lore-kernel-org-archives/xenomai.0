Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C184D3BBC1
	for <xenomai@lists.linux.dev>; Sat, 29 Jun 2024 13:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719668730; cv=none; b=unEA7Rmlta0lmHRk88rQjFmBhQPt4JGYobCdWPJIA7S5Ou+C9jPJeXeF4/8qpbbixTHtBpp3Yzwggmk1RqnI7TJdszLDpzFASyulch0dgw+rPBaQWnuM8I5XJv0KRxMw6MpHER1boImYsL9rcWxY8/a0MkvwIiwb3g8SHikp4Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719668730; c=relaxed/simple;
	bh=S40dsRIJeGenRH24+ehuU4uB7KsC4WstU+fzaerVsG8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gWk4vONxYDVeWtIHVIq0Gfg4pFkMOp4vIathu1OEgOEe4+YCHyHozyDJPhIxEPrkR89PySqyg4ahfaANeeGzsL1KafsIi6ONqIHtKQQCwexjQPx0v6/OoV2JVRLk5RyO2nuSd6O5w4lZVdymfafN309N4Cf2NygQzOHzQFdOAsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id D03F961966A1;
	Sat, 29 Jun 2024 15:45:19 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id xrqmLjoIj-2p; Sat, 29 Jun 2024 15:45:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 29E446195FE1;
	Sat, 29 Jun 2024 15:45:19 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jX0ekVFxwYis; Sat, 29 Jun 2024 15:45:19 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id EB71B6195FC4;
	Sat, 29 Jun 2024 15:45:18 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 0/5] Add cleanup checks to CI pipeline
Date: Sat, 29 Jun 2024 15:44:59 +0200
Message-Id: <20240629134504.11148-1-richard@nod.at>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Run make clean after building kernel and Xenomai and check whether
no stale files exist.
This allows also testing the --reverse feature of prepare-kernel.sh.

Since build artefacts are not used after building, at least as I understa=
nd
the current pipelines, make clean can get executed right in the build sta=
ge.

Richard Weinberger (5):
  gitlab-ci.yml: Use CI_PROJECT_DIR variable
  gitlab-ci.yml: Clean and check kernel build
  Refactor .gitignore file
  doxygen: Remove generated config file up make clean
  gitlab-ci.yml: Clean and check xenomai build

 .gitignore              | 56 +++++++++++++++++++++++++++++------------
 .gitlab-ci.yml          | 11 +++++---
 doc/doxygen/Makefile.am |  1 +
 3 files changed, 48 insertions(+), 20 deletions(-)

--=20
2.35.3

