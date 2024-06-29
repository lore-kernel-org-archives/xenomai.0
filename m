Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17DB37160
	for <xenomai@lists.linux.dev>; Sat, 29 Jun 2024 13:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719668730; cv=none; b=fN+UkI7/DcFvbv1+Hnh4P+x/+tSbb0OiZy9Zcx/81ruJLNslwkVc83s73Reibqk6I3BqXuI2WawqCv1zOHW9at4IDjdWGrocK0O/jlp8BDDzYX8C/AhjYcBEJwJW1Q9JzyZBolJwm+d6MXEa+QX+tbzTozUu6e0XdwqCjgsQJcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719668730; c=relaxed/simple;
	bh=JlyWi0qWFI6Kcx5KQb7zTJBp81ZiH48c19uvXjZqpH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GivEvfKoUOO6+arYBGdYW5acdvKFZ87iJOdZycb40nzk9lpLRwA6thQTDQyFnl2+Iyq5xfwYOxYNCKJb/ded4k30tXnKjV+biIMW90vUJ+z82qnIWdzDfnT54izDqOYD7XPNYcXJfPvF21EOziYtFTqmqvMxRHGnrDwi7Ho0fkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id B7AC861966AF;
	Sat, 29 Jun 2024 15:45:19 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id TtfPbbZc23hB; Sat, 29 Jun 2024 15:45:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 6C44061966A1;
	Sat, 29 Jun 2024 15:45:19 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id n1TPqUg-rv07; Sat, 29 Jun 2024 15:45:19 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 38BDC6195FFC;
	Sat, 29 Jun 2024 15:45:19 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 2/5] gitlab-ci.yml: Clean and check kernel build
Date: Sat, 29 Jun 2024 15:45:01 +0200
Message-Id: <20240629134504.11148-3-richard@nod.at>
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

Make sure that after cleaning the build none of our changes
are left behind.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 .gitlab-ci.yml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index c5c6c3a56..68e3ab324 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -171,6 +171,9 @@ variables:
     - ${CI_PROJECT_DIR}/scripts/prepare-kernel.sh
     - make -j $(nproc) olddefconfig
     - make -j $(nproc) all
+    - make clean
+    - ${CI_PROJECT_DIR}/scripts/prepare-kernel.sh --reverse
+    - git status --short | grep . && exit 1
     - popd
     - scripts/bootstrap
     - ./configure ${CONFIGURE_OPTS}
--=20
2.35.3

