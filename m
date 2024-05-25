Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022CD3D3B9
	for <xenomai@lists.linux.dev>; Sat, 25 May 2024 11:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716638322; cv=none; b=HM2QGIjoYhnqX+0so4B6G/WB9TRffvU9N5jM8XjDQ0z14bZp6XolbwvbguNKAUtr5rzNQtjnn7CLdlJZinZaAcPByGinV62/ESoIfj7++wX8MZ6qtrHibnsfLHVmEMjFNdUiLsYsvTu7kPnJ4pBW10ffQPuHv18zm8zGaFoDEI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716638322; c=relaxed/simple;
	bh=8DYqjFSFf0M7ei81OsN8OkkJnVIANptfdo6HxQPLJyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KMWnjEDnz4fOnbmSbIuQwXcJ6RhP5RWF5+ic2aVm/zXaWalStrmFqhIcVZvu85oTO9W3xoogHhgPgCD+641IkTjOotGAjL4Sb0OQnbE+HHpI+xdCbYhc4rkvSUCLouUgr9WFXMjPwdTr0fqOcw34Qsj6d32r/oFycYMQ1WGfZXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id F347064103ED;
	Sat, 25 May 2024 13:58:29 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id jUxHmYcbAISX; Sat, 25 May 2024 13:58:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 9942962348A5;
	Sat, 25 May 2024 13:58:29 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id EDekC8m1Emp2; Sat, 25 May 2024 13:58:29 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 539DA6340E1A;
	Sat, 25 May 2024 13:58:29 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 08/16] prepare-kernel.sh: Don't depend on bash
Date: Sat, 25 May 2024 13:57:58 +0200
Message-Id: <20240525115806.12101-9-richard@nod.at>
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

- type -p is not POSIX, so use realpath(1), I think it is safe
to assume this tool.

- echo -n is also not POSIX, but if some echo command does not support
omitting the trailing newline, so what...

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 scripts/prepare-kernel.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index 3c13d471f..f7aca804f 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -1,4 +1,4 @@
-#! /bin/bash
+#!/bin/sh
 set -e
=20
 unset CDPATH
@@ -210,7 +210,7 @@ done
 # Infere the location of the Xenomai source tree from
 # the path of the current script.
=20
-script_path=3D`type -p $0`
+script_path=3D`realpath $0`
 xenomai_root=3D`dirname $script_path`/..
 xenomai_root=3D`cd $xenomai_root && pwd`
=20
@@ -220,6 +220,7 @@ default_linux_tree=3D/lib/modules/`uname -r`/source
=20
 while test x$linux_tree =3D x; do
 	if test x$usedefault =3D x; then
+		# shellcheck disable=3DSC3037
 		echo -n "Linux tree [default $default_linux_tree]: "
 		read linux_tree
 	fi
@@ -318,6 +319,7 @@ else
 		echo "$me: no IRQ pipeline support found." >&2
 	fi
 	while test x$pipeline_patch =3D x; do
+		# shellcheck disable=3DSC3037
 		echo -n "IRQ pipeline patch: "
 		read pipeline_patch
 		if test \! -r "$pipeline_patch" -o x$pipeline_patch =3D x; then
--=20
2.35.3

