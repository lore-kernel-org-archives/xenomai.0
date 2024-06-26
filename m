Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3481157A5B
	for <xenomai@lists.linux.dev>; Wed, 26 Jun 2024 19:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719430863; cv=none; b=BnH2Bql5PV5McJFWY9pY3qtl/zLEuF2czoL5Hcw2AAVMoeI5V0qEcOvU26kC2cOykEhAogW99SA+q8+xoWLuylEZLv8+YpvZ/nkdqop8vZQg5lDz3ckRB+MPLgol2z1OWaTRNP2WefKo5yEk5lur5trtjbNjbSe2jfCJoH5MF4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719430863; c=relaxed/simple;
	bh=atwbqgawEx9oLXv32OIQNIVC5t+2q9PZR2M/tfaPS1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VPrHH/+FuKy/7H9NI655nw/8WSuMlWLvverJyjERRl2LLbuRZ8zE4IJKHytznG/sZeT7iq0vwSa7nJ/JQP1pMBSWck77OOBBU8e5FtjKceVaOq87nF4V51eR8bXNx0gIX5J5vqsRGPdL1lgMFV/UAub/g1l6BmruFm6XJCpLVYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 2C4ED61966AF;
	Wed, 26 Jun 2024 21:41:00 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id aUqb_HIe7H7a; Wed, 26 Jun 2024 21:40:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id E544D6195FD1;
	Wed, 26 Jun 2024 21:40:59 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wfjQeUgSMjpV; Wed, 26 Jun 2024 21:40:59 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id BC01061966AF;
	Wed, 26 Jun 2024 21:40:59 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 2/2] gitlab-ci.yml: Drop --enable-smp from configure calls
Date: Wed, 26 Jun 2024 21:40:43 +0200
Message-Id: <20240626194043.15307-2-richard@nod.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240626194043.15307-1-richard@nod.at>
References: <20240626194043.15307-1-richard@nod.at>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

SMP is enabled by default these days.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 .gitlab-ci.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index e174fdc48..fa9203525 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -175,7 +175,7 @@ variables:
     - make -j $(nproc) all
     - popd
     - scripts/bootstrap
-    - ./configure --enable-smp ${CONFIGURE_OPTS}
+    - ./configure ${CONFIGURE_OPTS}
     - make -j $(nproc)
     - ccache -s
   interruptible: true
@@ -254,7 +254,7 @@ i386-userland:
   script:
     - export CCACHE_DIR=3D$(pwd)/.ccache
     - scripts/bootstrap
-    - ./configure --enable-smp ${CONFIGURE_OPTS}
+    - ./configure ${CONFIGURE_OPTS}
     - make -j $(nproc)
     - ccache -s
=20
--=20
2.35.3

