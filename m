Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896A63D170C
	for <xenomai@lists.linux.dev>; Tue,  2 Jun 2026 09:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780393423; cv=none; b=gNCMkFu9B9+wh8TQiA43jE3Leez9PnRXqNirIjUKSefPfyS0Z3GFymMbgOHcy9xay7UAOVA/+wL2qMIDtp0rvlhvHJJPqLMvSvmaPlRtkgDXdFTc8Qr9QEdl+DsatI4uqmm0Ypk7Kf7g+yCiHt6aO1EExtEM2WdizB3VoS/VpdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780393423; c=relaxed/simple;
	bh=Wot0L9szDw0MPRYUwvi1UXx/+sNAAO1RBv3dKt/kVSo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jPKCatQkzYRurCz6X7nlWRXDWRl0sK546HQXJfSF00nMQEMAENGFm1rppftP74xoTunT9RKRf4uYx9q3YoZVtWmY88SNSYJvPKMMTlLm+9f1+jMu4T5Cc/k+UrUqDvKny2dg59bZ84VdA/EqvCHq6P21Yx9WBNiOOaqmGK2qGDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=gfW6es4J; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="gfW6es4J"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202606020943265e1cc1e6ab00020746
        for <xenomai@lists.linux.dev>;
        Tue, 02 Jun 2026 11:43:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=cnC5Y56RLb6XWsh73hbLYlJy4KD+u05glDy16yicbUY=;
 b=gfW6es4JuqI2h8fj9GjY+m89I+KLc4M2oDXQuvB1IouAE7crMaUdDVtNV0mOGEFHtbfAe0
 TvRqg8x5O14N6XUqv80u/uaotvSQ79zNhKf36x3HP9Xh8JEDF/43Kbe7NCad6LQtVbQ9kxXM
 C60tdGMa3n1JGRj0HKLNQh6S96d/h/6NS0vgm31h2lKb+CfI75EWajwb+gojTuncaqoucdDK
 pjoavq/PKbnN5sCDWuCbRvnfaIwJ7VNLjB4Cvc8ny7fbYER7+tUZo5/M+zRnAf7qpZw2N6P+
 lqF9qA1l1pRqVOFjtPhcUVt9D0ONeI7iHVFRDh7AaLikLpKUrA4WUcDg==;
Message-ID: <eae9c7c7ecfebf7503f52051e8a444a4cec90888.camel@siemens.com>
Subject: Re: Dovetail 7.1-rc6 updates pushed
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev, Tobias Schaffner
 <tobias.schaffner@siemens.com>,  Jan Kiszka <jan.kiszka@siemens.com>
Date: Tue, 02 Jun 2026 11:43:26 +0200
In-Reply-To: <87se763yji.fsf@xenomai.org>
References: <aea902f9f55316c2c357b9fadbbd8e9b716e92ff.camel@siemens.com>
		<87y0gy4brj.fsf@xenomai.org>
		<27c28604c6d3abca8b31ddf182bdf6d52ad4d572.camel@siemens.com>
	 <87se763yji.fsf@xenomai.org>
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

On Mon, 2026-06-01 at 20:28 +0200, Philippe Gerum wrote:
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>=20
> > On Mon, 2026-06-01 at 15:43 +0200, Philippe Gerum wrote:
> > > Florian Bezdeka <florian.bezdeka@siemens.com> writes:
> > >=20
> > > > Hi all,
> > > >=20
> > > > I just pushed the following branch updates for Dovetail based on 7.=
1-
> > > > rc6:
> > > >=20
> > > > Dovetail:
> > > > wip/flo/v7.1-dovetail-rebase
> > > > wip/flo/v7.1-dovetail-rebase+riscv
> > > >=20
> > > > Evl:
> > > > wip/flo/v7.1-evl-rebase
> > > > wip/flo/v7.1-evl-rebase+riscv
> > > >=20
> > > > The +riscv branches are containing v8 of Tobias' riscv enabling ser=
ies,
> > > > maybe we need v9, let's see.
> > > >=20
> > > > Any additional testing on those branches is highly appreciated.
> > > >=20
> > > > @Philippe:
> > > > I'm still waiting for some feedback for [1]. That seems now to be a
> > > > invalid combination of kconfigs, which is dovetail specific. Upstre=
am
> > > > thread at [2].
> > > >=20
> > > > Can you remember why KVM_INTEL is not selecting X86_FRED in case
> > > > IRQ_PIPELINE is enabled? I haven't checked the details yet, nor tri=
ed to
> > > > remove the dovetail specific adjustment.
> > > >=20
> > >=20
> > > Maybe because the pipeline never supported X86_FRED, doing so would
> > > required to rework the irq-entry trampoline macros, which is deemed
> > > painful work.
> >=20
> > I sent out a RFC patch for that, input welcome.
> >=20
> > Meanwhile I can provide some updates on the testing part. The following
> > problems seem to be reproducible on 7.1-rc5 and 7.1-rc6 - while 7.1-rc4
> > was fine (at least once):
> >=20
> > x86   x3: Test timeout. Something seems slower than expected.
> > arm64 x4: Same problem
> >=20
> > To rule out problems in our CI setup I spawned some 7.0 tests, which
> > were fine, at least twice in a row. Seems someone has to look into that=
.
> > As I'm running out of time: Any resources available?
> >=20
>=20
> Not here, at least not yet.

I scheduled a couple of overnight test runs on -rc4. Those test are
looking OK. Something in -rc5 seems to trigger that. The problem seems
qemu/kvm specific, test runs on real hardware were OK.

I found a couple of recent discussions around VMX/SVM regressions, some
of them related to the delayed hrtimer arming. As we disable the delayed
arming completely, that should not be our problem. Maybe we should just
wait for -rc7?
