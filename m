Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2174E187FEC
	for <xenomai@lists.linux.dev>; Tue,  8 Apr 2025 13:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744118182; cv=none; b=DMNFaq+XtQBmYLL92qCDztf0sFwzeRCf4XZzekP6COCKg7QeDSNXLPWOJXYcrhHds4T3mX4QHyTvsksrgevpcmdEN12g1QvS6IGuu2qQUJBLeW2xyFa8TyF812tEsmJ5ldkP7U1lkac5YQHv3BXxD1wyfyod08+TlohixjgEYl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744118182; c=relaxed/simple;
	bh=tcMaBT7GEExJcDfRfUjh8YdYPviFG+FgWqayflcVDcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KeNvMaQxoOEO1NHuAqGWYbUEzw7wd/4BHWjYUiuqkS7BIOrkWs0dvOxfTSwIjMWaYzMzdCiZ4qkjfwdoa4AFPxYGGIXLDLs8Al6sUbdTQ7DeZpgtpP7rLobaOc7vqGHezR5Q8gZHW4dQbbAEDwIxWBN9G+hgPpNJtfM6/ZkoK1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=eluUCGqK; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="eluUCGqK"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4394a823036so51291895e9.0
        for <xenomai@lists.linux.dev>; Tue, 08 Apr 2025 06:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1744118177; x=1744722977; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8SnjrT26aX5FvLrFlaha0KSmVNM6S2vHSfP2Nop9yEk=;
        b=eluUCGqK43Knxd8CPYwaWmYZHToGkulLTrQJtrqh6bg6mDMtA31JtT8oBzL8KUC3KP
         UxE3058B1jvmrtNXGrx/gxSWaxaRa3e2oSvQwq1FQxUS/xV7xhZBwTvLDLBAOn5a14UD
         rCu2ns4X74u9MGVwk3EWaam8oyWtTpMQ+O/fWjRrUHrArgm6VqVSgjdQeJEWi90mqgvB
         MxIwPhvJxFfq9LAW1paGiuJAq3lEsxILknGetb2GATE1jGZXU5BY9ruTQ5lzZxf/E+Up
         wjmCaqFGlnXKc83mKE7GiZ+yb05YFQGninP5mnQCEYDCIHJuR4xQXQpvl8+o+OFLnuEh
         v0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744118177; x=1744722977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8SnjrT26aX5FvLrFlaha0KSmVNM6S2vHSfP2Nop9yEk=;
        b=Zi1HpBMO3Ke+aeIiQMA4woSP01WGhhbR2Dsf/qkXxHgQrqrPi8CAoIcwIgTL+CrLYk
         w3TXDM8BOaXITYTR7knaMsveGZjzXyPh2rYrhlhdlnzuI9rVq+kM+iZKjltBR4Yr0eOY
         R5AH5RL2UV+YVr43XUNgqANobRJxfESvvc1PSYd4sj+xUHGitDKTIxmpEZ1NAZoIvaEX
         WhTPcO15VKa6VpmUruS8i6AR+ZgO6AXvKXmmOnx5EtP64FH/5PdMZQn46lO3p4431bL5
         MnbbboAF0o7rGSBdwOJmBvrl+lICeDQFHVjn4C90QJCGWj1ilvS55C5nzyfvvmq/kiBy
         lQDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJ450diporoSYWPY4suhkG8hGDP/GkDEHFwtzombHYY5hPL/Mh2FzUvwJaoBv/+a2h/8RSZQfZ@lists.linux.dev
X-Gm-Message-State: AOJu0YzXrttJkF/g3djEfbEuzNeIrOpadqESDQGHB1PgOJopeULBNrQT
	hww93L64w5DACHvNuhydFsdJ+YH1WbdwbB+EvOeM2mgfRp8fdpi24BnxpMkwSB8=
X-Gm-Gg: ASbGnctDHQl5x/1JNyjhWjuom3cA62Rpjz10zHvmibsHSlZsn3YKKX5+exXkV3jz00+
	K91eOoIRaZUEAqjbtAXah3G07myuipWiAsZx2Ml85aROb1I+sTjUb74DJTUyHUgXUtJqBxPQL6f
	45mvUpty1nla090tvcrOiU76XUruCVswevtBh2ZjoVcxvcL2kA3Gs2QDMhVm2uT+BA5RrHMe2Us
	v4DPT0W5MDmsNFNqR7rMBkLw3cgfp72dlkyaJADCWEahLZALVYskk9M9rULGLzjIMpsABF7JL/Y
	QE1DB/e7EGgmqC2YHWWhvPmRlmK/TyTqF7MCB4yzAghWMd+ldFse2jY/
X-Google-Smtp-Source: AGHT+IGTo4lgeAxchPQe9l1CVpGBRVp8jfOS0VxO+es2CXD+jbhTDVGleJYcKC9x6KxBqLTmjo87nQ==
X-Received: by 2002:a05:600c:46d5:b0:43d:fa:1f9a with SMTP id 5b1f17b1804b1-43ee077feeamr120422545e9.30.1744118177112;
        Tue, 08 Apr 2025 06:16:17 -0700 (PDT)
Received: from somecomputer ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30226f1fsm15033225f8f.95.2025.04.08.06.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 06:16:16 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Nikolaus Funk <nikolaus.funk@sigmatek.at>, xenomai@lists.linux.dev,
 Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Richard Weinberger <richard@nod.at>,
 Johannes Kirchmair <johannes.kirchmair@sigmatek.at>,
 Jan Kiszka <jan.kiszka@siemens.com>, Lorenz Kofler <lorenz@sigma-star.at>
Subject:
 Re: [PATCH 4/5] arm64: dovetail: Helper functions for signal frame setup and
 restore
Date: Tue, 08 Apr 2025 15:16:15 +0200
Message-ID: <32233504.Lj2Plt8kZL@anvil>
In-Reply-To: <82af204c390c6e18089310abb3531556971754cf.camel@siemens.com>
References:
 <20250408123423.627477-1-nikolaus.funk@sigmatek.at>
 <20250408123423.627477-5-nikolaus.funk@sigmatek.at>
 <82af204c390c6e18089310abb3531556971754cf.camel@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Dienstag, 8. April 2025 15:05 Florian Bezdeka wrote:
> > +	if (regs->sp & 15)
> > +		goto out;
>=20
> - Where is this magic 15 coming from?

The stack needs to be word aligned.
This was taken from the Linux side.

> - return -EFAULT; would also work and save us one label.

Ok.

>=20
> > +
> > +	frame =3D (struct rt_sigframe __user *)regs->sp;
> > +
> > +	pagefault_disable();
> > +
> > +	if (!access_ok(frame, sizeof (*frame)))
> > +		goto out_pfe;
> > +
> > +	if (restore_sigframe(regs, frame, &ua_state))
> > +		goto out_pfe;
> > +
> > +	restore_user_access_state(&ua_state);
> > +
> > +	ret =3D 0;
> > +
> > +out_pfe:
> > +	pagefault_enable();
> > +out:
> > +	return ret;
> > +}
> > +
> > +static int dovetail_restore_32_rt_signal_frame(struct pt_regs *regs)
> > +{
> > +	struct compat_rt_sigframe __user *frame;
> > +	int ret =3D 0;

That should be pre-initialized to -EFAULT. :-S

> > +	if (regs->sp & 7)

Given this a second thought, the check should inspect ->compat_sp, no ->sp.

> > +		goto out;
>=20
> Same as above.=20
> - Magic 7

The stack needs to be word aligned.

> - Is the error reporting really correct here? We would return 0.

Yes.

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT UID/VAT Nr:
ATU 66964118 | FN: 374287y


