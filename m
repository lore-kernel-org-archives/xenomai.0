Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7756B3D0D9
	for <xenomai@lists.linux.dev>; Sat, 25 May 2024 11:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716638319; cv=none; b=RxjtoLeTa5SJGYAgnT82RDsXEB6Okfv6uVKPZOt6v/ZrvEg5IXYPtLA0RRH+td+XDzyEeTa2xQ1brPBuka2tQLeFsAfzRFYxCY8TPGr53ggrVU2SDTxz460zbccdmcbqQMvXF1TiIEypMExksS23NdvZsR/64lDvyeOlea8C65s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716638319; c=relaxed/simple;
	bh=qf/Ip7KivqnOaqBVaJXEv5r/IWa/mMw3flpYu2dt74k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C5AkL/rXTwNoyNF3B9gTiV4yq1dHGR9FEe+lGjvDoVPJf8Kr8DFwUpNbLRytfMdhyRT3A/jqmI5/+gwjCb1W5/lqcLzr+ee7tvSjOehUf/3WL5Mq8xQ4L39xM1Xns5/mi9Ub2BvyAXekwWJBpHU51w0GndeqnJEYW3GpFNvvrHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 191A8626FAE9;
	Sat, 25 May 2024 13:58:28 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id fqfY_pPGoCtV; Sat, 25 May 2024 13:58:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id A94216195FFB;
	Sat, 25 May 2024 13:58:27 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id OcOwtMD4E_NW; Sat, 25 May 2024 13:58:27 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 6C67A6195FCF;
	Sat, 25 May 2024 13:58:27 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 00/16] Assorted Cleanups For prepare-kernel.sh
Date: Sat, 25 May 2024 13:57:50 +0200
Message-Id: <20240525115806.12101-1-richard@nod.at>
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

Richard Weinberger (16):
  prepare-kernel.sh: Add reverse mode
  prepare-kernel.sh: Emit architecture agnostic changes
  prepare-kernel.sh: Convert to tabs
  prepare-kernel.sh: Improve kernel tree check
  prepare-kernel.sh: Fix shellcheck SC2046 warnings wrt. check_filter
  prepare-kernel.sh: Disable SC2115 warning around $linux_tree
  prepare-kernel.sh: Don't use eval
  prepare-kernel.sh: Don't depend on bash
  prepare-kernel.sh: Remove --filterkvers=3D and --filterarch=3D
  prepare-kernel.sh: Remove interactivity
  prepare-kernel.sh: Remove --forcelink
  prepare-kernel.sh: Fix dovetail check
  prepare-kernel.sh: Define command line variables
  prepare-kernel.sh: Remove dead code
  prepare-kernel.sh: Don't allow uninitialized variables
  prepare-kernel.sh: Remove kernel version check

 scripts/Kconfig.frag      |   2 +-
 scripts/prepare-kernel.sh | 585 +++++++++++++++++---------------------
 2 files changed, 267 insertions(+), 320 deletions(-)

--=20
2.35.3

