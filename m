Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAD1437863
	for <xenomai@lists.linux.dev>; Mon, 20 Jul 2026 15:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562756; cv=none; b=U58gfHkS9ZP/PFOu63yYreGBKjoX3vl9L3GBHG/fqIzvr8BxiHV9fK3iWkjrcNYAyGZ2D/BeN0ifpIGbgA3/eYcOKGLMu64AVbJww+3HBtChh2QG03qvic9F49PA+s5TLoBecjkdWlgl4wI8Fbn4m5hrRlTTHlBv/2MNyenw1nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562756; c=relaxed/simple;
	bh=IPsldUIWOEzVEOUQC3xVxS0ZqD2fR8lYR/Cil9zZUr0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rmD/7KHIi2THLmubPlxYB/jjKXHOCtH9XoL8WZLjKos6B2aLp+QOrLcGWXyI9sc25SsIzklL/xSOPyQueisRPE3bdlaRxt80DGiMnpNC9sqfmZ8Vk1IezebV7wk9ZSuwbbtoQTswFsmKZShRQOgSxlqKvRceqESySXwKsb6c4FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Pu4QT3WZ; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Pu4QT3WZ"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20260720154216a5dc1eeb0900020764
        for <xenomai@lists.linux.dev>;
        Mon, 20 Jul 2026 17:42:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=Woa5Ix3zxhdwoH1PoUa0xs8vMXk8nhjbLwTCMY89BZw=;
 b=Pu4QT3WZzh5zmNwqn6qIK7NBFlD1M+rwhr0rZfZUngFHHtiZAEBGKrcpdSafF17Vj8lGH9
 2LDQKJbpkEHb59xywik45OSYNdXTjjG3AnSqp8UvsJg/y17iTuOD0xta7Ry2TUstn2+Th4DP
 eOaBm4JxnFObScD6z0+ZJAxb8O4ULKs1idGtTi2ihOduf8BTHfjtzlNzUxnGF2Ux9oO/oWFW
 izgoW+sO1oxHb1myy/eVfgrWir2qxAjX6Zx94NiWuycEMGgbGmLnNgZhMQBs74luSR68n8sK
 XKdwUTNIEROXixfxYTEJwyC6PZwbbl1E2RGEAzraPWny6AG8wtxC2cNw==;
Message-ID: <e448f28a201b46b7269cd3b182de2dc5f7dc9593.camel@siemens.com>
Subject: Re: [PATCH v3 4/4] testsuite/smokey/psostests: Fix compile error
 seen with gcc 16
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Mon, 20 Jul 2026 17:42:15 +0200
In-Reply-To: <8cd9b8ce-5cdb-42df-bf89-63eed39aaf96@siemens.com>
References: <20260717-wip-flo-gcc-16-v3-0-5429c866bcca@siemens.com>
	 <20260717-wip-flo-gcc-16-v3-4-5429c866bcca@siemens.com>
	 <36b4022a-e6c0-4402-abac-27167859e08a@siemens.com>
	 <7c80cb160002180c68ecade44b66fc3b488a3834.camel@siemens.com>
	 <8cd9b8ce-5cdb-42df-bf89-63eed39aaf96@siemens.com>
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

On Mon, 2026-07-20 at 17:04 +0200, Jan Kiszka wrote:
> On 20.07.26 17:02, Florian Bezdeka wrote:
> > On Mon, 2026-07-20 at 16:40 +0200, Jan Kiszka wrote:
> > > On 17.07.26 09:45, Florian Bezdeka wrote:
> > > > Fixes the following compile errors:
> > > >=20
> > > > rn-1.c: In function =E2=80=98alloc_task=E2=80=99:
> > > > rn-1.c:16:18: error: variable =E2=80=98n=E2=80=99 set but not used =
[-Werror=3Dunused-but-set-variable=3D]
> > > >    16 |         int ret, n;
> > > >       |                  ^
> > > > rn-1.c:15:22: error: variable =E2=80=98alloc_size=E2=80=99 set but =
not used [-Werror=3Dunused-but-set-variable=3D]
> > > >    15 |         u_long size, alloc_size =3D 0;
> > > >       |
> > > >=20
> > > > task-2.c: In function =E2=80=98backgroundTask=E2=80=99:
> > > > task-2.c:19:42: error: variable =E2=80=98count=E2=80=99 set but not=
 used [-Werror=3Dunused-but-set-variable=3D]
