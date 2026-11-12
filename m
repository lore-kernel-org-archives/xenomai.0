Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.178.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794483589;
	b=vyCeY4Ive3EIIi3rp2t2qeHRlhQeUoBwFhaU7xDY9EP4UMhVUwzVdbM1OgM9Q7u/xjCb
	 npFzQ/3lwUffSKFm+KSBucoI80Mkuk4MUoZlCaBhrSG0Eo9s/JUu5ISmGOkRUVoQLnn1I
	 TfUyZfMipcsMhXmwJaOU97oFKIdFoVH18YIUIl7KyXwtJqwuTkNj+Y9zYoSnfSXkaOseO
	 d6g3cLLcoFdAPgakCGTinCJCqwApg2QvFLdhAT8saCFHMpjiFANHSTyiGKaaFZ27rzKsN
	 dv6njHyoYadWcAiI/HccV8h2Owp+s9O4cimmXcPbVlQRsE+0Yd0ezzZ430X4t2zqeYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794483589;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Subject:From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-Flowmailer-Platform:
	 Feedback-ID:X-GND-State:X-GND-Score:X-GND-Cause;
	bh=eRg51wi9oWwJtzPM6RZkZXhuDW9tyvxqWYHY8gHTR4M=;
	b=hYaaUS4o2ApEnucQmsp/ocMxPgdFzkPle1RDjn+Rw5eZjvQ5rpl9nVxYR65wCbel6uBl
	 Y18HDEIIhjqRbHf+suyoiSnJXDLJdznMfboGsoUrX1d86cmRPr1lok3Eb++Kf+xKm1w3H
	 eldVyAElBKyOQI285BTtv78C5poQpENBI7v4e2sM3JIuLDpLVAGTnJCEsEa6Ikw/lJU1p
	 IaM8Zfd4UEAR98Y37d7FOScSooeqDIEASUp4vJ40tBvrhpGZK6QNgV5ZbkTfyB3d21gda
	 n4XmoKV3XursdkGiqcjeRVvtCXiFg1Vwo0edfsNr9TX6Jw7IblV8Nl9DI3xDIeLP8BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=redirect.mail.gandi.net;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=MIgW4d96;
	arc=none smtp.remote-ip=217.70.178.232
Received: from redirect.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9912606A31C
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 11:39:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9912606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=MIgW4d96
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay12.mail.gandi.net (Postfix) with ESMTPS id C9D973EA48
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 11:39:45 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 7CF24C00057
	for <xenomai@xenomai.org>; Thu, 12 Nov 2026 11:39:45 +0000 (UTC)
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm1 header.b=MIgW4d96;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of fm-68982-20261112113944fe9389d4010002073f-EKpBYU@rts-flowmailer.siemens.com designates 185.136.65.226 as permitted sender) smtp.mailfrom=fm-68982-20261112113944fe9389d4010002073f-EKpBYU@rts-flowmailer.siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20261112113944fe9389d4010002073f
        for <xenomai@xenomai.org>;
        Thu, 12 Nov 2026 12:39:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=eRg51wi9oWwJtzPM6RZkZXhuDW9tyvxqWYHY8gHTR4M=;
 b=MIgW4d96jOzKnlaC7Pf48gcjwaz6flAZtC8Ch7Rnz2O2PADkRWqxRHsPjAnJM61DzQk9yo
 qfxv4EbJGu6QMyd+7EKjdwWCE9Hrx01BDVNHT6VtC4MpX4vVNivvISgyEJJwQdWciKPhL/2a
 espCMuiVrVGJu4Ek0kBQWwvXvA7CuIoYdZAx3vcpIWTRYiFNit/KlBmEsLk+5VmQGbmlSNmO
 lLrzxCtIov6/85/NyUiJDaFRDoPa+J5F6+Kb0vG3umQRZIsFkeE54W3SL8gvsCtY+wwPWdpw
 0k1B8+Rt+xl4NwUVNEmwhYXd2DscLFckyToWXznu2BEwHnyfQbNtnTtg==;
