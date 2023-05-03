Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD8646AC
	for <xenomai@lists.linux.dev>; Wed,  3 May 2023 12:54:13 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202305031254101baf213ae36c5bd975
        for <xenomai@lists.linux.dev>;
        Wed, 03 May 2023 14:54:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=332itTgEEdahYUqv/6KDvM9zNAMPBDikjDvcn1phQ8g=;
 b=NQ4JbsH5v+rM+lWyclnYSqc39DQDizqwAvoJKTCu0bAHpBsHQV5dabhFvU+hl7e0iKQ06r
 cGN7kLyeKzVyMlI+5pyWortoYjulUQnZsNP0RG1TVNrst49T6p5B5ISf8lIxK3bOOIAYLvOh
 CgWcXIKen1KNelselskFAm//5EMyM=;
Message-ID: <549fb46b2327ef762fc9e7798a07e2e890081425.camel@siemens.com>
Subject: Re: [PATCH xenomai-images 3/4] customizations: Mask
 systemd-network-generator service
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Wed, 03 May 2023 14:54:09 +0200
In-Reply-To: <87725da2-1d9b-83e3-9822-da38db11f7ac@siemens.com>
References: 
	<20230503-flo-debian-bookworm-update-v1-0-6a4aa9e4d95f@siemens.com>
	 <20230503-flo-debian-bookworm-update-v1-3-6a4aa9e4d95f@siemens.com>
	 <87725da2-1d9b-83e3-9822-da38db11f7ac@siemens.com>
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

On Wed, 2023-05-03 at 14:47 +0200, Jan Kiszka wrote:
> On 03.05.23 14:10, Florian Bezdeka wrote:
> > We use ip=3Ddhcp as kernel cmdline option for most of our CI targets.
> > This cmdline option is now taken into account by newer systemd versions
> > and a network configuration generation in userspace is triggered.
> >=20
> > WLAN interfaces are part of the generated network configuration and
> > might trigger a complete system hang. Especially the HiKey board in
> > combination with 4.19 (ipipe) is affected.
> >=20
> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > ---
> >  recipes-core/customizations/files/postinst | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/recipes-core/customizations/files/postinst b/recipes-core/=
customizations/files/postinst
> > index 691988f..d8d141c 100644
> > --- a/recipes-core/customizations/files/postinst
> > +++ b/recipes-core/customizations/files/postinst
> > @@ -15,3 +15,5 @@ echo "Xenomai Demo Image (login: root/root)" > /etc/i=
ssue
> >  echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
> > =20
> >  echo "demo" > /etc/hostname
> > +
> > +/usr/bin/systemctl mask systemd-network-generator
> >=20
>=20
> Shouldn't this be patch 2 then, to avoid a regression moving to bullseye?

Valid point (assuming you meant moving to bullseye).

Let me spawn a pipeline run with the changed order to make sure there
are no side effects on bullseye (the current distro).

Florian

>=20
> Jan
>=20