> > > >    19 |         unsigned int safety =3D 100000000, count =3D 0;
> > > >       |                                          ^~~~~
> > > > cc1: all warnings being treated as errors
> > > >=20
> > > > The counting busy loop has been replaced by an interval based busy
> > > > loop. While at it: Enable this test for CI. It was previously marke=
d
> > > > as broken. The counting busy loop was not enough to keep the task a=
live.
> > > >=20
> > > > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > > > ---
> > > >  testsuite/smokey/psostests/psostests.c | 4 +---
> > > >  testsuite/smokey/psostests/rn-1.c      | 7 +++----
> > > >  testsuite/smokey/psostests/task-2.c    | 5 ++---
> > > >  3 files changed, 6 insertions(+), 10 deletions(-)
> > > >=20
> > > > diff --git a/testsuite/smokey/psostests/psostests.c b/testsuite/smo=
key/psostests/psostests.c
> > > > index 289d563ac3595f0e2d21bc5f5746772fd51234b8..31347ba45ea430ac4b2=
e62be4c1e437519f2fb37 100644
> > > > --- a/testsuite/smokey/psostests/psostests.c
> > > > +++ b/testsuite/smokey/psostests/psostests.c
> > > > @@ -15,9 +15,7 @@ static const char * const tests[] =3D {
> > > >  	"psostests_sem1",
> > > >  	"psostests_sem2",
> > > >  	"psostests_task1",
> > > > -	// 0"014.452| BUG in __traceobj_assert_failed(): [FGND] trace ass=
ertion failed:
> > > > -	//		../../../../../../../../../workspace/sources/xenomai/testsuit=
e/smokey/psostests/task-2.c:56 =3D> "ret =3D=3D 0"
> > > > -	//"psostests_task2",
> > > > +	"psostests_task2",
> > > >  	"psostests_task3",
> > > >  	"psostests_task4",
> > > >  	"psostests_task5",
> > > > diff --git a/testsuite/smokey/psostests/rn-1.c b/testsuite/smokey/p=
sostests/rn-1.c
> > > > index 5e82d1506ca029ae2bf812ccbfbf9c3a9ab9cc7e..d2e847375212c9746de=
3e550a5d10a8be4694de5 100644
> > > > --- a/testsuite/smokey/psostests/rn-1.c
> > > > +++ b/testsuite/smokey/psostests/rn-1.c
> > > > @@ -12,15 +12,15 @@ static u_long tid, rnid;
> > > > =20
> > > >  static void alloc_task(u_long a1, u_long a2, u_long a3, u_long a4)
> > > >  {
> > > > -	u_long size, alloc_size =3D 0;
> > > > -	int ret, n;
> > > > +	u_long size;
> > > >  	void *buf;
> > > > +	int ret;
> > > > =20
> > > >  	traceobj_enter(&trobj);
> > > > =20
> > > >  	srandom(0x11223344);
> > > > =20
> > > > -	for (n =3D 0;; n++) {
> > > > +	for (;;) {
> > > >  		size =3D (random() % (sizeof(rn_mem) / 8)) + 4;
> > > >  		ret =3D rn_getseg(rnid, size, RN_NOWAIT, 0, &buf);
> > > >  		if (ret) {
> > > > @@ -28,7 +28,6 @@ static void alloc_task(u_long a1, u_long a2, u_lo=
ng a3, u_long a4)
> > > >  			break;
> > > >  		}
> > > >  		memset(buf, 0xaa, size);
> > > > -		alloc_size +=3D size;
> > > >  	}
> > > > =20
> > > >  	traceobj_exit(&trobj);
> > > > diff --git a/testsuite/smokey/psostests/task-2.c b/testsuite/smokey=
/psostests/task-2.c
> > > > index d24c13465367c7c2a6975dd4cbb01eb75f8fd1ad..21497433f1a35841844=
06b172c367eacd5a8b127 100644
> > > > --- a/testsuite/smokey/psostests/task-2.c
> > > > +++ b/testsuite/smokey/psostests/task-2.c
> > > > @@ -2,6 +2,7 @@
> > > >  #include <stdio.h>
> > > >  #include <stdlib.h>
> > > >  #include <copperplate/traceobj.h>
> > > > +#include <copperplate/threadobj.h>
> > > >  #include <psos/psos.h>
> > > > =20
> > > >  static struct traceobj trobj;
> > > > @@ -16,7 +17,6 @@ static u_long sem_id;
> > > > =20
> > > >  static void backgroundTask(u_long a1, u_long a2, u_long a3, u_long=
 a4)
> > > >  {
> > > > -	unsigned int safety =3D 100000000, count =3D 0;
> > > >  	int ret;
> > > > =20
> > > >  	traceobj_enter(&trobj);
> > > > @@ -28,8 +28,7 @@ static void backgroundTask(u_long a1, u_long a2, =
u_long a3, u_long a4)
> > > > =20
> > > >  	traceobj_mark(&trobj, 2);
> > > > =20
> > > > -	while (--safety > 0)
> > > > -		count++;
> > > > +	threadobj_spin(2000000);
> > > > =20
> > >=20
> > > Here you do the right thing.
> > >=20
> > > >  	traceobj_mark(&trobj, 3);
> > > > =20
> > > >=20
> > >=20
> > > But the patch description is confusing: It only talks about fixing
> > > compiler errors, but the code is actually re-enabling psostests_task2=
,
> > > isn't it?
> >=20
> > Taken from the description above:
> >=20
> > While at it: Enable this test for CI. It was previously marked
> > as broken. The counting busy loop was not enough to keep the task alive=
.
> >=20
> > I can re-order the description a bit to make that even clearer.
> >=20
>=20
> Start with the subject...

v4 will factor that part out, so that the test enablement is a separate
patch.
