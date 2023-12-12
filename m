Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E48956B9B
	for <xenomai@lists.linux.dev>; Tue, 12 Dec 2023 08:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="IPzYRC6E"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20231212085909fae695926705ea60b4
        for <xenomai@lists.linux.dev>;
        Tue, 12 Dec 2023 09:59:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=UuyhiSW4DWsmcIY/osAmHAc/rnk5lfGBjwS37LLWtyo=;
 b=IPzYRC6Evarwmj6AYZ2lBaOors8ITXJqipmNhjutrpCtQXuW1JFpu5Wu4zIyXDCl16pCPp
 UPVVrVwxb1+7rAtXm5XPS6Qx01OOd0UjQc+Jg1s3iX8/FOK7zYPluKVohl8yb1PBiZvGbh6b
 uTSnL+UZQ8U0RZh7x7QklCIVYQyAw=;
Message-ID: <5897736d591a75e317a0c60b2f3fb102043d94d2.camel@siemens.com>
Subject: Re: [PATCH v3] lib/psos/task.c: fix build with gcc >= 12 and -Ofast
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Fabrice Fontaine
	 <fontaine.fabrice@gmail.com>, xenomai@lists.linux.dev
Date: Tue, 12 Dec 2023 09:59:07 +0100
In-Reply-To: <fddc0898-7281-4d72-8d0b-0b712319dd3f@siemens.com>
References: <20231204083935.629619-1-fontaine.fabrice@gmail.com>
	 <e0089ecf-a597-49e8-8186-9944101260f8@siemens.com>
	 <51181fc4df79c4b6cbfd17fea731eb512d4740d9.camel@siemens.com>
	 <fddc0898-7281-4d72-8d0b-0b712319dd3f@siemens.com>
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

On Tue, 2023-12-05 at 07:14 +0900, Jan Kiszka wrote:
> On 04.12.23 21:36, Florian Bezdeka wrote:
> > On Mon, 2023-12-04 at 21:52 +0900, Jan Kiszka wrote:
> > > On 04.12.23 16:39, Fabrice Fontaine wrote:
> > > > Fix the following build failure with gcc >=3D 12 and -Ofast (found =
by
> > > > buildroot autobuilders on xenomai 3.0.10 [1]):
> > > >=20
> > > > task.c: In function 't_start':
> > > > task.c:398:16: error: 'ret' may be used uninitialized [-Werror=3Dma=
ybe-uninitialized]
> > > >   398 |         return ret;
> > > >       |                ^~~
> > > > task.c:364:13: note: 'ret' was declared here
> > > >   364 |         int ret;
> > > >       |             ^~~
> > > > task.c: In function 't_resume':
> > > > task.c:444:16: error: 'ret' may be used uninitialized [-Werror=3Dma=
ybe-uninitialized]
> > > >   444 |         return ret;
> > > >       |                ^~~
> > > > task.c:428:13: note: 'ret' was declared here
> > > >   428 |         int ret;
> > > >       |             ^~~
> > > >=20
> > > > [1] http://autobuild.buildroot.org/results/bc1b40de22e563b704ad7f20=
b6bf4d1f73a6ed8a
> > > >=20
> > > > Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
> > > > ---
> > > > Changes v2 -> v3 (after review of Jan Kiszka and Florian Bezdeka):
> > > >  - Move ERR_OBJDEL to get_psos_task
> > > >  - Update commit message to mention -Ofast and xenomai 3.0.10
> > > >=20
> > > > Changes v1 -> v2 (after review of Jan Kiszka):
> > > >  - Replace SUCCESS by ERR_OBJDEL
> > > >=20
> > > >  lib/psos/task.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >=20
> > > > diff --git a/lib/psos/task.c b/lib/psos/task.c
> > > > index f678be61d..b5cd087e4 100644
> > > > --- a/lib/psos/task.c
> > > > +++ b/lib/psos/task.c
> > > > @@ -99,6 +99,7 @@ static struct psos_task *find_psos_task_or_self(u=
_long tid, int *err_r)
> > > > =20
> > > >  struct psos_task *get_psos_task(u_long tid, int *err_r)
> > > >  {
> > > > +	*err_r =3D ERR_OBJDEL;
> > > >  	struct psos_task *task =3D find_psos_task(tid, err_r);
> > > > =20
> > > >  	/*
> > >=20
> > > Thanks, applied.
> >=20
> > Hm... err_r can never be NULL?
> >=20
>=20
> This function already assumed that err_r is always non-NULL before this
> change.

This patch makes the smokey testsuite fail, psostests reports:

2023-12-07T10:59:27 [1] at task-4.c:22
2023-12-07T10:59:27    0\"011.394| BUG in __traceobj_assert_failed(): [TASK=
] trace assertion failed:
2023-12-07T10:59:27               task-4.c:36 =3D> \"ret =3D=3D 0 && regval=
 =3D=3D 0xdeadbeef\"
2023-12-07T10:59:27 test psostests_task4 failed: 256

ret is now 5 (ERR_OBJDEL) instead of the expected 0 (SUCCESS).

>=20
> Jan
>=20
> --=20
> Siemens AG, Technology
> Linux Expert Center

