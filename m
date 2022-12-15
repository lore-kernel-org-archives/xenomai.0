Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD76190
	for <xenomai@lists.linux.dev>; Thu, 15 Dec 2022 15:25:59 +0000 (UTC)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202212151525517785bf5fd26250464a
        for <xenomai@lists.linux.dev>;
        Thu, 15 Dec 2022 16:25:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=X2HgpjBOrCUH6guvEluIyX1V4Fsuq3EtxAjzikiEGWA=;
 b=YHZFaCAXI5bdTkL09qXQ6E6toJYRXAKxoenzXE8zxuH1XCRzFVfOJG+GgrEmHl/7jo6qmf
 G0Cobht8lXisX5mGtpbc+tStgAnIIKCfr1WfxCl4nvZ9K+rnEfG19Qa73iW9xec3VFurDtY5
 gRG/ywuBGmcANtvpImgjTtxZAew4c=;
Message-ID: <d00c3c982f41ead3147dcfb2900f2a55606eb9aa.camel@siemens.com>
Subject: Re: Synchronization request of supported ipipe kernel versions
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Greg Gallagher
 <greg@embeddedgreg.com>
Cc: xenomai@lists.linux.dev
Date: Thu, 15 Dec 2022 16:25:50 +0100
In-Reply-To: <dda4a74d-84d2-7282-7517-74ec4cd58436@siemens.com>
References: <c7b9c30c4f0685adbd3f3829b9bba4b42835177a.camel@siemens.com>
	 <CALLqZ8RgN_WNdf_k=My5m7kyOKFw=gmVB36e3ztQVUjsN9V_7g@mail.gmail.com>
	 <CALLqZ8T8ZxV2bJD7h47t_cQDkAyb9dMUpA2HOUO0x=0_0Pht2A@mail.gmail.com>
	 <15331e9004e2a34e03bada655de9895531befaa8.camel@siemens.com>
	 <dda4a74d-84d2-7282-7517-74ec4cd58436@siemens.com>
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

On Tue, 2022-11-29 at 08:01 +0100, Jan Kiszka wrote:
> On 28.11.22 17:36, Florian Bezdeka wrote:
> > On Sun, 2022-11-27 at 22:09 -0500, Greg Gallagher wrote:
> > > On Fri, Nov 25, 2022 at 4:13 PM Greg Gallagher <greg@embeddedgreg.com=
> wrote:
> > > >=20
> > > > On Fri, Nov 25, 2022 at 9:11 AM Florian Bezdeka
> > > > <florian.bezdeka@siemens.com> wrote:
> > > > >=20
> > > > > Hi Jan, Hi Greg,
> > > > >=20
> > > > > while tracking down some ipipe issues that appeared while trying =
to
> > > > > modernize the CI toolchain (Debian 11 =3D> 12 update) I had massi=
ve
> > > > > problems with all the different kernel versions that we have for
> > > > > different architectures.
> > > > >=20
> > > > > Currently we have:
> > > > >=20
> > > > >             4.19             5.4
> > > > > armhf   4.19.229-cip67+    5.4.180+
> > > > > arm64   4.19.144+          5.4.180+
> > > > > amd64   4.19.264-cip84+    5.4.223+
> > > > >=20
> > > > >=20
> > > > > Might I request to synchronize them?
> > > > >=20
> > > > > It would simplify things a lot if
> > > > >   - all 4.19 versions would be based on the same patch level
> > > > >   - all 5.4  versions would be based on the same patch level
> > > > >   - The 4.19 and 5.4 versions would be based on the same stable
> > > > >     patch set. Currently 4.19.266 and 5.4.224 are recent versions
> > > > >     with the "same" set of patches applied.
> > > > >=20
> > > > > Concrete example:
> > > > >=20
> > > > > I had to update my 4.19 baseline to recent 4.19.264 to make sure =
that
> > > > > I'm not hunting for something that is already fixed. With that I =
pulled
> > > > > in the following upstream commit:
> > > > >=20
> > > > > 211565b10099 ("serial: pl011: UPSTAT_AUTORTS requires .throttle/u=
nthrottle")
> > > > >=20
> > > > > This commit breaks (or will break) the pl011 driver in case ipipe=
 is
> > > > > enabled. It is part of 4.19.253 and 5.4.207. The only tree that a=
lready
> > > > > has this commit is for amd64, but it's not a real problem as x86
> > > > > normally doesn't require this driver.
> > > > >=20
> > > > > a) I'm currently not able to fix that for arm/arm64
> > > > >    (too old but not yet affected)
> > > > > b) If 4.19 and 5.4 for arm/arm64 are not based on the same stable
> > > > >    patch level I have to backport for each arch/ipipe.
> > > > >=20
> > > > > Let me know what you think!
> > > > >=20
> > > > > Regards,
> > > > > Florian
> > > > >=20
> > > > >=20
> > > > >=20
> > > >=20
> > > > Sorry if this is a double reply I think my original didn't go throu=
gh.
> > > > I=E2=80=99m good with this, I can update the arm/arm64 branches thi=
s weekend.
> > > >=20
> > > > -Greg
> > >=20
> > > I've got my local branches based on 4.19.266 and 5.4.224, running
> > > smoke tests.  I haven't looked into the pl011 driver breaking yet, do
> > > we need that fixed before I update 4.19 and 5.4 ipipe? Once I run my
> > > local smoke tests I should be ready to update the branches tomorrow o=
r
> > > Tuesday.

Hi Greg,

I revisited the pl011 driver problem today and was unable to reproduce
so far. I will continue for some time but it might be that the real
issue (system hang) is triggered by the wlan driver.

Any findings from your tests? Can you update the trees?

Best regards,
Florian

> >=20
> > If we do not fix that upfront I would expect Xenomai CI to report
> > "hangs" on next pipline run.=20
> >=20
> > Jan, can you also offer 4.19.226 and 5.4.224 for x86?
> >=20
>=20
> ipipe-noarch ipipe/master and the heads of ipipe-x86-4.19.y-cip as well
> as ipipe-x86-5.4.y have been updates, CI is running.
>=20
> Jan
>=20

