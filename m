Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C127015698D
	for <xenomai@lists.linux.dev>; Wed,  3 Apr 2024 21:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712180909; cv=none; b=p80fY7/u5RzvNG69uEv7IYLA4TVvwRn2AkCcUtE7tMcQV6OxzKCNJ5fcUTJp+KzAeRqEAEeaZhaFz6znT4TsoPw6vQdXhw1fT+mZZvE/Iv8QzmOzleVRJFJZSyq/S1E3NIW2aLoQyUIUsOrA/pBuuDm2dfPYF+FwhUWAS/2Gl/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712180909; c=relaxed/simple;
	bh=KXR4qyBE7L7AhWvxo2MzV3NhX6ET5DrYlc93/oY91MI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HaXBjMpbmec2xTkEvk37sl62P6Xe5BAoX+d9OpH9SjGghMlTukzCuVE05zwjotCIPigyltap2OIsgaF3sOCk6ukKxA4zke8QcQiddWbUY271cTkwbi/yyvFcfhZhTCC11rppFPw/moqsJ/iPLQn9bXuRXUiApaP8U5Ax6MZXoaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 95A75647A81F
	for <xenomai@lists.linux.dev>; Wed,  3 Apr 2024 23:48:18 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id lTSYjgNHpX5M; Wed,  3 Apr 2024 23:48:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 3EB48647A800;
	Wed,  3 Apr 2024 23:48:18 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 82q4XTRtsc9H; Wed,  3 Apr 2024 23:48:18 +0200 (CEST)
Received: from blindfold.corp.sigma-star.at (84-115-238-31.cable.dynamic.surfer.at [84.115.238.31])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 0B15D647A814;
	Wed,  3 Apr 2024 23:48:18 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: Richard Weinberger <richard@nod.at>
Subject: [PATCH 2/2] prepare-kernel.sh: Warn when result can be defective
Date: Wed,  3 Apr 2024 23:48:11 +0200
Message-Id: <20240403214811.8979-2-richard@nod.at>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240403214811.8979-1-richard@nod.at>
References: <20240403214811.8979-1-richard@nod.at>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the target Linux source tree contains stale files which
are owned by Xenomai, the result can be defective.
Detect such situations and warn the user to avoid crazy errors.

It happened to me twice that the resulting --outpatch was faulty
because my kernel tree contained old Xenomail related files.
Hopefully this saves somebody else valuable debug time.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 scripts/prepare-kernel.sh | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index ed168773247f..f9cf9933da88 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -107,13 +107,18 @@ patch_link() {
             d=3D`dirname $f`
             if test "x$output_patch" =3D "x"; then
                 mkdir -p $linux_tree/$link_dir/$d
-                if test x$forcelink =3D x1 -o \
-		   ! $xenomai_root/$target_dir/$f -ef $linux_tree/$link_dir/$f;
-		then
+                if ! test $xenomai_root/$target_dir/$f -ef $linux_tree/$=
link_dir/$f; then
+                    if test -e $linux_tree/$link_dir/$f -a "x$forcelink"=
 !=3D "x1"; then
+                        echo "$me: warning: $link_dir/$f already present=
 in Linux kernel tree, resulting source tree might be inconsistent!" >&2
+                        continue
+                    fi
                     ln -sf $xenomai_root/$target_dir/$f $linux_tree/$lin=
k_dir/$f
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
2.26.2

