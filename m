Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2403F9D9
	for <xenomai@lists.linux.dev>; Sat, 25 May 2024 11:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716638323; cv=none; b=E6X16FKpVOQqE3A5BWfJGlPWIp64SkUZ2Vg3VnDggnQsFIJTydFcbSBWwi0OJ92BYKO5pVq7Db37/8Dz9GVe+kO7ZGe33PQk/p50epnEOMxLbxCAACCFNbyeNDcs5Vb9ceeHYStaGwuEAhA1x0YLD1iX8FhlxonfNHygc6KhbuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716638323; c=relaxed/simple;
	bh=czXcMUMN0Dgkywp0hB6lnLcnolDRWu6ekw/x2k4w8kI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qeKfvM6tOugfd9+Eo9h1RMaugwbJbQuLKU9R7uO2zJwi7z9PCejPpVRWtJ8GOoYY2tSbR4fOTAazC1NlDKPTXWv/FpBRI4nlyvF2UtQD1HWCg9814s7X0eIIHhp9BtF9u1C+nb2jJs3h3Eu+I+zpKRT9kP9OtRpYXLh8GMZj5r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id AA8C1644CE8E;
	Sat, 25 May 2024 13:58:30 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id CyeWC2EpdzH5; Sat, 25 May 2024 13:58:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 322626340E1A;
	Sat, 25 May 2024 13:58:30 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1XHASGJMyl3F; Sat, 25 May 2024 13:58:30 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id EB49F6340E17;
	Sat, 25 May 2024 13:58:29 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 11/16] prepare-kernel.sh: Remove --forcelink
Date: Sat, 25 May 2024 13:58:01 +0200
Message-Id: <20240525115806.12101-12-richard@nod.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240525115806.12101-1-richard@nod.at>
References: <20240525115806.12101-1-richard@nod.at>
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
 scripts/prepare-kernel.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index 2b74e9f7b..214a008e3 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -82,7 +82,7 @@ patch_link() {
 				rm -f $linux_tree/$link_dir/$f
 			else
 				mkdir -p $linux_tree/$link_dir/$d
-				if test x$forcelink =3D x1 -o ! $xenomai_root/$target_dir/$f -ef $li=
nux_tree/$link_dir/$f; then
+				if test ! $xenomai_root/$target_dir/$f -ef $linux_tree/$link_dir/$f;=
 then
 					ln -sf $xenomai_root/$target_dir/$f $linux_tree/$link_dir/$f
 				fi
 			fi
@@ -117,7 +117,7 @@ generate_patch() {
 }
=20
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
@@ -145,7 +145,7 @@ while test $# -gt 0; do
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

