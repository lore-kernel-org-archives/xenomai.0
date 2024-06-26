Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE59191494
	for <xenomai@lists.linux.dev>; Wed, 26 Jun 2024 19:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719429997; cv=none; b=eLTS3sMtN1c1P7jizJKfa43GtKvJyK4KBzNyNDZeajkAlisP6OlTJb+R1jwd/DTnGJJk5RD5EdsdeQ8LzvsHAAYBPnbITqGS7ElsFTYIK7x6nTbZL/dXs0bGZYRv3AlkDBQ7ZVBodplC6fnPBmgaJLeAUf89YrEzeJW5jhr16Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719429997; c=relaxed/simple;
	bh=hFEcdUpQcjqJX2Yq5qzZOm0dujGXJ0w0G1aRs783Xko=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JdTqQNjK1IpuqgSKu4I2x5rkVs15p3QL5wTCdjINLEyMSgVRiAlUVmzFuNwLYnpTbUOTxEAE1603xWfkeJ62HZgxpQHBcknEgkveZNDzig+W4dKuAmJ3SdVpVxIAc0TcMtUm7yQAZPjhv+cPBAUnoFK58pzWitSW9tpa1joOhJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 877E461966AF;
	Wed, 26 Jun 2024 21:26:32 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Qljd00iM4Kv1; Wed, 26 Jun 2024 21:26:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id F330A6195FD3;
	Wed, 26 Jun 2024 21:26:31 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id LHCygoWMarUe; Wed, 26 Jun 2024 21:26:31 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id C14C961966AF;
	Wed, 26 Jun 2024 21:26:31 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH] kernel: Clean up generated syscall_entries.h file
Date: Wed, 26 Jun 2024 21:26:25 +0200
Message-Id: <20240626192625.14745-1-richard@nod.at>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add it to the clean-files list, such that Kbuild will remove it
up make clean.
Also drop it from the target list, this variable seems unused
is most likely a copy&paste relict from the past.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 kernel/cobalt/posix/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cobalt/posix/Makefile b/kernel/cobalt/posix/Makefile
index 5b4f3214a..9e2f3f6e0 100644
--- a/kernel/cobalt/posix/Makefile
+++ b/kernel/cobalt/posix/Makefile
@@ -31,7 +31,7 @@ quiet_cmd_syscall_entries =3D GEN     $@
 $(obj)/syscall_entries.h: $(syscall_entries) $(wildcard $(srctree)/$(src=
)/*.c) FORCE
 	$(call if_changed,syscall_entries)
=20
-target +=3D syscall_entries.h
+clean-files +=3D syscall_entries.h
=20
 $(obj)/syscall.o: $(obj)/syscall_entries.h
=20
--=20
2.35.3

