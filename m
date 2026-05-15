Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD79F3E9F98
	for <xenomai@lists.linux.dev>; Fri, 15 May 2026 09:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778838183; cv=none; b=cBqVOEAvSknCX2buuYh0VVoZP6JdEVkyZhEcsXYVsBVng/eiQRTtfp1zkYhSxXr0TDYoK0A4tUCa7aBSCFluPIFysdlt7tR+GoDuv6XJ6nhWSidoKbkA8bkDr0xewCWHLbULaqxtIYJjWaEsADS4QWzBHOZVFcpKvF2SW8FEBxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778838183; c=relaxed/simple;
	bh=0oHZ5g5r+WITX7YRN9GtW9vefu9KoCVBEpveonOueLs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dOHlegdeCzMDYWgw5By9OplZwYwmviW2D5rJ5CRT3shyxGkM66LvH/I590S/vrB/CL4r99b7OfFK8DnQd1uA9by+znELTF9pR5ntt3Nkr6zkablqJYvJv7oJR860Z9I8UInh6G8Kjs1poKXretPEpPu7rQhrvND6Cx8tbkdfD9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=FcJ+3qMq; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="FcJ+3qMq"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20260515094252a4a153f44b000207a5
        for <xenomai@lists.linux.dev>;
        Fri, 15 May 2026 11:42:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=AqmAmYQHKVP/NPUWf7TeLWRdXgzYBNRfZ57vzarY9x4=;
 b=FcJ+3qMqZTVNNm5dBZtr9DsBQ7CvfCqHR0VGezN6gvdmfliVR6KwUA3t0KC07IuHyDwkub
 ModSQkggTwQ3A0V9XuZXW+q+JGj16RZ5bNXpA+xO+O69cMhvs+Lq5l7kiWim56xyLzDfQfDa
 ONt7/1ViKoxKWpRvsCF7b6MXZcBkquxQcCUhUUP1cl1c3RDExSpN/XanECBKa8XMpGtZSYcJ
 S4DTS1PzrqpUklDai1KziEpLNLoceoGjcYGaA0UbxfcwZZ2ir8YeSlQVAAFZF8602xyomsu+
 NHMm/TrgUh1hPVtFU3anC8ESS3/QSRKIOFIiBE3+Ioygb//ky9r0o20Q==;
Message-ID: <ccbce15c2018791958d696aabec46cd66bb45c27.camel@siemens.com>
Subject: Re: [PATCH 3/5] testsuite/smokey/vxworktests: Fix compile error
 seen with gcc 16
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Fri, 15 May 2026 11:42:51 +0200
In-Reply-To: <a8612493-f49f-419e-a952-0b9a0199f553@siemens.com>
References: <20260513-wip-flo-gcc-16-v1-0-120ae1287401@siemens.com>
	 <20260513-wip-flo-gcc-16-v1-3-120ae1287401@siemens.com>
	 <0a460b08-ec31-48c8-9255-98c562f3ca50@siemens.com>
	 <a1529505a5131d8b324d97d3191997998357d25b.camel@siemens.com>
	 <a8612493-f49f-419e-a952-0b9a0199f553@siemens.com>
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

On Wed, 2026-05-13 at 16:02 +0200, Jan Kiszka wrote:
> On 13.05.26 15:55, Florian Bezdeka wrote:
> > On Wed, 2026-05-13 at 15:52 +0200, Jan Kiszka wrote:
> > > On 13.05.26 14:50, Florian Bezdeka wrote:
> > > > Fixes the following error:
> > > >=20
> > > > task-2.c: In function =E2=80=98backgroundTask=E2=80=99:
> > > > task-2.c:26:42: error: variable =E2=80=98count=E2=80=99 set but not=
 used [-Werror=3Dunused-but-set-variable=3D]
> > > >    26 |         unsigned int safety =3D 100000000, count =3D 0;
> > > >       |                                          ^~~~~
> > > > cc1: all warnings being treated as errors
> > > >=20
> > > > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > > > ---
> > > >  testsuite/smokey/vxworkstests/task-2.c | 5 ++---
> > > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > >=20
> > > > diff --git a/testsuite/smokey/vxworkstests/task-2.c b/testsuite/smo=
key/vxworkstests/task-2.c
> > > > index 0cbb9e18a13383418c4360241ef244b8a24da975..ed3e31806baad930bb3=
0edc53d2dc6b6e51d6277 100644
> > > > --- a/testsuite/smokey/vxworkstests/task-2.c
> > > > +++ b/testsuite/smokey/vxworkstests/task-2.c
> > > > @@ -23,7 +23,7 @@ static SEM_ID sem_id, fdone_sem_id;
> > > > =20
> > > >  static void backgroundTask(long arg, ...)
> > > >  {
> > > > -	unsigned int safety =3D 100000000, count =3D 0;
> > > > +	unsigned int safety =3D 100000000;
> > > >  	int ret;
> > > > =20
> > > >  	traceobj_enter(&trobj);
> > > > @@ -35,8 +35,7 @@ static void backgroundTask(long arg, ...)
> > > > =20
> > > >  	traceobj_mark(&trobj, 2);
> > > > =20
> > > > -	while (--safety > 0)
> > > > -		count++;
> > > > +	while (--safety > 0) {}
> > >=20
> > > This first of all increases the risk of getting optimized out. I susp=
ect
> > > this is intended to generate some load, and that needs to be preserve=
d.
> > > We should likely do that via a busy loop which spins for a number of
> > > microseconds.
> > >=20
> >=20
> > I compared the generated code, where only the increment was missing. Le=
t
> > me double check that the optimization level was > 0.
>=20
> Neither the new nor the current versions are safe here, specifically
> regarding timing.
>=20

Seems both "affected" tests are a bit different. The following applies
to the psos test, vxworkstests needs additional checking.

The background task has to be kept alive, so that the foreground task
can cancel it. In case of a test failure, the task has to complete, so
that we can safely report the testfailure.

First idea was to simply wait on the semaphore again, but that would
suspend the task forever, breaking the test failure detection.

v2 (as currently running in CI) will simply silence the compiler
warning. (void)count;=20

Better ideas welcome, but for now fixing the tests looks out of scope
for adding the compiler support. The timing issue - if any - has been
there for more then a decade...
