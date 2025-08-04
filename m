Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7C923AE62
	for <xenomai@lists.linux.dev>; Mon,  4 Aug 2025 22:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754346576; cv=none; b=K/Q5g/2VdS6q9wCX4cfyiLkzKFQHGDDm1lfQAwTKAMx4rwJ3jQoacLb7y+2pHvVHGEBr7IQS5SLkVF5Izzo3xHcY6FznNkN7G4PM3K0aD8F6okNKaU4BLlXh3fig7+VxTJyM+7NELhN39v5jvBYxS5kXADNgWXw9IpZr/dlsc2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754346576; c=relaxed/simple;
	bh=4HiKaH+WAvb//oplj8B1SwA1Atn9kstN3g5JqlT8FGQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fYKnBa4OQe2SToMQwVwnPraVwyim159oklxUdV4ibEuQ6AnD42ehRR5m/6T37svCmYRGY8gVV1movD0q/fkB+QP6AnjmQPKgJKwAPeDZTVphHVkO9FYr3Q0DfzlgJCBhrqIaukEgKliyscz5wqYmjOKpYA6BDWhge5ufAFH9ekc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=G4YbGG5R; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="G4YbGG5R"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 2025080421491103f0c3da27ac031dde
        for <xenomai@lists.linux.dev>;
        Mon, 04 Aug 2025 23:49:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=4HiKaH+WAvb//oplj8B1SwA1Atn9kstN3g5JqlT8FGQ=;
 b=G4YbGG5R4GDgK8j1W6wq7dHNplkxDA8Nf9GG2aC/OGzJaXmTdqLV04RQxkvsgWEcnLd8AT
 PdM93p/fqGBqjHWP4EsN+C0oYSsNjDLk5pz0IGhrA73y4O9x4+ioQq57tEFDGul7KFg3I26G
 Eb0yxl7lJCBMvYWwgod4LQTYcflMQo86gKDcK9Q9ojFTiHkOLAHWnjo+7WvASZLIxB0K4Ni5
 hcv7JXxRoGF/CQETMMHxhDretYrg7dw16O6rfmPKp0VB2SqFNO0nNTVK62bs47lId0tPobun
 d5oCMINDCPRaXMxRmOTsKbKPUKm/kHzrbBsv2U+Dd9a2Kj0+M8E07ZSQ==;
Message-ID: <4ae7cb56913eab99ce5aa350aa792e01c976e619.camel@siemens.com>
Subject: Re: Xenomai Meetup at OSS Amsterdam in August
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Markus Kurz <markus.kurz@sigmatek.at>, Steve Rosenbluth
 <stever8@gmail.com>,  Jan Kiszka <jan.kiszka@siemens.com>, Clara Kowalsky
 <clara.kowalsky@siemens.com>
Cc: Richard Weinberger <richard.weinberger@gmail.com>, Xenomai
	 <xenomai@lists.linux.dev>
Date: Mon, 04 Aug 2025 23:49:10 +0200
In-Reply-To: <15630110.O9o76ZdvQC@pop-os>
References: 
	<CAFLxGvy2U_0hfTKfPPZAui8XFBMAFqxLnjgCUcD2-Xw3=79UBA@mail.gmail.com>
	 <CAExw09CzR9UXe9y2a+YGtQ5Of-g2wP6hmNh4Y4HvyGgwHQ55TQ@mail.gmail.com>
	 <9d3a82e2-118e-4bb3-962b-9b11bb7ddb71@siemens.com>
	 <15630110.O9o76ZdvQC@pop-os>
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

On Sat, 2025-08-02 at 17:24 +0000, Markus Kurz wrote:
> On Friday, July 11, 2025 9:10:51 AM CEST Clara Kowalsky wrote:
> > On 10.07.25 21:29, Steve Rosenbluth wrote:
> > > On Wed, Jul 9, 2025 at 8:21=E2=80=AFAM Jan Kiszka <jan.kiszka@siemens=
.com> wrote:
> > > > On 09.07.25 16:55, Richard Weinberger wrote:
> > > > > Like last year, I expect that some members of the Xenomai communi=
ty
> > > > > will be attending
> > > > > the upcoming Open Source Summit in Amsterdam. If there's enough
> > > > > interest,
> > > > > we could arrange an in-person community meeting at a local beer
> > > > > garden?
> > > >=20
> > > > I will be around.
> > > >=20
> > > > Jan
> > > >=20
> > > > --
> > > > Siemens AG, Foundational Technologies
> > > > Linux Expert Center
> > >=20
> > > 'Wish I could be there.
> > >=20
> > > -Steve
> >=20
> > I'll be there too.
> > Clara
> Christian, Jimmy, and I will be joining as well.

It seems that I'll be around as well. See you there...


