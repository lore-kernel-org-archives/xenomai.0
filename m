Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1507242DA50
	for <xenomai@lists.linux.dev>; Mon, 20 Jul 2026 15:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559746; cv=none; b=eMuyOB9f20EIckQW5vrgTdSH+gmTL34MzaU2c5HoUfL5UuHqGPvc3RbcFCAeBhYpUoqg7OMjt0FKbvYwN3XM4+iGLjaroZoCc0JDwsrKBhMa5rjv51LJZ/JBuUUtXlVGRM7rCbgDr2PIQg49RdmTFCzox3g2l8v6EHphjuH9yeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559746; c=relaxed/simple;
	bh=odQuGYmSGgmjFJUbXLyFzwPuyin7RImIzQX3kF0NdgQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L2s9gCtSMUzj7RK7fh3B1R2NiAJDAX1eS0i1Yg2aDjKohoyZRyiL6w3YRiWHD0UNx8OS59S0d+Lslx6cWNRsPzY60iomyXAytUsFjDyqzYeZJsaU17OLd8MmNkdPhISpiXq8NmzcmBbdCqHOYOY+rMQLV+XyFf7tQEha74jFfDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=dSgTTpC3; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="dSgTTpC3"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202607201502115a6f3c9a7e0002078d
        for <xenomai@lists.linux.dev>;
        Mon, 20 Jul 2026 17:02:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=9EKYwFvnTqo2Ci9Gae3SdUQcs3Oo5x3908H8dBvn1W0=;
 b=dSgTTpC3zVNtHYqh31mbJcnyaED/odiQb9anx2aeNhAsbPFKrydCMkE1i+Ju4wRV4peTFP
 ZA9ujDYgn3uYooSJRkbSx0W8N84rNxE9ALOEsrFcZbgoGX8ZK9y/Ei7ao5qP+o3eVWaxjQVE
 CwQKD47/lyf+/BfaO3MQ8TduwAaIQ6Ii91gdRw15r+mtjTHYMB4dgt2zQvf9KfcN++NDA1y8
 9P+m/EPAI4fNX/tf0vxhO9lKtyTWIp+svxPpWDrAHNQTp0d/wWu+N/6zS48Y9AS+6O/lIdXd
 7x6CEMb4Kx1kk+J5uGHh8VLvmIwv5KXsYOmPT8XUdiTOVhxWGknp5gqQ==;
Message-ID: <7c80cb160002180c68ecade44b66fc3b488a3834.camel@siemens.com>
Subject: Re: [PATCH v3 4/4] testsuite/smokey/psostests: Fix compile error
 seen with gcc 16
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Mon, 20 Jul 2026 17:02:11 +0200
In-Reply-To: <36b4022a-e6c0-4402-abac-27167859e08a@siemens.com>
References: <20260717-wip-flo-gcc-16-v3-0-5429c866bcca@siemens.com>
	 <20260717-wip-flo-gcc-16-v3-4-5429c866bcca@siemens.com>
	 <36b4022a-e6c0-4402-abac-27167859e08a@siemens.com>
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

