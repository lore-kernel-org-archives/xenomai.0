Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.65.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795359140;
	b=0OWlM1fCJPIVjFF8WtQDTj1wdlHLOQIKXu2yyK+vv6fUQqxYrhyiOMFfIVkbfInEGLkY
	 eN8an5IbqI3+kMQx1bj4QgczOO4kxAAPW0fd8ES+Rm2+Ear+8gHnzPGIOUetbr1YKAonH
	 EDu1Y8nPk27l6r4/+homN4Oz8W93hVdPWmOYhNkVYU6eimTXMTcyDeizQJU8gBwikDB/k
	 MRo3Txy5dX3Adltuh9ibrpWeMb2sXU1gIVHP0Tu2y47a6xpLtmRJh+iGyxknJ1S9L+CNq
	 aPaQox2wgryroqf7+yn1LZs+NcU0Rcv8+P9zWkoCSewa9wAappqgHa08eciYG0Pta8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795359140;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:X-Flowmailer-Platform:Feedback-ID;
	bh=OrA702rOThZFya+I1OSF/6doKC5OovuHLfuEQK7BjFc=;
	b=d7Z6VD5aWsvPsF564hGIkvlcvoNwz0RsdTvFCRXdFxC84tJv/tfpvFq/HRbH800U9WpE
	 0DIogSyzLGZwVRIAOjVJUzwd7pZL95YadP/DE82bZswp6YKOjCHeuwmpbyZI/UmV4DGzy
	 L2b9vshwiYom6qKesk0JHmXJKdpf7Cfq2V5Bg8AFXYCVA5TULiIMydjpm0xodeacRM7hq
	 EFFpUCS91Ru1WozxbaJY54FRM3RCUFzeDA/YSaPTUtCTrD9ZG2GPRv7YgYIFyIAhsYhRp
	 4vj7ZWovOCroaOJC8KhPZsrmTTR3cWM2DDePTIvbi0trAO2A51CkkF00N5bdiW9fmlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=jRZqJRKK;
	arc=none smtp.remote-ip=185.136.65.228
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60915606A320
	for <xenomai@lists.linux.dev>; Sun, 22 Nov 2026 14:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60915606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=jRZqJRKK
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202611221452097cd924599d0002076f
        for <xenomai@lists.linux.dev>;
        Sun, 22 Nov 2026 15:52:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=OrA702rOThZFya+I1OSF/6doKC5OovuHLfuEQK7BjFc=;
 b=jRZqJRKKiGfku9H2Ly8PPSjzl909lHHpySGGQIcGHYgwNwcMUDDEiyf/QFY+Gj+hcGktVR
 hcFwHgFbb5gGG5LOGSb/2RI8cUNM+QxsUddyGKtbwjhJRQo7ztc8PZodmAdD2Gdx374NQMZA
 fVcmb/s2go+PQ95fDzUG1B67byNoOPJ+0u6USwAL2f5IZ28FHcAW6WUbXrivO+FU3GVsuukA
 Mttk8ulWmrZpLwju4+5G9aBEwy6G6Z27/Y7HGODxyqJKEoxhlYrYGd9ZmgjQte3p+V4SmDYQ
 OtJtXn0mqjakl5Vi198Fk3cTwwVbIDISWKH0tnciCaSG+nY3tWu1FTRQ==;
Message-ID: <b533b6ad250bf960948765d5829fea34f26b99c3.camel@siemens.com>
Subject: Re: [RFC][PATCH] smokey: Add traps test for trap routing of primary
 mode threads
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>, Jan Kiszka
	 <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Cc: Philippe Gerum <rpm@xenomai.org>
Date: Sun, 22 Nov 2026 15:52:09 +0100
In-Reply-To: <4f118759-234c-4ed1-afe2-fbefe849e369@siemens.com>
References: <31921289-e2ce-4370-bb21-97d66de8e566@siemens.com>
	 <37fbdf8e-9116-4b36-840a-612d49fc7f55@siemens.com>
	 <e78f2129-6875-4b5e-87c7-088950b69785@siemens.com>
	 <4f118759-234c-4ed1-afe2-fbefe849e369@siemens.com>
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

On Sat, 2026-11-21 at 18:04 +0100, Tobias Schaffner wrote:
> On 11/17/26 18:28, Jan Kiszka wrote:
> > On 17.11.26 10:27, Tobias Schaffner wrote:
> > > On 11/12/26 18:44, Jan Kiszka wrote:
> > > > From: Jan Kiszka <jan.kiszka@siemens.com>
> > > >=20
> > > > A thread running in primary mode which takes a synchronous exceptio=
n must
> > > > be reported to the Cobalt core by the Dovetail layer exactly once p=
er
> > > > trap, before the in-band kernel applies its fixup. Cobalt then rela=
xes
> > > > the thread, accounts the trap and sends SIGDEBUG_MIGRATE_FAULT when
> > > > asked for. Only the page fault flavor of this was covered so far, b=
y
> > > > the sigdebug test.
> > > >=20
> > > > Add a test which triggers one specific trap per case from a primary=
 mode
> > > > thread and checks that the expected in-band fixup happened. Most tr=
aps
> > > > for x86, arm, and arm64 are covered here. Left out are those that a=
re
> > > > practically irrelevant: AC for unaligned accesses on x86 and VFP
> > > > exceptions
> > > > on ARM. Not yet covered is RISC-V, but it should be easy to add on
> > > > top.
> > > >=20
> > > > See extensive AI generated explanation at the top of traps.c for mo=
re
> > > > details.
> > > >=20
> > > > This test may become useful for checking future OBB trap reporting =
by
> > > > extending it only slightly.
> > > >=20
> > > > Assisted-by: opencode:Fable-5.1/Opus-5.5 Signed-off-by: Jan Kiszka
> > > > <jan.kiszka@siemens.com> ---
> > > >=20
> > > > I know this is huge. Therefore, it is also something that we likely=
 would
