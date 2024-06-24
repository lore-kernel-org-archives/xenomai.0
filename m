Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393D01A08B8
	for <xenomai@lists.linux.dev>; Mon, 24 Jun 2024 20:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719261249; cv=none; b=F/4P+je1ENdTXpN5GnZOATjrLTZLz5mg8lUpmG4k4mO7pBtg9tzoNNzPYtAWlRb9PecmVwc2LmXtjnB5kriV+1bSNbzPlXILEfL0MzbA7VxYT4JFUmiHjFj329ngSzOHP94wrClYnW3SwL8qYnWvn1ZZvr3qLyP2oLPl1CwFUro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719261249; c=relaxed/simple;
	bh=q9VHY/HTeYd7G43kBYvI2qchYw3uYZZeRY3aoxDy9AA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qOtNyIdz/XZmE/9ydw7fzhthpjvCVO82xX4cOPq0YIR5amFFyRw40MjrkD73g5fIN9p1vPKzhHRKOPgN3SRCqwwZ44zBYsr4sHN100RUOrR+PP4RuQ6Mji7zrD1KOZ45Ea39UzsAY1hFj4HBVIYY4xMRZ3PZGFWxsQ5A4++qL7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id E7A056195FCC;
	Mon, 24 Jun 2024 22:33:55 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id BYOGK4pGWeeo; Mon, 24 Jun 2024 22:33:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 79D0C6195FFE;
	Mon, 24 Jun 2024 22:33:55 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3iV8RH_FuDpr; Mon, 24 Jun 2024 22:33:55 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 22E5B61966B8;
	Mon, 24 Jun 2024 22:33:55 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 13/14] prepare-kernel.sh: Don't allow uninitialized variables
Date: Mon, 24 Jun 2024 22:33:40 +0200
Message-Id: <20240624203341.6263-14-richard@nod.at>
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

Use "set -u" to detect subtle breakage in future.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 scripts/prepare-kernel.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index 37be3a3b0..276273a96 100755
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

