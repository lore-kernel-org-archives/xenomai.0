Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BC72C08DC
	for <xenomai@lists.linux.dev>; Wed, 13 May 2026 13:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778680573; cv=none; b=eetPmRADAh18my15uzzmvs0bCydNsWcQz3QWSPYPZVxRfVJBIiCtzWb+CxSf/tmSSqF0fJwmWwNH1Im4V+COjDJq7Mu3kHAKS9Kuqew+2xu/N2TGcSTec6SiOJuKE7w2ltV0Yfjev6nUBvWuE8NjpNWPA0sKw6yU1PCdZfDe2xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778680573; c=relaxed/simple;
	bh=M/sqNALGG/NePKxRZNatcZxy1wrY3bSyyeWrjJUxwdE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aamY1qI35JI2skmKYCDm1yelnlrrgpjwINI0rB6eXTtIbdQevpUNxcxia7BQhSyTKYXCzPJX9yQxh/NwZDSRlA2kh8F/5dm2bfWYGURDNC+82zGvQoOZm3uueU1dAujFLdmsP9BlSS866CJzFAwFoAW9J+3aCOAfoAysUzcC7CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=MR++1xsg; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="MR++1xsg"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202605131355429acbc0aac800020716
        for <xenomai@lists.linux.dev>;
        Wed, 13 May 2026 15:55:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=57dLNdIEUnB8EHbzb1oZlXeEv4oVTMwZds/WbI2/mVo=;
 b=MR++1xsg7I81Y/AGtMTBhVZm2/VWV+MYQWIz6WBVHmfz0BtwRcTvlN27V6JaRmrux70enC
 lbViEq8o30qOe8usWzmziT7zBqiJiNJE8ewSoNUDrInVxSsyE6pv2IPehSIWjN3H6mRkSjCc
 zR26zwUpXvgwBOKiE1AdiffwQ9BhUDibcEuw0yyZa7KYJ+DKR1bF70plwPpFLZ2zSU5cWSxz
 OxMWqvwQczU/FwoG1W8DIl72XLhV5C3zhogY6yJmgu0+xhGuitBlaS4DUudq6A8bUwzQBpxM
 rnJ6WCPmWR9FGpDIYOkWbaHjtDdmyFSLkgAyqXvePRFP/pG0Zn63+prw==;
Message-ID: <a1529505a5131d8b324d97d3191997998357d25b.camel@siemens.com>
Subject: Re: [PATCH 3/5] testsuite/smokey/vxworktests: Fix compile error
 seen with gcc 16
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Wed, 13 May 2026 15:55:41 +0200
In-Reply-To: <0a460b08-ec31-48c8-9255-98c562f3ca50@siemens.com>
References: <20260513-wip-flo-gcc-16-v1-0-120ae1287401@siemens.com>
	 <20260513-wip-flo-gcc-16-v1-3-120ae1287401@siemens.com>
	 <0a460b08-ec31-48c8-9255-98c562f3ca50@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Wed, 2026-05-13 at 15:52 +0200, Jan Kiszka wrote:
> On 13.05.26 14:50, Florian Bezdeka wrote:
> > Fixes the following error:
> >=20
> > task-2.c: In function =E2=80=98backgroundTask=E2=80=99:
> > task-2.c:26:42: error: variable =E2=80=98count=E2=80=99 set but not use=
d [-Werror=3Dunused-but-set-variable=3D]
> >    26 |         unsigned int safety =3D 100000000, count =3D 0;
> >       |                                          ^~~~~
> > cc1: all warnings being treated as errors
> >=20
> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > ---
> >  testsuite/smokey/vxworkstests/task-2.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/testsuite/smokey/vxworkstests/task-2.c b/testsuite/smokey/=
vxworkstests/task-2.c
> > index 0cbb9e18a13383418c4360241ef244b8a24da975..ed3e31806baad930bb30edc=
53d2dc6b6e51d6277 100644
> > --- a/testsuite/smokey/vxworkstests/task-2.c
> > +++ b/testsuite/smokey/vxworkstests/task-2.c
> > @@ -23,7 +23,7 @@ static SEM_ID sem_id, fdone_sem_id;
> > =20
> >  static void backgroundTask(long arg, ...)
> >  {
> > -	unsigned int safety =3D 100000000, count =3D 0;
> > +	unsigned int safety =3D 100000000;
> >  	int ret;
> > =20
> >  	traceobj_enter(&trobj);
> > @@ -35,8 +35,7 @@ static void backgroundTask(long arg, ...)
> > =20
> >  	traceobj_mark(&trobj, 2);
> > =20
> > -	while (--safety > 0)
> > -		count++;
> > +	while (--safety > 0) {}
>=20
> This first of all increases the risk of getting optimized out. I suspect
> this is intended to generate some load, and that needs to be preserved.
> We should likely do that via a busy loop which spins for a number of
> microseconds.
>=20

I compared the generated code, where only the increment was missing. Let
me double check that the optimization level was > 0.
