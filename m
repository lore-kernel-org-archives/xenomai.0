Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61E0374187
	for <xenomai@lists.linux.dev>; Fri,  8 May 2026 07:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778226199; cv=none; b=IUwDEilkdvhx/YXfiMnH0knrPyCUzziDsJTQPZMeKRKMZoI7yBCapV7vjuk0w6yGSLMvHpYBlBvLhexK9v/jzoIXyWjhFUZVcX/rPp8YBm+QzJaggTlS9aLJdNjnAwExHNS8ZF7fMJE4Lb/3x7+aeyLmI8D/Sv/I5X4HTdI5gBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778226199; c=relaxed/simple;
	bh=zDZdq7OYxuixOD244KM5kQRayu3hZdB/dq5wX64svmo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=snmJqHJaB0Zzk63cN3/4UlVemHN35JpRPSPAdzV0eB+lG6c1sF4yXshezRjma4Wif3WeowyecY1/u2VXV/5yJv+fe2LOfVFKu2L7cL/ai6GuKk+yGR7XlZIZ2D0tGWniIuEyZoiY2V3KMEvrx3fBvaIXhoPJxjhzVCpbzp/zDl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=m7TA2bRM; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="m7TA2bRM"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260508074309401a86076f000207ba
        for <xenomai@lists.linux.dev>;
        Fri, 08 May 2026 09:43:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=lMEv0cO4XcqZ1HWjNyCD86rLYtZXY6i4ml0Na3fRggI=;
 b=m7TA2bRMSU3qu096yBUvJZC7BqIlWKF4jxJyDVerp7fO6onp090bUvgZZQBWNjlAt3KXdm
 Q2+XFM7B5b/crXyalrL3r3M8SvgUWH3LkktBALiFs1wii/k8bYHzD08i864s8Uiy6JkPGlZQ
 gSrlmoOm4XmlhS3jXXowoCWJUZ6LsRQE4D0j4XaseMmHvmNKdwkBrpBtKBNVAqpSPLspXF+W
 1uyD8QL1Pmf9hhURjSngpfvwQpOjzlzKZFF7YiL4IQR0/l5sxUk2ZXdlW5OlgkTNB8n2m7Lb
 z+BrECfRic4TMPiqiXg0rdj4MBnNXmdfRZmAT7X0cVO1aUxWiOAL5g5A==;
Message-ID: <cfde3caa812e6ab9fb96eccc915e8bb38ed394a3.camel@siemens.com>
Subject: Re: [PATCH] testsuite/smokey/alchemytests: Relax mq-2 test over VM
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Date: Fri, 08 May 2026 09:43:08 +0200
In-Reply-To: <665e76d5-22fc-42e3-a65a-4b55c74bd008@siemens.com>
References: <f5c42b11-56c8-4a87-be41-e1b73172425e@siemens.com>
	 <dc069eaf339d470fecc3bae1d1f6e2d299c0cafb.camel@siemens.com>
	 <50dd943e-4c75-456b-b540-5d8d2781d901@siemens.com>
	 <313fd59a45d7860b8772040e1b74d6a42bea2770.camel@siemens.com>
	 <665e76d5-22fc-42e3-a65a-4b55c74bd008@siemens.com>
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

On Thu, 2026-05-07 at 14:53 +0200, Jan Kiszka wrote:
> On 07.05.26 14:35, Florian Bezdeka wrote:
> > On Thu, 2026-05-07 at 14:23 +0200, Jan Kiszka wrote:
> > > On 07.05.26 13:03, Florian Bezdeka wrote:
> > > > On Wed, 2026-05-06 at 12:26 +0200, Jan Kiszka wrote:
> > > > > From: Jan Kiszka <jan.kiszka@siemens.com>
> > > > >=20
> > > > > VM environment may delay or reorder the execution of tasks, so re=
lax the
> > > > > checks.
> > > > >=20
> > > > > Part of #52.
> > > > >=20
> > > > > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > > > > ---
> > > > >  testsuite/smokey/alchemytests/mq-2.c | 8 ++++++--
> > > > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > > >=20
> > > > > diff --git a/testsuite/smokey/alchemytests/mq-2.c b/testsuite/smo=
key/alchemytests/mq-2.c
> > > > > index a389e46db0..09b26b2135 100644
> > > > > --- a/testsuite/smokey/alchemytests/mq-2.c
> > > > > +++ b/testsuite/smokey/alchemytests/mq-2.c
> > > > > @@ -7,6 +7,7 @@
> > > > >  #include <alchemy/queue.h>
> > > > > =20
> > > > >  static struct traceobj trobj;
> > > > > +static bool on_vm;
> > > > > =20
> > > > >  static int tseq[] =3D {
> > > > >  	3, 4, 5, 6,
> > > > > @@ -87,9 +88,10 @@ static void main_task(void *arg)
> > > > > =20
> > > > >  	ret =3D rt_queue_inquire(&q, &info);
> > > > >  	traceobj_check(&trobj, ret, 0);
> > > > > -	traceobj_assert(&trobj, info.nmessages =3D=3D 0);
> > > > > +	traceobj_assert(&trobj, info.nmessages =3D=3D 0 || on_vm);
> > > > > =20
> > > > > -	traceobj_verify(&trobj, tseq, sizeof(tseq) / sizeof(int));
> > > > > +	if (info.nmessages =3D=3D 0)
> > > > > +		traceobj_verify(&trobj, tseq, sizeof(tseq) / sizeof(int));
> > > > > =20
> > > > >  	traceobj_exit(&trobj);
> > > > >  }
> > > > > @@ -99,6 +101,8 @@ int main(int argc, char *const argv[])
> > > > >  	RT_TASK t_main;
> > > > >  	int ret;
> > > > > =20
> > > > > +	on_vm =3D argc > 1 && strcmp(argv[1], "--vm") =3D=3D 0;
> > > > > +
> > > >=20
> > > > Seems a bit risky to expect --vm as first argument only.
> > > >=20
> > >=20
> > > It's not a new pattern, and I thought (please prove me wrong) that th=
is
> > > is already a filtered argv, freed from generic switches.
> >=20
> > Yes, that seems to be the case, but the filtering seems questionable:
> >=20
> > Taken from run_alchemytests():
> >=20
> > 	tmp =3D smokey_run_extprog(XENO_TEST_DIR, tests[i],
> > 				 smokey_on_vm ? args : args + 5,
> > 				 &test_ret);
> >=20
> > Where args is
> >=20
> > 	const char *args =3D "--vm";
> >=20
> > args + 5 is pointing to garbage in case smokey_on_vm is false. Right?
>=20
> Yeah, went unnoticed in via 61fc9ff4b7214fb1d9802aa7d177a555f0ad47e3.
> Please fix and also check the other tests at that chance.
>=20

testsuite/smokey/psostests/mq-3.c has also a check for --vm in argv[1]
but never got this cmdline parameter...

Should I remove the check or fix the cmdline arg invocation? Were there
any issues seen with this specific test (in CI) in the past?
