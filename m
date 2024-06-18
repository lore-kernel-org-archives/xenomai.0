Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24AD13AD0F
	for <xenomai@lists.linux.dev>; Tue, 18 Jun 2024 07:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718695258; cv=none; b=hcQsvCqsGF0yjqNidDC/08bIFKuN3FsoPheAOk1CK8N52ePwLk0RkiSXON9TzGYL5k6/XzwV9bJc6vLmx8b5FhnBFki+rbkK/k1qm+D2tLds4vu7pnAfjLSedxBsb/6qlHST6h2kXQSjrmAavA1StrwpiJ1kJbmYVSUlTWGoCyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718695258; c=relaxed/simple;
	bh=Ntq7OU16vGpoiM54MfM4sH0+8zkO7pwPho1J76a3xzs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RbZaB9g1eitwJYbcgf7iOIxjOxZ4xv2KzwiDqvDSwOdHIbVS7FadkUTC2Em4NmVJDpb70uOcymjCc58/gd9Wogl375KhK9B83J5LLsKi+rhS0MCHQbrlntvl60pyXwt9JHfaiZ9UgABK+YZRneOgv0S6pPI+BRMmQG77CMHi5wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=ihOcUl67; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="ihOcUl67"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20240618072022f27068738323607a13
        for <xenomai@lists.linux.dev>;
        Tue, 18 Jun 2024 09:20:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=UiDhQNX2ko9+aT9kd2lnYO4W43eyuQri7mxPBZ4Ac48=;
 b=ihOcUl67F2JoW56ED/O/Oes8Cq+vLIU37u9WdcxeZrXSOz3nERRj9NDnKw+4Z23YhD7Q4L
 aCxEC4Ae4cA7DqFd8OVjraOSfnQJ1Gjki8TbaGq+cRNX2jp5QnrtNOVl1WCvv+TMk3RMSjkv
 E/oktK+aCfWop30HJFdoYiEedScUY=;
Message-ID: <5b831c9e1d047ba3e30f7d9497b934753bd7ac3f.camel@siemens.com>
Subject: Re: [PATCH v2] rpi4: fix arm64_defconfig CONFIG_BCMGENET
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Yi Jiang <yi.jiang@siemens.com>, 
	xenomai@lists.linux.dev
Date: Tue, 18 Jun 2024 09:20:20 +0200
In-Reply-To: <ab5621f9-de3e-4d49-98b9-0440f35bc006@siemens.com>
References: <20240617152859.32359-1-yi.jiang@siemens.com>
	 <ab5621f9-de3e-4d49-98b9-0440f35bc006@siemens.com>
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

On Mon, 2024-06-17 at 18:47 +0200, Jan Kiszka wrote:
> On 17.06.24 17:28, Yi Jiang wrote:
> > Remove the typo "space" before CONFIG_BCMGENET, so that TFTP booting ca=
n be supported.
> >=20
> > Signed-off-by: Yi Jiang <yi.jiang@siemens.com>
> > ---
> >  recipes-kernel/linux/files/arm64_defconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/recipes-kernel/linux/files/arm64_defconfig b/recipes-kerne=
l/linux/files/arm64_defconfig
> > index 94f7b5b..1dc8b69 100644
> > --- a/recipes-kernel/linux/files/arm64_defconfig
> > +++ b/recipes-kernel/linux/files/arm64_defconfig
> > @@ -1951,7 +1951,7 @@ CONFIG_MACB_USE_HWSTAMP=3Dy
> >  # CONFIG_MACB_PCI is not set
> >  CONFIG_NET_VENDOR_BROADCOM=3Dy
> >  # CONFIG_B44 is not set
> > - CONFIG_BCMGENET=3Dy
> > +CONFIG_BCMGENET=3Dy
> >  # CONFIG_BNX2 is not set
> >  # CONFIG_CNIC is not set
> >  # CONFIG_TIGON3 is not set
>=20
> Thanks, applied.
>=20
> Jan
>=20
> --=20
> Siemens AG, Technology
> Linux Expert Center
>=20

We could still squash it into=C2=A0
0ac81bd9b650 ("rpi4: Add rpi4 (Raspberry Pi 4) as target platform")

It's not part of main/master yet.

Florian
