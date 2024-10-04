Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7DB1DAC8D
	for <xenomai@lists.linux.dev>; Fri,  4 Oct 2024 17:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728063464; cv=none; b=oof6tEwU6R5Mk4kre0q9eNqnDE5xAfZnKgPFVSGlFrLXtDqg+J98hkOGR3ajT8Kewf0bc8ZaLjhHGqtK+r1d+BxaI8oBjELBS0nHC1H1PcRcuI4tjPHIKAF1PiOBPfmbfjkJRE+/pSkrxQH6p6MedQC2jdo2DhvNjWwdssjeK1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728063464; c=relaxed/simple;
	bh=H92Y0ubtmsPRdVltR50kepxdR1Od97aQ0q/fVMkWCls=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cZpQFRnOG5mDxJTxhvDBziJsYeJe79d9SY1vlXIrpq/rzfxdcehiKotKFvJJzbvtb6oGKvUk8QiMoiHSv84VfEVOasngHTgJYhgFyTWTog9I6Q/az4vq6qz8yyZ8VPLDgjkEWxbVtfv1dznVYGuox50XSk2OL4PFVtF3aK+ej9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=IbaSwZJl; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="IbaSwZJl"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20241004173728e9ef913a7da5f33df9
        for <xenomai@lists.linux.dev>;
        Fri, 04 Oct 2024 19:37:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=I2Foh0UyJc5z+dpZvcFi6iiLsSJczqsCiyVniecdpbw=;
 b=IbaSwZJl+s3iWVRUH7UKh64pzskVG2ogsucWHRRGoZYho3UZLaaPcUECEAmn/7manTFSAI
 m5q7tlHqt+8mlR7B0oJXsig6UWRWj2tQMiGi5VlZb6ubtsdnWUurvNxIs8pb63QjzDilgikS
 VXtSc6pZLLfYxrnVm8Ij5YW8IKKtN3KAWehaaEsH4fa8J1N868g0Wn1mPKfXUqtXtQut8Bct
 Df0EVpUyE9U5m7g1x0xKrUVWzT3TFQ7qE8XiSsMumWUfBRHawsLmgWIgr99lGALwaswaaZRp
 bPskDvDEceE1CLYGNZXtdzTt3CylL+iG7qcbdzsN0/s4F+oWloVgWi5Q==;
Message-ID: <f676b8a184912f87d6ee175e171b351fb210f93c.camel@siemens.com>
Subject: Re: POSIX API for EVL
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Pierre FICHEUX <pierre.ficheux@smile.fr>, xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
Date: Fri, 04 Oct 2024 19:37:27 +0200
In-Reply-To: <CAFc1U0udyU8FJMB_Vmz7zg1kB0M=9SC=Q1m+-E6hekcsYcRHXQ@mail.gmail.com>
References: 
	<CAFc1U0vYfF_aj5a0zz7GwpjZATgB9td4Usc6JivATCe6tmoSLQ@mail.gmail.com>
	 <CAFc1U0udyU8FJMB_Vmz7zg1kB0M=9SC=Q1m+-E6hekcsYcRHXQ@mail.gmail.com>
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

Hi Pierre,

On Fri, 2024-09-20 at 09:41 +0200, Pierre FICHEUX wrote:
> Maybe we could talk about it during the next Xenomai community call ?

Everyone is invited to attend to the next community call and ask
questions or bring up topics that should be discussed. So yes, that
would be an option.

Up to now most attendees in the community call have/had Xenomai 3
background. As Xenomai 4 is mainly driven by Philippe, we might have to
ask him if he could join as well. Now in CC.

According to my calendar the next call is scheduled for Wednesday, 16th
of October, 9:00 AM in the central European timezone. Dail-in
instructions can be found on the list and are normally re-shared a
couple of minutes before the event.

Btw: The "new" Xenomai mailing list is at xenomai@lists.linux.dev.

HTH,
Florian

>=20
>=20
> Le ven. 20 sept. 2024 =C3=A0 07:57, Pierre FICHEUX
> <pierre.ficheux@smile.fr> a =C3=A9crit :
> >=20
> > Hi all,
> >=20
> > I've read some discussions (may 2024) about the lack of POSIX skin in
> > EVL.  Supporting several skins just like for Xenomai 3 is not
> > really useful but POSIX is an industrial standard and so for people
> > willing to use Xenomai instead of PREEMPT_RT.
> >=20
> > In the EVL documentation
> > (https://evlproject.org/core/user-api/thread/) I can read :
> >=20
> > The main kernel=E2=80=99s thread is the basic execution unit in EVL.
> > The most common kind of EVL threads is a regular POSIX thread started
> > by pthread_create(3) which has attached itself to the EVL core by a
> > call to evl_attach_self().
> >=20
> > Don't you think a kind of POSIX "wrapper" could be useful or is that a
> > silly question ? Did I miss anything ?
> >=20
> > I'm about to start a study for a big industrial company and the lack
> > of POSIX support is a real issue.
> >=20
> > Regards
> >=20
> > --
> >=20
> > Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
> >                              http://www.smile.fr
> >                              https://smile.eu/fr/offres/embarque-iot
> > I would love to change the world, but they won't give me the source cod=
e
>=20
>=20
>=20
> --
>=20
> Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
>                              http://www.smile.fr
>                              https://smile.eu/fr/offres/embarque-iot
> I would love to change the world, but they won't give me the source code
>=20

