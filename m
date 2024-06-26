Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FC8157A5B
	for <xenomai@lists.linux.dev>; Wed, 26 Jun 2024 19:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719430859; cv=none; b=BVtqii5EBPgMD63WkZQnS50+YJoL/+ilJinoWkRJkeRYG+n5dzlXd7RXqojJIs8R/mZMBEG6tx3nHxwVuMLjJ//yCfpxEjp4kjzKKuGHxx4RWGNGysSOcSIy3IauipgzGVwPUS7W/mFAZlaiPeAWXWzqr3JKQ5ipNjzFTu/b0G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719430859; c=relaxed/simple;
	bh=XM0fxxko0qHXJxNK1uqEumOIo3mf7I+/ANt2FN9tghY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ifnrvX/y8q5xz3ladbyLB6Lnce0L+ko2CJo4iil07pvB8bc8ArcDqaXwFpJ39Ukn15b+Iq/1jj0aZE5/tm6XVRce/zt7jSh1NAirjnu/+85jcDhbySBKx471SM2PEw7wB6yO8YC4/niL17UdDqsGBrEQJhHH8gf2ehjARAg/lSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 5CBB861966AF;
	Wed, 26 Jun 2024 21:40:54 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id PyjEPBmUFDZp; Wed, 26 Jun 2024 21:40:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 0423E6195FD3;
	Wed, 26 Jun 2024 21:40:54 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vfEyhMkyu9HN; Wed, 26 Jun 2024 21:40:53 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id BE3C561966AF;
	Wed, 26 Jun 2024 21:40:53 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 1/2] gitlab-ci.yml: Drop --arch= from prepare_kernel.sh call
Date: Wed, 26 Jun 2024 21:40:42 +0200
Message-Id: <20240626194043.15307-1-richard@nod.at>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

prepare_kernel.sh no longer produces architecture specific kernel changes=
.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 .gitlab-ci.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 7929a7efa..e174fdc48 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -169,7 +169,7 @@ variables:
     - ./scripts/config -e XENO_DRIVERS_SPI_OMAP2_MCSPI_RT
     - ./scripts/config -e XENO_DRIVERS_SPI_DEBUG
     - popd
-    - scripts/prepare-kernel.sh --arch=3D${ARCH} --linux=3D${KDIR}
+    - scripts/prepare-kernel.sh --linux=3D${KDIR}
     - pushd ${KDIR}
     - make -j $(nproc) olddefconfig
     - make -j $(nproc) all
--=20
2.35.3

