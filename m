Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756EB405D8
	for <xenomai@lists.linux.dev>; Sat, 25 May 2024 11:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716638323; cv=none; b=s586xKFbCYaciSIBGWgf4VcY2L95mnerICE2bvbGPgR5OpqoXtBZsd6x2MhB8+0eKBc+xMZmlfIEIpVhZ/NNjj9QtyiJ/eg15KZitOC5iIvfPLwOUUUGAbwQQ6Ut5Uhm2HEdmAmpxsRQXguDZzytq8wH8d/SnXXsO8EgW7pMtoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716638323; c=relaxed/simple;
	bh=z2GUFRXpaioPG///2zGTLdwJXpFPu+WZcpHnZkOU270=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sckh/ut0n6fARmfeEM0stMufnnZyMWt+/CV8seWlVNesoAA1t6h3XBUQHuClm6sJgekXaqCJX60cjNOztqYC0Bmk9mptK/0obZGxUbYKKutHLfmlinSFlQz+O3Bq9kIAhYUr6DaqfiFRJAy0QmypIuKshtgGXxIavvckfSCYuA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 3823A63DCAC9;
	Sat, 25 May 2024 13:58:31 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id e21sIgJOREIO; Sat, 25 May 2024 13:58:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id E57C5644CE93;
	Sat, 25 May 2024 13:58:30 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id QtOPPGp2XDKe; Sat, 25 May 2024 13:58:30 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id A1668644CE83;
	Sat, 25 May 2024 13:58:30 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 14/16] prepare-kernel.sh: Remove dead code
Date: Sat, 25 May 2024 13:58:04 +0200
Message-Id: <20240525115806.12101-15-richard@nod.at>
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

CONFIG_XENO_REVISION_LEVEL was added via
b370b7d54 ("build: introduce core API revision level in userland"),
to my best knowledge it was dead code since ever.
Let's remove it.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 scripts/prepare-kernel.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index 43883ded3..fe9dd5de5 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -325,8 +325,6 @@ case $linux_VERSION.$linux_PATCHLEVEL in
 		patch_reverse init/Kconfig
 	fi
=20
-test "x$CONFIG_XENO_REVISION_LEVEL" =3D "x" && CONFIG_XENO_REVISION_LEVE=
L=3D0
-
 	for a in $target_linux_archs; do
 		if ! grep -q CONFIG_XENOMAI $linux_tree/arch/$a/Makefile; then
 			p1=3D"KBUILD_CFLAGS +=3D -I\$(srctree)/arch/\$(SRCARCH)/xenomai/inclu=
de -I\$(srctree)/include/xenomai"
--=20
2.35.3

