Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963001F8F09
	for <xenomai@lists.linux.dev>; Fri, 21 Mar 2025 12:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742561516; cv=none; b=oytXQk1i/Hs87FmOwGt9PimbwLOq6gXeMianjyQ5dKEWe3y2QyV+o46I+K3CMgV6BIx1qrmxIfjR8Ezak5twtk/6hV79I5cUNwWQMnLxSCTPEvcYgculNuAAyZLKF0v3zH0SeFqLLzO1galh8qTPQg10czuWl0DqFGOD3LT5izQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742561516; c=relaxed/simple;
	bh=6dYox8FnOxfwNd/myQwpSU6PxHE1vLuQ+kV4QoUWq8w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Es5J3CyC90af06sUkd0vFLaBNGhXYHnzvOAT97R28a5Gdu5f3++9KUQP+/f9FuAQRziJgfPLuMsDYAWirWBNyLRFYakwo+pnliDt6amGxuFUTjY+9xfWn5H2iGX1c5IEzNFFuhdyeCFVrm05ewX+j1P8peqxk3hpBqoXpVjDNmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=HLPBoDqh; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="HLPBoDqh"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20250321125140acdaf80fce5eae9149
        for <xenomai@lists.linux.dev>;
        Fri, 21 Mar 2025 13:51:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=boLeVXUWS9AtH6Fczmy8H7Z0hw2OIPQCzU6MnOzfSp0=;
 b=HLPBoDqh3gG1XN3oLnMMRRKCPUzTBa20s9eVquOFFPGOnssqE5hRR3DHFVvH9NNYNEEaIY
 ATNr7wF1L7sTbtZsIuD/tyw3Q3D2HcctK3C5SZ8bzUxTTkg/MTocEoy8KPFyLhI9WPyHvGSG
 mOWhIXHortqnPO+J+mepiCDAIugrsgwDd58E2SRcr5amOjZgroiOtxM4K/TQScUmlUF8G7CL
 8KAqnhgXULouXW0PuLPZQvL/gu0lL+hn129t36M0yJSfZDTuLSe51cixyoBEGYuHOy4jTfxE
 +lhbjF75uBPtdTDGGbfwK4mTQ5QR3DImUxAcK8EWY58mLBpI/t37ww8g==;
Message-ID: <1b298aee5042ea0948591be9e5922f204fcc22b6.camel@siemens.com>
Subject: Re: [PATCH] dovetail: Fix interrupt re-enabling after hibernation
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Date: Fri, 21 Mar 2025 13:51:39 +0100
In-Reply-To: <87r02qlt34.fsf@xenomai.org>
References: <68cf84b9-57bc-4a6c-9546-101a13c7acc4@siemens.com>
	 <87r02qlt34.fsf@xenomai.org>
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

On Fri, 2025-03-21 at 08:51 +0100, Philippe Gerum wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
>=20
> > From: Jan Kiszka <jan.kiszka@siemens.com>
> >=20
> > We had unbalanced hard_cond_local_irq_disable here so far.
> >=20
> > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > ---
> >=20
> > Minus one hunk that is already in current 6.12.y, this needs to be=20
> > applied to older stable versions as well.
> >=20
> >  kernel/power/hibernate.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> > index 733b1a196f09e..e1c05f276a453 100644
> > --- a/kernel/power/hibernate.c
> > +++ b/kernel/power/hibernate.c
> > @@ -352,6 +352,7 @@ static int create_image(int platform_mode)
> >  	syscore_resume();
> > =20
> >   Enable_irqs:
> > +	hard_cond_local_irq_enable();
> >  	system_state =3D SYSTEM_RUNNING;
> >  	local_irq_enable();
> > =20
> > @@ -522,6 +523,7 @@ static int resume_target_kernel(bool platform_mode)
> >  	syscore_resume();
> > =20
> >   Enable_irqs:
> > +	hard_cond_local_irq_enable();
> >  	system_state =3D SYSTEM_RUNNING;
> >  	local_irq_enable();
> > =20
> > @@ -628,6 +630,7 @@ int hibernation_platform_enter(void)
> >   Power_up:
> >  	syscore_resume();
> >   Enable_irqs:
> > +	hard_cond_local_irq_enable();
> >  	system_state =3D SYSTEM_RUNNING;
> >  	local_irq_enable();
>=20
> Merged into v6.12 and backported to v6.1.y-cip, thanks.

Sorry, but I have to highlight that this patch does not help at all.
Testing shows that we already "hang" when trying to hibernate. We never
make it into the "wakeup" path.

I think the "process" we followed here is broken. First we have to
implement and *TEST* things in latest development branches and once we
are sure we fully addressed the problem back porting can happen.

Florian

>=20
> --=20
> Philippe.

