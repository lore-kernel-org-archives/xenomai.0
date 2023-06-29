Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868B5258D
	for <xenomai@lists.linux.dev>; Thu, 29 Jun 2023 13:20:00 +0000 (UTC)
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id 1157C100008
	for <xenomai@lists.linux.dev>; Thu, 29 Jun 2023 13:19:52 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	by spool.mail.gandi.net (Postfix) with ESMTPS id C54B1941814
	for <xenomai@xenomai.org>; Thu, 29 Jun 2023 13:19:50 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20230629131950f5ddcf537de9035031
        for <xenomai@xenomai.org>;
        Thu, 29 Jun 2023 15:19:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=OXyK4i0YG60oiFhuKdPYKYJDdKb20UD50yT/931wEuI=;
 b=f9OEf9wMcg1quD6OcXbrJHhSPDn8EcdewEVN4KZ3F2t3GpjUtPI5EbUihfbChT/HcK+129
 AFTsall6Ad08xlQ6S4zUDbQPo9QwTbtrR+u95fLCPygqMFPnGpuZ//8aY5qiOhEmabPcfkTo
 hdZTZ8k9DJQfxzNlUafs9AhUrRbP4=;
Message-ID: <525e6d4dbbdf8123b9957a244bedf817cefd8d02.camel@siemens.com>
Subject: Re: [PATCH] Macb/gem network driver does not build anymore on
 recent  xenomai/kernels
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: =?ISO-8859-1?Q?Fran=E7ois?= Legal <devel@thom.fr.eu.org>, xenomai
	 <xenomai@xenomai.org>
Date: Thu, 29 Jun 2023 15:19:49 +0200
In-Reply-To: <300db1-649d8180-4b-79908c80@57806451>
References: <300db1-649d8180-4b-79908c80@57806451>
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
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm1 header.b=f9OEf9wM;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of fm-68982-20230629131950f5ddcf537de9035031-BKpc42@rts-flowmailer.siemens.com designates 185.136.65.227 as permitted sender) smtp.mailfrom=fm-68982-20230629131950f5ddcf537de9035031-BKpc42@rts-flowmailer.siemens.com

Hi,

On Thu, 2023-06-29 at 15:04 +0200, Fran=C3=A7ois Legal wrote:
> Subject: [PATCH] Make macb/gem RT driver to be built against linux >=3D 5=
.0 kernels

^^ this line can be removed. We have the mail subject, that's
sufficient.

In addition, could you please run checkpatch on your patch? There are a
lot of warnings that should be addressed (especially regarding line
endings, code style, ...)

Looking forward to a v2.

Best regards,
Florian

>=20
> PHY layer in upstream has changed a little after 5.0 in the way autonegoc=
iation capabilities are encoded.
> MACB platform data tend to disappear after 5.2 upstream.
> Plus, ioctl prototype has changed in xenomai. RTMACB driver does not buil=
d anymore.
>=20
> Signed-off-by: Fran=C3=A7ois LEGAL <devel@thom.fr.eu.org>
> ---

