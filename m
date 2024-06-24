Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F374B1A08B2
	for <xenomai@lists.linux.dev>; Mon, 24 Jun 2024 20:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719261244; cv=none; b=GIm4GGwDqtXf0bR+0UdokEy6qMqsGuo7ZEH6VL/EtNyEdyOZ3qo4SmIrwh+8RPWR9tvJzACYHpoZ0UUODvrr82jBwsigsvFtakQANqAmcwsw17f3n+E+9Df42S/hrbyfuoUawdhcPw0cV5SuoatCwM6CTn4KBUDyr/C6wwG3iWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719261244; c=relaxed/simple;
	bh=uzALpQ49zvtTwVKSnJzcBj3fqyMcNb9HSMRtHhtP4lI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k1FfQigKszHhEkXs+nz2K1j2l32geLkj3W3DGyp9OG6SDUD8+z5qYbnjpy5jo1GQbE49r9ke9c4zVYDQ8BJdEUNyqSQfRi53aQMw83dXWAdTGLD8P2uEOUvf+dFCTn2yWJHdaIwCo9F6M6z2bz5xC+xTNGASskFzLRAwp8j01Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 7F8B86195FE9;
	Mon, 24 Jun 2024 22:33:54 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id MsSjy89L0auM; Mon, 24 Jun 2024 22:33:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 5EC8361F0AB9;
	Mon, 24 Jun 2024 22:33:53 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id k-q3VV2bnjf9; Mon, 24 Jun 2024 22:33:53 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 2D4416195FE9;
	Mon, 24 Jun 2024 22:33:53 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 04/14] prepare-kernel.sh: Improve kernel tree check
Date: Mon, 24 Jun 2024 22:33:31 +0200
Message-Id: <20240624203341.6263-5-richard@nod.at>
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

Currently any directory that contains a Makefile is treated as kernel tre=
e.
This causes strange errors when calling the script without parameters
within the Xenomai tree.

$ ./scripts/prepare-kernel.sh
./scripts/prepare-kernel.sh: line 298: linux_: command not found

Fix it by checking the kernel README file.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 scripts/prepare-kernel.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index aa845e65e..5712f760d 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -239,7 +239,7 @@ done
=20
 linux_tree=3D`cd $linux_tree && pwd`
=20
-if test \! -r $linux_tree/Makefile; then
+if test "$(head -1 $linux_tree/README 2> /dev/null)" !=3D "Linux kernel"=
; then
 	echo "$me: $linux_tree is not a valid Linux kernel tree" >&2
 	exit 2
 fi
--=20
2.35.3

