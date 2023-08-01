Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281B51DDFF
	for <xenomai@lists.linux.dev>; Tue,  1 Aug 2023 11:27:45 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20230801112743e5d09dc5ca599527c9
        for <xenomai@lists.linux.dev>;
        Tue, 01 Aug 2023 13:27:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Ez0wA93dG+p8txBnZWvJznBd/3e5ZGY/9KU+BXB+vLo=;
 b=eBzVyWxPuj+tpYSRixkjE1Z4lsdS2EdmzdTHyra51HYO2smjMtHcYNut5EYKSk/J6tRBZa
 V8H/IxBEIvk1DPMlkoEfDVij3d6AsRgnz1f38fWYFK9vsC812zVZs5Hhw4s0f0ZWF7e7rQhU
 uo065DioiRtt3LJ60QCuRm0tsyD94=;
Message-ID: <beff2aa61a6b00af08baa7374feff1a0ddf6dd93.camel@siemens.com>
Subject: Re: v6.1.y-dovetail-rebase
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Date: Tue, 01 Aug 2023 13:27:42 +0200
In-Reply-To: <a35a96771c0f059370357b9a37c9ab1871e621b0.camel@siemens.com>
References: <a022bab1-7fbb-3b71-3eb3-e16791f3c2be@siemens.com>
	 <87edlkeu1b.fsf@xenomai.org>
	 <a35a96771c0f059370357b9a37c9ab1871e621b0.camel@siemens.com>
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

On Mon, 2023-07-10 at 08:59 +0200, Florian Bezdeka wrote:
> On Thu, 2023-07-06 at 21:00 +0200, Philippe Gerum wrote:
> > Hi,
> >=20
> > Jan Kiszka <jan.kiszka@siemens.com> writes:
> >=20
> > > Hi Philippe,
> > >=20
> > > quick feedback on latest rebasing:
> > >=20
> > > https://source.denx.de/Xenomai/linux-dovetail/-/commit/8f155631c8b517=
31dfc2ae5145d4dcc68f2ed7ed
> > >=20
> > > This was likely accidentally folded, right?
> > >=20
> >=20
> > It looks so. This conditional statement appeared upstream during the
> > v6.0 cycle it seems, and was unfortunately left unfixed in the dovetail
> > patch for this entire series.
> >=20
> > > Furthermore, I will factor this change out into a separate commit in=
=20
> > > merging v6.1.y-dovetail, for better traceability:
> > >=20
> > > diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> > > index ce8bdd804bc7..c843bf352999 100644
> > > --- a/arch/x86/mm/fault.c
> > > +++ b/arch/x86/mm/fault.c
> > > @@ -1466,7 +1466,7 @@ void do_user_addr_fault(struct pt_regs *regs,
> > > =20
> > >  	/* The fault is fully completed (including releasing mmap lock) */
> > >  	if (fault & VM_FAULT_COMPLETED)
> > > -		return;
> > > +		goto out;
> > > =20
> > >  	/*
> > >  	 * If we need to retry the mmap_lock has already been released,
> > >=20
> > > To my understanding, this was a dovetail fix that applied to previous=
=20
> > > versions as well.
> >=20
> > Only to v6.0, however this series is not maintained dovetail-wise
> > anymore, so this stayed under the radar.
>=20
> FYI: This change fixes a real issue here. The 6.1-rebase branch made it
> through a 24h stress test while the "merge" branch failed. Happily
> waiting for the next release...

Do we have a idea / plan when the next 6.1 dovetail release will
happen? My internal customer is waiting for that and I want to avoid
backporting to 6.1.34.

@Philippe, any news regarding the IRQ issue? Did the VM image help to
reproduce the issue?

Florian

>=20
> >=20
> > > Besides StackRot, another reason to update 6.1 soon.
> > >=20
> > > A tag on the new branch is still missing. I suspect you are still=20
> > > testing? CI picked up the head already as well:
> > >=20
> >=20
> > Yes, still in the process of testing the latest rebases on -stable for
> > 5.10, 5.15, and 6.1 (armv8).
> >=20
>=20
>=20