Message-ID: <b4f20066cfe191c9aa22e4da524d56838da5df3c.camel@siemens.com>
Subject: Re: [dovetail][PATCH v2 0/4] ARM trap fixes and generic handling of
 trap nesting
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org
Date: Thu, 12 Nov 2026 12:39:43 +0100
In-Reply-To: <6033b5fe-60d8-4032-ab43-58048673c71e@siemens.com>
References: <cover.1794399047.git.jan.kiszka@siemens.com>
	 <87cxsa2vej.fsf@xenomai.org>
	 <f91999aa3245c9e4759abb00d9113712226e884f.camel@siemens.com>
	 <383c361e-ca33-4ca5-9619-8baa870ca3ea@siemens.com>
	 <339734f5fd22b6c1cd01bb70e3e07d444f121369.camel@siemens.com>
	 <6033b5fe-60d8-4032-ab43-58048673c71e@siemens.com>
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
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTEtzLimOFskh7vUIe0Fvr0tS2qWV//tFPjz2bmPGIN1JjdsTphtCeo8h022dnch4FB8p1OgaHPZcRBy0zWRk8F+XWx451KK+6AZg1qIUJN3bB3tg7+LRJKyrzlb4j8nLorZEoQ+rxDAEU11RFUu3h4/ZOPFlSXAK+toeuJJysO66c2KHDXmN7X4QcVyZEaSxtg3wVpDrf5sVhVbV+pCfj4YURRnr93WvROlwCNJ1iOwBrDEA6E8AXsImiP7rjkvE8kXEUd4iJyJx4ksO2YpE8krraaXcKbA0PK/+azIVbn5nLt/5IZpzsIRGW5vcFUdiX93+m9pjbv0clIkxJHd7rfVCirl0ce+DiWncIbDZadQR36xu/J3KkR4vHNODZW3fXXM+BUfMcRAqynqbHpmlPO8XLC0Lp0GqaoxU5wa/tlg3NVvqtFKT7EyxpuExC5IHNT9kkdU6TNTQHO/3Er0/MiV9FCDjJJahBPnLghDgWW4sCye4QSnV2ZTDsSBijyVDcc70gniL6xpiFOI+/+s0ycIWUXdIOsGTRq5p+M82fARGCLPfTXIag5vtxaXnrOK/LhGP8YoL8ogMLQCbctGLSsPtgOqnhMu1hoH3xu+V24P5zqA5pyHhgkV5RqB90A57/lh6smu7baEAbIzZVXp9Hxc6xH80KjA/N2RAk9AfSdO+g

On Thu, 2026-11-12 at 12:30 +0100, Jan Kiszka wrote:
> On 12.11.26 12:25, Florian Bezdeka wrote:
> > On Thu, 2026-11-12 at 12:16 +0100, Jan Kiszka wrote:
> > > On 12.11.26 12:05, Florian Bezdeka wrote:
> > > > On Thu, 2026-11-12 at 11:31 +0100, Philippe Gerum wrote:
> > > > > Jan Kiszka <jan.kiszka@siemens.com> writes:
> > > > >=20
> > > > > >=20
> > > > > > I will share the lengthy test case as well once I'm done with s=
tripping
> > > > > > it down further (if possible). What the tests already demonstra=
ted is
> > > > > > that unpatched kernels crash.
> > > > > >=20
> > > > > > These patches here are almost completely generated. One of my f=
ew
> > > > > > contributions was to encode _TLF_OOBTRAP into oob_trap_regs. Th=
e idea
> > > > > > of having oob_trap_regs as a nesting detector came from the AI,=
 though.
> > > > > >=20
> > > > > > As usual, AI is still rather verbose in descriptions and commen=
ts. Some
> > > > > > of them I already shortened, but most is still left. We can cut=
 down
> > > > > > further, but I would first of all like to have another review r=
ound.
> > > > > >=20
> > > > > > While doing that, keep in mind that AI tends to ignore issues l=
eft and
> > > > > > right when being told to do a specific task. It may have simply=
 missed
> > > > > > further preexisting issues or even created new ones now. Watch =
out!
> > > > > >=20
> > > > >=20
> > > > > It looks like patches 1-3 have landed into v6.18.Y already, which=
 means
> > > > > that you are confident with those changes eventually.
> > > > >=20
> > > >=20
> > > > Those patches should not go anywhere until they reached the latest
> > > > development branch. The common "upstream first" rule.
> > > >=20
> > > > Everything else will add a lot of confusion.
> > >=20
> > > The v6.18 application was experimental, to validate that the test sui=
te
> > > passes on real hardware when all issues are addressed. Nothing is
> > > official in rebase branches until it is tagged, including those patch=
es.
> > >=20
> > > Jan
> > >=20
> >=20
> > Why not just push out a wip/ prefixed branch? That does not require to
> > temporary update branches looked at by different / more people.
>=20
> CI is not picking up such branches.
>=20

Which is OK. Those branches should be tested only when requested
manually. The "internal" infrastructure has such a feature, while the
public one is missing that.

Upstreaming was not considered yet as it highly reworked the xenomai-
images project. But maybe it's of interest now.

