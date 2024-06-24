Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41D31A08BA
	for <xenomai@lists.linux.dev>; Mon, 24 Jun 2024 20:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719261248; cv=none; b=lO1N57U0veB7aB36QyylkYZsJgETwZyryy02eXzd/VohiEn5217oXjRA+wFyCKi/6nip6gCK+A9/zT6A/7McZ6HhtsgQQs1+GcbZtSOlo3zreHv0bnqbGReFvkt1UXOX+xJJfBmSrARkd8U+rrlJ5NHIr4mzk2D+5UqDDzRLfA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719261248; c=relaxed/simple;
	bh=q56wdxNLovPR3h7sSAaFPc5XyO88tZKTSc03fV5hzPI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RqhNnjT/zfTXyjsE411oxwbf3xL9QUWRCr5rvhmF2NiQpDEKub2L21gPHZ35XrZT2XkSH7oBK+BLSQls+siq37ycXRLSnjYbEudxlhwhWzTbSs8yuZ9vZCCO7Ct3WV1USvLIrl1WnyqTbKIJjIjy+lz3MRbE0yYVCbGlweWiZ1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id B5133626FAFC;
	Mon, 24 Jun 2024 22:33:55 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Nv9iXfDPQaN9; Mon, 24 Jun 2024 22:33:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id A640D63D93AD;
	Mon, 24 Jun 2024 22:33:54 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xIbdtthXYl1Q; Mon, 24 Jun 2024 22:33:54 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 5D72D6195FD1;
	Mon, 24 Jun 2024 22:33:54 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 10/14] prepare-kernel.sh: Fix dovetail check
Date: Mon, 24 Jun 2024 22:33:37 +0200
Message-Id: <20240624203341.6263-11-richard@nod.at>
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

$probe_header and $arch_probe_header are only set when --dovetail=3D is u=
sed,
otherwise they are unset and checking whether the kernel has dovetail
always succeeds.

Fix by remove the variables and use the header files directly.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 scripts/prepare-kernel.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index d16e3feab..cc1907b63 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -129,8 +129,6 @@ while test $# -gt 0; do
 	--dovetail=3D*)
 		pipeline_patch=3D`echo $1|sed -e 's,^--dovetail=3D\\(.*\\)$,\\1,g'`
 		pipeline_patch=3D`eval "echo $pipeline_patch"`
-		probe_header=3Dinclude/linux/dovetail.h
-		arch_probe_header=3Dinclude/asm/dovetail.h
 	;;
 	--arch=3D*)
 		linux_arch=3D`echo $1|sed -e 's,^--arch=3D\\(.*\\)$,\\1,g'`
@@ -257,7 +255,7 @@ if test x$verbose =3D x1; then
 	echo "Preparing kernel $linux_version$linux_EXTRAVERSION in $linux_tree=
..."
 fi
=20
-if test -r $linux_tree/$probe_header; then
+if test -r $linux_tree/include/linux/dovetail.h; then
 	if test x$verbose =3D x1; then
 		echo "IRQ pipeline found - bypassing patch."
 	fi
@@ -283,7 +281,7 @@ else
 fi
=20
 for a in $target_linux_archs; do
-	if test \! -r $linux_tree/arch/$a/$arch_probe_header; then
+	if test \! -r $linux_tree/arch/$a/include/asm/dovetail.h; then
 		echo "$me: $linux_tree has no IRQ pipeline support for $a" >&2
 		exit 2
 	fi
--=20
2.35.3

