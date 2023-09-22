Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCF9323E
	for <xenomai@lists.linux.dev>; Fri, 22 Sep 2023 21:09:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 3A458622F589;
	Fri, 22 Sep 2023 23:03:05 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id TW0IGXQe9yVX; Fri, 22 Sep 2023 23:03:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id B7B846234897;
	Fri, 22 Sep 2023 23:03:04 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UGwx7gfQYqck; Fri, 22 Sep 2023 23:03:04 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 86BC6622F589;
	Fri, 22 Sep 2023 23:03:04 +0200 (CEST)
Date: Fri, 22 Sep 2023 23:03:04 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: aaron <aaron@sigma-star.at>, xenomai <xenomai@lists.linux.dev>
Message-ID: <1429431084.70724.1695416584325.JavaMail.zimbra@nod.at>
In-Reply-To: <23cc119f-7301-49d8-9a95-03ff9e061ab1@siemens.com>
References: <901c80cc-d506-445e-add9-00aa0e536803@siemens.com> <20230920135253.5842-1-aaron@sigma-star.at> <20230920135253.5842-2-aaron@sigma-star.at> <23cc119f-7301-49d8-9a95-03ff9e061ab1@siemens.com>
Subject: Re: [PATCH 1/5] lib: Add smokey_run_extprog as helper for testsuite
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
Thread-Topic: Add smokey_run_extprog as helper for testsuite
Thread-Index: BrsRe2XjlkY38zZgUO3GpN0eQIm1tQ==

----- Urspr=C3=BCngliche Mail -----
> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
>> +int smokey_run_extprog(const char *dir, const char *name, int argc, cha=
r *const
>> argv[])
>> +{
>> +=09int ret;
>> +=09char *tst_path;
>> +
>> +=09ret =3D asprintf(&tst_path, "%s/%s --cpu-affinity=3D0", dir, name);
>=20
> Why do we need to hard-code an affinity here?

We don't. Looks like a copy&paste error from my initial Alchemy test driver=
.
Aaron, please make it more flexible.

Alchemy, pSos and VxWorks tests assume an CPU affinity of 0, but we cannot
enforce that for smokey in general.

Thanks,
//richard
