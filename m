Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB47F1EA74
	for <xenomai@lists.linux.dev>; Mon,  8 Jul 2024 20:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720472376; cv=none; b=qjTl5J67sDJLW3a5J6ZzZdHch9XFYQrEIvTdm2yXBdufAcH9O6BQCsKCe6e0DGUzCBofXkOam2H/rPnmRxYQwCjxbBdo+Z4Z6AY6oJRjr2fjQvbGCSTYc5YF6YoRhoHyTzgti6TFNdpvbU3uWp2w1WXUAEPp+EfuAfTTB6bKdwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720472376; c=relaxed/simple;
	bh=wBx4MwOWXJTepHzaSu8ofRK0qLOcwQAA+LuMrlmwrj8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EJLLtLPETc4jFe2IkYjB2bPT9Jj6m4vwUsYgEnKJxVnabkEpd7oww/BIYiJgj2UeqMMN2DVEDRqRiwHxgDYEBjBGtkeuRezjmIjIQNZtybAeC7rQ8I1SzzV7LwzKc88PCetJSly/ZnbOq+YyhHOV6ki6tlxT70Q9r77i2Cx9Qxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Tv6CdSWZ; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Tv6CdSWZ"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240708205921a30d864316ae405325
        for <xenomai@lists.linux.dev>;
        Mon, 08 Jul 2024 22:59:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Avlm6pHp9jx8wsGqyiKBYktphnOrKMp2ZIOT2us0YCw=;
 b=Tv6CdSWZfGJwf28v1x0Oepp7JvXRo5rS6QVqVggOuxnuKoRJKkeTZ0HUXmL3bbddlflIvO
 D/yx3+hG1iIFqVLMUJB2A8DTkeZTUl4iagbmZ7iRmLGHBy4AYuatTAAmW0YzGTTa2xRrPaCo
 75FLtGDzYmM3mD8gmZ2K9LsHs/Fr8=;
Message-ID: <33a683d330571dc955b7d5f71caa9ee5cf5f31c0.camel@siemens.com>
Subject: Re: [PATCH dovetail v5 0/2] Fix KVM guest support of dovetail
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
Date: Mon, 08 Jul 2024 22:59:20 +0200
In-Reply-To: <98bce1fe-9669-4cda-b5af-7d2194808f79@siemens.com>
References: 
	<20240531-flo-fix-kvm-guest-for-6-9-v5-0-1efec77fe0a0@siemens.com>
	 <875xtwcd0v.fsf@xenomai.org>
	 <92516aba9b4726ac25f00731abce36d99c96ef84.camel@siemens.com>
	 <98bce1fe-9669-4cda-b5af-7d2194808f79@siemens.com>
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

Hi Philippe, Hi Jan,

On Wed, 2024-06-26 at 13:29 +0200, Jan Kiszka wrote:
> On 26.06.24 12:44, Florian Bezdeka wrote:
> > On Wed, 2024-06-26 at 10:40 +0200, Philippe Gerum wrote:
> > > > Florian Bezdeka (2):
> > > >       KVM: x86: dovetail: Move handling async page faults to the in=
band stage
> > > >       KVM: x86: dovetail: Allow kvm_wait() to be called from any co=
ntext
> > > >=20
> > > >  arch/x86/include/asm/idtentry.h |  2 +-
> > > >  arch/x86/kernel/irq_pipeline.c  |  6 ++++++
> > > >  arch/x86/kernel/kvm.c           | 29 ++++++++++++++++++++++-------
> > > >  3 files changed, 29 insertions(+), 8 deletions(-)
> > > > ---
> > > > base-commit: 17865a05b459df6e7e7e38018b15b29a96df49af
> > > > change-id: 20240531-flo-fix-kvm-guest-for-6-9-5ef61aac08ad
> > > >=20
> > > > Best regards,
> > >=20
> > > Merged, thanks.
> >=20
> > Nice. What is the procedure now to get that into the (non-rebase) 6.1
> > branch?
> >=20
> > As written in the cover letter, patches should apply down to 5.15, I
> > can look into 5.10 again if necessary.
>=20
> I will take care of the 5.x updates.
>=20
> Jan

Any news about the backporting / release process? Additional help
needed?

Best regards,
Florian

>=20
> --=20
> Siemens AG, Technology
> Linux Expert Center

