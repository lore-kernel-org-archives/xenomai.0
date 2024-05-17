Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643501A2C23
	for <xenomai@lists.linux.dev>; Fri, 17 May 2024 15:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715958425; cv=none; b=EKXyAW8fzCLm6Qp5hLbKHTGquEEiLQJVY35A7724o1GX9iKyf10NWxfUH1HjjIWaLjV31/8UXuKCfHjz0fXwDHbAxG/CAnlUlCQgjkhtjbW9sUweY/9PxRDEhiJ644pNF7aHVwRAvXWIu2RkrawNG/OXLaCyAjtv9AoxUM1ssAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715958425; c=relaxed/simple;
	bh=2CXfS1LOBdOt58pCCGDG7wSspgM94KMor45aNq/v7RE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WyJEzhTUxGwiWKaqXwlspJTrYIFveGKaG5RA7vaTw6qhw8NMfHnm9bJg3emEepm50z1x7MnIk+Ad0MnFYByHrn7uISAmYfnadpPJ1Vq5NZMWbpcCCpAv3hNdpNhrGX2Sz/EaTzDLAKLVRf2DFmHXKhVtF0L+9Zx3vhILCCy0UIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 4FD4B647A801
	for <xenomai@lists.linux.dev>; Fri, 17 May 2024 17:06:59 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Vl8sIelCYCQG; Fri, 17 May 2024 17:06:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id ED19563D93AF;
	Fri, 17 May 2024 17:06:58 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JgKccS0wXFDd; Fri, 17 May 2024 17:06:58 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id BB56C647A801;
	Fri, 17 May 2024 17:06:58 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: Richard Weinberger <richard@nod.at>
Subject: [PATCH v2] prepare-kernel.sh: Warn when result can be defective
Date: Fri, 17 May 2024 17:06:51 +0200
Message-Id: <20240517150651.30974-1-richard@nod.at>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the target Linux source tree contains stale files which
are owned by Xenomai, the result can be defective when --outpatch
is used.
Detect such situations and warn the user to avoid crazy errors.

It happened to me twice that the resulting patch was faulty
because my kernel tree contained old Xenomail related files.
Hopefully this saves somebody else valuable debug time.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
v1 tried to be smart in link mode too, but made things worse,
this version adds only a warning for outpatch mode which is
the use case I'm actually focusing on and initially faced problems.
---
 scripts/prepare-kernel.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index 0b11eca66..b609d9998 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -126,6 +126,9 @@ patch_link() {
                 fi
             else
                 if test `check_filter $link_dir/$f` =3D "ok"; then
+                    if test -e $linux_tree/$link_dir/$f; then
+                        echo "$me: warning: $link_dir/$f already present=
 in Linux kernel tree, output patch might be defective" >&2
+                    fi
                     mkdir -p $temp_tree/$link_dir/$d
                     cp $xenomai_root/$target_dir/$f $temp_tree/$link_dir=
/$f
                 fi
--=20
2.35.3

