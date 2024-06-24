Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E92F19E7F8
	for <xenomai@lists.linux.dev>; Mon, 24 Jun 2024 20:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719261248; cv=none; b=P2gC5g2i+sBLfgjT9ly6+ttd5ItFuXvRQZb/aoRSEkhgYgGt5hI6Yrv64Vvr3GCBDEQvOnPlarTYv4Bzu6UYD871nG+KbMO+JrYc1g0GcDxl6q42cPqRWFCCAbw9Lb+j9JgqfgEj1tRBdhZPGe6i9i7yoVM1Hev0M9x7WTd0UGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719261248; c=relaxed/simple;
	bh=Nt3iSolB33lpQ/wDu+KueO8HzRG/Z1zaIvRdG77Uz1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZIpgOfKtxTuVONDiMVxFpsxunUX5pkA1/N5nJlhnDS1SBq0/KjOkyGJSOYl4Py6oFRRYDMBEo37rlTW//oohHzm01/oVXO6xapFVGmAywCeZ2SSjILtfBQXzRG8gSivGB4Kr8BfRfFvMxNIqQSIickcPIUz9FUcs4PEA95xm6E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 2ED226450978;
	Mon, 24 Jun 2024 22:33:55 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id dHUEM1SLctDP; Mon, 24 Jun 2024 22:33:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 29896644CE65;
	Mon, 24 Jun 2024 22:33:54 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id MjHNA5JMK3vy; Mon, 24 Jun 2024 22:33:54 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id F2E6863CDC39;
	Mon, 24 Jun 2024 22:33:53 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 08/14] prepare-kernel.sh: Don't depend on bash
Date: Mon, 24 Jun 2024 22:33:35 +0200
Message-Id: <20240624203341.6263-9-richard@nod.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240624203341.6263-1-richard@nod.at>
References: <20240624203341.6263-1-richard@nod.at>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

type -p is not POSIX, so use realpath(1), I think it is safe
to assume this tool.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 scripts/prepare-kernel.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index a6eb6c1e0..26333c419 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -1,4 +1,4 @@
-#! /bin/bash
+#!/bin/sh
 set -e
=20
 unset CDPATH
@@ -174,7 +174,7 @@ done
 # Infere the location of the Xenomai source tree from
 # the path of the current script.
=20
-script_path=3D`type -p $0`
+script_path=3D`realpath $0`
 xenomai_root=3D`dirname $script_path`/..
 xenomai_root=3D`cd $xenomai_root && pwd`
=20
--=20
2.35.3

