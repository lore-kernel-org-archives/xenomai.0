Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F7E2233B
	for <xenomai@lists.linux.dev>; Mon, 24 Jun 2024 20:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719261248; cv=none; b=nTx2bx+ISKYzozgqAVnCiHdwWwF1JyZM/B6VX+sbX5uA1JW2AaP7NyrWWJGiy0lMcKi8fvgQ80MoJfeS0cq7ecXwOfly8gbbG05nh8AQoeZY+2wPfXlvpgx9xvMu5j1sqW6ndTLta6Ah/BwnyNvauozXEocp7VlomiB56RFBzgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719261248; c=relaxed/simple;
	bh=aVhldSUpIZtKnXLtyzsse4R+DouLmsoIXFks9vDPo44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OklBUIV48wnNMhLI5LnEnzk9+KBku5nKJ2kVcxacgi8BF4nv/QVqwDfCGBNByplGDCwvce1lsspZI10fJzEPFS44LcKsIcXH0gZKkO4Qf9mp1TRagjE8HVhApNTlR+8bxZ2fQ6xXgqdjUjjpy6BqpdlZew9LrIBrg4KXZYCwjR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 2C0056196386;
	Mon, 24 Jun 2024 22:33:55 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id eNaqiDcZd9Hs; Mon, 24 Jun 2024 22:33:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 6585B647A803;
	Mon, 24 Jun 2024 22:33:54 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qYLvcxn87sWl; Mon, 24 Jun 2024 22:33:54 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 2959764103E3;
	Mon, 24 Jun 2024 22:33:54 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 09/14] prepare-kernel.sh: Remove --forcelink
Date: Mon, 24 Jun 2024 22:33:36 +0200
Message-Id: <20240624203341.6263-10-richard@nod.at>
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

To my best knowledge, the idea behind --forcelink was forcing
the script to recreate the symlinks if the xenomai tree has changed.
But since  7098866e0 ("Fix prepare-kernel.sh when it is run in order to c=
hange the xenomai directory to which the kernel is linked").
the script is smart enough to figure whether links need an update.
So, --forcelink is essentially in vain and can be removed.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 scripts/prepare-kernel.sh | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index 26333c419..d16e3feab 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -84,9 +84,7 @@ patch_link() {
 				rm -f $linux_tree/$link_dir/$f
 			else
 				mkdir -p $linux_tree/$link_dir/$d
-				if test x$forcelink =3D x1 -o \
-					! $xenomai_root/$target_dir/$f -ef $linux_tree/$link_dir/$f;
-				then
+				if test ! $xenomai_root/$target_dir/$f -ef $linux_tree/$link_dir/$f;=
 then
 					ln -sf $xenomai_root/$target_dir/$f $linux_tree/$link_dir/$f
 				fi
 			fi
@@ -119,7 +117,7 @@ generate_patch() {
 	)
 }
=20
-usage=3D'usage: prepare-kernel --linux=3D<linux-tree> [--dovetail=3D<dov=
etail-patch>] [--arch=3D<arch>] [--outpatch=3D<file> [--forcelink] [--ver=
bose] [--reverse]'
+usage=3D'usage: prepare-kernel --linux=3D<linux-tree> [--dovetail=3D<dov=
etail-patch>] [--arch=3D<arch>] [--outpatch=3D<file> [--verbose] [--rever=
se]'
 me=3D`basename $0`
=20
 while test $# -gt 0; do
@@ -147,7 +145,7 @@ while test $# -gt 0; do
 		echo "$me: warning: --filterarch=3D is deprecated and now a no-op" >&2
 		;;
 	--forcelink)
-		forcelink=3D1
+		echo "$me: warning: --forcelink is deprecated and now a no-op" >&2
 		;;
 	--default)
 		echo "$me: warning: --default is deprecated and now always on" >&2
--=20
2.35.3

