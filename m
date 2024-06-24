Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9011A08BD
	for <xenomai@lists.linux.dev>; Mon, 24 Jun 2024 20:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719261248; cv=none; b=NKw18bvJsPhTAAeHhKVF/JN4NgcKrCY6dGTJxvxq4jhuudDVY1aLkPhBEHYDpOR2JAVkbk+xz/tWCVPEW+m5TiVpEHovJEghcfvoy1KMSx1p9jSZ3AvHF6yCQ7CfoYleh7yGJXvPnQcnReOzanHtCdGaoTaEmfsUxH9AO9IA7Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719261248; c=relaxed/simple;
	bh=jgfANf+fgTfv/WhIj8sOygk7JhJVkUjsYra2EqRt4/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lce9GuyqKFe67GIKRMaIJatAnDbMURDLO7kKwbc+lAHxS/TWAgL6u97Qvv1a6qbiupDTQs2yv2Yj4wTXvF24/dz/21HfM+BTVrN6oVPHt4mBI0u71sLoPlu9QlOYKOB3pkllSig63Naa7afGJApErORJopP+laZSkYoKlR50HgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id C0CF7626FAF4;
	Mon, 24 Jun 2024 22:33:55 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id ZGTBEOF-3YGM; Mon, 24 Jun 2024 22:33:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 32EF3647A800;
	Mon, 24 Jun 2024 22:33:55 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id A1e_l28Nr2v4; Mon, 24 Jun 2024 22:33:55 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id EF95D6195FE0;
	Mon, 24 Jun 2024 22:33:54 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 12/14] prepare-kernel.sh: Remove dead code
Date: Mon, 24 Jun 2024 22:33:39 +0200
Message-Id: <20240624203341.6263-13-richard@nod.at>
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

CONFIG_XENO_REVISION_LEVEL was added via
b370b7d54 ("build: introduce core API revision level in userland"),
to my best knowledge it was dead code since ever.
Let's remove it.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 scripts/prepare-kernel.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index e1d1c318d..37be3a3b0 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -323,8 +323,6 @@ case $linux_VERSION.$linux_PATCHLEVEL in
 		patch_append init/Kconfig
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

