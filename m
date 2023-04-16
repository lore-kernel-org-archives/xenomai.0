Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11234C60
	for <xenomai@lists.linux.dev>; Sun, 16 Apr 2023 19:37:57 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (unknown [217.70.183.197])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id BF2C4C80BE
	for <xenomai@lists.linux.dev>; Sun, 16 Apr 2023 19:31:08 +0000 (UTC)
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 361AF1C0005
	for <xenomai@lists.linux.dev>; Sun, 16 Apr 2023 19:31:00 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by spool.mail.gandi.net (Postfix) with ESMTPS id F200674001D
	for <xenomai@xenomai.org>; Sun, 16 Apr 2023 19:30:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 53E906431C28;
	Sun, 16 Apr 2023 21:30:59 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 5nlRIW1vvxB0; Sun, 16 Apr 2023 21:30:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id BF9C963CC16F;
	Sun, 16 Apr 2023 21:30:58 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id d357oV_cRcku; Sun, 16 Apr 2023 21:30:58 +0200 (CEST)
Received: from blindfold.corp.sigma-star.at (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 7906B63CC165;
	Sun, 16 Apr 2023 21:30:58 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@xenomai.org
Cc: Richard Weinberger <richard@nod.at>,
	aaron@sigma-star.at
Subject: [PATCH] alchemy: Correctly translate return value from pthread_mutex_init
Date: Sun, 16 Apr 2023 21:30:53 +0200
Message-Id: <20230416193053.22092-1-richard@nod.at>
X-Mailer: git-send-email 2.26.2
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: 
Authentication-Results: spool.mail.gandi.net;
	dkim=none;
	spf=pass (spool.mail.gandi.net: domain of richard@nod.at designates 195.201.40.130 as permitted sender) smtp.mailfrom=richard@nod.at;
	dmarc=none

The alchemy API uses negative error values, so the return value from
pthread_mutex_init() needs translation.

Cc: aaron@sigma-star.at
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 lib/alchemy/mutex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/alchemy/mutex.c b/lib/alchemy/mutex.c
index f8933858647a..5836af59f05e 100644
--- a/lib/alchemy/mutex.c
+++ b/lib/alchemy/mutex.c
@@ -133,7 +133,7 @@ int rt_mutex_create(RT_MUTEX *mutex, const char *name=
)
 	pthread_mutexattr_settype(&mattr, PTHREAD_MUTEX_RECURSIVE);
 	/* pthread_mutexattr_setrobust() might not be implemented. */
 	pthread_mutexattr_setrobust(&mattr, PTHREAD_MUTEX_ROBUST_NP);
-	ret =3D __RT(pthread_mutex_init(&mcb->lock, &mattr));
+	ret =3D -__RT(pthread_mutex_init(&mcb->lock, &mattr));
 	if (ret) {
 		xnfree(mcb);
 		goto out;
--=20
2.26.2

