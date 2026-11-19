Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.64.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795107168;
	b=QFcYnvt+inYuDySDyy8sY47Ma0ePB8+W5N3kiQOzHMSS+vK5Jq1XReEPrMLrof2Knqmr
	 vE8XUdVhZS2bQ91iGiQlD90RYWoeHgncBcmT7ZpG8uZjztrIHvOa+GKNJOqOEt7r7iiT2
	 c3pgy249JIz+9m0h2Y0pa6XgEWMWlkkNVbEYI6jwQ6bhg8O3aP+BZTaL6ZOWV1Cvl94tL
	 N0Rn/TJGfLNzQxaAIspyyk5LNDI5q3Eej06TsFqV5HdzitPMsehYMHEBKWKjTuJ9lVyzy
	 qh7nf9woNE2Q+sJDQhbXgvhxnfiLwSq0xBEMSyY7zWK86mZ2/iZAw07/4dScW4YDvXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795107168;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:X-Flowmailer-Platform:Feedback-ID;
	bh=67jn/S1L4m5x2IZ7scZ1CUAVswfZ6IkHIjTwylSDKnw=;
	b=haKpvIxEZoP68muiMDPQ6Eb3wkMUzZ2RSiyz2Sa8bgb93pF5tE2Nz/PdHQnwL2snn9wJ
	 MUFBuwLy42zLlh6iFSRWwIpR8J51ghm8KdS5B1B5VHiqZSFiR3mJrQIBYzkSCoSULhK7g
	 2Efc3pd5B8tQOlNhqegRtM4Rq91rFo8mBJ8HsNOPk6bsrXijBEArOZ/YiCNXRMaTY7uxm
	 hxPfoEE+ZG2mpGlCFml03DxuqJecCnUqRp/nNntVP4QeVHD8iD/uhQFEnsg2YeV7EaFgu
	 QbNOlVF6kShDhlrDm98IM/6BCBQupSsIlMR2of5vgspbP287mNTxL/nmHl0RgZ9rubw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=OTbINYRu;
	arc=none smtp.remote-ip=185.136.64.227
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA0C60A2613
	for <xenomai@lists.linux.dev>; Thu, 19 Nov 2026 16:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AA0C60A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=OTbINYRu
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20261119165244c8580f03e10002074f
        for <xenomai@lists.linux.dev>;
        Thu, 19 Nov 2026 17:52:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=67jn/S1L4m5x2IZ7scZ1CUAVswfZ6IkHIjTwylSDKnw=;
 b=OTbINYRuvD4lO+2Pwc8z4JJxO8MZnLaf+VcoD32QSgdSXiBAyK4ijSiKwkPTge+l4q8hhk
 dFSGzzsy7zEO+SQ405zqtpMmxzyBZ+bHuljWjkjFJagc8HbCABwzrJtNEncxb3GeWFXFR/Oc
 MvXQ2bxpde751nA9FKzqoaQyXWjZzlWqu+I5AyCeSnSVqwGioUEIWy57e00Jffch9rA11Z3+
 TOnIwn0nxLL7ypBeRsasvIz5q5VDCA+QW7JawQHmDPLH4bjLeOz8v6tLaM7avR+AkgmiG4sp
 fE0BE8ITpPW0CW6wadUVHHFbKeYenXhUHMWPrpwotP8KLKrU0Ftoe7aA==;
Message-ID: <ab1bc8a70479d318ce72872f6b36cb7a41ba3631.camel@siemens.com>
Subject: Re: [dovetail][PATCH] x86: dovetail: preserve in-band stall state
 across handle_bug()
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
Date: Thu, 19 Nov 2026 17:52:44 +0100
In-Reply-To: <340dcf92-40dd-4f00-9473-434e58e9dc34@siemens.com>
References: <edda3386-02fc-4d36-9e87-ce3f2c4f1916@siemens.com>
	 <87qzghnf5x.fsf@xenomai.org>
	 <e06d42af87e95d790ebb9b41f361385f3f1a0251.camel@siemens.com>
	 <340dcf92-40dd-4f00-9473-434e58e9dc34@siemens.com>
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

On Thu, 2026-11-19 at 17:48 +0100, Jan Kiszka wrote:
> On 19.11.26 16:58, Florian Bezdeka wrote:
> > On Thu, 2026-11-19 at 14:07 +0100, Philippe Gerum wrote:
> > > Jan Kiszka <jan.kiszka@siemens.com> writes:
> > >=20
> > > > From: Jan Kiszka <jan.kiszka@siemens.com>
> > > >=20
> > > > handle_bug() runs from the raw #UD entry, before irqentry_enter(), =
and
> > > > returns straight to the exception site when a WARN() was handled. T=
he
> > > > trap only cleared the hardware interrupt flag, the in-band stall bi=
t
> > > > still reflects the state of the exception site.
> > > >=20
> > > > When the site ran with hard irqs on, handle_bug() used
> > > > local_irq_enable_full() and local_irq_disable_full() for the in-ban=
d
> > > > stage, which also unstall then stall the in-band stage. As a result=
:
> > > >=20
> > > > - a WARN() hit with in-band interrupts enabled returned with the
> > > >   in-band stage stalled, leaking a virtually disabled interrupt sta=
te
> > > >   into the interrupted code, until the next in-band irq enable.
> > > > - a WARN() hit with in-band interrupts disabled (e.g. under
> > > >   spin_lock_irqsave()) unstalled the in-band stage while reporting.
> > > >=20
> > > > Only restore the hard interrupt state, like upstream does with the
> > > > (then non-virtualized) interrupt flag, on both stages.
> > > >=20
> > > > Assisted-by: opencode:Opus-5.5
> > > > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >=20
> > To simplify the next forward port and the usual history cleanup:
> >=20
> > Could you please add / provide the Fixes: tags for all the patches
> > recently merged? Thanks!
> >=20
>=20
> Those are not overly important, specifically over time as rebasing are
> invalidating their commit IDs. AI is also good in identifying missed
> backports (found several for 6.18 or 6.12).

Please add them. It helps. IDs normally stay stable - at least for non
LTS releases.

Please, don't make AI required.

>=20
> Jan
>=20
> --=20
> Siemens AG, Foundational Technologies
> Linux Expert Center
