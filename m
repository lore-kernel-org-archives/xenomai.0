Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2E6139A
	for <xenomai@lists.linux.dev>; Sun, 16 Apr 2023 09:13:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 9068964551BD;
	Sun, 16 Apr 2023 11:03:18 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id cuF4QKfiOp-0; Sun, 16 Apr 2023 11:03:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 2B61864551DF;
	Sun, 16 Apr 2023 11:03:18 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Kq1heE5Z7tgU; Sun, 16 Apr 2023 11:03:18 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 0EA1C64551BD;
	Sun, 16 Apr 2023 11:03:18 +0200 (CEST)
Date: Sun, 16 Apr 2023 11:03:17 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: aaron <aaron@sigma-star.at>, xenomai <xenomai@lists.linux.dev>, 
	Florian Bezdeka <florian.bezdeka@siemens.com>
Message-ID: <701402089.81094.1681635797935.JavaMail.zimbra@nod.at>
In-Reply-To: <0443c031-46cd-de1d-6d16-acd656b90832@siemens.com>
References: <20220413215819.22954-1-richard@nod.at> <20230406103341.2914-1-aaron@sigma-star.at> <8ee4086e-580d-3d15-cade-4d983c86e402@siemens.com> <0443c031-46cd-de1d-6d16-acd656b90832@siemens.com>
Subject: Re: [PATCH v3 0/11] Revive alchemy, pSOS and VxWorks tests
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Revive alchemy, pSOS and VxWorks tests
Thread-Index: J69FVOOzyVr4XsNFi5MXRkZyKTEmiQ==

----- Urspr=C3=BCngliche Mail -----
> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
>> ...but it does hook up with smokey, thus will not run as part of
>> xeno-test and our CI. Please fix that - after either resolving the
>> remaining broken tests or disabling them for now. It should be easy to
>> spawn the new tests as separate processes from a smokey instance and
>> visualize their results as part of smokey.
>>=20
>=20
> BTW, mutex1 from alchemytest fails for me, all other alchemy tests are fi=
ne.

Not sure whether this is related, but on Thursday I ran into a bug in rt_mu=
tex_create(),
it returns also positive error numbers.
This seems to be the fix:

diff --git a/lib/alchemy/mutex.c b/lib/alchemy/mutex.c
index f8933858647a..5836af59f05e 100644
--- a/lib/alchemy/mutex.c
+++ b/lib/alchemy/mutex.c
@@ -133,7 +133,7 @@ int rt_mutex_create(RT_MUTEX *mutex, const char *name)
 =09pthread_mutexattr_settype(&mattr, PTHREAD_MUTEX_RECURSIVE);
 =09/* pthread_mutexattr_setrobust() might not be implemented. */
 =09pthread_mutexattr_setrobust(&mattr, PTHREAD_MUTEX_ROBUST_NP);
-=09ret =3D __RT(pthread_mutex_init(&mcb->lock, &mattr));
+=09ret =3D -__RT(pthread_mutex_init(&mcb->lock, &mattr));
 =09if (ret) {
 =09=09xnfree(mcb);
 =09=09goto out;

Thanks,
//richard
