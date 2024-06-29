Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18E078C8E
	for <xenomai@lists.linux.dev>; Sat, 29 Jun 2024 13:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719668731; cv=none; b=YbA2jiamj/d32MU1G8Y6fMmL9boYR4rq8YJH8ygx/dkHowJyNlCvDCdUer6JvDbG9WoL96iDbUCdxgqMpPbNrvRcl2FB+ohMZxS//n39eUS+70yls87B3W5QbTXPBTDzOnZc6LYgKLk/wlCu6bqkKjzOSjuffep6jfWFboQQQt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719668731; c=relaxed/simple;
	bh=SlRqhrsc1maGioKq0CyG/41YI1rqbE1EDROUXG7351Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sjHWXawMvBIuTHGqrKlCNb/PenTgygbRW3tX1dbWg922871PgP12fPuSdgLUgfd36E89Nn/nxvyFR4fzn1MmrA1GLsxlJjmvF+7inw94vT1m0qdTtoiwhyDAQyMA87TxHX07esgMkiGtFcZSN13M1o88KXN7uns2fIwqexBrqwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 155FD61966A5;
	Sat, 29 Jun 2024 15:45:20 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 33tqdS0SWiM9; Sat, 29 Jun 2024 15:45:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 8CF7461966A3;
	Sat, 29 Jun 2024 15:45:19 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id CaruhYXJ0rXd; Sat, 29 Jun 2024 15:45:19 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 5C41C6195FD3;
	Sat, 29 Jun 2024 15:45:19 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 3/5] Refactor .gitignore file
Date: Sat, 29 Jun 2024 15:45:02 +0200
Message-Id: <20240629134504.11148-4-richard@nod.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240629134504.11148-1-richard@nod.at>
References: <20240629134504.11148-1-richard@nod.at>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add C and autoconf specific artefacts.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 .gitignore | 56 ++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 16 deletions(-)

diff --git a/.gitignore b/.gitignore
index b1d682032..402604c59 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,17 +1,41 @@
+# Regular C artifacts
+*.a
+*.la
+*.lo
+*.o
+*.s
+*.so
+
+# autoconf specific
+/aclocal.m4
+/autom4te.cache
+/config.log
+/config.status
+/config/compile
+/config/config.guess
+/config/config.sub
+/config/depcomp
+/config/install-sh
+/config/libtool.m4
+/config/ltmain.sh
+/config/ltoptions.m4
+/config/ltsugar.m4
+/config/ltversion.m4
+/config/lt~obsolete.m4
+/config/missing
+/configure
+/include/stamp-h?
+/libtool
+/include/xeno_config.h
+/include/xeno_config.h.in*
+/.ccache
+.deps
+.libs
+.dirstamp
+Makefile
 Makefile.in
-include/xeno_config.h.in*
-config/compile
-config/config.guess
-config/config.sub
-config/depcomp
-config/install-sh
-config/libtool.m4
-config/ltmain.sh
-config/ltoptions.m4
-config/ltsugar.m4
-config/ltversion.m4
-config/lt~obsolete.m4
-config/missing
-configure
-aclocal.m4
-autom4te.cache
+# They are part of AC_CONFIG_FILES
+/utils/net/rtnet
+/utils/net/rtnet.conf
+/scripts/xeno
+/scripts/xeno-config
--=20
2.35.3

