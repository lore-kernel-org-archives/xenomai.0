Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4F517C7C3
	for <xenomai@lists.linux.dev>; Wed, 26 Jun 2024 10:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719398709; cv=none; b=Nl90Nn9XDSmlmmgJPslE4l+pNFmaIDYMF44LAjT1nwEp3LUFjlJOIqWLALV2ejF5II1qa4vbQmctW+YseVP5xRwynGHnk8hVnG/SWeVFmJhXiIkKQSCaaVEhegtzHY5M59EG1gAi83J+2e0cllGbg9RtB06Ncf6GxQ6nuDLoLAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719398709; c=relaxed/simple;
	bh=5Y1Hwru6/OqX4TwewKhzUbarjuZ9kFRlyp85Up+NKsc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VB6ecCmNmOHJyoT/EhcBHvx/VSQCPNk6F2iZ5jcm/yR2z+2BOnJnzWOf7Xo9QZq+ESMHVxIAkTvnrb41j/2Tk1SF+TEHHtqN01DORFR/TyX3qIl6RIVZgnmL3S5OjDAic1az4apTPys5YneUWjHcZlvT8gJqduz6EKccaucv5o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=o+GvDDcE; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="o+GvDDcE"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20240626104458cf8bb98699b83372e6
        for <xenomai@lists.linux.dev>;
        Wed, 26 Jun 2024 12:44:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Oc0/oMVpkNI7szj5uxh2kPmnC14WJjgHVfakohnIfA4=;
 b=o+GvDDcEl7LzzWh3rPjSfR+CHCBdn2Eo7coqQ7/Z0598lCZoVWJwTsQ0l3DDj98zRE/4xC
 dbKa1kHSYUPNa3lyVeGaUKwEh7Qky4xmosrLpy8IA0HjUrP1v+ICIM4E6gcFDfuagQMWe+2R
 gP7RYPX23bcRUxvFlfqhlVKbslVWI=;
Message-ID: <92516aba9b4726ac25f00731abce36d99c96ef84.camel@siemens.com>
Subject: Re: [PATCH dovetail v5 0/2] Fix KVM guest support of dovetail
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Date: Wed, 26 Jun 2024 12:44:54 +0200
In-Reply-To: <875xtwcd0v.fsf@xenomai.org>
References: 
	<20240531-flo-fix-kvm-guest-for-6-9-v5-0-1efec77fe0a0@siemens.com>
	 <875xtwcd0v.fsf@xenomai.org>
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

On Wed, 2024-06-26 at 10:40 +0200, Philippe Gerum wrote:
> > Florian Bezdeka (2):
> >       KVM: x86: dovetail: Move handling async page faults to the inband=
 stage
> >       KVM: x86: dovetail: Allow kvm_wait() to be called from any contex=
t
> >=20
> >  arch/x86/include/asm/idtentry.h |  2 +-
> >  arch/x86/kernel/irq_pipeline.c  |  6 ++++++
> >  arch/x86/kernel/kvm.c           | 29 ++++++++++++++++++++++-------
> >  3 files changed, 29 insertions(+), 8 deletions(-)
> > ---
> > base-commit: 17865a05b459df6e7e7e38018b15b29a96df49af
> > change-id: 20240531-flo-fix-kvm-guest-for-6-9-5ef61aac08ad
> >=20
> > Best regards,
>=20
> Merged, thanks.

Nice. What is the procedure now to get that into the (non-rebase) 6.1
branch?

As written in the cover letter, patches should apply down to 5.15, I
can look into 5.10 again if necessary.

Best regards,
Florian

>=20
> --=20
> Philippe.

