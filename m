Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C647442A
	for <xenomai@lists.linux.dev>; Thu,  4 Apr 2024 09:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712223062; cv=none; b=lZMXyJaWZ5f+2kAI7Zj6/5bXMVFofbgnVyjTq/fQMEyKCJWKeedB+G7OvLd/FluwAryar1hxdGQcK1DfZVcwegGrVKAF4nrFmMjHVeWLD4MT2E0jBMdmA1YZQW1cNOa3m0HTpL/2Due294FlEEUmAqMBZFMdBgNlERajUSByLsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712223062; c=relaxed/simple;
	bh=TnaLIm9Z56TTPzhAckA32jfRmMCKWsEzDHkgHeziiYk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nfvutqFEDdO3IjwQFauHwiasTKayqJZzry6BLdzeBmb6i0/1ph0pQI8s5/szjB6bv38JqA/Mq2XRLx8MrOKsF0dhGbNpdCA5cH4DhGhlQs5G3DtaKdKNXeWGviCz2dzwJqV4Y0VEOMf3O5+5EXcs/UCpBeBA6wl/av7SzCI1vwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 98AC3647A81F
	for <xenomai@lists.linux.dev>; Thu,  4 Apr 2024 11:30:57 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 6VDmolqv5KNP; Thu,  4 Apr 2024 11:30:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 48E85647A80A;
	Thu,  4 Apr 2024 11:30:57 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8W2A4d1aj5Sy; Thu,  4 Apr 2024 11:30:57 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 1E51F647A81C;
	Thu,  4 Apr 2024 11:30:57 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: Richard Weinberger <richard@nod.at>
Subject: [PATCH 2/2] prepare-kernel.sh: Fix typo in variable name
Date: Thu,  4 Apr 2024 11:30:40 +0200
Message-Id: <20240404093040.15605-2-richard@nod.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240404093040.15605-1-richard@nod.at>
References: <20240404093040.15605-1-richard@nod.at>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

recursive_opts was added via
3f4c56c74 ("fix prepare-kernel for 2.4 and mindepth argument")
but never worked as expected, it's recursive_opt, without "s".

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 scripts/prepare-kernel.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index d50680dba..0b11eca66 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -94,7 +94,7 @@ patch_link() {
               link_makefiles_opt=3D"-name Makefile -o"
            fi
            if test x$recursive =3D xr; then
-	       recursive_opts=3D"-mindepth 1"
+	       recursive_opt=3D"-mindepth 1"
 	       dir_opt=3D"-type d -o"
            else
 	       recursive_opt=3D"-maxdepth 1"
--=20
2.35.3