> > > > not have done without LLM support - way too much effort for testing
> > > > corner cases.
> > > >=20
> > > > I went through it, but not in all details. The tests fail when they
> > > > are expected to on unfixed kernels, they apparently pass on fixed
> > > > one, at least on our CI hardware. "Should be OK"...
> > > >=20
> > > > BTW, if we merge this, we implicitly document parts of our so far
> > > > unwritten
> > > > AI policy ("yes, we take generated code"). I still need to think
> > > > about which of the templates out there to use best, then I will pro=
pose
> > > > one.
> > >=20
> > > Hi Jan,
> > >=20
> > > Following your input, I spent some time last week on RISC-V trap
> > > handling in EVL. To verify the proposed patches, I ended up with a
> > > similar trap matrix test generated for EVL.
> > >=20
> > > With the number of fixes we can now produce with AI support, I think =
it
> > > is right, and important, to put more time into test infrastructure.
> > > I think it makes sense to pin down in more detail how Dovetail and th=
e
> > > co-kernels built on top are supposed to behave to make sure this is n=
ot
> > > changed by AI without us noticing when these tools are trusted more a=
nd
> > > more.
> > >=20
> > > I am asking myself if we want to keep some kind of human readable
> > > source of truth that tells us how this is supposed to work. If we sta=
rt
> > > generating both sides and both sides are hard to understand (at least
> > > for me, the kernel side still is) I feel like it will be hard to noti=
ce
> > > if the tools start to slowly change the design.
> > >=20
> >=20
> > Good point. I'm currently fairly impressed how much the models
> > understood about the current dovetail architecture by just reading the
> > kernel patches. Maybe they consumed some documents upfront, but
> > definitely not while answering prompts.
> >=20
> > That said, we more guardrails, also for models that might be cheaper,
> > more sovereign (local open-weight...), but also less smart could be
> > useful. Question remains how to encode things best to have both side
> > understand the same.
> >=20
> > > In addition, I feel like most of the tests are Dovetail functionality
> > > tests and not specific to cobalt/EVL. I think we should at least try =
to
> > > find a way to tackle this with joined forces for cobalt, EVL and what
> > > ever other co-kernel using the infrastructure.
> >=20
> > Yeah, valid point. Maybe the availability of a POSIX interface for EVL
> > will once allow to write more portable test cases or even share the sam=
e
> > code base.
> >=20
> > >=20
> > > I think that RV can maybe help here. It would allow us to decouple so=
me
> > > of the checks from the triggering of the test cases. Triggering could=
 be
> > > in the co-kernel projects while most of the verification lives in
> > > Dovetail.
> > >=20
> > > I created a POC of a more detailed trap monitor paired with a matrix
> > > test that solely triggers the traps from the different contexts in
> > > cobalt here:
> > > https://github.com/TobiasSchaffner/linux/commits/tobsch/trap-monitor-
> > > rfc-proposal-nofixes/
> > >=20
> > > Asking Opus 5.5 about a comparison to your proposed RFC it tells me:
> > > ```
> > > Not covered:
> > > - SIGDEBUG with SIGDEBUG_MIGRATE_FAULT, exactly once. That's Cobalt's
> > >  =C2=A0 notification to the application, and we don't check it.
> > > - The counters in /proc/xenomai/faults: the right trap +1, all others
> > >  =C2=A0 unchanged. That's Cobalt's accounting.
> > > - The exact mode-switch count (Cobalt's msw statistics).
> > >=20
> > > On top of the RFC, it covers (checks no user-space test can see):
> > > - the handler level of the unwind, through the stack frame;
> > > - irqs off on trap exit;
> > > - demotion only from task context;
> > > - no IRQ in NMI context;
> > > - no sched-out during a kprobe;
> > > - the time limit.
> > > - more fault cases: read-null, write-ro, write-retry, exec-nx, bus-eo=
f,
> > > fresh, fork-write, kernel-fault, kernel-fresh, misaligned.
> > > ```
> > >=20
> > > The output makes sense cause the POC has no cobalt API specific check=
s
> > > anymore while the monitor adds more kernel internal checks.
> > >=20
> > > The hole approach Monitor + Triggering matrix is smaller than your te=
st
> > > while the monitor part could be reused. A rendering of the monitor is
> > > attached.
> > >=20
> > > Maybe you want to consider it or spend some tokens for further analys=
is
> > > if this can be valuable.
> > >=20
> >=20
> > "Smaller" triggers me for sure! Would be worth to see the outcome in
> > code. And we may still consider addressing potential gaps on top in the
> > userland. Key is that the userland test orchestrator and stimulus
> > generator and also read back the result of the RV monitor run.
> >=20
> > But what might be more challenging: we would have to backport your
> > infrastructure to all kernels we are maintaining. Is that realistic? At
> > least down to 5.10?
>=20
> Hmm... I did not have this on my radar... The RV subsystem was merged in
> 6.0 and the Hybrid Automata that I build on was introduced in 7.1. I
> think that back porting the whole subsystem as well as all the needed
> tracepoints would be a huge lift.
>=20
>=20

The Linux RV monitor is usable since 7.3, before that it simply had to
much overhead when compiled in, even if not being used. With 7.3 you can
build enable it without any impact unless you start using it.

That said, I don't think that we should backport that at all. If someone
is interested in validation =3D> use a modern kernel.

