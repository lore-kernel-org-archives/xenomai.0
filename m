Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.65.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795374448;
	b=wNr8kafHJQbC+1TE97flasPYX+e3nljqYJrpGGoA7KHZeXmudstUw8Fpjqihx+ab36L3
	 nkP+WZZ4FRK2EJM2tgb07bvhJl3ToRocToQVPiPQ5k5IzZkJq2ai41KCYKGIXQa/xzJYB
	 uzUd/txDETUfFe36AW6oTwT92aKc2rXFO+fL6lFQddRnbUW6RqyFuOX2FJms6gPyQQN0a
	 /rLafrJpE1daY4SJ3n262Uxk9MlnA26b93e9yTMWlYrkYPn+ykatsrY0FTT+w0GUAXoci
	 F+iBiFvXL10Az4Nr0xc1Y0ZvmEfX4QyFflcYzHXZx4geFkSHspfIs76s1bbIDgOhtLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795374448;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:X-Flowmailer-Platform:Feedback-ID;
	bh=DM/op7tuRre8LeQW26SkP4+I2IUWso9RhcDYCXbG9c0=;
	b=I0mIq4y4h70gx21y/AzOW+1SJ0YoJ2DrlB2iJSRq0xAwwVvVL95QMvyn9kO9zdKKSnjQ
	 tEUb/8Yzkb4XTV6vUrukP9c/BqWElM6m6xA60KN6PdYLQy+IoPQ5ixzrHplORmZthUTgL
	 Dz09oJQwUOT+nSjI6yrGKcsTZcmK6iX+zjq9Kz2Zb/2TAEtEsYXaFTklpUcl6uPTHTk5L
	 MB8dwZKQV4rjQp/6ScceKwKEQ4FxG5IKosBNLvYzN1u4RpQ67sUy1kKuKSOXAqGbrdyEF
	 9Hr4IIQkc/smzsZYSZr28qfDRKsJog2RkCGETcdX6blwxTJUs7xCiLsBrrmJldPKumA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=YBFpBEHn;
	arc=none smtp.remote-ip=185.136.65.226
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5C9606A337
	for <xenomai@lists.linux.dev>; Sun, 22 Nov 2026 19:07:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD5C9606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=YBFpBEHn
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2026112219071612725f75d300020767
        for <xenomai@lists.linux.dev>;
        Sun, 22 Nov 2026 20:07:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=DM/op7tuRre8LeQW26SkP4+I2IUWso9RhcDYCXbG9c0=;
 b=YBFpBEHnk68CMg4ciVNTPZR1fiCr85vHBxn3gOpftk4RhdMP2KvnXqlsUQ+OT82hqK14Ku
 T5zbZcQ55Jh425UOT5aVINsJcoCRF+RE6m/xLBFCy2knEXh5nQHgWHmFTWs54hcG2rexLQVc
 rx2rf87jaYLarPwhmAd0eAEYqvDNuKZ4nzz0OgcnEsFo6rx6MvHOsZih5uzaffmVTc62FjR1
 jqNoYTflCR+ic7NtNxNG4usPGgPyvXSe0pOcFZZZHqOgG2vzWKVe9Nm+luupVeB2yUY7O/sm
 upPlsF+TldNhlnv2Jgs6942uhKtWY9LzUgsiwjQpEq1hoGEel7Vixrxg==;
Message-ID: <6c4a73ca6be802d564e770baecd5d90220627d13.camel@siemens.com>
Subject: Re: [RFC][PATCH] smokey: Add traps test for trap routing of primary
 mode threads
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>, Jan Kiszka
	 <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Cc: Philippe Gerum <rpm@xenomai.org>
Date: Sun, 22 Nov 2026 20:07:14 +0100
In-Reply-To: <ba91a81f-a52a-4742-b4f9-4c9c3437ef8c@siemens.com>
References: <31921289-e2ce-4370-bb21-97d66de8e566@siemens.com>
	 <37fbdf8e-9116-4b36-840a-612d49fc7f55@siemens.com>
	 <e78f2129-6875-4b5e-87c7-088950b69785@siemens.com>
	 <4f118759-234c-4ed1-afe2-fbefe849e369@siemens.com>
	 <b533b6ad250bf960948765d5829fea34f26b99c3.camel@siemens.com>
	 <ba91a81f-a52a-4742-b4f9-4c9c3437ef8c@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Sun, 2026-11-22 at 19:17 +0100, Tobias Schaffner wrote:
