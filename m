Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7CA3446C3
	for <xenomai@lists.linux.dev>; Mon, 18 May 2026 10:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779099864; cv=none; b=iRLS+bbE4ambGzDWCBX7+ENuK8ueYLBxhpeWuqOq63Ao4Y2+5N/1uHCfS6q9QDHtwlQZc6fP60VJGo5IFeTf+oPOGOvL/RA1q3OcVJI0iX/F/eXPL5QultSvl+ql2REqIJwBDAmE4eFv9CmOL4WF7aopOIyjVIdueZaIDyzfs7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779099864; c=relaxed/simple;
	bh=guXXpB+fL5rarR5YMagCCF4pRxvuchCS7PkYXfGoV/0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U59VkE22Wbs4pDunZs5/uWVK/Gs1PPGmHj8MYPvtWiZL8RgjrjIeA5l8o89txCG9QB7LHgSmCLQkLyP/7weenFUu4QpZGb4fTRrpZBM9F+w2Z3eqz4EbhekKTcoaW2o/vy+6eE9Ec6KBP0kCEKlnkX9ruaKRUJNPYxH8dRej+HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=febF5m3I; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="febF5m3I"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202605181024147e4bbba8c400020751
        for <xenomai@lists.linux.dev>;
        Mon, 18 May 2026 12:24:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=Kmco0PtXD9IaXlkUWeChmLw0/xTvzLF8i3FIwc46AN0=;
 b=febF5m3I5CnFfjTF9m84yweYTaPk+ZJmJURVdrXpwm+IE8bLi5z/NfhlVEfqyEHGlABlss
 488+Nu89ONasFR/Dt3gPvJ8yLtzolgmG6qF7tYgPxgRaMo1Rh3Oyj9rtBhkvZrEQsxlsYton
 qoPXIMz4d01YzWYbxFWebN10lPupaRvIgKf7yQ7LPP6+AedvtVkbfPOEkxwT1VfiV6EIjr5v
 6yEapwB9osopVXmQh0b549rJffd0qqJ62aFdjlGC7W9UGNcb71hdWOMODar8v7BzLMSOfo0c
 ZVzCzre1FgZEYqoaK9EpEYU9c0GOEpK0GGVL1dYF5UVb+3QHhqsYiWcA==;
Message-ID: <abcd8f3cd377cd33e7033220af02cd097d0ca3b8.camel@siemens.com>
Subject: Re: [PATCH v2 4/4] testsuite/smokey/psostests: Fix compile error
 seen with gcc 16
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Mon, 18 May 2026 12:24:14 +0200
In-Reply-To: <b84b91e1-4316-4b5c-8190-73bd46742c1a@siemens.com>
References: <20260518-wip-flo-gcc-16-v2-0-f93562624fb4@siemens.com>
	 <20260518-wip-flo-gcc-16-v2-4-f93562624fb4@siemens.com>
	 <b84b91e1-4316-4b5c-8190-73bd46742c1a@siemens.com>
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

On Mon, 2026-05-18 at 11:21 +0200, Jan Kiszka wrote:
> On 18.05.26 11:02, Florian Bezdeka wrote:
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
> > loop.
> >=20
> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > ---
> >  testsuite/smokey/psostests/rn-1.c   | 7 +++----
> >  testsuite/smokey/psostests/task-2.c | 5 ++---
> >  2 files changed, 5 insertions(+), 7 deletions(-)
> >=20
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
> > index d24c13465367c7c2a6975dd4cbb01eb75f8fd1ad..be1b6ca18c5354ba092d55b=
3655bae9a294f2ce7 100644
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
> > +	threadobj_spin(1000);
>=20
> That's just 1 =C2=B5s, isn't it? That sounds rather short, not only for V=
M
> setups.
>=20

Arg, this is crazy. I measured the execution time of the previous
counting loop on my nested virtualized test system and tried to get down
as much as possible until CI would complain. Turned out: This test is
actually never run in CI...

There is a comment in psostests.c that this test (as it was) is broken,
so disabled.

To get that running on my nested VM setup here I have to increase to
something around 2ms.

Let me spawn another couple of CI test runs, maybe we can re-enable that
test - or delete it entirely?

Florian
