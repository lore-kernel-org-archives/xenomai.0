Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8020835294D
	for <xenomai@lists.linux.dev>; Wed, 28 Jan 2026 11:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599713; cv=none; b=p8CXUbGBGE88B19PoT3LtfHRDNHDVGUZ5WcGvlhEShVQfpYWyj7/nE4unta93lLVl6EYGfHZn30SVIXdLt8RxYKC0aNHYxGdFmfAry4d2ZB8cck/f+nf5+DrbQw/8R7mTBb8IbF5/7YyoJg9gYguA/fxFrKdoBeiGZSdMSg3V6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599713; c=relaxed/simple;
	bh=mHq2K/vWwvAi/c218iQwpvjPvh8o7sn6yoVx9ZsuirE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A+/k0mJeOjsMevRoR5PYrtIsWScLRZlgUMqqV3SP59E7ILxbJ3SOWxayjILiznG8IkhGoAlT/jAdJxgcqNh/WUfacs0KGRsKiEWrDElQw5nRi9uoAM/VC0XRRnShLd3GCaqkaC/nbE3ENkjL8+GvteHZfmwoJLEk9uERo9csyss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 7AB18BE332;
	Wed, 28 Jan 2026 12:28:28 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id IUhxR9NdXtay; Wed, 28 Jan 2026 12:28:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id DE4F82FFDBE;
	Wed, 28 Jan 2026 12:28:27 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zCuXignJe1rd; Wed, 28 Jan 2026 12:28:27 +0100 (CET)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 9EEDEBE32B;
	Wed, 28 Jan 2026 12:28:27 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 4/5] Warn on unexpected RTDM task termination
Date: Wed, 28 Jan 2026 12:28:20 +0100
Message-ID: <20260128112821.1232-4-richard@nod.at>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260128112821.1232-1-richard@nod.at>
References: <20260128112821.1232-1-richard@nod.at>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Now that all in-tree RTDM tasks have been updated to handle termination
correctly, introduce a check to detect unexpected task terminations.

This warning will assist authors of out-of-tree modules in identifying
tasks that do not yet properly handle interrupted function calls.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 kernel/cobalt/thread.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index 3f0ed98ef..fb7190cf3 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -210,6 +210,12 @@ static int kthread_trampoline(void *arg)
=20
 	thread->entry(thread->cookie);
=20
+	/*
+	 * Warn the user if a thread chickens out.
+	 */
+	if (!xnthread_test_info(thread, XNCANCELD))
+		printk(XENO_WARNING "unexpected thread termination: %s\n", thread->nam=
e);
+
 	xnthread_cancel(thread);
=20
 	return 0;
--=20
2.51.0

