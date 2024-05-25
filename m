Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105344204B
	for <xenomai@lists.linux.dev>; Sat, 25 May 2024 11:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716638325; cv=none; b=kP6NuRYgZAb+qGaB+s3nifFHkBfjzyahVLVAfu1Qbl+yooMB1dBVCx+ATpAJduHxIPdwxjY0Kq0JEziXAP/6TCom6MtvtHmbixuu3uSzwcaq/1/9M56MQ5hYumIllQhMKR6nQlxz40UtDDM6kqzGW0eqpz01O3pnJeKEV/FOsuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716638325; c=relaxed/simple;
	bh=+3XP5emsVtfmfK9dpcNUOV02LckxdznDFiP2miXACSI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dQCv3nkpXtuyl8NaCcpD0i8Oc+IVAKXfdUangaf9noM+N0UxUs0dAzXj3TedDb17Q27alB8q7AePBm6cgX12tzBJrs2A4UWlGx29IO1FYAB1t5b+Q9PM6GuN3UHZzRiJN+Ykr8oNfZtZgFA5J60wi2HAQeIfZjakDRUycWGYlso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 61C156195FFD;
	Sat, 25 May 2024 13:58:31 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 7E71mlB6LcrH; Sat, 25 May 2024 13:58:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 1B05B64103F3;
	Sat, 25 May 2024 13:58:31 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id eBF-Tnb2jRrn; Sat, 25 May 2024 13:58:31 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id D2685644CE7C;
	Sat, 25 May 2024 13:58:30 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 15/16] prepare-kernel.sh: Don't allow uninitialized variables
Date: Sat, 25 May 2024 13:58:05 +0200
Message-Id: <20240525115806.12101-16-richard@nod.at>
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

Use "set -u" to detect subtle breakage in future.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 scripts/prepare-kernel.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index fe9dd5de5..f6eedc1a0 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 set -e
+set -u
=20
 unset CDPATH
=20
--=20
2.35.3

