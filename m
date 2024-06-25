Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDDF143C49
	for <xenomai@lists.linux.dev>; Tue, 25 Jun 2024 21:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719352212; cv=none; b=EPbuTS2/ye0oLp4h9tqGqP6VYHqOrBpAyuB4UHmeHpXdG2ZTgkRAlT5VpOmOFbsoaXA2ppBimXQBKR0JbQvW5ed4jQCq4bu1eF/qHuunlvdDPOeCzbydkcwmlNcG9rKxmkz/zZspEDQOixGzM7FRLLxqJvzZqQo167F66cGjtqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719352212; c=relaxed/simple;
	bh=grjnpqUuOFrJwndL0bnjndCjpv3rO3AuQpG9wAB/6pU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UuV27yGDUREVkQ7UvYC2oG3zh3i7mkBixITcniA0/aJjMJtS37R4v5p4WdpSLDkVLN/K8fX4G6TWAtXUbPrx23XvI9+/5yEtXUkISkOms5UwG8beGPuioR+NkNRaoFK2FeOwSf1O87g2lYhMgKkkl6660bi3JdGxISMlMHXE+sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 94B286195FE9;
	Tue, 25 Jun 2024 23:50:07 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id UxpMAGiUWE48; Tue, 25 Jun 2024 23:50:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id A38876195FFC;
	Tue, 25 Jun 2024 23:50:06 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NSn0Yt8DbsPU; Tue, 25 Jun 2024 23:50:06 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 0855961966A9;
	Tue, 25 Jun 2024 23:50:05 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 02/15] prepare-kernel.sh: Tame link mode cleanup code
Date: Tue, 25 Jun 2024 23:49:49 +0200
Message-Id: <20240625214950.22728-1-richard@nod.at>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The existing cleanup code tries to delete stale links from a previous
run of prepare-kernel.sh.  It removes all links below $target_dir
which don't exist in the Xenomai $link_dir directory.
patch_link() implicitly assumes ascending order of calls,
the new reverse mode feature explicitly needs descending call order.

Digging deeper unearthed further odds in the cleanup code.
Originally it used to rm -Rf stale folders and files, but after commit
e72d695a7 ("scripts/prepare-kernel: only purge links from target director=
ies")
in 2010 code tested whether the target file is a symlink.
So $dir_opt and rm'ing recursively is not needed anymore.

To make reverse mode work, change the removal test to remove symlinks
only if they are broken.
e.g. when they point to a moved/old Xenomai installation.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 scripts/prepare-kernel.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index 352893224..7a1c4d923 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -83,18 +83,16 @@ patch_link() {
 		fi
 		if test x$recursive =3D xr; then
 			recursive_opt=3D"-mindepth 1"
-			dir_opt=3D"-type d -o"
 		else
 			recursive_opt=3D"-maxdepth 1"
-			dir_opt=3D""
 		fi
-		find_clean_opt=3D"$recursive_opt \( $dir_opt $link_makefiles_opt -name=
 Kconfig -o -name '*.[chS]' -o -name '*.sh' \)"
+		find_clean_opt=3D"$recursive_opt \( $link_makefiles_opt -name Kconfig =
-o -name '*.[chS]' -o -name '*.sh' \)"
 		find_link_opt=3D"$recursive_opt \( $link_makefiles_opt -name Kconfig -=
o -name '*.[chS]' -o -name '*.sh' \)"
 	fi
=20
 	if test "x$output_patch" =3D "x" -a -e $linux_tree/$link_dir; then
 		cd $linux_tree/$link_dir && eval find . $find_clean_opt | while read f=
; do
-			if test -L $f -a ! -e $xenomai_root/$target_dir/$f; then rm -Rf $f; f=
i
+			if test -L $f -a ! -e $f; then rm -f $f; fi
 		done
 	fi
=20
--=20
2.35.3