> On 11/22/26 15:52, Florian Bezdeka wrote:
> > On Sat, 2026-11-21 at 18:04 +0100, Tobias Schaffner wrote:
> > > On 11/17/26 18:28, Jan Kiszka wrote:
> > > > On 17.11.26 10:27, Tobias Schaffner wrote:
> > > > > On 11/12/26 18:44, Jan Kiszka wrote:
> > > > > > From: Jan Kiszka <jan.kiszka@siemens.com>
> > > > > >=20
> > > > > > A thread running in primary mode which takes a synchronous exce=
ption must
> > > > > > be reported to the Cobalt core by the Dovetail layer exactly on=
ce per
> > > > > > trap, before the in-band kernel applies its fixup. Cobalt then =
relaxes
> > > > > > the thread, accounts the trap and sends SIGDEBUG_MIGRATE_FAULT =
when
> > > > > > asked for. Only the page fault flavor of this was covered so fa=
r, by
> > > > > > the sigdebug test.
> > > > > >=20
> > > > > > Add a test which triggers one specific trap per case from a pri=
mary mode
> > > > > > thread and checks that the expected in-band fixup happened. Mos=
t traps
> > > > > > for x86, arm, and arm64 are covered here. Left out are those th=
at are
> > > > > > practically irrelevant: AC for unaligned accesses on x86 and VF=
P
> > > > > > exceptions
> > > > > > on ARM. Not yet covered is RISC-V, but it should be easy to add=
 on
> > > > > > top.
> > > > > >=20
> > > > > > See extensive AI generated explanation at the top of traps.c fo=
r more
> > > > > > details.
> > > > > >=20
> > > > > > This test may become useful for checking future OBB trap report=
ing by
> > > > > > extending it only slightly.
> > > > > >=20
> > > > > > Assisted-by: opencode:Fable-5.1/Opus-5.5 Signed-off-by: Jan Kis=
zka
> > > > > > <jan.kiszka@siemens.com> ---
> > > > > >=20
> > > > > > I know this is huge. Therefore, it is also something that we li=
kely would
> > > > > > not have done without LLM support - way too much effort for tes=
ting
> > > > > > corner cases.
> > > > > >=20
> > > > > > I went through it, but not in all details. The tests fail when =
they
> > > > > > are expected to on unfixed kernels, they apparently pass on fix=
ed
> > > > > > one, at least on our CI hardware. "Should be OK"...
> > > > > >=20
> > > > > > BTW, if we merge this, we implicitly document parts of our so f=
ar
> > > > > > unwritten
> > > > > > AI policy ("yes, we take generated code"). I still need to thin=
k
> > > > > > about which of the templates out there to use best, then I will=
 propose
> > > > > > one.
> > > > >=20
> > > > > Hi Jan,
> > > > >=20
> > > > > Following your input, I spent some time last week on RISC-V trap
> > > > > handling in EVL. To verify the proposed patches, I ended up with =
a
> > > > > similar trap matrix test generated for EVL.
> > > > >=20
> > > > > With the number of fixes we can now produce with AI support, I th=
ink it
> > > > > is right, and important, to put more time into test infrastructur=
e.
> > > > > I think it makes sense to pin down in more detail how Dovetail an=
d the
> > > > > co-kernels built on top are supposed to behave to make sure this =
is not
> > > > > changed by AI without us noticing when these tools are trusted mo=
re and
> > > > > more.
> > > > >=20
> > > > > I am asking myself if we want to keep some kind of human readable
> > > > > source of truth that tells us how this is supposed to work. If we=
 start
> > > > > generating both sides and both sides are hard to understand (at l=
east
> > > > > for me, the kernel side still is) I feel like it will be hard to =
notice
> > > > > if the tools start to slowly change the design.
> > > > >=20
> > > >=20
> > > > Good point. I'm currently fairly impressed how much the models
> > > > understood about the current dovetail architecture by just reading =
the
> > > > kernel patches. Maybe they consumed some documents upfront, but
> > > > definitely not while answering prompts.
> > > >=20
> > > > That said, we more guardrails, also for models that might be cheape=
r,
> > > > more sovereign (local open-weight...), but also less smart could be
> > > > useful. Question remains how to encode things best to have both sid=
e
> > > > understand the same.
> > > >=20
> > > > > In addition, I feel like most of the tests are Dovetail functiona=
lity
> > > > > tests and not specific to cobalt/EVL. I think we should at least =
try to
> > > > > find a way to tackle this with joined forces for cobalt, EVL and =
what
> > > > > ever other co-kernel using the infrastructure.
> > > >=20
> > > > Yeah, valid point. Maybe the availability of a POSIX interface for =
EVL
> > > > will once allow to write more portable test cases or even share the=
 same