On Mon, 2026-07-20 at 16:40 +0200, Jan Kiszka wrote:
> On 17.07.26 09:45, Florian Bezdeka wrote:
> > Fixes the following compile errors:
> >=20
> > rn-1.c: In function =E2=80=98alloc_task=E2=80=99:
> > rn-1.c:16:18: error: variable =E2=80=98n=E2=80=99 set but not used [-We=
rror=3Dunused-but-set-variable=3D]
> >    16 |         int ret, n;
> >       |                  ^
> > rn-1.c:15:22: error: variable =E2=80=98alloc_size=E2=80=99 set but not =
used [-Werror=3Dunused-but-set-variable=3D]
> >    15 |         u_long size, alloc_size =3D 0;
> >       |
> >=20
> > task-2.c: In function =E2=80=98backgroundTask=E2=80=99:
> > task-2.c:19:42: error: variable =E2=80=98count=E2=80=99 set but not use=
d [-Werror=3Dunused-but-set-variable=3D]
> >    19 |         unsigned int safety =3D 100000000, count =3D 0;
> >       |                                          ^~~~~
> > cc1: all warnings being treated as errors
> >=20
> > The counting busy loop has been replaced by an interval based busy
> > loop. While at it: Enable this test for CI. It was previously marked
> > as broken. The counting busy loop was not enough to keep the task alive=
.
> >=20
> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > ---
> >  testsuite/smokey/psostests/psostests.c | 4 +---
> >  testsuite/smokey/psostests/rn-1.c      | 7 +++----
> >  testsuite/smokey/psostests/task-2.c    | 5 ++---
> >  3 files changed, 6 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/testsuite/smokey/psostests/psostests.c b/testsuite/smokey/=
psostests/psostests.c
> > index 289d563ac3595f0e2d21bc5f5746772fd51234b8..31347ba45ea430ac4b2e62b=
e4c1e437519f2fb37 100644
> > --- a/testsuite/smokey/psostests/psostests.c
> > +++ b/testsuite/smokey/psostests/psostests.c
> > @@ -15,9 +15,7 @@ static const char * const tests[] =3D {
> >  	"psostests_sem1",
> >  	"psostests_sem2",
> >  	"psostests_task1",
> > -	// 0"014.452| BUG in __traceobj_assert_failed(): [FGND] trace asserti=
on failed:
> > -	//		../../../../../../../../../workspace/sources/xenomai/testsuite/sm=
okey/psostests/task-2.c:56 =3D> "ret =3D=3D 0"
> > -	//"psostests_task2",
> > +	"psostests_task2",
> >  	"psostests_task3",
> >  	"psostests_task4",
> >  	"psostests_task5",
> > diff --git a/testsuite/smokey/psostests/rn-1.c b/testsuite/smokey/psost=
ests/rn-1.c
> > index 5e82d1506ca029ae2bf812ccbfbf9c3a9ab9cc7e..d2e847375212c9746de3e55=
0a5d10a8be4694de5 100644
> > --- a/testsuite/smokey/psostests/rn-1.c
> > +++ b/testsuite/smokey/psostests/rn-1.c
> > @@ -12,15 +12,15 @@ static u_long tid, rnid;
> > =20
> >  static void alloc_task(u_long a1, u_long a2, u_long a3, u_long a4)
> >  {
> > -	u_long size, alloc_size =3D 0;
> > -	int ret, n;
> > +	u_long size;
> >  	void *buf;
> > +	int ret;
> > =20
> >  	traceobj_enter(&trobj);
> > =20
> >  	srandom(0x11223344);
> > =20
> > -	for (n =3D 0;; n++) {
> > +	for (;;) {
> >  		size =3D (random() % (sizeof(rn_mem) / 8)) + 4;
> >  		ret =3D rn_getseg(rnid, size, RN_NOWAIT, 0, &buf);
> >  		if (ret) {
> > @@ -28,7 +28,6 @@ static void alloc_task(u_long a1, u_long a2, u_long a=
3, u_long a4)
> >  			break;
> >  		}
> >  		memset(buf, 0xaa, size);
> > -		alloc_size +=3D size;
> >  	}
> > =20
> >  	traceobj_exit(&trobj);
> > diff --git a/testsuite/smokey/psostests/task-2.c b/testsuite/smokey/pso=
stests/task-2.c
> > index d24c13465367c7c2a6975dd4cbb01eb75f8fd1ad..21497433f1a3584184406b1=
72c367eacd5a8b127 100644
> > --- a/testsuite/smokey/psostests/task-2.c
> > +++ b/testsuite/smokey/psostests/task-2.c
> > @@ -2,6 +2,7 @@
> >  #include <stdio.h>
> >  #include <stdlib.h>
> >  #include <copperplate/traceobj.h>
> > +#include <copperplate/threadobj.h>
> >  #include <psos/psos.h>
> > =20
> >  static struct traceobj trobj;
> > @@ -16,7 +17,6 @@ static u_long sem_id;
> > =20
> >  static void backgroundTask(u_long a1, u_long a2, u_long a3, u_long a4)
> >  {
> > -	unsigned int safety =3D 100000000, count =3D 0;
> >  	int ret;
> > =20
> >  	traceobj_enter(&trobj);
> > @@ -28,8 +28,7 @@ static void backgroundTask(u_long a1, u_long a2, u_lo=
ng a3, u_long a4)
> > =20
> >  	traceobj_mark(&trobj, 2);
> > =20
> > -	while (--safety > 0)
> > -		count++;
> > +	threadobj_spin(2000000);
> > =20
>=20
> Here you do the right thing.
>=20
> >  	traceobj_mark(&trobj, 3);
> > =20
> >=20
>=20
> But the patch description is confusing: It only talks about fixing
> compiler errors, but the code is actually re-enabling psostests_task2,
> isn't it?

Taken from the description above:

While at it: Enable this test for CI. It was previously marked
as broken. The counting busy loop was not enough to keep the task alive.

I can re-order the description a bit to make that even clearer.

>=20
> Jan
>=20
> --=20
> Siemens AG, Foundational Technologies
> Linux Expert Center
