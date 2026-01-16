Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D3F32E698
	for <xenomai@lists.linux.dev>; Fri, 16 Jan 2026 12:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768565634; cv=none; b=Cx4rGdeNiF94mtgvsPOOtHZ1s0Gpl1x8qqqPkFmuuvMGHHv+8MM+fiaXY1zHF7nnTrOG97gqLlXmkwyVy/Prt5rJKWrX6AcfyCz+SIv16RxCeApilwumhm06GhzUi2jqa2hOIo6x3HgiiMgSiKjdQ/EUwz+MsB30OmMR6ZbuYKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768565634; c=relaxed/simple;
	bh=i5AMZ3qTJLSyiIbRB5SLn7Jq63nQYGgYVAGxr0wqU5E=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pzgkvhR4XDq2mdxdWDRaCOH9SsRHaSG/9erzUzGKNOmLV4urv7oj8iAleHlW4pIal6crbfFWmX87AQj6bWyDw6BBcW/wx27OI4iWByGq9x8PA1rca/0+8x1nHU+7pUJq0AjWexJF85gmdW1r5BNhkPOs4M3+h58/53yGqgmJ8r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Bh4r4kDJ; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Bh4r4kDJ"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2026011612134156f978f94e00020798
        for <xenomai@lists.linux.dev>;
        Fri, 16 Jan 2026 13:13:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=i5AMZ3qTJLSyiIbRB5SLn7Jq63nQYGgYVAGxr0wqU5E=;
 b=Bh4r4kDJnx3w1+GWtfDHc7mX7bCxGeeEx1yLpkKZR2HG/yA/IgoIaRac45pBYjS+CwbA55
 x8AhXPCWdyqXBaKJUmbrOUJlNU6ADRSSQPToX1pblsxA1Go5/ritNSa4kZBKhSn+QpLUj9zV
 6/1vr8W1s9CuCgCvBNPcRiiuJjKBcOD6SuZrxFdM/LWSqTla20vyJqS4Za22KTO9z1NT7dXY
 8XgsDs2tW1w9glsItGVNiJYIHZpN4ELkZ2Hs9q1hWmo7AzaQOlpHAzUJm5Sec6odJPFgv2DH
 C5EbrLlbrIRUJXzPYI8fDJNncfZMC6JDGsYwKxChV7hWkLAu3Yw0hQ1g==;
Message-ID: <a1b1ce6908071182cdfe97e7995d9c6e1d51941f.camel@siemens.com>
Subject: Re: [xenomai-images][PATCH 2/2] ci: Add CI for linux-dovetail
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Clara Kowalsky
	 <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
Date: Fri, 16 Jan 2026 13:13:40 +0100
In-Reply-To: <0d89b51e-be92-4a21-9ed9-6260c3da0d54@siemens.com>
References: <20260109142001.2548128-1-clara.kowalsky@siemens.com>
	 <20260109142001.2548128-2-clara.kowalsky@siemens.com>
	 <8671583f7cf796643263dde1d4e6b8640b3821c9.camel@siemens.com>
	 <993b8ab6-6dd6-4a24-92e4-928fb03fd26c@siemens.com>
	 <b7273fbc764ebe2c5b40b2c1285a0ea56324caee.camel@siemens.com>
	 <6bb6c04c-bffb-4f9b-8ddd-0d713d180bba@siemens.com>
	 <0d89b51e-be92-4a21-9ed9-6260c3da0d54@siemens.com>
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

On Mon, 2026-01-12 at 17:01 +0100, Jan Kiszka wrote:
> Forgot to comment on the second part.
>=20
> On 12.01.26 16:51, Jan Kiszka wrote:
> > On 12.01.26 15:27, Florian Bezdeka wrote:
> > > On Fri, 2026-01-09 at 15:52 +0100, Jan Kiszka wrote:
> > > > On 09.01.26 15:42, Florian Bezdeka wrote:
> > > > >=20
> > > > > I'm also unsure if we should really move that logic into the xeno=
mai-
> > > > > images project. Seems a bit overloaded already. Maybe it's time f=
or a
> > > > > xenomai-ci project?
> > > > >=20
> > > >=20
> > > > xenomai-image is so far the project driving the main pipeline that =
also
> > > > does on-device testing. But there is also CI in xenomai3, e.g. A
> > > > separate "xenomai-ci" project would sound to me like all CI is hand=
led
> > > > there - would that be your vision?
> > >=20
> > > To me the purpose of xenomai-images could be split-ed into two parts:
> > >=20
> > > a) Build reference images. Images that get you to a working starting
> > > point within seconds.
> > >=20
> > > b) CI. Build all the kernel/arch/userland combinations that we need.
> > >=20
> > > The b) part is getting more and more complicated, which might confuse
> > > users - especially beginners. We have a lot of bitbake and gitlab-ci
> > > magic. At some point it might make sense to split those different
> > > purposes into different projects.=20
> > >=20
>=20
> I would agree - if changes to the CI infrastructure would make the usage
> of xenomai-images as, well, image generator more complicated. But I'm
> not yet seeing this, maybe you can point out some examples.
>=20
> At the same time, if we removed all CI from xenomai-images and xenomai,
> how would that make the (granted) complex CI setup simpler?
>=20

I'm not worried about the CI part. Covering all the combinations that we
have / support is complex. But: This complexity should be hidden for
beginners trying to build their first image.

Looking at the current recipes - fetching from different repos (folded
with all the history from ipipe), doing a lot of magic regarding PV and
preferred-versions: it's visible at the moment. We try to hide that with
"kas menu" but there are too many options already.

I agree, were not adding complexity right now, so it's "fine". Too late
anyhow, already merged.

At some point it might make sense to establish a "xenomai-examples"
project building exactly one version of xenomai (latest stable) with the
latest dovetail combination. Maybe even limited to virtual targets. Easy
to read recipes and a minimal and easy build process, so that bitbake
beginners can understand it.
