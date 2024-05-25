Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19FE3032A
	for <xenomai@lists.linux.dev>; Sat, 25 May 2024 11:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716638323; cv=none; b=eDVSntSDusF8r4xBveKyj3hvbJGnOeCw0wotrKbQwXtl+Zjol2OScVNxXBPSvY+ZPpKWCDZ/3+81WH7HMasl1VJiaRnehsECw9IB7xSQKBXRCnorRo4rzOhTUZZ1Mwrlwan9zlFdLVwkIC3lhrFg+OgQVTAGk7LSUMjok0U0Ft8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716638323; c=relaxed/simple;
	bh=YgBB+1iOlcHj93XCWst3D17B8WWNQNLOjm9ouG0v7hQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EQjjlF7BhqcVZyJg2ZL7ivvZXLBHVRKQFOX8GpQ3e+BA/sqgtHrDPgUFHI5FAHLa3iZJ3qAKUfP7YBCr/ysP+J3yigNNti+JiIADgRQN0viFf1jLtx04DEYW0dfkdiD5O9/2UwvPnc61YXqQ3vlLlIsdLO056MZjg31x1Uc5Mgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 8E52862348A5;
	Sat, 25 May 2024 13:58:30 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id PTw8ENlQmWl9; Sat, 25 May 2024 13:58:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id F08F86195FFB;
	Sat, 25 May 2024 13:58:29 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id czmKcUvmDIqd; Sat, 25 May 2024 13:58:29 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id BABF563DCAC9;
	Sat, 25 May 2024 13:58:29 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 10/16] prepare-kernel.sh: Remove interactivity
Date: Sat, 25 May 2024 13:58:00 +0200
Message-Id: <20240525115806.12101-11-richard@nod.at>
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

Let's reduce complexity and remove user interaction, all parameters
shall get set using command line switches instead.
This makes also --default obsolete, if someone passes --linux=3D (empty)
to the script, it will from now on automatically fall back to /lib/module=
s/`uname -r`/source.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 scripts/prepare-kernel.sh | 38 +++++++++-----------------------------
 1 file changed, 9 insertions(+), 29 deletions(-)

diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index 53ff89abd..2b74e9f7b 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -117,7 +117,7 @@ generate_patch() {
 }
=20
=20
-usage=3D'usage: prepare-kernel --linux=3D<linux-tree> [--dovetail=3D<dov=
etail-patch>] [--arch=3D<arch>] [--outpatch=3D<file> [--forcelink] [--def=
ault] [--verbose] [--reverse]'
+usage=3D'usage: prepare-kernel --linux=3D<linux-tree> [--dovetail=3D<dov=
etail-patch>] [--arch=3D<arch>] [--outpatch=3D<file> [--forcelink] [--ver=
bose] [--reverse]'
 me=3D`basename $0`
=20
 while test $# -gt 0; do
@@ -148,7 +148,7 @@ while test $# -gt 0; do
 		forcelink=3D1
 		;;
 	--default)
-		usedefault=3D1
+		echo "$me: warning: --default is deprecated and now always on" >&2
 		;;
 	--verbose)
 		verbose=3D1
@@ -180,24 +180,9 @@ xenomai_root=3D`cd $xenomai_root && pwd`
=20
 default_linux_tree=3D/lib/modules/`uname -r`/source
=20
-while test x$linux_tree =3D x; do
-	if test x$usedefault =3D x; then
-		# shellcheck disable=3DSC3037
-		echo -n "Linux tree [default $default_linux_tree]: "
-		read linux_tree
-	fi
-	if test x$linux_tree =3D x; then
-		linux_tree=3D$default_linux_tree
-	fi
-	if test \! -x "$linux_tree"; then
-		echo "$me: cannot access Linux tree in $linux_tree"
-		linux_tree=3D
-		usedefault=3D
-		default_linux_tree=3D/usr/src
-	else
-		break
-	fi
-done
+if test x$linux_tree =3D x; then
+	linux_tree=3D$default_linux_tree
+fi
=20
 linux_tree=3D`cd $linux_tree && pwd`
=20
@@ -280,15 +265,10 @@ else
 	if test x$verbose =3D x1; then
 		echo "$me: no IRQ pipeline support found." >&2
 	fi
-	while test x$pipeline_patch =3D x; do
-		# shellcheck disable=3DSC3037
-		echo -n "IRQ pipeline patch: "
-		read pipeline_patch
-		if test \! -r "$pipeline_patch" -o x$pipeline_patch =3D x; then
-			echo "$me: cannot read IRQ pipeline support from $pipeline_patch" >&2
-			pipeline_patch=3D
-		fi
-	done
+	if test x$pipeline_patch =3D x; then
+		echo "$me: no IRQ pipeline support found in $linux_tree and --dovetail=
=3D not set" >&2
+		exit 2
+	fi
 	patchdir=3D`dirname $pipeline_patch`;
 	patchdir=3D`cd $patchdir && pwd`
 	pipeline_patch=3D$patchdir/`basename $pipeline_patch`
--=20
2.35.3

