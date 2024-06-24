Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42501A08C0
	for <xenomai@lists.linux.dev>; Mon, 24 Jun 2024 20:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719261248; cv=none; b=h4acaGJai02/f7qUfZUv3WSWDpMqktJCHXwqywToLQo5c7NTkwaYdtcu4lHrTmTu0OmbcPcA7m1ElgsgZtgMPN9lmVRWaWH3vR+12+LybUmpvk6a5of2A3QG/vX/HjqX9MzwsVJ8lkBT+oqPe/ekpFLX4+Ek4iWDDzrI1ipVbuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719261248; c=relaxed/simple;
	bh=aVrzg+J46wWkmQMXPVvY5HmVzMN5fND53iSkdAif5Kg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ci/P66p9RQ7fy1IqoNOHhtDhKDy5xWYMw7jh3CDMdNnyGbL5xYo5K/v8xiLt4tNqtLU9g7fdeus6CDGRMN7nk2AMDBkLSAWqwEGQgMctz2AgM2+/vH4ErNDk4VWPFr9yNtPPf4JBYYmDDjqJrD9Q7g4N7lgVAceaSSIhbdCLY5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 94C7F61966B8;
	Mon, 24 Jun 2024 22:33:55 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 8ChuR0HMcVLT; Mon, 24 Jun 2024 22:33:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 33127644CE7C;
	Mon, 24 Jun 2024 22:33:54 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id QlppiiiBZiX9; Mon, 24 Jun 2024 22:33:54 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id C9E0F61966AF;
	Mon, 24 Jun 2024 22:33:53 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 07/14] prepare-kernel.sh: Remove interactivity
Date: Mon, 24 Jun 2024 22:33:34 +0200
Message-Id: <20240624203341.6263-8-richard@nod.at>
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

Let's reduce complexity and remove user interaction, all parameters
shall get set using command line switches instead.
This makes also --default obsolete, if someone passes --linux=3D (empty)
to the script, it will from now on automatically fall back to /lib/module=
s/`uname -r`/source.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 scripts/prepare-kernel.sh | 36 +++++++++---------------------------
 1 file changed, 9 insertions(+), 27 deletions(-)

diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index ad2cacd4e..a6eb6c1e0 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -119,7 +119,7 @@ generate_patch() {
 	)
 }
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
@@ -150,7 +150,7 @@ while test $# -gt 0; do
 		forcelink=3D1
 		;;
 	--default)
-		usedefault=3D1
+		echo "$me: warning: --default is deprecated and now always on" >&2
 		;;
 	--verbose)
 		verbose=3D1
@@ -182,23 +182,9 @@ xenomai_root=3D`cd $xenomai_root && pwd`
=20
 default_linux_tree=3D/lib/modules/`uname -r`/source
=20
-while test x$linux_tree =3D x; do
-	if test x$usedefault =3D x; then
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
@@ -281,14 +267,10 @@ else
 	if test x$verbose =3D x1; then
 		echo "$me: no IRQ pipeline support found." >&2
 	fi
-	while test x$pipeline_patch =3D x; do
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

