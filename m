Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC635D49C
	for <xenomai@lists.linux.dev>; Tue, 12 Dec 2023 12:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="axSwOq7U"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202312121213381d709e91e981534722
        for <xenomai@lists.linux.dev>;
        Tue, 12 Dec 2023 13:13:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=uGsz3tw/0zSWmkjFodS05DZMAFEsYUH0urlbGW9g8XM=;
 b=axSwOq7UwidqubGCRSck7+VK01g+XwrpYnpV8gkbGHZDQEGjZGMwBIzYK6Zj7Ar5sFhsG2
 ydtkYngKR2WDF+34jzU0Qt3EAz5gd0DsmKU+Ch5eKdwRHk+Fvchl88ToN5Fh6JfkeFRw1586
 WbmVfifRv2ja2GlWJbgJm9+nKpeAY=;
Message-ID: <a8d23bf707291c5d8ef2534baf8c22b535f16159.camel@siemens.com>
Subject: Re: [PATCH] lib/psos/task.c: Fix psos tests, incorrect error
 reporting
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Cc: Fabrice Fontaine <fontaine.fabrice@gmail.com>
Date: Tue, 12 Dec 2023 13:13:37 +0100
In-Reply-To: <b96c25bb-20b1-48f3-8eb8-a9b1876ee820@siemens.com>
References: <20231212-flo-fix-testsuite-v1-1-614eb1703e08@siemens.com>
	 <b96c25bb-20b1-48f3-8eb8-a9b1876ee820@siemens.com>
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

On Tue, 2023-12-12 at 11:47 +0100, Jan Kiszka wrote:
> On 12.12.23 11:01, Florian Bezdeka wrote:
> > The following smokey test failure was seen on the current next branch:
> >=20
> >  [1] at task-4.c:22
> >     0\"011.394| BUG in __traceobj_assert_failed(): [TASK] trace asserti=
on failed:
> >                task-4.c:36 =3D> \"ret =3D=3D 0 && regval =3D=3D 0xdeadb=
eef\"
> >  test psostests_task4 failed: 256
> >=20
> > The problem was introduced in
> > 8dceca122dbb ("lib/psos/task.c: fix build with gcc >=3D 12 and -Ofast")=
,
> > the second parameter of get_psos_task() was unconditionally initialized
> > with ERR_OBJDEL. Even if no error occurred later on, an error was
> > reported.
> >=20
> > All users of get_psos_task() and get_psos_task_or_self() have to
> > initialize the second parameter when the care about the returned error
> > code afterwards. The value of the parameter will only be overwritten in
> > case of an error.
> >=20
> > Fixes: 8dceca122dbb ("lib/psos/task.c: fix build with gcc >=3D 12 and -=
Ofast")
> > CC: Fabrice Fontaine <fontaine.fabrice@gmail.com>
> >=20
> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > ---
> >  lib/psos/task.c | 9 ++++-----
> >  lib/psos/tm.c   | 2 +-
> >  2 files changed, 5 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/lib/psos/task.c b/lib/psos/task.c
> > index 5341289df..70b5c6596 100644
> > --- a/lib/psos/task.c
> > +++ b/lib/psos/task.c
> > @@ -96,7 +96,6 @@ static struct psos_task *find_psos_task_or_self(u_lon=
g tid, int *err_r)
> > =20
> >  struct psos_task *get_psos_task(u_long tid, int *err_r)
> >  {
> > -	*err_r =3D ERR_OBJDEL;
>=20
> This re-introduces the bug that the previous commit was (also) trying to
> fix: We do not set *err_t when
>=20
> task =3D=3D NULL || threadobj_lock(&task->thobj) =3D=3D -EINVAL

Nope, I don't think so. The caller already does the initialization
(now). *err_t is only over-written in case an error occurred. That is
where the "might be uninitialized" error came from.

We have to look at get_psos_task() and get_psos_task_or_self()
together. I think it's wrong to do the initialization inside
get_psos_task().

>=20
> is false. Maybe just moving this assignment under that condition, before
> the return, will solve both? And I would prefer a v4 of the previous
> patch as it is not yet in master.

Migration to a v4 should be easy once we agree the provided fix is
correct.

>=20
> Jan

