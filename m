Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0230C3D967
	for <xenomai@lists.linux.dev>; Sat, 25 May 2024 11:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716638323; cv=none; b=Tp+VSjpIYHme53FjV0ptYtiDSwNefWX3iFRBsFCJKScRvWP+nySqmFUrFnIcVI47M99rKKvGMJoHiaPEQtX3ZIp1kp53DgU0+GoGA5SYzW1WIUYsR1W0VK/T2YS8GvW22Se10V9i8Hp9yyWHR9nW23PduEkiywKyDgAq76a47aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716638323; c=relaxed/simple;
	bh=sm5vjuGjANmkXyvYg49ye7j2C3yfHMzYKOh/8GAr77M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O9cVxGGXZw7hhYrtCBFTbI4bf1VQ8+P1OZQapO5SmF6LOsytka5zH3bM84dyysCc7VZJUZrulJVfCOt2f9qyB0XeCAoL2oqoSPI1yr20KogcPJTLVty1l1icVvD9E9FMnDiF4v1qK95CdMX7ZTNUmqvak/V5CU1r0fojWyID4PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id DBA906343503;
	Sat, 25 May 2024 13:58:29 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 1qsFQknqElLk; Sat, 25 May 2024 13:58:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 7A90A64103F3;
	Sat, 25 May 2024 13:58:29 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ozwjN9uyhjOy; Sat, 25 May 2024 13:58:29 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 24E4E6340E17;
	Sat, 25 May 2024 13:58:29 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 07/16] prepare-kernel.sh: Don't use eval
Date: Sat, 25 May 2024 13:57:57 +0200
Message-Id: <20240525115806.12101-8-richard@nod.at>
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

eval is evil and confuses shellcheck.

Fixes:
In scripts/prepare-kernel.sh line 302:
linux_version=3D"$linux_VERSION.$linux_PATCHLEVEL.$linux_SUBLEVEL"
               ^------------^ SC2154 (warning): linux_VERSION is referenc=
ed but not assigned (did you mean 'linux_version'?).
                              ^---------------^ SC2154 (warning): linux_P=
ATCHLEVEL is referenced but not assigned.
                                                ^-------------^ SC2154 (w=
arning): linux_SUBLEVEL is referenced but not assigned.

In scripts/prepare-kernel.sh line 305:
        echo "Preparing kernel $linux_version$linux_EXTRAVERSION in $linu=
x_tree..."
                                             ^-----------------^ SC2154 (=
warning): linux_EXTRAVERSION is referenced but not assigned.

Instead of using eval plus grep and sed, just use good old awk.
Tested also with busybox awk.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 scripts/prepare-kernel.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index e78c48e61..3c13d471f 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -298,10 +298,10 @@ if [ ! -z $foo ] ; then
 fi
 unset foo
=20
-eval linux_`grep '^EXTRAVERSION =3D' $linux_tree/Makefile | sed -e 's, ,=
,g'`
-eval linux_`grep '^PATCHLEVEL =3D' $linux_tree/Makefile | sed -e 's, ,,g=
'`
-eval linux_`grep '^SUBLEVEL =3D' $linux_tree/Makefile | sed -e 's, ,,g'`
-eval linux_`grep '^VERSION =3D' $linux_tree/Makefile | sed -e 's, ,,g'`
+linux_EXTRAVERSION=3D`awk -F=3D '/^EXTRAVERSION =3D/{ gsub(/ /, "", $2);=
 print $2}' $linux_tree/Makefile`
+linux_PATCHLEVEL=3D`awk -F=3D '/^PATCHLEVEL =3D/{ gsub(/ /, "", $2); pri=
nt $2}' $linux_tree/Makefile`
+linux_SUBLEVEL=3D`awk -F=3D '/^SUBLEVEL =3D/{ gsub(/ /, "", $2); print $=
2}' $linux_tree/Makefile`
+linux_VERSION=3D`awk -F=3D '/^VERSION =3D/{ gsub(/ /, "", $2); print $2}=
' $linux_tree/Makefile`
=20
 linux_version=3D"$linux_VERSION.$linux_PATCHLEVEL.$linux_SUBLEVEL"
=20
--=20
2.35.3

