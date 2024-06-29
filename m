Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A899F78C83
	for <xenomai@lists.linux.dev>; Sat, 29 Jun 2024 13:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719668734; cv=none; b=CxjoV/4UB3R8D7MiAUh0ptLa7MnaWJB8IVoIvNMol587fGKPFfjbLMzgGyn8nsG0O47pHd7K2gnS34kAsAaNbLocL7uyh+8r0RnRHRDIFNXlGYjgNBWY4u1PukDS7CklIXxJTnbQCoE/Gd23AoonBIBFdjyzHHCg29OvakwPfA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719668734; c=relaxed/simple;
	bh=fV+S6ZFq72sxdAUm97Wb727JG8dvrUy/dO/tcCFR3QY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nyszAIlenqWtzRRv3D0lB9+TK7rT3u+9EptWpI9wxpFHiiaEz6WBZv/MK/3Q27R10fM2br2Fbdqsjmle4XTyEgYpo/t3Hq2yu2rmUg5WhHfdIavEQ/Qop7kj8aI+n3p1PbizU0TsfMBd/f0lfMso20pFk3oWYuaZHyFt7H00eYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 36D1C61966B8;
	Sat, 29 Jun 2024 15:45:20 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 0Ck9_rwe6Q7g; Sat, 29 Jun 2024 15:45:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id E5DBE61966C1;
	Sat, 29 Jun 2024 15:45:19 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jnR6iPEZNt2z; Sat, 29 Jun 2024 15:45:19 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id B13E661966AC;
	Sat, 29 Jun 2024 15:45:19 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 5/5] gitlab-ci.yml: Clean and check xenomai build
Date: Sat, 29 Jun 2024 15:45:04 +0200
Message-Id: <20240629134504.11148-6-richard@nod.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240629134504.11148-1-richard@nod.at>
References: <20240629134504.11148-1-richard@nod.at>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Like for the kernel build, make sure make clean leaves no
auto generated files behind.
If this check fails in future, either clean rules are missing or
.gitignore patterns need an update.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 .gitlab-ci.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 68e3ab324..0839da010 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -178,6 +178,8 @@ variables:
     - scripts/bootstrap
     - ./configure ${CONFIGURE_OPTS}
     - make -j $(nproc)
+    - make clean
+    - git status --short | grep . && exit 1
     - ccache -s
   interruptible: true
   cache:
--=20
2.35.3

