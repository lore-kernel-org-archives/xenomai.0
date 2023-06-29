Received: from redirect.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306F112B80
	for <xenomai@lists.linux.dev>; Thu, 29 Jun 2023 15:44:28 +0000 (UTC)
Received: from spool.mail.gandi.net (spool3.mail.gandi.net [217.70.178.212])
	by relay12.mail.gandi.net (Postfix) with ESMTPS id 79544200005
	for <xenomai@lists.linux.dev>; Thu, 29 Jun 2023 15:44:26 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 72E78AC0EA8
	for <xenomai@xenomai.org>; Thu, 29 Jun 2023 15:44:25 +0000 (UTC)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20230629154424222b8f9f5ea4d24032
        for <xenomai@xenomai.org>;
        Thu, 29 Jun 2023 17:44:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=O6mjB2qKwlCuoRuZfaEgEeo6njSKHi3+TCBUjeQeUes=;
 b=j1CVgcWrF68OYyUgkxmyoO2y/QPVqZQHiyOxnLj3EifX1rIxhsAjs9Qk6hsCoGiQtsX7fq
 cze1/GtBk0OogW3yQ8TrpPDeyrL0GLUhflMnWwzkqCOVUqHjBxTNWMOZ7OASH4m4IyTc/vI0
 dkmYjDtjO6g3lREzXA++/STV2X5Xk=;
Message-ID: <ed5fcc0b018341fbbaa9e9732a8dd10422064c92.camel@siemens.com>
Subject: Re: [PATCH] Macb/gem network driver does not build anymore on 
 recent  xenomai/kernels
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: =?ISO-8859-1?Q?Fran=E7ois?= Legal <devel@thom.fr.eu.org>
Cc: xenomai <xenomai@xenomai.org>
Date: Thu, 29 Jun 2023 17:44:24 +0200
In-Reply-To: <3b7514-649d9300-2f-28cbfc80@10273562>
References: <3b7514-649d9300-2f-28cbfc80@10273562>
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
	dkim=pass header.d=siemens.com header.s=fm1 header.b=j1CVgcWr;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of fm-68982-20230629154424222b8f9f5ea4d24032-3t9Pw3@rts-flowmailer.siemens.com designates 185.136.65.226 as permitted sender) smtp.mailfrom=fm-68982-20230629154424222b8f9f5ea4d24032-3t9Pw3@rts-flowmailer.siemens.com

On Thu, 2023-06-29 at 16:18 +0200, Fran=C3=A7ois Legal wrote:
> Le Jeudi, Juin 29, 2023 15:19 CEST, Florian Bezdeka <florian.bezdeka@siem=
ens.com> a =C3=A9crit:=20
> =20
> > Hi,
> >=20
> > On Thu, 2023-06-29 at 15:04 +0200, Fran=C3=A7ois Legal wrote:
> > > Subject: [PATCH] Make macb/gem RT driver to be built against linux >=
=3D 5.0 kernels
> >=20
> > ^^ this line can be removed. We have the mail subject, that's
> > sufficient.
> >=20
> > In addition, could you please run checkpatch on your patch? There are a
> > lot of warnings that should be addressed (especially regarding line
> > endings, code style, ...)
> >=20
>=20
> Yes, sorry, it's been a while since I last posted a patch here.
> Can I assume warnings like=20
> WARNING: LINUX_VERSION_CODE should be avoided, code should be for the ver=
sion to which it is merged
> #193: FILE: kernel/drivers/net/drivers/macb.c:1810:
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 5, 0)
>=20
> WARNING: Comparisons should place the constant on the right side of the t=
est
> #193: FILE: kernel/drivers/net/drivers/macb.c:1810:
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 5, 0)

4.5.0 dates back to the ipipe. master/next branch of Xenomai already
removed ipipe support and went ahead with dovetail (Linux >=3D 5.10)
only. We don't care about such old kernels anymore.

You should be able to remove this #if machinery here and only provide
the "new code".

>=20
> from checkpatch can be ignored (I copied existing code from the file to c=
onditionnalise some code)
>=20
> ?
>=20
> Otherwise, v2 is ready.
>=20
> Fran=C3=A7ois
>=20
> > Looking forward to a v2.
> >=20
> > Best regards,
> > Florian
> >=20
> > >=20
> > > PHY layer in upstream has changed a little after 5.0 in the way auton=
egociation capabilities are encoded.
> > > MACB platform data tend to disappear after 5.2 upstream.
> > > Plus, ioctl prototype has changed in xenomai. RTMACB driver does not =
build anymore.
> > >=20
> > > Signed-off-by: Fran=C3=A7ois LEGAL <devel@thom.fr.eu.org>
> > > ---
> >=20

