Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E0B3E462
	for <xenomai@lists.linux.dev>; Sat, 25 May 2024 11:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716638319; cv=none; b=tr7pAwmP6ZqY6dnkxF/8Yc3iQYE7+ON42NVgYnl7ylbXg4QYHBD8Et7bjl0WyuN61HbCyL+jQfwabai6PGf9aIec4hX1ta3Wkm2Hlqkfg4v/BhkDOz9Dwtt4pEUdMc1R2ksEW23P2WtmJjRFBeKjS914iCz8XDtrtgaHT1ayruw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716638319; c=relaxed/simple;
	bh=jF39tRUIuAdVRnz2Qc12V9wAX20daq+oWrYehCAvglc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=smkamIZd/WsMSWQ6NjO05Op6BqwpJYnQGSStVk82FwvgZDgnTWufD/LFhsmuDQpGKqU+anbzYCccN2wYMvRivFBepaLdQUJ7uOeKV2kH73yewpGmU2hXt+Z9UMtd+mRP/uVSCOR+MSXn3M4CMmbnejV6kXgeUwK7eP6jpzirCEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 1A59D626FAF9;
	Sat, 25 May 2024 13:58:29 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id ACBydy6JFOsQ; Sat, 25 May 2024 13:58:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id B7D5E64103ED;
	Sat, 25 May 2024 13:58:28 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kt9dKH7C5Oz2; Sat, 25 May 2024 13:58:28 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 523FE6340E1A;
	Sat, 25 May 2024 13:58:28 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 04/16] prepare-kernel.sh: Improve kernel tree check
Date: Sat, 25 May 2024 13:57:54 +0200
Message-Id: <20240525115806.12101-5-richard@nod.at>
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

Currently any directory that contains a Makefile is treated as kernel tre=
e.
This causes strange errors when calling the script without parameters
within the Xenomai tree.

$ ./scripts/prepare-kernel.sh
./scripts/prepare-kernel.sh: line 298: linux_: command not found

Fix it by checking for a more specific file in the kernel tree.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 scripts/prepare-kernel.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index 534531e2b..800528058 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -237,7 +237,7 @@ done
=20
 linux_tree=3D`cd $linux_tree && pwd`
=20
-if test \! -r $linux_tree/Makefile; then
+if test \! -r $linux_tree/kernel/kallsyms.c; then
 	echo "$me: $linux_tree is not a valid Linux kernel tree" >&2
 	exit 2
 fi
--=20
2.35.3

