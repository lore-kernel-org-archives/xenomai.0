Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C2271730
	for <xenomai@lists.linux.dev>; Thu,  4 Apr 2024 09:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712223063; cv=none; b=D9JaL93d5Ov4XmKJUzWm9Kfxg+A+sa2g3SKiMHKRdtLUA5sZ56dHNlF1osFAVC074uomIeQhXz4LTgXDSmrXOmzCTR3FFAWm1wJf4GfCNcW71i0UU6cDUgKSIeUf3ERKDOTeoq/ZdqdDd5re+YclFfuLhOPb/3FfSy5woSqSsWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712223063; c=relaxed/simple;
	bh=dLkqay9MYesFNKjM/E+OOjlE3qgY8lVs384tLcw+JYY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YkGjovICOA5VW6nE+KKaen32KaNY4Iu7f8rKdHVhU5D+wk4A6fOUSLHDwxAfrBC06sbvVlMWwpzeHj70UoCX8tkj2NZtNDhdLWRbXrxhOCBmK+UznENmHXURWAxVi+fy8rx9xqNK47Vx2BvRtWMenaEaGf5CE4CeXuMjRWWiHS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 96197647A81C
	for <xenomai@lists.linux.dev>; Thu,  4 Apr 2024 11:30:57 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Ckj3YUMIlRwC; Thu,  4 Apr 2024 11:30:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 32C8C647A81E;
	Thu,  4 Apr 2024 11:30:57 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UMGhycNxvGMI; Thu,  4 Apr 2024 11:30:57 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id ECFAA647A80A;
	Thu,  4 Apr 2024 11:30:56 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: Richard Weinberger <richard@nod.at>
Subject: [PATCH 1/2] prepare-kernel.sh: Remove dead variable
Date: Thu,  4 Apr 2024 11:30:39 +0200
Message-Id: <20240404093040.15605-1-richard@nod.at>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

linux_out got added in 2006 via 68d0bf171 ("Allow configuration over a ke=
rnel output tree")
but was never in use.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 scripts/prepare-kernel.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index 64e2484e1..d50680dba 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -241,7 +241,6 @@ while test x$linux_tree =3D x; do
 done
=20
 linux_tree=3D`cd $linux_tree && pwd`
-linux_out=3D$linux_tree
=20
 if test \! -r $linux_tree/Makefile; then
    echo "$me: $linux_tree is not a valid Linux kernel tree" >&2
--=20
2.35.3

