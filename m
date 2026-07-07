Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4C625A2DD
	for <xenomai@lists.linux.dev>; Tue,  7 Jul 2026 22:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783461617; cv=none; b=Ui7Bgk05Si6V/rnP7LbMRmOoxWPyr1L9uE8v2sESiUgtZ07+CZGl50OduTig+iZhZSRL9Jmts+YaCOpFrVDzBuE/ZuPzdIJtCKraSQ5EqxHQLcV1522HDWQAMz0lWjb252oq4gPVwIcQA3vV2fqDXRAKckr3c7dIxWp8mnA+6HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783461617; c=relaxed/simple;
	bh=/H0Wvd1vBhISW7Ds06vBpDmMtP1MBZQCFIy4rwisEj0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B7Sh0vgKPqVWfhi1uMNM/TGsC89uZePaJpuU6mSYfC0r76dokjTF3Yebk8F3Rsr0T4j7F+OJbSSyWqJZS8BYGneHQ7QS38nmJm/p3S5Fb7l2VhZybwxDUM+Ba1k/Hc4FlTJbVe3qEI2vy71qCB2nbIZzKgjkoVQKZE2Cgqylv9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=eCAL5W5I; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="eCAL5W5I"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20260707220010d9460a9bb40002072c
        for <xenomai@lists.linux.dev>;
        Wed, 08 Jul 2026 00:00:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=/H0Wvd1vBhISW7Ds06vBpDmMtP1MBZQCFIy4rwisEj0=;
 b=eCAL5W5IBuujlxLdGFhPCUaVsGZWqDMFfrHaOaOh15kgNXtnYL8uSbmd5pRGjj9XYmIjlZ
 zYShRc0TEqJ/Xehb7t8CQfMcnq6xjplxp1sIi1ixfkwb/ISRMHkk5ZkRCvGSlYWPoyOfD/vC
 3CBu8gB9m8wsUgpkbgIwK2zppa5GHEAHrNLQ2zZ48TH9nrww3XXxWgl1XY5+Z2uTFPYGzEro
 4NKDfZkNxl5oUwQQkoykK6TvtaCHFnLeZgy2KR3JcE9Rcln/Ckco/JYzi+kgd9tXoqzSU/s7
 xDS2NLKWsYGajvMlZtqNPjKLn+u4sOhPX8FVuHOeWxGHPBR/SA41cqWg==;
Message-ID: <c0d059dc953b483e3d855fd13fda231548a4bcf4.camel@siemens.com>
Subject: Re: Dovetail/Evl confusion on my end
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Tobias Schaffner
	 <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Date: Wed, 08 Jul 2026 00:00:09 +0200
In-Reply-To: <87y0fmu9l1.fsf@xenomai.org>
References: <a4322e374ac79703bf12de3512510af2773a26d5.camel@siemens.com>
		<87o6givqdi.fsf@xenomai.org> <877bn6vpu0.fsf@xenomai.org>
	 <87y0fmu9l1.fsf@xenomai.org>
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

On Tue, 2026-07-07 at 17:02 +0200, Philippe Gerum wrote:
> Philippe Gerum <rpm@xenomai.org> writes:
>=20
> > Philippe Gerum <rpm@xenomai.org> writes:
> >=20
> > > Florian Bezdeka <florian.bezdeka@siemens.com> writes:
> > >=20
> > > > Hi Philippe,
> > > >=20
> > > > I just recognized that you updated the source of my rebase branches
> > > > meanwhile, so v7.0-dovetail-rebase (for dovetail) and next/v7.0-evl=
-
> > > > rebase for evl.
> > > >=20
> > > > While syncing the missing pieces I noticed that commit=C2=A0
> > > > ad7e492ff2 ("/dev/{null, zero}: dovetail: drop deprecated .write ha=
ndler ")=20
> > > > is part of v7.0-evl-rebase but is not part of v7.0-dovetail-rebase.
> > > >=20
> > > > Why is that? Any specific reason?
> > > >=20
> > >=20
> > > I pushed this patch yesterday, and wanted to have some hindsight abou=
t
> > > it for a couple of (testing) days of the evl tree. I believe it is
> > > correct, but given the patched area, better safe than sorry. I plan t=
o
> > > merge it last on top of 7.0-dovetail.
> >=20
> > To elaborate a bit more, this patch only helps evl strictly speaking, b=
y
> > preventing stdout/err redirections through proxies to cause a kernel
> > warning, which in fact reveals that some portion of the upstream code
> > (namely the /null and /zero cdevs at least) are still using a deprecate=
d
> > file_operations handler, which the VFS complains about when using the
> > kernel interface to write to them.
>=20
> The feedback I received from internal users regarding this is
> positive, no regression.

Ok. I applied it to wip/flo/v7.1-dovetail-rebase now and rebased
wip/flo/v7.1-evl-rebase accordingly.

For full risc-v support [1] has to be applied to evl. I will comment on
that series later. Seems to have style issues. To be able to test
already wip/flo/v7.1-evl-rebase+riscv has been pushed.

Waiting for over-night test results.

[1] https://lore.kernel.org/xenomai/20251010101130.3758633-1-tobias.schaffn=
er@siemens.com/
