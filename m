Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F46373C00
	for <xenomai@lists.linux.dev>; Thu,  7 May 2026 12:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778157942; cv=none; b=sOZg6rDOZw7zzF1BMDa2s0nyGk3T6NLBtsX0kPyvdMtC+6r7iLQ+7nRH+O9Wv9PgUyzouez3nIhwCv/2ByuMaO3j1q0ggU+rmgTbEHrzDxj2G888abyFudAzHZ3d5gMg3D3aoMDioaxKprSR1B/ljg41ZZMeuQD259YP/zRk+4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778157942; c=relaxed/simple;
	bh=DgVtwnjB1px/HD1UCIgOD5BUsKFolOsPT4aYxIhv9Tk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TRm6EeS1qHbqmT3fVFe94+618jqcpcobXqmQ3iPKycoKRokFRSeerX1VkYkR7p75VSstv8AY2QRw+oGc+lav5nkhwSfqycp9yg73GW/Wwjb8jiaqKDavwzkHsgua+fK9XGegBz/X7GsxetZH3U1CZ9pkGufV1uvg8jKyZixkBTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=g1a9CfXy; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="g1a9CfXy"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260507123522dc1162ce3a0002076b
        for <xenomai@lists.linux.dev>;
        Thu, 07 May 2026 14:35:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=EXn7Af69Mzk8mqASYIiICQf3ot53jH9s8hte2dcPuKc=;
 b=g1a9CfXyIZ+VG0ApMdsJx9ISYiA37DEK/OzMPtfGALDBY8FuJcUYfYFS7v6wEeFL6pin7e
 aOe6zNodUBIZpyJlVBEb7eodKZvEI/W55YSi+/ZvHRtCsI0nQJFpm2l90HbfBPpQ1xNyIuwi
 DnEQ/q2Q8gRXYbZn8Q2Evia3YGNUU0PW+y9O1/LDmX+jiUixWi5vY8xn26lBRzHY/9iuASxQ
 MofiZJzpWzvS0c3znp2i18ug8rQ/rIHxb/KBshBFPkTtwE4uuQjk5CGJBZujyNIKHnoRBPqz
 oquD+pdRYzcl11IYsJWUhZzCb3SuDraKs9XGdeA3wD6Xzn1dv6x+WUQA==;
Message-ID: <313fd59a45d7860b8772040e1b74d6a42bea2770.camel@siemens.com>
Subject: Re: [PATCH] testsuite/smokey/alchemytests: Relax mq-2 test over VM
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Date: Thu, 07 May 2026 14:35:22 +0200
In-Reply-To: <50dd943e-4c75-456b-b540-5d8d2781d901@siemens.com>
References: <f5c42b11-56c8-4a87-be41-e1b73172425e@siemens.com>
	 <dc069eaf339d470fecc3bae1d1f6e2d299c0cafb.camel@siemens.com>
	 <50dd943e-4c75-456b-b540-5d8d2781d901@siemens.com>
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

On Thu, 2026-05-07 at 14:23 +0200, Jan Kiszka wrote:
> On 07.05.26 13:03, Florian Bezdeka wrote:
> > On Wed, 2026-05-06 at 12:26 +0200, Jan Kiszka wrote:
> > > From: Jan Kiszka <jan.kiszka@siemens.com>
> > >=20
> > > VM environment may delay or reorder the execution of tasks, so relax =
the
> > > checks.
> > >=20
> > > Part of #52.
> > >=20
> > > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > > ---
> > >  testsuite/smokey/alchemytests/mq-2.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/testsuite/smokey/alchemytests/mq-2.c b/testsuite/smokey/=
alchemytests/mq-2.c
> > > index a389e46db0..09b26b2135 100644
> > > --- a/testsuite/smokey/alchemytests/mq-2.c
> > > +++ b/testsuite/smokey/alchemytests/mq-2.c
> > > @@ -7,6 +7,7 @@
> > >  #include <alchemy/queue.h>
> > > =20
> > >  static struct traceobj trobj;
> > > +static bool on_vm;
> > > =20
> > >  static int tseq[] =3D {
> > >  	3, 4, 5, 6,
> > > @@ -87,9 +88,10 @@ static void main_task(void *arg)
> > > =20
> > >  	ret =3D rt_queue_inquire(&q, &info);
> > >  	traceobj_check(&trobj, ret, 0);
> > > -	traceobj_assert(&trobj, info.nmessages =3D=3D 0);
> > > +	traceobj_assert(&trobj, info.nmessages =3D=3D 0 || on_vm);
> > > =20
> > > -	traceobj_verify(&trobj, tseq, sizeof(tseq) / sizeof(int));
> > > +	if (info.nmessages =3D=3D 0)
> > > +		traceobj_verify(&trobj, tseq, sizeof(tseq) / sizeof(int));
> > > =20
> > >  	traceobj_exit(&trobj);
> > >  }
> > > @@ -99,6 +101,8 @@ int main(int argc, char *const argv[])
> > >  	RT_TASK t_main;
> > >  	int ret;
> > > =20
> > > +	on_vm =3D argc > 1 && strcmp(argv[1], "--vm") =3D=3D 0;
> > > +
> >=20
> > Seems a bit risky to expect --vm as first argument only.
> >=20
>=20
> It's not a new pattern, and I thought (please prove me wrong) that this
> is already a filtered argv, freed from generic switches.

Yes, that seems to be the case, but the filtering seems questionable:

Taken from run_alchemytests():

	tmp =3D smokey_run_extprog(XENO_TEST_DIR, tests[i],
				 smokey_on_vm ? args : args + 5,
				 &test_ret);

Where args is

	const char *args =3D "--vm";

args + 5 is pointing to garbage in case smokey_on_vm is false. Right?

>=20
> Jan
>=20
> > >  	traceobj_init(&trobj, argv[0], sizeof(tseq) / sizeof(int));
> > > =20
> > >  	ret =3D rt_task_spawn(&t_main, "main_task", 0,  50, 0, main_task, N=
ULL);
> > > --=20
> > > 2.47.3
>=20
>=20
> --=20
> Siemens AG, Foundational Technologies
> Linux Expert Center
