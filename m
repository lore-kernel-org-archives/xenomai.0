Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D9DD289
	for <xenomai@lists.linux.dev>; Mon, 30 Oct 2023 23:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Aq3ltqqR"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20231030231450396a189e5d874df61d
        for <xenomai@lists.linux.dev>;
        Tue, 31 Oct 2023 00:14:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=3e2xVSBHL/yhmTND1Yj1BdbF43L9IW3drDZUMcdIGUE=;
 b=Aq3ltqqR/72I+C+cSFZE1M3iO00G4ppwV15/6WAoEm6Yj5JQ/AOo9e9H+2RUvdfHvwrHse
 2+pt920KaV7ZM5w5pDqFhx5cywEpX1AL0OSFy5pmt9uqLseK6GbywNSIL2GjHdVSaq+gU6ey
 wn3ovpBucHly4mPDaP76bTMGyDZhQ=;
Message-ID: <3eda6fb3c3b5d1c000f7e41205bca2e96e04bc0d.camel@siemens.com>
Subject: Dovetail build failure
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: rpm@xenomai.org
Cc: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Date: Tue, 31 Oct 2023 00:14:49 +0100
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

Hi Philippe,

current CI jobs are failing with the following error. The reason
resides inside a recently added patch titled=20

  dmaengine: bcm2835: dovetail: use IRQ forwarding=20

The declaration of the flags variable has been removed but the variable
is still being used:

2023-10-30 20:16:40 - INFO     - | ../drivers/dma/bcm2835-dma.c: In functio=
n 'bcm2835_dma_callback':
2023-10-30 20:16:40 - INFO     - | ../drivers/dma/bcm2835-dma.c:507:17: err=
or: 'flags' undeclared (first use in this function)
2023-10-30 20:16:40 - INFO     - |   507 |                 flags =3D readl(=
c->chan_base + BCM2835_DMA_CS);
2023-10-30 20:16:40 - INFO     - |       |                 ^~~~~
2023-10-30 20:16:40 - INFO     - | ../drivers/dma/bcm2835-dma.c:507:17: not=
e: each undeclared identifier is reported only once for each function it ap=
pears in

At least 5.10 and 6.1 -rebase branches are affected.

Best regards,
Florian

--=20
Siemens AG, Technology
Linux Expert Center

