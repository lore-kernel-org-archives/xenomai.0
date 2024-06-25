Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6604C6E
	for <xenomai@lists.linux.dev>; Tue, 25 Jun 2024 20:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719347919; cv=none; b=QpIn8yQ9AT7ZfOPGEEFG3wBpq/v10fWiofvx3XQxMNezcMLFDbd6JOar97EkdbGb+6uLogwMMb+T16JIwmJjR/myH6CUpX7/fP/cUw9FI2O8wsi674Raj9TNUzvcbnnV/DtuUoVGY8q1jG4+5Oc0PqumVcR3bETOJF9tmZjR+TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719347919; c=relaxed/simple;
	bh=4BpkkHeqh4o3p4NBsIrLvWZF2JC4R6Aw9wC0U9l8B2g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jJtGupuJ+NbvqOjfNwQwUv+l0ZudQ5lSq8CrIGxLtmSpbx9YBPgSApr5Js0nstaXvAIyDQKaBwj7KNV29j1X3PEmUOBGGtq36DsASNqDYzuprfPWRz4oFjVhkG5BwTgqAyxPhmhtsqCsulGSa1ykU8/6GCeMCtBN8M6dpdw+3b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 3E3E661966A9;
	Tue, 25 Jun 2024 22:38:28 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id hkkmxqyQ967T; Tue, 25 Jun 2024 22:38:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id CD5D96195FC4;
	Tue, 25 Jun 2024 22:38:27 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2ZH7twSAbYRv; Tue, 25 Jun 2024 22:38:27 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 9A6E761966A9;
	Tue, 25 Jun 2024 22:38:27 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH next] prepare-kernel.sh: Tame link mode cleanup code
Date: Tue, 25 Jun 2024 22:38:15 +0200
Message-Id: <20240625203815.24997-1-richard@nod.at>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Reverse mode introduced an odd regression, in link mode suddenly some
links vanished.
The root cause is that after a further refactoring I have changed
the sequence of patch_link() calls.

A sequence of:
patch_link r n include/rtdm/uapi include/xenomai/rtdm/uapi
patch_link r n include/cobalt/kernel/rtdm include/xenomai/rtdm

caused the second patch_link() call to remove all links in
include/xenomai/rtdm/uapi because of the cleanup code.
The existing cleanup code tries to delete stale links from a previous run
of prepare-kernel.sh.
It removes all links below include/xenomai/rtdm/ which don't exist
in the Xenomai include/cobalt/kernel/rtdm/ directory.
So, patch_link() implicitly assumed ascending order of calls,
the new reverse mode feature explicitly needs descending call order.

Digging deeper unearthed further odds in the cleanup code.
Originally it used to rm -Rf stale folders and files, but after commit
e72d695a7 ("scripts/prepare-kernel: only purge links from target director=
ies")
in 2010 code tested whether the target file is a symlink.
So $dir_opt and rm'ing recursively is not needed anymore.

In order to fix the regression, change the removal test to remove
symlinks only if they are broken.
e.g. when they point to a moved/old Xenomai installation.
Also run the cleanup code only when not in reverse mode.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 scripts/prepare-kernel.sh | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index 5108737ea..0afb812a4 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -57,18 +57,16 @@ patch_link() {
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
-	if test "x$output_patch" =3D "x" -a -e $linux_tree/$link_dir; then
+	if test "x$output_patch" =3D "x" -a "x$reverse" =3D "x0" -a -e $linux_t=
ree/$link_dir; then
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

