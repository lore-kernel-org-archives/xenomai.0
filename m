Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CDD1A714
	for <xenomai@lists.linux.dev>; Tue, 31 Oct 2023 11:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="LPJ1J6Fo"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202310311127426f4487bd55e48dd843
        for <xenomai@lists.linux.dev>;
        Tue, 31 Oct 2023 12:27:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=klOC9NTQe0MJAytmMlwOjXKL00Co+OAPHrvRL5JnVzA=;
 b=LPJ1J6Fo81adauFOwzfQ91nla0Wsz4F5Nrvu3rfBxwidQIOvQ4byn9iciwLzlLuiV5o+3d
 f8rIa1DQOLhUoWrnNWledmSWFGlOuCGsoIRBnn+0DzpnjGIsZwspm7v2C676mJSNB2SJt9qW
 1uuMIGQ4FT1EIj1KBb64sRW1AbjDk=;
Message-ID: <dd9a43fbe4d7099c6017f9383550980bfa44a39b.camel@siemens.com>
Subject: Re: [PATCH v3][Dovetail 6.6] arm64: dovetail: Fix undefinstr/break
 trap handling
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
Date: Tue, 31 Oct 2023 12:27:41 +0100
In-Reply-To: <87h6m7ghm1.fsf@xenomai.org>
References: <20231024093242.1077831-1-clara.kowalsky@siemens.com>
	 <87lebjgi5x.fsf@xenomai.org>
	 <bfc296acb34deccc3615edc828779592c68346c7.camel@siemens.com>
	 <87h6m7ghm1.fsf@xenomai.org>
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

On Tue, 2023-10-31 at 12:23 +0100, Philippe Gerum wrote:
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>=20
> > On Tue, 2023-10-31 at 11:46 +0100, Philippe Gerum wrote:
> > > Ack. I initially thought we could postpone the in-band switch until
> > > after some of the emulation code paths have been considered (typicall=
y
> > > the MRS stuff), but that would involve convoluted logic for no obviou=
s
> > > gain, so let's take the straightforward approach instead. The assumpt=
ion
> > > here is that issuing an (emulated) MRS read request from a userland
> > > application should not happen from a time-critical context anyway, so
> > > doing this in-band should be acceptable. We'll see from complains if =
its
> > > not..
> > >=20
> > > IOW, patch merged to v6.6, thanks.
> >=20
> > Nice! Thanks!
> >=20
> > >=20
> > > PS: There are three Dovetail branches to maintain concurrently ATM,
> > > twice that number when including the EVL trees. So please always ment=
ion
> > > the kernel release any patch sent my way applies to, this may help
> > > speeding up the process on my end (e.g. this patch conflicts, needs
> > > manual backport to v5.10, v6.1.y).
> >=20
> > We had [Dovetail 6.6] in the subject. I thought that should be
> > sufficient. Seems it's not. How should we make that clear?
>=20
> No, that's perfect. PEBKAC detected locally.

Happens to the best ;-)

Let us know if we can help backporting. Clara might have a look
especially at 6.1 - our preferred target right now.

>=20
> --=20
> Philippe.

