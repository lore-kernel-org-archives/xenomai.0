Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578014204E
	for <xenomai@lists.linux.dev>; Mon,  1 Jun 2026 18:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780337596; cv=none; b=fswvGqf38EzanctxXj95h7N6J+R2PcHeNY/1iBMRAZKCVfMIaHa+bSSkLW25y6xRIFHMhP8Rn0UqHIq++nqFVgJehN84VDceIENisxiZM+FBtG0oaeAdaSOMNinyXsd+GMRBhsuZ4t7vKy4AYGHKGjLFN5Ep6Y5upGlkyTV7uoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780337596; c=relaxed/simple;
	bh=hDBVdSijmDAroLQv4UkKP6smOmIaChZWUji1N3cT8BM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RXcVPf0a06HtJ3fVtLVlazt44tFMLXOjqUkS45aY3R+rgElb/BENrMV3GYj/rnt50OqOFk5682geOH2TD5I2jufk0NlhGyg7yoD/WljjSurxq0IUiCRfOgs6DVvX6qHnQyxkexqfGVW3DIVi4YhdQ/c3XOQIDUycJyFRKC0V1BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=k8sSNsvz; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="k8sSNsvz"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202606011813044d3f601a060002079e
        for <xenomai@lists.linux.dev>;
        Mon, 01 Jun 2026 20:13:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=2VTB3ZCUDaNFtNGid6MSV7X3bTqYWCfkHw97TVMPhDc=;
 b=k8sSNsvz9KZRKYxU6OTWI2QB8kjpPftnzab84po3eszJxeIAam/bDry+NzjJ96ZvxtG820
 9zz+mJeETrTaymJLbet0vLasHJbS45vpJaxE68hDnf6IXkDp6kBQApIsrHw4RyEfbWWhKwhp
 bcjGApzmXFUDu73NgAqe1edvYis/dDufMnX8zQiv5JIkHyotaQncF1LcLNtduuhOqIRDAc4L
 A73ykW6w23esn0+1prN5aNv/zxdFoq2+9spT4Mv2ySTdMupagnmmoT0csdxOLTj323O3wE76
 8C0JBKRSLBItj0GEmJJzqJSq3grGZ5uCinzJbQaq3Ey0savuYQRcmKdw==;
Message-ID: <27c28604c6d3abca8b31ddf182bdf6d52ad4d572.camel@siemens.com>
Subject: Re: Dovetail 7.1-rc6 updates pushed
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev, Tobias Schaffner
 <tobias.schaffner@siemens.com>,  Jan Kiszka <jan.kiszka@siemens.com>
Date: Mon, 01 Jun 2026 20:13:03 +0200
In-Reply-To: <87y0gy4brj.fsf@xenomai.org>
References: <aea902f9f55316c2c357b9fadbbd8e9b716e92ff.camel@siemens.com>
	 <87y0gy4brj.fsf@xenomai.org>
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

On Mon, 2026-06-01 at 15:43 +0200, Philippe Gerum wrote:
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>=20
> > Hi all,
> >=20
> > I just pushed the following branch updates for Dovetail based on 7.1-
> > rc6:
> >=20
> > Dovetail:
> > wip/flo/v7.1-dovetail-rebase
> > wip/flo/v7.1-dovetail-rebase+riscv
> >=20
> > Evl:
> > wip/flo/v7.1-evl-rebase
> > wip/flo/v7.1-evl-rebase+riscv
> >=20
> > The +riscv branches are containing v8 of Tobias' riscv enabling series,
> > maybe we need v9, let's see.
> >=20
> > Any additional testing on those branches is highly appreciated.
> >=20
> > @Philippe:
> > I'm still waiting for some feedback for [1]. That seems now to be a
> > invalid combination of kconfigs, which is dovetail specific. Upstream
> > thread at [2].
> >=20
> > Can you remember why KVM_INTEL is not selecting X86_FRED in case
> > IRQ_PIPELINE is enabled? I haven't checked the details yet, nor tried t=
o
> > remove the dovetail specific adjustment.
> >=20
>=20
> Maybe because the pipeline never supported X86_FRED, doing so would
> required to rework the irq-entry trampoline macros, which is deemed
> painful work.

I sent out a RFC patch for that, input welcome.

Meanwhile I can provide some updates on the testing part. The following
problems seem to be reproducible on 7.1-rc5 and 7.1-rc6 - while 7.1-rc4
was fine (at least once):

x86   x3: Test timeout. Something seems slower than expected.
arm64 x4: Same problem

To rule out problems in our CI setup I spawned some 7.0 tests, which
were fine, at least twice in a row. Seems someone has to look into that.
As I'm running out of time: Any resources available?

Best regards,
Florian
