Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761C7819
	for <xenomai@lists.linux.dev>; Thu, 27 Jun 2024 08:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719478497; cv=none; b=Eh9E5H/4g6oZdPCZkoqg3t1wEmA3hsT+OYzafmC+yHJS1NEkQqjeexMHfGPY/slNgWjJ8j6d7c+Jpb9zXQ1COkVG22UdcxQozpkJBbtf3aIvat+3sCncOsPESQ+5Gf3liO/qb78z4cZcPIkTBeh9yVd9gjZ5pQTQtYupjHdBaCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719478497; c=relaxed/simple;
	bh=u7c+srT/t2s53stnRK+rZpWHo0R0aa5FrNO9MNEoFb0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eEXwQrdXzHrrXI/HImzROVxlTn7lFW2inNZdiLp9dciZ3neHU72vjbWWGe5CYZokOgXh3BDhsDUUtkmymFbFuL/yvJNdzRNz6AmApGtHSnhld6mfRLNLZVX7Yugi0M35/49czaWrpWltNeyW5vbtovRPJ2lyM+lYQ7czrXDzwZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 97715606BA37;
	Thu, 27 Jun 2024 10:54:46 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 5RrgNuE9q_fa; Thu, 27 Jun 2024 10:54:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 4ECD5647A807;
	Thu, 27 Jun 2024 10:54:46 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id CygBy3bMER6g; Thu, 27 Jun 2024 10:54:46 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 21023606BA37;
	Thu, 27 Jun 2024 10:54:46 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH v2] kernel: Clean up generated syscall_entries.h file
Date: Thu, 27 Jun 2024 10:54:34 +0200
Message-Id: <20240627085434.8189-1-richard@nod.at>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add it to the clean-files list, such that Kbuild will remove it
upon make clean.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
Changes since v1:
	- Keep target, it is needed because if if_changed usage
---
 kernel/cobalt/posix/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cobalt/posix/Makefile b/kernel/cobalt/posix/Makefile
index 5b4f3214a..852d221e5 100644
--- a/kernel/cobalt/posix/Makefile
+++ b/kernel/cobalt/posix/Makefile
@@ -32,6 +32,7 @@ $(obj)/syscall_entries.h: $(syscall_entries) $(wildcard=
 $(srctree)/$(src)/*.c) F
 	$(call if_changed,syscall_entries)
=20
 target +=3D syscall_entries.h
+clean-files +=3D syscall_entries.h
=20
 $(obj)/syscall.o: $(obj)/syscall_entries.h
=20
--=20
2.35.3