> > > > code base.
> > > >=20
> > > > >=20
> > > > > I think that RV can maybe help here. It would allow us to decoupl=
e some
> > > > > of the checks from the triggering of the test cases. Triggering c=
ould be
> > > > > in the co-kernel projects while most of the verification lives in
> > > > > Dovetail.
> > > > >=20
> > > > > I created a POC of a more detailed trap monitor paired with a mat=
rix
> > > > > test that solely triggers the traps from the different contexts i=
n
> > > > > cobalt here:
> > > > > https://github.com/TobiasSchaffner/linux/commits/tobsch/trap-moni=
tor-
> > > > > rfc-proposal-nofixes/
> > > > >=20
> > > > > Asking Opus 5.5 about a comparison to your proposed RFC it tells =
me:
> > > > > ```
> > > > > Not covered:
> > > > > - SIGDEBUG with SIGDEBUG_MIGRATE_FAULT, exactly once. That's Coba=
lt's
> > > > >   =C2=A0 notification to the application, and we don't check it.
> > > > > - The counters in /proc/xenomai/faults: the right trap +1, all ot=
hers
> > > > >   =C2=A0 unchanged. That's Cobalt's accounting.
> > > > > - The exact mode-switch count (Cobalt's msw statistics).
> > > > >=20
> > > > > On top of the RFC, it covers (checks no user-space test can see):
> > > > > - the handler level of the unwind, through the stack frame;
> > > > > - irqs off on trap exit;
> > > > > - demotion only from task context;
> > > > > - no IRQ in NMI context;
> > > > > - no sched-out during a kprobe;
> > > > > - the time limit.
> > > > > - more fault cases: read-null, write-ro, write-retry, exec-nx, bu=
s-eof,
> > > > > fresh, fork-write, kernel-fault, kernel-fresh, misaligned.
> > > > > ```
> > > > >=20
> > > > > The output makes sense cause the POC has no cobalt API specific c=
hecks
> > > > > anymore while the monitor adds more kernel internal checks.
> > > > >=20
> > > > > The hole approach Monitor + Triggering matrix is smaller than you=
r test
> > > > > while the monitor part could be reused. A rendering of the monito=
r is
> > > > > attached.
> > > > >=20
> > > > > Maybe you want to consider it or spend some tokens for further an=
alysis
> > > > > if this can be valuable.
> > > > >=20
> > > >=20
> > > > "Smaller" triggers me for sure! Would be worth to see the outcome i=
n
> > > > code. And we may still consider addressing potential gaps on top in=
 the
> > > > userland. Key is that the userland test orchestrator and stimulus
> > > > generator and also read back the result of the RV monitor run.
> > > >=20
> > > > But what might be more challenging: we would have to backport your
> > > > infrastructure to all kernels we are maintaining. Is that realistic=
? At
> > > > least down to 5.10?
> > >=20
> > > Hmm... I did not have this on my radar... The RV subsystem was merged=
 in
> > > 6.0 and the Hybrid Automata that I build on was introduced in 7.1. I
> > > think that back porting the whole subsystem as well as all the needed
> > > tracepoints would be a huge lift.
> > >=20
> > >=20
> >=20
> > The Linux RV monitor is usable since 7.3, before that it simply had to
> > much overhead when compiled in, even if not being used. With 7.3 you ca=
n
> > build enable it without any impact unless you start using it.
>=20
> Do you have any source or measurement results that show this? This
> statement does not fit to what I know about RV and contradicts my
> measurement results. RV has always been very cheap when running and=20
> close to free when it's not.

Close to free is not acceptable for production systems. Depending on the
workload you could easily run into problems (pre 7.3).

My own experiments (especially with the RV monitor), the discussions we
had at plumbers this year and especially John's talk about the RV at the
RT user forum in Prague (see
https://www.youtube.com/watch?v=3DjO4M5dx52Vw) would be he references you
are looking for.


